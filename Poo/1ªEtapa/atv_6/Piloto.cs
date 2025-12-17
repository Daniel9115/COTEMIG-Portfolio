using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace atv_6
{
    public class Piloto
    {
        private int codigo;
        private string nome;
        private string dataAdmissao;

        public Piloto(int codigo, string nome, string dataAdmissao)
        {
            this.codigo = codigo;
            this.nome = nome;
            this.dataAdmissao = dataAdmissao;
        }
    }
}
