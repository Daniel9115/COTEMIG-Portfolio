using BlazorCrudApp.Shared.Models;

namespace BlazorCrudApp.Client.Services
{
    public interface IClienteService
    {
        Task<List<Cliente>> GetClientes(string? busca = null);
        Task<Cliente?> GetCliente(int id);
        Task<Cliente> AddCliente(Cliente cliente);
        Task<Cliente> UpdateCliente(Cliente cliente);
        Task DeleteCliente(int id);
    }
}
