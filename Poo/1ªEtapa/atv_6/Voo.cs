using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace atv_6
{
    public class Voo : Aeroporto
    {
        private string dataHora;
        private Aeroporto destino;
        private Piloto piloto;
        private Aeronave aeronave;

        public Voo(int codigo, string nome, string cidade, string estado, string pais, string dataHora,
                   Aeroporto destino, Piloto piloto, Aeronave aeronave)
            : base(codigo, nome, cidade, estado, pais)
        {
            this.dataHora = dataHora;
            this.destino = destino;
            this.piloto = piloto;
            this.aeronave = aeronave;
        }
    }
}
