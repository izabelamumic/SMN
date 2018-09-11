using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Supermercado
{
    public class Produto
    {
        private string nome;
        private double precoUnitario;
        private string descricao;
        private string tipo;
       
        public Produto(string nome, double precoUnitario, string descricao, string tipo)
        {
            this.nome = nome;
            this.precoUnitario = precoUnitario;
            this.descricao = descricao;
            this.tipo = tipo;
        }

        public string Nome { get => nome; set => nome = value; }
        public double PrecoUnitario { get => precoUnitario; set => precoUnitario = value; }
        public string Descricao { get => descricao; set => descricao = value; }
        public string Tipo { get => tipo; set => tipo = value; }

        public void mostrarProduto()
        {
            Console.WriteLine("Nome: " + this.nome + "\nPreço Unitario: R$" + this.precoUnitario + "\nDescrição: " + this.descricao + "\nTipo: " + this.tipo);
        }
    }
}
