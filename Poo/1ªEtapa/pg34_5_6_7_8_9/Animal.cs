using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pg34_5_6_7_8_9
{
    abstract class Animal
    {
        protected string Nome;
        protected int Idade;

        public string EmitirSom(string som)
        {
            return som;
        }
        
        public string InformacaoDoAnimal()
        {
            return $"Nome: {Nome}, Idade: {Idade}";
        }
    }
}
