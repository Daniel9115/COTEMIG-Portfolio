using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace atv_6
{
    public class Cliente : Compra
    {
        private int codigoCliente;
        private string nomeCliente;
        private string cpf;
        private string endereco;

        public Cliente(int codigoCliente, string nomeCliente, string cpf, string endereco,
                       int codigoCompra, string pagamento, double valorTotal,
                       int codigoPassagem, string assento, string cpfPassageiro, string nomePassageiro,
                       double preco, int codigoVoo, string nomeVoo, string cidade, string estado, string pais,
                       string dataHora, Aeroporto destino, Piloto piloto, Aeronave aeronave)
            : base(codigoCompra, pagamento, valorTotal, codigoPassagem, assento, cpfPassageiro,
                   nomePassageiro, preco, codigoVoo, nomeVoo, cidade, estado, pais, dataHora, destino, piloto, aeronave)
        {
            this.codigoCliente = codigoCliente;
            this.nomeCliente = nomeCliente;
            this.cpf = cpf;
            this.endereco = endereco;
        }

        public void MostrarCliente()
        {
            MessageBox.Show($"Cliente: {nomeCliente}\nCPF: {cpf}\nEndereço: {endereco}");
        }
    }
}
