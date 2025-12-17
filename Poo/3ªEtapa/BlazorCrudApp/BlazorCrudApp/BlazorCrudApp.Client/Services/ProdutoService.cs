using BlazorCrudApp.Shared.Models;
using System.Net.Http.Json; // Fornece métodos de extensão para HttpClient, como GetFromJsonAsync.

namespace BlazorCrudApp.Client.Services
{
    // Implementação concreta da interface IProdutoService.
    public class ProdutoService : IProdutoService
    {
        // Cliente HTTP para fazer requisições à nossa API.
        private readonly HttpClient _httpClient;

        // O construtor recebe o HttpClient via injeção de dependência.
        public ProdutoService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<Produto>> GetProdutos()
        {
            // Faz uma requisição GET para "api/produtos" e desserializa a resposta JSON para uma lista de produtos.
            var produtos = await _httpClient.GetFromJsonAsync<List<Produto>>("api/produtos");
            // Retorna a lista de produtos ou uma lista vazia se a resposta for nula.
            return produtos ?? new List<Produto>();
        }

        public async Task<Produto?> GetProduto(int id)
        {
            // Faz uma requisição GET para "api/produtos/{id}" e desserializa a resposta.
            return await _httpClient.GetFromJsonAsync<Produto>($"api/produtos/{id}");
        }

        public async Task<Produto> AddProduto(Produto produto)
        {
            // Envia o objeto 'produto' como JSON em uma requisição POST para a API.
            var response = await _httpClient.PostAsJsonAsync("api/produtos", produto);
            // Lança uma exceção se a resposta da API for um código de erro (4xx ou 5xx).
            response.EnsureSuccessStatusCode();
            // Lê e desserializa o produto retornado pela API (que agora inclui o ID).
            var novoProduto = await response.Content.ReadFromJsonAsync<Produto>();
            return novoProduto!;
        }

        public async Task<Produto> UpdateProduto(Produto produto)
        {
            // Envia o objeto 'produto' como JSON em uma requisição PUT.
            var response = await _httpClient.PutAsJsonAsync($"api/produtos/{produto.Id}", produto);
            response.EnsureSuccessStatusCode();
            return produto;
        }

        public async Task DeleteProduto(int id)
        {
            // Envia uma requisição DELETE para a API.
            var response = await _httpClient.DeleteAsync($"api/produtos/{id}");
            response.EnsureSuccessStatusCode();
        }
    }
}