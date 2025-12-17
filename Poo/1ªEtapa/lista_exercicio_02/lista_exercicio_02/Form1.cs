using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace lista_exercicio_02
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void btn1_Click(object sender, EventArgs e)
        {
            if (txt01.Text == "")
            {
                MessageBox.Show("Por favor preencha uma senha.");
            }
            else
            {
                int senha = int.Parse(txt01.Text);
                if (senha == 1234)
                {
                    MessageBox.Show("Acesso permitido");
                }
                else
                {
                    MessageBox.Show("Acesso negado");
                }
            }
        }

        private void btn2_Click(object sender, EventArgs e)
        {
            if (txtProduto.Text == "" || txtQuant.Text == "" || txtPrecoUni.Text == "")
            {
                MessageBox.Show("Erro, vazio.");
            }
            else if (int.Parse(txtQuant.Text) <= 0 || int.Parse(txtPrecoUni.Text) <= 0)
            {
                MessageBox.Show("Erro, negativo.");
            }
            else
            {
                int quantidade = int.Parse(txtQuant.Text);
                int precoUni = int.Parse(txtPrecoUni.Text);
                float desconto = float.Parse(txtDesconto.Text);

                MessageBox.Show($"Total: {(quantidade*precoUni) - desconto}", "Total");
            }
        }

        int saldo = 0;
        private void button1_Click(object sender, EventArgs e)
        {
            if (txtnumConta.Text == "" || txtTitular.Text == "" || cmbtipoMovimento.Text == "" || txtvalorMovimento.Text == "")
            {
                MessageBox.Show("Erro, vazio.");
            }
            else if (txtTitular.Text == "" || cmbtipoMovimento.Text == "" || txtvalorMovimento.Text == "")
            {
                MessageBox.Show("Erro, negativo.");
            }
            else
            {
                int valorMovimento = int.Parse(txtvalorMovimento.Text);
                if (cmbtipoMovimento.Text == "deposito")
                {
                    saldo = valorMovimento;
                    MessageBox.Show("Saldo: " + saldo);
                }
                else if(cmbtipoMovimento.Text == "saque")
                {
                    saldo = saldo - valorMovimento;
                    MessageBox.Show("Saldo: " + saldo);
                }
                else
                {
                    MessageBox.Show("Erro, vazio.");    
                }
            }

        }

        private void btn4_Click(object sender, EventArgs e)
        {
            int[] vet = new int[6];
            string texto = "";
            int num = 100;
            for (int i = 0; i < vet.Length; i++)
            {
                vet[i] = num;
                texto += $"Índice {i} = {vet[i]}\n";
                num = num * 2;
            }
            MessageBox.Show(texto);
        }

        private void btn7_Click(object sender, EventArgs e)
        {
            if (txtN1.Text == "" || txtN2.Text == "" || txtN3.Text == "")
            {
                MessageBox.Show("Erro.Vazio");
            }
            else
            {
                int n1 = int.Parse(txtN1.Text);
                int n2 = int.Parse(txtN2.Text);
                int n3 = int.Parse(txtN3.Text);
                int numMaior = 0;
                if (n1 == n2 || n2 == n3 || n3 == n1)
                {
                    MessageBox.Show("Erro, iguais.");

                }
                else
                {
                    if (n1 > n2 && n1 > n3)
                    {
                        numMaior = n1;
                    }
                    else if (n2 > n1 && n2 > n3)
                    {
                        numMaior = n2;
                    }
                    else
                    {
                        numMaior = n3;
                    }

                    MessageBox.Show("O maior número é: " + numMaior);
                }
            }
        }

        private void btn10_Click(object sender, EventArgs e)
        {
            int soma = 0;

            for (int i = 0; i <= 1000; i += 10)
            {
                soma += i;
            }

            MessageBox.Show("Soma: " + soma);
        }
    }
}
