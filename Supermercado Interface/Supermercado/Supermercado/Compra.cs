using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Supermercado
{
    public class Compra
    {
        private List<Item> item;
        private Cliente cliente;
        private Funcionario funcionario;
        private double valorTotal;

        public Compra(List<Item> item, Cliente cliente, Funcionario funcionario, double valorTotal)
        {
            this.Item = item;
            this.cliente = cliente;
            this.funcionario = funcionario;
            this.valorTotal = valorTotal;
        }

        public Cliente Cliente { get => cliente; set => cliente = value; }
        public double ValorTotal { get => valorTotal; set => valorTotal = value; }
        public List<Item> Item { get => item; set => item = value; }
        internal Funcionario Funcionario { get => funcionario; set => funcionario = value; }

        public void mostraCompra()
        {
            Console.WriteLine("---------------CUPOM FISCAL----------------");
            Console.WriteLine("Nome cliente:" + cliente.Nome + "            Data: " + DateTime.Now);
            Console.WriteLine("Nome funcionário: " + funcionario.Nome);
            Console.WriteLine("Produto              Quantidade      Preço Unitário      Valor Total" );
            foreach (Item item in this.item)
            {
                Console.WriteLine(item.Produto.Nome + "              " + item.Quantidade + "      " + item.Produto.PrecoUnitario + "      " + item.valorItem());
            }
            Console.WriteLine("Valor Total da compra:      " + this.valorTotal);
        }
    }
}
