namespace ClasseVeiculo
{
    partial class Form1
    {
        /// <summary>
        /// Variável de designer necessária.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpar os recursos que estão sendo usados.
        /// </summary>
        /// <param name="disposing">true se for necessário descartar os recursos gerenciados; caso contrário, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código gerado pelo Windows Form Designer

        /// <summary>
        /// Método necessário para suporte ao Designer - não modifique 
        /// o conteúdo deste método com o editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.label5 = new System.Windows.Forms.Label();
            this.txtCilindrada = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtEixos = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtCargaMax = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtCombustivel = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.txtPortas = new System.Windows.Forms.TextBox();
            this.btnCaminhao = new System.Windows.Forms.Button();
            this.btnAutomovel = new System.Windows.Forms.Button();
            this.btnMoto = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(202, 189);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(53, 13);
            this.label5.TabIndex = 25;
            this.label5.Text = "Cilindrada";
            // 
            // txtCilindrada
            // 
            this.txtCilindrada.Location = new System.Drawing.Point(191, 205);
            this.txtCilindrada.Name = "txtCilindrada";
            this.txtCilindrada.Size = new System.Drawing.Size(75, 20);
            this.txtCilindrada.TabIndex = 24;
            this.txtCilindrada.Visible = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(540, 189);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(32, 13);
            this.label3.TabIndex = 23;
            this.label3.Text = "Eixos";
            // 
            // txtEixos
            // 
            this.txtEixos.Location = new System.Drawing.Point(518, 205);
            this.txtEixos.Name = "txtEixos";
            this.txtEixos.Size = new System.Drawing.Size(75, 20);
            this.txtEixos.TabIndex = 22;
            this.txtEixos.Visible = false;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(535, 117);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(43, 26);
            this.label4.TabIndex = 21;
            this.label4.Text = "Cargar\r\nMáxima";
            // 
            // txtCargaMax
            // 
            this.txtCargaMax.Location = new System.Drawing.Point(518, 146);
            this.txtCargaMax.Name = "txtCargaMax";
            this.txtCargaMax.Size = new System.Drawing.Size(75, 20);
            this.txtCargaMax.TabIndex = 20;
            this.txtCargaMax.Visible = false;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(362, 189);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(66, 13);
            this.label2.TabIndex = 19;
            this.label2.Text = "Combustível";
            // 
            // txtCombustivel
            // 
            this.txtCombustivel.Location = new System.Drawing.Point(358, 205);
            this.txtCombustivel.Name = "txtCombustivel";
            this.txtCombustivel.Size = new System.Drawing.Size(75, 20);
            this.txtCombustivel.TabIndex = 18;
            this.txtCombustivel.Visible = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(377, 130);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(37, 13);
            this.label1.TabIndex = 17;
            this.label1.Text = "Portas";
            // 
            // txtPortas
            // 
            this.txtPortas.Location = new System.Drawing.Point(358, 146);
            this.txtPortas.Name = "txtPortas";
            this.txtPortas.Size = new System.Drawing.Size(75, 20);
            this.txtPortas.TabIndex = 16;
            this.txtPortas.Visible = false;
            // 
            // btnCaminhao
            // 
            this.btnCaminhao.Location = new System.Drawing.Point(518, 255);
            this.btnCaminhao.Name = "btnCaminhao";
            this.btnCaminhao.Size = new System.Drawing.Size(75, 23);
            this.btnCaminhao.TabIndex = 15;
            this.btnCaminhao.Text = "Caminhão";
            this.btnCaminhao.UseVisualStyleBackColor = true;
            // 
            // btnAutomovel
            // 
            this.btnAutomovel.Location = new System.Drawing.Point(358, 255);
            this.btnAutomovel.Name = "btnAutomovel";
            this.btnAutomovel.Size = new System.Drawing.Size(75, 23);
            this.btnAutomovel.TabIndex = 14;
            this.btnAutomovel.Text = "Automóvel";
            this.btnAutomovel.UseVisualStyleBackColor = true;
            // 
            // btnMoto
            // 
            this.btnMoto.Location = new System.Drawing.Point(191, 255);
            this.btnMoto.Name = "btnMoto";
            this.btnMoto.Size = new System.Drawing.Size(75, 23);
            this.btnMoto.TabIndex = 13;
            this.btnMoto.Text = "Moto";
            this.btnMoto.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.txtCilindrada);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtEixos);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txtCargaMax);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtCombustivel);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtPortas);
            this.Controls.Add(this.btnCaminhao);
            this.Controls.Add(this.btnAutomovel);
            this.Controls.Add(this.btnMoto);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtCilindrada;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtEixos;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtCargaMax;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtCombustivel;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtPortas;
        private System.Windows.Forms.Button btnCaminhao;
        private System.Windows.Forms.Button btnAutomovel;
        private System.Windows.Forms.Button btnMoto;
    }
}

