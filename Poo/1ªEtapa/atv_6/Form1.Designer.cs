namespace atv_6
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
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnComprarpassagem = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.btnComprarpassagem);
            this.panel1.Location = new System.Drawing.Point(169, 96);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(450, 253);
            this.panel1.TabIndex = 0;
            // 
            // btnComprarpassagem
            // 
            this.btnComprarpassagem.Location = new System.Drawing.Point(168, 204);
            this.btnComprarpassagem.Name = "btnComprarpassagem";
            this.btnComprarpassagem.Size = new System.Drawing.Size(120, 23);
            this.btnComprarpassagem.TabIndex = 1;
            this.btnComprarpassagem.Text = "Comprar passagem";
            this.btnComprarpassagem.UseVisualStyleBackColor = true;
            this.btnComprarpassagem.Click += new System.EventHandler(this.btnComprarpassagem_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.panel1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button btnComprarpassagem;
    }
}

