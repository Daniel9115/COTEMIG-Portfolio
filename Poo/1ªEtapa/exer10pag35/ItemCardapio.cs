using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace exer10pag35
{
    internal class ItemCardapio
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
    }
}
