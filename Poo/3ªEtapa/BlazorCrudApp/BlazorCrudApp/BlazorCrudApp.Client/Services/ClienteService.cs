using BlazorCrudApp.Shared.Models;
using System.Net.Http.Json;

namespace BlazorCrudApp.Client.Services
{
    public class ClienteService : IClienteService
    {
        private readonly HttpClient _httpClient;
        public ClienteService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<Cliente>> GetClientes(string? busca = null)
        {
            string url = "api/clientes";
            if (!string.IsNullOrWhiteSpace(busca))
                url += $"?busca={busca}";

            var clientes = await _httpClient.GetFromJsonAsync<List<Cliente>>(url);
            return clientes ?? new List<Cliente>();
        }

        public async Task<Cliente?> GetCliente(int id)
        {
            return await _httpClient.GetFromJsonAsync<Cliente>($"api/clientes/{id}");
        }

        public async Task<Cliente> AddCliente(Cliente cliente)
        {
            var response = await _httpClient.PostAsJsonAsync("api/clientes", cliente);
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadFromJsonAsync<Cliente>() ?? cliente;
        }

        public async Task<Cliente> UpdateCliente(Cliente cliente)
        {
            var response = await _httpClient.PutAsJsonAsync($"api/clientes/{cliente.Id}", cliente);
            response.EnsureSuccessStatusCode();
            return cliente;
        }

        public async Task DeleteCliente(int id)
        {
            var response = await _httpClient.DeleteAsync($"api/clientes/{id}");
            response.EnsureSuccessStatusCode();
        }
    }
}
