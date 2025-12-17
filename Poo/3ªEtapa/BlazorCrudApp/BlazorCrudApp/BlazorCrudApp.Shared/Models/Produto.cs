// Importa o namespace para usar atributos de validação como [Required], [StringLength], etc.
using System.ComponentModel.DataAnnotations;

// Define o namespace para organizar as classes do projeto compartilhado.
namespace BlazorCrudApp.Shared.Models
{
    // Declara a classe Produto, que será nosso modelo de dados.
    public class Produto
    {
        // Chave primária da tabela no banco de dados.
        public int Id { get; set; }

        // Atributo que torna o campo 'Nome' obrigatório. A mensagem de erro é customizada.
        [Required(ErrorMessage = "O nome é obrigatório")]
        // Define o tamanho máximo da string para 100 caracteres.
        [StringLength(100, ErrorMessage = "O nome deve ter no máximo 100 caracteres")]
        // Propriedade para o nome do produto. Inicializada como string vazia para evitar nulos.
        public string Nome { get; set; } = string.Empty;

        // Atributo que torna o campo 'Preco' obrigatório.
        [Required(ErrorMessage = "O preço é obrigatório")]
        // Define um intervalo de valores válidos para o preço (deve ser maior que zero).
        [Range(0.01, double.MaxValue, ErrorMessage = "O preço deve ser maior que zero")]
        // Propriedade para o preço. 'decimal' é usado para precisão monetária.
        public decimal Preco { get; set; }

        // Atributo que torna o campo 'Quantidade' obrigatório.
        [Required(ErrorMessage = "A quantidade é obrigatória")]
        // Define um intervalo de valores válidos (não pode ser negativo).
        [Range(0, int.MaxValue, ErrorMessage = "A quantidade deve ser maior ou igual a zero")]
        // Propriedade para a quantidade em estoque.
        public int Quantidade { get; set; }
    }
}