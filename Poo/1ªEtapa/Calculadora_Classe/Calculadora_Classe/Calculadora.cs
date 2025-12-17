using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Calculadora_Classe
{
    public class Calculadora
    {
        private int num1, num2;
        protected int x;

        public void setValores(int num1, int num2)
        {
            this.num1 = num1;
            this.num2 = num2;
        }

        public int getSoma()
        {
            return num1 + num2;
        }
    }
}
