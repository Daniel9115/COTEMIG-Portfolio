using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace atv_6
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btnComprarpassagem_Click(object sender, EventArgs e)
        {
            Aeroporto destino = new Aeroporto(2, "Aeroporto B", "Cidade B", "Estado B", "Brasil");
            Piloto piloto = new Piloto(1, "Carlos Silva", "2020-05-10");
            Aeronave aeronave = new Aeronave(1, "Boeing 737", 180, 70000);

            Cliente cliente = new Cliente(
                1, "Maria Souza", "98765432100", "Rua A, 123",
                1, "Cartão", 800.00,
                1, "15B", "98765432100", "Maria Souza", 800.00,
                1, "Voo 101", "Belo Horizonte", "MG", "Brasil", "2025-04-24 14:00",
                destino, piloto, aeronave
            );

            cliente.MostrarCliente();
            cliente.RealizarVenda();
        }
    }
}
