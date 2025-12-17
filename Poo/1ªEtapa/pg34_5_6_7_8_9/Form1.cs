using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace pg34_5_6_7_8_9
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        Cachorro c = new Cachorro();
        Gato g = new Gato();
        private void btnCachorro_Click(object sender, EventArgs e)
        {
            c.Latir();
        }

        /*private void btnCartao_Click(object sender, EventArgs e)
        {
            Pagamento cartao = new CartaoCredito();
            double valor = 20;
            MessageBox.Show((cartao.ProcessarPagamento(valor)));
        }*/

        private void btnGato_Click(object sender, EventArgs e)
        {
            g.
        }

        private ContaBancaria conta;

        private void AtualizarCamposConta()
        {MessageBox.Show($"Número da Conta: {conta.NumeroConta}\n Nome do Titular: {conta.NomeTitular}\n Classificação da Conta: {conta.ClassificacaoConta}\n Saldo: {conta.Saldo}");
        }

        private void btnSaque_Click(object sender, EventArgs e)
        {
            double valor = 200;
            conta.Sacar(valor);
            AtualizarCamposConta();
        }

        private void btnDeposito_Click(object sender, EventArgs e)
        {
            double valor = 500;
            conta.Depositar(valor);
            AtualizarCamposConta();
        }
    }
}
