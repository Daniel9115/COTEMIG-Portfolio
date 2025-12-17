using Microsoft.EntityFrameworkCore;
using GerenciadorDeTarefas.Shared;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;

namespace GerenciadorDeTarefas.Data;

public class ApplicationDbContext : IdentityDbContext<IdentityUser>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    public DbSet<Tarefa> Tarefas { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Dados iniciais para um usuário administrador
        var adminUser = new IdentityUser
        {
            Id = "a18be9c0-aa65-4af8-bd17-00bd9344e575",
            UserName = "admin@tarefas.com",
            NormalizedUserName = "ADMIN@TAREFAS.COM",
            Email = "admin@tarefas.com",
            NormalizedEmail = "ADMIN@TAREFAS.COM",
            EmailConfirmed = true,
            // Hash fixo para a senha "Admin@123"
            PasswordHash = "AQAAAAIAAYagAAAAEHqOZ8vn8Da8NFKMxHtLfUeelk7ncpHmC4HdUBzjQeXzJQTKtT6ddVTgzgzRlWn/Tg==",
            SecurityStamp = "SEJYWTDXNBQXGQCHMPKDMQRJXNKQZRQV",
            ConcurrencyStamp = "c8554266-b401-4519-9aeb-667a8ef0b0c6"
        };

        modelBuilder.Entity<IdentityUser>().HasData(adminUser);
    }
}