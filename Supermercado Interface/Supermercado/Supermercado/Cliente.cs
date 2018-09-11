using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Supermercado
{
    public class Cliente : Pessoa
    {
        private string endereco;
        private string telefone;
       
        public Cliente(string nome, string CPF_CNPJ) : base(nome, CPF_CNPJ)
        {
            
        }

        public string Endereco { get => endereco; set => endereco = value; }
        public string Telefone { get => telefone; set => telefone = value; }

       public override void mostrarDados()
        {
            //Console.WriteLine("Nome: " + Nome + "\nCPF/CNPJ: " + CPF_CNPJ + "\nEndereço: " + this.endereco + "\nTelefone: "+ this.telefone);
            Interface i = new Interface();
            i.lcliente.Text = Nome;
            
        }
    }
}
