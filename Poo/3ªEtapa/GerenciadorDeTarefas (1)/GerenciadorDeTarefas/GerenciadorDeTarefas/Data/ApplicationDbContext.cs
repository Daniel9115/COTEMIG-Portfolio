using Microsoft.EntityFrameworkCore;
using GerenciadorDeTarefas.Shared;

namespace GerenciadorDeTarefas.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    public DbSet<Tarefa> Tarefas { get; set; }
}