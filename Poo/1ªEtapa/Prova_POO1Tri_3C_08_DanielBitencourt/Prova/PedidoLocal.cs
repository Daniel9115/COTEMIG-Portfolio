using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Prova
{
    public class PedidoLocal : Pedido
    {
        public PedidoLocal(double valorBase) : base(valorBase)
        {
        }

        public void MensagemLocal()
        {
            MessageBox.Show("Nome do Cliente: ");
        }
    }
}
