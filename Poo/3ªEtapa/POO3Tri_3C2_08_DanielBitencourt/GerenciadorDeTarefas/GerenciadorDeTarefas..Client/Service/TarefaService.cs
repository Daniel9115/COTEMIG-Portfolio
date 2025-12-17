using GerenciadorDeTarefas.Shared.Models;
using System.Net.Http.Json;

namespace GerenciadorDeTarefas.Client.Service
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
                // O caminho "api/tarefas" é relativo ao BaseAddress configurado
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
        }
    }



