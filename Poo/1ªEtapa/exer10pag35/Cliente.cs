using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace exer10pag35
{
    internal class Cliente
    {
        private int idcliente;
        private string nome;
        private string telefone;

        public Cliente(int idcliente, string nome, string telefone)
        {
            this.idcliente = idcliente;
            this.nome = nome;
            this.telefone = telefone;
        }
    }
}
