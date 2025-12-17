using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pg35_10
{
    class Funcionario
    {
        private int idFuncionario;
        private string nome;
        private string cargo;

        public Funcionario(int idFuncionario, string nome, string cargo)
        {
            this.idFuncionario = idFuncionario;
            this.nome = nome;
            this.cargo = cargo;
        }

        public void RegistrarPedido(Pedido pedido)
        {
            MessageBox.Show("Pedido registrado pelo garçom: " + nome, "Registro de Pedido");
        }

        public void PrepararPedido(Pedido pedido)
        {
            MessageBox.Show("Pedido preparado pelo cozinheiro: " + nome, "Preparação de Pedido");
        }
    }
}
