using GerenciadorDeTarefas.Data;
using GerenciadorDeTarefas.Shared.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace GerenciadorDeTarefas.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize] // Protege todo o Controller
    public class TarefasController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public TarefasController(ApplicationDbContext context)
        {
            _context = context;
        }

        // Método Auxiliar para Obter o ID do Usuário Logado
        private string GetUserId()
        {
            // ClaimTypes.NameIdentifier contém o ID único do usuário (GUID)
            return User.FindFirstValue(ClaimTypes.NameIdentifier) ?? 
                   throw new UnauthorizedAccessException("Usuário não autenticado ou ID de usuário não encontrado.");
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Tarefa>>> GetTarefas()
        {
            var userId = GetUserId();
            var tarefas = await _context.Tarefas
                .Where(t => t.UsuarioId == userId || 
                           _context.Compartilhamentos.Any(c => c.TarefaId == t.Id && c.UsuarioIdCompartilhado == userId))
                .ToListAsync();
            return Ok(tarefas);
        }

        // GET: api/Tarefas/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Tarefa>> GetTarefa(int id)
        {
            var tarefa = await _context.Tarefas.FindAsync(id);

            // Verifica se a tarefa existe E pertence ao usuário (própria ou compartilhada)
            var userId = GetUserId();
            var isShared = await _context.Compartilhamentos.AnyAsync(c => c.TarefaId == id && c.UsuarioIdCompartilhado == userId);

            if (tarefa == null || (tarefa.UsuarioId != userId && !isShared))
            {
                return NotFound();
            }

            return tarefa;
        }

        // POST: api/Tarefas
        [HttpPost]
        public async Task<ActionResult<Tarefa>> PostTarefa(Tarefa tarefa)
        {
            var userId = GetUserId();
            tarefa.UsuarioId = userId;
            _context.Tarefas.Add(tarefa);
            await _context.SaveChangesAsync();
            return Ok(tarefa);
        }

        // PUT: api/Tarefas/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTarefa(int id, Tarefa tarefa)
        {
            if (id != tarefa.Id)
            {
                return BadRequest();
            }

            var userId = GetUserId();
            
            // Verifica se a tarefa existe e se o usuário tem permissão (própria ou compartilhada)
            var tarefaExistente = await _context.Tarefas.AsNoTracking().FirstOrDefaultAsync(t => t.Id == id);
            var isShared = await _context.Compartilhamentos.AnyAsync(c => c.TarefaId == id && c.UsuarioIdCompartilhado == userId);

            if (tarefaExistente == null || (tarefaExistente.UsuarioId != userId && !isShared))
            {
                return Forbid(); // Proíbe a edição de tarefas que não são do usuário ou compartilhadas com ele
            }
            
            // Garante que o UsuarioId não seja alterado (mantém o criador original)
            tarefa.UsuarioId = tarefaExistente.UsuarioId; 
            
            _context.Entry(tarefa).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Tarefas.Any(e => e.Id == id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Tarefas/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTarefa(int id)
        {
            var userId = GetUserId();
            var tarefa = await _context.Tarefas.FindAsync(id);
            
            if (tarefa == null || tarefa.UsuarioId != userId) 
            {
                return NotFound(); 
            }

            // Remove todos os compartilhamentos relacionados antes de deletar a tarefa
            var compartilhamentos = _context.Compartilhamentos.Where(c => c.TarefaId == id);
            _context.Compartilhamentos.RemoveRange(compartilhamentos);

            _context.Tarefas.Remove(tarefa);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // POST: api/Tarefas/5/compartilhar
        [HttpPost("{id}/compartilhar")]
        public async Task<IActionResult> CompartilharTarefa(int id, [FromBody] string usuarioIdParaCompartilhar)
        {
            var userId = GetUserId();
            var tarefa = await _context.Tarefas.FindAsync(id);

            if (tarefa == null || tarefa.UsuarioId != userId)
            {
                return NotFound("Tarefa não encontrada ou você não tem permissão."); 
            }
            
            if (string.IsNullOrWhiteSpace(usuarioIdParaCompartilhar))
            {
                return BadRequest("ID do usuário é obrigatório.");
            }

            if (usuarioIdParaCompartilhar == userId)
            {
                return BadRequest("Não é possível compartilhar uma tarefa consigo mesmo.");
            }

            var compartilhamentoExistente = await _context.Compartilhamentos
                .AnyAsync(c => c.TarefaId == id && c.UsuarioIdCompartilhado == usuarioIdParaCompartilhar);

            if (compartilhamentoExistente)
            {
                return BadRequest("Tarefa já compartilhada com este usuário.");
            }

            var novoCompartilhamento = new Compartilhamento
            {
                TarefaId = id,
                UsuarioIdCompartilhado = usuarioIdParaCompartilhar
            };

            _context.Compartilhamentos.Add(novoCompartilhamento);
            await _context.SaveChangesAsync();

            return Ok("Tarefa compartilhada com sucesso!");
        }

        // PATCH: api/Tarefas/5/concluir
        [HttpPatch("{id}/concluir")]
        public async Task<IActionResult> AlternarConclusaoTarefa(int id)
        {
            var userId = GetUserId();
            var tarefa = await _context.Tarefas.FindAsync(id);
            
            // Verifica se a tarefa existe E se o usuário tem permissão (própria ou compartilhada)
            var isShared = await _context.Compartilhamentos.AnyAsync(c => c.TarefaId == id && c.UsuarioIdCompartilhado == userId);
            
            if (tarefa == null || (tarefa.UsuarioId != userId && !isShared))
            {
                return NotFound();
            }
            
            // Alterna o status de conclusão
            tarefa.Concluida = !tarefa.Concluida;
            
            await _context.SaveChangesAsync();
            
            return Ok(new { concluida = tarefa.Concluida });
        }

        // GET: api/Tarefas/minhas
        [HttpGet("minhas")]
        public async Task<ActionResult<IEnumerable<Tarefa>>> GetMinhasTarefas()
        {
            var userId = GetUserId();
            
            // Busca tarefas próprias e compartilhadas em uma única consulta
            var tarefas = await _context.Tarefas
                .Where(t => t.UsuarioId == userId || 
                           _context.Compartilhamentos.Any(c => c.TarefaId == t.Id && c.UsuarioIdCompartilhado == userId))
                .OrderBy(t => t.Concluida)
                .ThenBy(t => t.DataVencimento)
                .ToListAsync();
            
            return Ok(tarefas);
        }

        // DELETE: api/Tarefas/5/compartilhar/{usuarioId}
        [HttpDelete("{id}/compartilhar/{usuarioId}")]
        public async Task<IActionResult> RemoverCompartilhamento(int id, string usuarioId)
        {
            var userId = GetUserId();
            var tarefa = await _context.Tarefas.FindAsync(id);

            if (tarefa == null || tarefa.UsuarioId != userId)
            {
                return NotFound("Tarefa não encontrada ou você não tem permissão.");
            }

            var compartilhamento = await _context.Compartilhamentos
                .FirstOrDefaultAsync(c => c.TarefaId == id && c.UsuarioIdCompartilhado == usuarioId);

            if (compartilhamento == null)
            {
                return NotFound("Compartilhamento não encontrado.");
            }

            _context.Compartilhamentos.Remove(compartilhamento);
            await _context.SaveChangesAsync();

            return Ok("Compartilhamento removido com sucesso!");
        }

        // GET: api/Tarefas/5/compartilhamentos
        [HttpGet("{id}/compartilhamentos")]
        public async Task<ActionResult<IEnumerable<string>>> GetCompartilhamentos(int id)
        {
            var userId = GetUserId();
            var tarefa = await _context.Tarefas.FindAsync(id);

            if (tarefa == null || tarefa.UsuarioId != userId)
            {
                return NotFound("Tarefa não encontrada ou você não tem permissão.");
            }

            var compartilhamentos = await _context.Compartilhamentos
                .Where(c => c.TarefaId == id)
                .Select(c => c.UsuarioIdCompartilhado)
                .ToListAsync();

            return Ok(compartilhamentos);
        }
    }
}
