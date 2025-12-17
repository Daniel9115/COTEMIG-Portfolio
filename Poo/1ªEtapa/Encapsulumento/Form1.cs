using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Encapsulumento
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        Metodo meto = new Metodo(); //criando instância da classe

        private void btnCadastro_Click(object sender, EventArgs e)
        {
            string valor = txtValor.Text;
            MessageBox.Show("Valor digitado: " + valor);

            meto.valor = int.Parse(txtValor.Text);
            meto.setNumero(int.Parse(txtNumero.Text));

            // meto.numero = int.Parse(txtValor.Text);

        }
    }
}
