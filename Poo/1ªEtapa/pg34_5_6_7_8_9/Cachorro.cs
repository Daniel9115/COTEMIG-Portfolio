using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pg34_5_6_7_8_9
{
    internal class Cachorro : Animal
    {
        private string mijarposte;

        public void setXixi(string mijar)
        {
            this.mijarposte = mijar
;       }

        public string getXixi()
        {
            return mijarposte;
        }

        public void Latir()
        {
            EmitirSom("Au au!");
        }

        public void Dados()
        {
            Nome = "bolinha";
            Idade = 4;
            InformacaoDoAnimal();
            
        }
    }
}
