using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pg35_10
{
    class Pedido
    {
        private int numero;
        private DateTime dataCriacao;
        private string status;
        private Cliente cliente;
        private ItemCardapio[] itens;
        private int quantidadeItens;

        public Pedido(int numero, DateTime dataCriacao, Cliente cliente)
        {
            this.numero = numero;
            this.dataCriacao = dataCriacao;
            this.status = "Em preparo";
            this.cliente = cliente;
            this.itens = new ItemCardapio[10];
            this.quantidadeItens = 0;
        }

        public bool AdicionarItem(ItemCardapio item)
        {
            if (quantidadeItens < 10)
            {
                itens[quantidadeItens] = item;
                quantidadeItens++;
                return true;
            }
            return false;
        }

        public double CalcularTotal()
        {
            double total = 0;
            for (int i = 0; i < quantidadeItens; i++)
            {
                total += itens[i].GetPreco();
            }
            return total;
        }

        public void FinalizarPedido()
        {
            status = "Pronto";
            MessageBox.Show("Pedido finalizado!", "Status do Pedido");
        }

        public void ExibirItens()
        {
            string listaItens = "Itens do Pedido:\n";
            for (int i = 0; i < quantidadeItens; i++)
            {
                listaItens += "- " + itens[i].GetNome() + "\n";
            }
            MessageBox.Show(listaItens, "Itens do Pedido");
        }
    }
}
