using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace pg35_10
{
    public partial class Form1: Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Cliente cliente = new Cliente(1, "Carlos", "11999999999");
            Pedido pedido = cliente.FazerPedido(1001, DateTime.Now);

            ItemCardapio item1 = new ItemCardapio(1, "Pizza", "Pizza de calabresa", 45.00);
            ItemCardapio item2 = new ItemCardapio(2, "Suco", "Suco de laranja", 10.00);

            pedido.AdicionarItem(item1);
            pedido.AdicionarItem(item2);

            Funcionario garcom = new Funcionario(1, "João", "Garçom");
            garcom.RegistrarPedido(pedido);

            Funcionario cozinheiro = new Funcionario(2, "Pedro", "Cozinheiro");
            cozinheiro.PrepararPedido(pedido);

            pedido.FinalizarPedido();
            pedido.ExibirItens();

            double total = pedido.CalcularTotal();
            Pagamento pagamento = new Pagamento(5001, total, "Cartão de Crédito");
            pagamento.RealizarPagamento();
        }
    }
}
