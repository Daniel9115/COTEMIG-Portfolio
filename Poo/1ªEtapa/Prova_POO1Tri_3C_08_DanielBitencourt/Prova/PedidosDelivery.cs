using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Prova
{
    public class PedidosDelivery : Pedido
    {
        private double taxaEntrega;
        private double valorBase;

        public PedidosDelivery(double valorBase, double valorBase1) : base(valorBase)
        {
            taxaEntrega = taxaEntrega;
            valorBase = valorBase;
        }


        public double valorTotal()
        {
            return taxaEntrega;
        }
    }
}
