using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Prova
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnProcessar_Click(object sender, EventArgs e)
        {
            if (txtValorbase.Text == "")
            {
                MessageBox.Show("Campo valor base vazio!");
            }
            else if (txtNome.Text == "")
            {
                MessageBox.Show("Campo nome base vazio!");
            }
            else if (cmbTipopedido.Text == "")
            {
                MessageBox.Show("Selecione o tipo de pedido!");
            }
            else
            {
                try
                {
                    if (double.Parse(txtValorbase.Text) > 0)
                    {
                        string nome = txtNome.Text;
                        double valorbase = double.Parse(txtValorbase.Text);
                        string cmbPedido = cmbTipopedido.Text;
                        Pedido pedido = new Pedido(valorbase);
                        MessageBox.Show($"Nome: {nome}\n{pedido.ExibirValor()}\nTipo de pedido: {cmbPedido}");

                    }
                    else
                    {
                        MessageBox.Show("Digite apenas números positivos!");
                    }
                }
                catch
                {
                    MessageBox.Show("Digite apenas números!");
                }
            }
            
        }
    }
}
