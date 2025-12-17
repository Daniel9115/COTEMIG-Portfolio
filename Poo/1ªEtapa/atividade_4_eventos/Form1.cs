using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace atividade_4_eventos
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            float n1 = float.Parse(txtN1.Text);
            float n2 = float.Parse(txtN2.Text);

            lblSoma.Text = $"{n1} + {n2} = {n1 + n2}";
            lblSub.Text = $"{n1} - {n2} = {n1 - n2}";
            lblMulti.Text = $"{n1} X {n2} = {n1 * n2}";
            lblDiv.Text = $"{n1} / {n2} = {n1 / n2}";
        }
    }
}
