using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms.VisualStyles;

namespace exerc6pag34
{
    abstract class Pagamento
    {
        public double valor;
        private double sal;
        virtual public double Pagar()
        {
            return valor;
        }
        virtual public void calculaSal(double inss)
        {
            double total = sal - inss;
        }
    }
}
