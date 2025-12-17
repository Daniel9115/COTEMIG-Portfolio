using BlazorCrudApp.Data;
using BlazorCrudApp.Shared.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BlazorCrudApp.Controllers
{
    // Atributo que indica que esta classe é um Controller de API.
    [ApiController]
    // Define o padrão da rota: "api/" seguido pelo nome do controller ("Produtos").
    [Route("api/[controller]")]
    public class ProdutosController : ControllerBase
    {
        // Campo privado para armazenar a instância do DbContext. 'readonly' garante que só seja atribuído no construtor.
        private readonly ApplicationDbContext _context;

        // Construtor que recebe o DbContext via injeção de dependência.
        public ProdutosController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/produtos - Método para buscar todos os produtos.
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Produto>>> GetProdutos()
        {
            // Acessa a tabela de produtos e retorna todos como uma lista de forma assíncrona.
            return await _context.Produtos.ToListAsync();
        }

        // GET: api/produtos/5 - Método para buscar um produto específico pelo ID.
        [HttpGet("{id}")]
        public async Task<ActionResult<Produto>> GetProduto(int id)
        {
            // Procura um produto pelo ID de forma assíncrona.
            var produto = await _context.Produtos.FindAsync(id);
            // Se o produto não for encontrado, retorna um erro 404 Not Found.
            if (produto == null) return NotFound();
            // Se encontrado, retorna o produto com status 200 OK.
            return produto;
        }

        // POST: api/produtos - Método para criar um novo produto.
        [HttpPost]
        public async Task<ActionResult<Produto>> PostProduto(Produto produto)
        {
            // Adiciona o novo produto ao DbContext (ainda não salva no banco).
            _context.Produtos.Add(produto);
            // Salva as mudanças no banco de dados de forma assíncrona.
            await _context.SaveChangesAsync();
            // Retorna um status 201 Created, com o link para o novo recurso e o objeto criado.
            return CreatedAtAction(nameof(GetProduto), new { id = produto.Id }, produto);
        }

        // PUT: api/produtos/5 - Método para atualizar um produto existente.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProduto(int id, Produto produto)
        {
            // Validação básica para garantir que o ID da rota corresponda ao ID do objeto.
            if (id != produto.Id) return BadRequest();

            // Informa ao EF Core que o estado da entidade 'produto' é 'Modificado'.
            _context.Entry(produto).State = EntityState.Modified;
            // Salva as alterações no banco de dados.
            await _context.SaveChangesAsync();
            // Retorna um status 204 No Content, indicando sucesso na atualização.
            return NoContent();
        }

        // DELETE: api/produtos/5 - Método para excluir um produto.
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduto(int id)
        {
            // Encontra o produto a ser excluído.
            var produto = await _context.Produtos.FindAsync(id);
            // Se não encontrar, retorna 404 Not Found.
            if (produto == null) return NotFound();

            // Remove o produto do DbContext.
            _context.Produtos.Remove(produto);
            // Salva as alterações (efetiva a exclusão) no banco.
            await _context.SaveChangesAsync();
            // Retorna 204 No Content indicando sucesso.
            return NoContent();
        }
    }
}