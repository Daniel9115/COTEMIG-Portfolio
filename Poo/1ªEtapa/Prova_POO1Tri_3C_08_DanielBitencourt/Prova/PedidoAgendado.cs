using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Prova
{
    public class PedidoAgendado : PedidosDelivery
    {
        private string nomeCliente;
        private double valorBase;

        public PedidoAgendado(double taxaEntrega, double valorBase) : base(taxaEntrega, valorBase)
        {
        }


        public string DetalhesPedido()
        {
            return $"Nome do cliente: {nomeCliente}";
        }
    }
    
}
