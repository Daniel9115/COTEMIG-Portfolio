using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace exer10pag35
{
    internal class Pagamento
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
    }
}
