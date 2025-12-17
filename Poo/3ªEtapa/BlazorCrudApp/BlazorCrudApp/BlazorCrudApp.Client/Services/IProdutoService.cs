using BlazorCrudApp.Shared.Models;

namespace BlazorCrudApp.Client.Services
{
    // Uma interface define um "contrato" de métodos que uma classe deve implementar.
    public interface IProdutoService
    {
        // Contrato para um método que retorna a lista de todos os produtos.
        Task<List<Produto>> GetProdutos();
        // Contrato para um método que retorna um produto pelo seu ID.
        Task<Produto?> GetProduto(int id);
        // Contrato para um método que adiciona um novo produto.
        Task<Produto> AddProduto(Produto produto);
        // Contrato para um método que atualiza um produto existente.
        Task<Produto> UpdateProduto(Produto produto);
        // Contrato para um método que deleta um produto pelo seu ID.
        Task DeleteProduto(int id);
    }
}