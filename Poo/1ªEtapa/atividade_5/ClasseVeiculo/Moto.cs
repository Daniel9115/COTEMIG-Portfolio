using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClasseVeiculo
{
    internal class Moto : Veiculo
    {
        private int cilindrada;

        public Moto(int cilindrada)
        {
            this.cilindrada = cilindrada;
        }
    }
}
