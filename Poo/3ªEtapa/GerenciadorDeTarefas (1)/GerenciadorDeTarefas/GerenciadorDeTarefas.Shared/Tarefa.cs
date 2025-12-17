using System.ComponentModel.DataAnnotations;

namespace GerenciadorDeTarefas.Shared;

public class Tarefa
{
    public int Id { get; set; }

    [Required(ErrorMessage = "O título é obrigatório")]
    [StringLength(100, ErrorMessage = "O título deve ter no máximo 100 caracteres")]
    public string Titulo { get; set; } = string.Empty;

    [StringLength(500, ErrorMessage = "A descrição deve ter no máximo 500 caracteres")]
    public string? Descricao { get; set; }

    public DateTime? DataVencimento { get; set; }

    public bool Concluida { get; set; }
}