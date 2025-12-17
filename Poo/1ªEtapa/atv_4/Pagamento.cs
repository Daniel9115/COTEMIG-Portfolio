using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pg35_10
{
    class Pagamento
    {
        private int numeroTransacao;
        private double valor;
        private string metodo;

        public Pagamento(int numeroTransacao, double valor, string metodo)
        {
            this.numeroTransacao = numeroTransacao;
            this.valor = valor;
            this.metodo = metodo;
        }

        public void RealizarPagamento()
        {
            MessageBox.Show("Pagamento realizado no valor de R$" + valor.ToString("F2") + " via " + metodo, "Pagamento");
        }
    }
}
