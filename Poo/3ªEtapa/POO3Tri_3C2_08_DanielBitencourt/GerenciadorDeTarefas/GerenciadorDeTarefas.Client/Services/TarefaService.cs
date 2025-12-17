using GerenciadorDeTarefas.Shared.Models;
using System.Net.Http.Json;

namespace GerenciadorDeTarefas.Client.Services
{
    public class TarefaService
    {
        private readonly HttpClient _httpClient;

        public TarefaService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        // --- Métodos de CRUD ---

        public async Task<List<Tarefa>> GetTarefasAsync()
        {
            return await _httpClient.GetFromJsonAsync<List<Tarefa>>("api/tarefas") ?? new List<Tarefa>();
        }

        public async Task<Tarefa?> GetTarefaAsync(int id)
        {
            return await _httpClient.GetFromJsonAsync<Tarefa>($"api/tarefas/{id}");
        }

        public async Task AddTarefaAsync(Tarefa tarefa)
        {
            await _httpClient.PostAsJsonAsync("api/tarefas", tarefa);
        }

        public async Task UpdateTarefaAsync(Tarefa tarefa)
        {
            await _httpClient.PutAsJsonAsync($"api/tarefas/{tarefa.Id}", tarefa);
        }

        public async Task DeleteTarefaAsync(int id)
        {
            await _httpClient.DeleteAsync($"api/tarefas/{id}");
        }
        
        // --- Método de Compartilhamento (R3) ---
        public async Task ShareTarefaAsync(int tarefaId, string usuarioIdParaCompartilhar)
        {
            // Envia o ID do usuário no corpo da requisição POST
            var response = await _httpClient.PostAsJsonAsync($"api/tarefas/{tarefaId}/compartilhar", usuarioIdParaCompartilhar);
            
            if (!response.IsSuccessStatusCode)
            {
                 // Tratar erros, como usuário não encontrado ou tarefa já compartilhada
                var errorMessage = await response.Content.ReadAsStringAsync();
                throw new Exception($"Erro ao compartilhar tarefa: {errorMessage}");
            }
        }

        // --- Método para marcar como concluída ---
        public async Task AlternarConclusaoAsync(int tarefaId)
        {
            var response = await _httpClient.PatchAsync($"api/tarefas/{tarefaId}/concluir", null);
            
            if (!response.IsSuccessStatusCode)
            {
                var errorMessage = await response.Content.ReadAsStringAsync();
                throw new Exception($"Erro ao alterar status da tarefa: {errorMessage}");
            }
        }

        // --- Método para buscar tarefas do usuário ---
        public async Task<List<Tarefa>> GetMinhasTarefasAsync()
        {
            return await _httpClient.GetFromJsonAsync<List<Tarefa>>("api/tarefas/minhas") ?? new List<Tarefa>();
        }

        // --- Método para remover compartilhamento ---
        public async Task RemoverCompartilhamentoAsync(int tarefaId, string usuarioId)
        {
            var response = await _httpClient.DeleteAsync($"api/tarefas/{tarefaId}/compartilhar/{usuarioId}");
            
            if (!response.IsSuccessStatusCode)
            {
                var errorMessage = await response.Content.ReadAsStringAsync();
                throw new Exception($"Erro ao remover compartilhamento: {errorMessage}");
            }
        }

        // --- Método para listar compartilhamentos de uma tarefa ---
        public async Task<List<string>> GetCompartilhamentosAsync(int tarefaId)
        {
            return await _httpClient.GetFromJsonAsync<List<string>>($"api/tarefas/{tarefaId}/compartilhamentos") ?? new List<string>();
        }
    }
}
