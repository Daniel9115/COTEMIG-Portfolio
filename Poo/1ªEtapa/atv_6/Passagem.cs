using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace atv_6
{
    public class Passagem : Voo
    {
        private int codigoPassagem;
        private string assento;
        private string cpfPassageiro;
        private string nomePassageiro;
        private double preco;

        public Passagem(int codigoPassagem, string assento, string cpfPassageiro, string nomePassageiro,
                        double preco, int codigoVoo, string nomeVoo, string cidade, string estado, string pais,
                        string dataHora, Aeroporto destino, Piloto piloto, Aeronave aeronave)
            : base(codigoVoo, nomeVoo, cidade, estado, pais, dataHora, destino, piloto, aeronave)
        {
            this.codigoPassagem = codigoPassagem;
            this.assento = assento;
            this.cpfPassageiro = cpfPassageiro;
            this.nomePassageiro = nomePassageiro;
            this.preco = preco;
        }
    }
}
