using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pg35_10
{
    class Cliente
    {
        private int idCliente;
        private string nome;
        private string telefone;

        public Cliente(int idCliente, string nome, string telefone)
        {
            this.idCliente = idCliente;
            this.nome = nome;
            this.telefone = telefone;
        }

        public Pedido FazerPedido(int numero, DateTime dataCriacao)
        {
            return new Pedido(numero, dataCriacao, this);
        }
    }
}
