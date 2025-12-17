using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace atv_6
{
    public class Aeronave : Empresa
    {
        private int capacidade;
        private int pesoMaximo;

        public Aeronave(int codigo, string nome, int capacidade, int pesoMaximo)
            : base(codigo, nome)
        {
            this.capacidade = capacidade;
            this.pesoMaximo = pesoMaximo;
        }
    }
}
