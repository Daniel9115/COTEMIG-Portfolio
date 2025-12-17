namespace pg34_5_6_7_8_9
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
            this.btnCachorro = new System.Windows.Forms.Button();
            this.btnGato = new System.Windows.Forms.Button();
            this.btnPayPal = new System.Windows.Forms.Button();
            this.btnCartao = new System.Windows.Forms.Button();
            this.btnSaque = new System.Windows.Forms.Button();
            this.btnDeposito = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnCachorro
            // 
            this.btnCachorro.Location = new System.Drawing.Point(72, 144);
            this.btnCachorro.Name = "btnCachorro";
            this.btnCachorro.Size = new System.Drawing.Size(75, 23);
            this.btnCachorro.TabIndex = 0;
            this.btnCachorro.Text = "Cachorro";
            this.btnCachorro.UseVisualStyleBackColor = true;
            this.btnCachorro.Click += new System.EventHandler(this.btnCachorro_Click);
            // 
            // btnGato
            // 
            this.btnGato.Location = new System.Drawing.Point(72, 173);
            this.btnGato.Name = "btnGato";
            this.btnGato.Size = new System.Drawing.Size(75, 23);
            this.btnGato.TabIndex = 1;
            this.btnGato.Text = "Gato";
            this.btnGato.UseVisualStyleBackColor = true;
            this.btnGato.Click += new System.EventHandler(this.btnGato_Click);
            // 
            // btnPayPal
            // 
            this.btnPayPal.Location = new System.Drawing.Point(204, 173);
            this.btnPayPal.Name = "btnPayPal";
            this.btnPayPal.Size = new System.Drawing.Size(75, 23);
            this.btnPayPal.TabIndex = 3;
            this.btnPayPal.Text = "PayPal";
            this.btnPayPal.UseVisualStyleBackColor = true;
            // 
            // btnCartao
            // 
            this.btnCartao.Location = new System.Drawing.Point(204, 144);
            this.btnCartao.Name = "btnCartao";
            this.btnCartao.Size = new System.Drawing.Size(75, 23);
            this.btnCartao.TabIndex = 2;
            this.btnCartao.Text = "Cartão";
            this.btnCartao.UseVisualStyleBackColor = true;
            // 
            // btnSaque
            // 
            this.btnSaque.Location = new System.Drawing.Point(338, 144);
            this.btnSaque.Name = "btnSaque";
            this.btnSaque.Size = new System.Drawing.Size(75, 23);
            this.btnSaque.TabIndex = 2;
            this.btnSaque.Text = "Saque";
            this.btnSaque.UseVisualStyleBackColor = true;
            this.btnSaque.Click += new System.EventHandler(this.btnSaque_Click);
            // 
            // btnDeposito
            // 
            this.btnDeposito.Location = new System.Drawing.Point(338, 173);
            this.btnDeposito.Name = "btnDeposito";
            this.btnDeposito.Size = new System.Drawing.Size(75, 23);
            this.btnDeposito.TabIndex = 3;
            this.btnDeposito.Text = "Deposito";
            this.btnDeposito.UseVisualStyleBackColor = true;
            this.btnDeposito.Click += new System.EventHandler(this.btnDeposito_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnDeposito);
            this.Controls.Add(this.btnPayPal);
            this.Controls.Add(this.btnSaque);
            this.Controls.Add(this.btnCartao);
            this.Controls.Add(this.btnGato);
            this.Controls.Add(this.btnCachorro);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnCachorro;
        private System.Windows.Forms.Button btnGato;
        private System.Windows.Forms.Button btnPayPal;
        private System.Windows.Forms.Button btnCartao;
        private System.Windows.Forms.Button btnSaque;
        private System.Windows.Forms.Button btnDeposito;
    }
}

