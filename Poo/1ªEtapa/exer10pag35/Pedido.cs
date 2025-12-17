using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace exer10pag35
{
    internal class Pedido
    {
        private int numero;
        private DateTime dataCriacao;
        private string status;
                private int idcliente;

        public Pedido(int numero, DateTime dataCriacao, string status, int idcliente)
        {
            this.numero = numero;
            this.dataCriacao = dataCriacao;
            this.status = status;
            this.idcliente = idcliente;
        }
    }
}
