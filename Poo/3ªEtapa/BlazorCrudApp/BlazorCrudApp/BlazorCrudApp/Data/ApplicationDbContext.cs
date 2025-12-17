// Importa o modelo 'Produto' do projeto compartilhado.
using BlazorCrudApp.Shared.Models;
// Importa o namespace principal do Entity Framework Core.
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Reflection.Emit;

namespace BlazorCrudApp.Data
{
    // A classe DbContext representa a sessão com o banco de dados.
    public class ApplicationDbContext : DbContext
    {
        // Construtor que recebe as opções de configuração do banco (como a connection string).
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

        // Esta propriedade se tornará a tabela 'Produtos' no banco de dados.
        public DbSet<Produto> Produtos { get; set; }
        public DbSet<Cliente> Clientes { get; set; }
        // Método opcional para configurar o modelo de forma mais detalhada (Fluent API).
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Inicia a configuração da entidade 'Produto'.
            modelBuilder.Entity<Produto>(entity =>
            {
                // Define 'Id' como a chave primária da tabela.
                entity.HasKey(e => e.Id);
                // Configura a propriedade 'Nome' para ser obrigatória (NOT NULL) e ter um tamanho máximo.
                entity.Property(e => e.Nome).IsRequired().HasMaxLength(100);
                // Define o tipo da coluna SQL para 'Preco', garantindo a precisão correta para valores monetários.
                entity.Property(e => e.Preco).HasColumnType("decimal(18,2)");
            });

            modelBuilder.Entity<Cliente>(entity =>
            {
                // Define 'Id' como chave primária.
                entity.HasKey(e => e.Id);

                // Nome obrigatório, máximo 100 caracteres.
                entity.Property(e => e.Nome)
                      .IsRequired()
                      .HasMaxLength(100);

                // Email obrigatório, máximo 100 caracteres (pode limitar aqui também).
                entity.Property(e => e.Email)
                      .IsRequired()
                      .HasMaxLength(100);

                // Telefone obrigatório, máximo 15 caracteres.
                entity.Property(e => e.Telefone)
                      .IsRequired()
                      .HasMaxLength(15);
            });

        }


    }
}