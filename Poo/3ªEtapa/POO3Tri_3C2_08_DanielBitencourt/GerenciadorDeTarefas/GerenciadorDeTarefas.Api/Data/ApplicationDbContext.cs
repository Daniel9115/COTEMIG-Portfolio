using Microsoft.EntityFrameworkCore;
using GerenciadorDeTarefas.Shared.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;

namespace GerenciadorDeTarefas.Data;

public class ApplicationDbContext : IdentityDbContext<IdentityUser>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    public DbSet<Tarefa> Tarefas { get; set; }
    public DbSet<Compartilhamento> Compartilhamentos { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        
        // Configuração da entidade Tarefa
        modelBuilder.Entity<Tarefa>(entity =>
        {
            entity.HasKey(t => t.Id);
            entity.Property(t => t.Titulo).IsRequired().HasMaxLength(100);
            entity.Property(t => t.Descricao).IsRequired().HasMaxLength(500);
            entity.Property(t => t.UsuarioId).IsRequired().HasMaxLength(450);
            entity.Property(t => t.DataVencimento).IsRequired();
            entity.Property(t => t.Concluida).HasDefaultValue(false);
            
            // Índice para melhorar performance nas consultas
            entity.HasIndex(t => t.UsuarioId);
            entity.HasIndex(t => new { t.UsuarioId, t.Concluida });
        });
        
        // Configuração da entidade Compartilhamento
        modelBuilder.Entity<Compartilhamento>(entity =>
        {
            entity.HasKey(c => c.Id);
            entity.Property(c => c.TarefaId).IsRequired();
            entity.Property(c => c.UsuarioIdCompartilhado).IsRequired().HasMaxLength(450);
            
            // Relacionamento com Tarefa
            entity.HasOne<Tarefa>()
                  .WithMany()
                  .HasForeignKey(c => c.TarefaId)
                  .OnDelete(DeleteBehavior.Cascade);
            
            // Índice único para evitar compartilhamentos duplicados
            entity.HasIndex(c => new { c.TarefaId, c.UsuarioIdCompartilhado }).IsUnique();
        });
    }
}