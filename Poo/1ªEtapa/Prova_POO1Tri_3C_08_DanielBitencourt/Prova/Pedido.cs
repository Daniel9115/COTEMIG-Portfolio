using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Prova
{
    public class Pedido
    {
        private double valorBase;

        public Pedido(double valorBase)
        {
            this.valorBase = valorBase;
        }

        public string ExibirValor()
        {
            return $"Valor: {valorBase}";
        }
    }
}
