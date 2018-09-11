using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Supermercado
{
    //cria uma classe abstrada 
    public abstract class Pessoa
    {
        private string nome;
        private string cpf_cnpj;
        
        protected Pessoa(string Nome, string CPF_CNPJ)
        {
            this.nome = Nome;
            this.cpf_cnpj = CPF_CNPJ;

        }

        public string Nome { get => nome; set => nome = value; }
        public string CPF_CNPJ { get => cpf_cnpj; set => cpf_cnpj = value; }

        public virtual void mostrarDados()
        {
            
        }

    }

}
