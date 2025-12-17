using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace exerc6pag34
{
    internal class Cartao : Pagamento
    {
        public override double Pagar()
        {
            return (base.Pagar() * 2);
        }

        public void calculaSal(double inss, double irrf)
        {
            double total = inss + irrf - sal;
        }
    }
}
