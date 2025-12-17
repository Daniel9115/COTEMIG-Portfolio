using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pg34_5_6_7_8_9
{
    class ContaBancaria
    {
        private int NumeroConta;
        private string NomeTitular;
        private string ClassificacaoConta;
        private double Saldo;

        public ContaBancaria(int numeroConta, string nomeTitular, string classificacaoConta, double saldo)
        {
            NumeroConta = numeroConta;
            NomeTitular = nomeTitular;
            ClassificacaoConta = classificacaoConta;
            Saldo = saldo;
        }

        public void Sacar(double valor)
        {
            if (valor <= Saldo)
            {
                Saldo -= valor;
            }
            else
            {
                MessageBox.Show("Saldo insuficiente.");
            }
        }

        public void Depositar(double valor)
        {
            Saldo += valor;
        }
    }
}
