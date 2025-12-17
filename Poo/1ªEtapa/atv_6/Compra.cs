using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace atv_6
{
    public class Compra : Passagem
    {
        private int codigoCompra;
        private string pagamento;
        private double valorTotal;

        public Compra(int codigoCompra, string pagamento, double valorTotal,
                      int codigoPassagem, string assento, string cpfPassageiro, string nomePassageiro,
                      double preco, int codigoVoo, string nomeVoo, string cidade, string estado, string pais,
                      string dataHora, Aeroporto destino, Piloto piloto, Aeronave aeronave)
            : base(codigoPassagem, assento, cpfPassageiro, nomePassageiro, preco,
                   codigoVoo, nomeVoo, cidade, estado, pais, dataHora, destino, piloto, aeronave)
        {
            this.codigoCompra = codigoCompra;
            this.pagamento = pagamento;
            this.valorTotal = valorTotal;
        }

        public void RealizarVenda()
        {
            try
            {
                MessageBox.Show($"Compra realizada com sucesso! Valor total: {valorTotal:C}");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro na venda: " + ex.Message);
            }
        }
    }
}