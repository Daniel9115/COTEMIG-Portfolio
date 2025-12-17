using System.ComponentModel.DataAnnotations;

namespace GerenciadorDeTarefas.Shared.Models
{
    public class Compartilhamento
    {
        public int Id { get; set; }

        [Required]
        public int TarefaId { get; set; }

        [Required]
        // ID do usuário com quem a tarefa foi compartilhada (GUID)
        public string UsuarioIdCompartilhado { get; set; } = string.Empty; 
    }
}
