using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pg35_10
{
    class ItemCardapio
    {
        private int idItem;
        private string nome;
        private string descricao;
        private double preco;

        public ItemCardapio(int idItem, string nome, string descricao, double preco)
        {
            this.idItem = idItem;
            this.nome = nome;
            this.descricao = descricao;
            this.preco = preco;
        }

        public double GetPreco()
        {
            return preco;
        }

        public void AtualizarPreco(double novoPreco)
        {
            preco = novoPreco;
        }

        public string GetNome()
        {
            return nome;
        }
    }
}
