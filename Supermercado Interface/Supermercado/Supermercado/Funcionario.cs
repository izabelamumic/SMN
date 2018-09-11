using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Supermercado
{
    public class Funcionario : Pessoa
    {
        private string cargo;
        private double salario;
        
        public Funcionario(string nome, string CPF_CNPJ) : base(nome, CPF_CNPJ)
        {

        }

        public string Cargo { get => cargo; set => cargo = value; }
        public double Salario { get => salario; set => salario = value; }

        public override void mostrarDados()
        {
            //Console.WriteLine("Nome: " + Nome + "\nCPF/CNPJ: " + CPF_CNPJ + "\nCargo: " + this.cargo + "\nSalario: " + this.salario);
            Interface i = new Interface();
            i.lfuncionario.Text = Nome;
        }
    }
}
