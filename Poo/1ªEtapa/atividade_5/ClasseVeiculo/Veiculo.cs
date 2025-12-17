using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClasseVeiculo
{
    internal class Veiculo
    {
        private string marca, modelo;
        private int ano;
        private decimal preco;

        public Veiculo(string marca, string modelo, int ano, decimal preco)
        {
            this.marca = marca;
            this.modelo = modelo;
            this.ano = ano;
            this.preco = preco;
        }
    }
}
