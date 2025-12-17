using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Calculadora_Classe
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        Calculadora calc = new Calculadora();
        Banco b = new Banco();

        private void button1_Click(object sender, EventArgs e)
        {
            calc.setValores(int.Parse(textBox1.Text), int.Parse(textBox2.Text));
            MessageBox.Show("Test: " + calc.getSoma());


            b.setaldo(b.getSoma());

            /*int num1 = int.Parse(textBox1.Text);
            int num2 = int.Parse(textBox2.Text);*/
        }
    }
}
