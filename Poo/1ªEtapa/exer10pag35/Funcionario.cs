using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace exer10pag35
{
    internal class Funcionario
    {
        private int idFuncioanrio;
        private string nome;
        private string cargo;

        public Funcionario(int idFuncioanrio, string nome, string cargo)
        {
            this.idFuncioanrio = idFuncioanrio;
            this.nome = nome;
            this.cargo = cargo;
        }
    }
}
