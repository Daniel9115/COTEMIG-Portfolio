
using ControleDeEstoque.Shared;
using Microsoft.EntityFrameworkCore;

namespace ControleDeEstoque.Server.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

        public DbSet<Produto> Produtos { get; set; }

    }
}
