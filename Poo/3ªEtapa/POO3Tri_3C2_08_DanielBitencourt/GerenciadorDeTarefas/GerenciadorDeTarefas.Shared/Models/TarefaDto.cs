using System.ComponentModel.DataAnnotations;

namespace GerenciadorDeTarefas.Shared.Models
{
    public class TarefaDto
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "O título é obrigatório")]
        [StringLength(100, ErrorMessage = "O título deve ter no máximo 100 caracteres")]
        public string Titulo { get; set; } = string.Empty;

        [Required(ErrorMessage = "A descrição é obrigatória")]
        [StringLength(500, ErrorMessage = "A descrição deve ter no máximo 500 caracteres")]
        public string Descricao { get; set; } = string.Empty;

        [Required(ErrorMessage = "A data de vencimento é obrigatória")]
        public DateTime DataVencimento { get; set; }

        public bool Concluida { get; set; } = false;

        // Propriedades adicionais para exibição
        public bool EhProprietario { get; set; }
        public bool EhCompartilhada { get; set; }
        public List<string> CompartilhadoCom { get; set; } = new();
    }

    public class CompartilharTarefaDto
    {
        [Required(ErrorMessage = "O ID do usuário é obrigatório")]
        public string UsuarioId { get; set; } = string.Empty;
    }
}