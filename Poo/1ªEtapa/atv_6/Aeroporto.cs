using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace atv_6
{
    public class Aeroporto
    {
        private int codigo;
        private string nome;
        private string cidade;
        private string estado;
        private string pais;

        public Aeroporto(int codigo, string nome, string cidade, string estado, string pais)
        {
            this.codigo = codigo;
            this.nome = nome;
            this.cidade = cidade;
            this.estado = estado;
            this.pais = pais;
        }
    }
}
