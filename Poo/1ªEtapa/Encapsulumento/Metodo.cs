using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Encapsulumento
{
    public class Metodo
    {
        public int valor;
        private int numero;

        /*public void setNumero(int numero)
        {
            this.numero = numero;
        }

        public int getNumero()
        {
            return this.numero;
        }*/

        public void setNumero(int numero)
        {
            this.numero = numero;
        }

        public int getNumero()
        {
            return this.numero;
        }

        public void chamada()
        {
            setNumero(valor);
            System.Windows.Forms.MessageBox.Show("Test"+getNumero());
        }
    }
}
