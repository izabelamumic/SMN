using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace Supermercado
{
    public partial class Interface : Form
    {
        private Label vt3;
        private Label pr3;
        private Label q3;
        private Label p3;
        private Label vt2;
        private Label pr2;
        private Label q2;
        private Label p2;
        private Label vt1;
        private Label pr1;
        private Label q1;
        private Label p1;
        private Label label_totalCompra;
        private Label label_data;
        private Label label2;
        private Label label_funcionario;
        private Label label_cliente;
        private Label label_valorTotal;
        private Label label_PrecoUnitario;
        private Label label_quantidade;
        private Label label_produto;
        private Panel panel1;
        private Label label_valorCompra;
        public Label lcliente;
        public Label lfuncionario;
        private Label ldata;
        private Label label1;

        public Interface()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void InitializeComponent()
        {
            this.vt3 = new System.Windows.Forms.Label();
            this.pr3 = new System.Windows.Forms.Label();
            this.q3 = new System.Windows.Forms.Label();
            this.p3 = new System.Windows.Forms.Label();
            this.vt2 = new System.Windows.Forms.Label();
            this.pr2 = new System.Windows.Forms.Label();
            this.q2 = new System.Windows.Forms.Label();
            this.p2 = new System.Windows.Forms.Label();
            this.vt1 = new System.Windows.Forms.Label();
            this.pr1 = new System.Windows.Forms.Label();
            this.q1 = new System.Windows.Forms.Label();
            this.p1 = new System.Windows.Forms.Label();
            this.label_totalCompra = new System.Windows.Forms.Label();
            this.label_data = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label_funcionario = new System.Windows.Forms.Label();
            this.label_cliente = new System.Windows.Forms.Label();
            this.label_valorTotal = new System.Windows.Forms.Label();
            this.label_PrecoUnitario = new System.Windows.Forms.Label();
            this.label_quantidade = new System.Windows.Forms.Label();
            this.label_produto = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.lfuncionario = new System.Windows.Forms.Label();
            this.lcliente = new System.Windows.Forms.Label();
            this.label_valorCompra = new System.Windows.Forms.Label();
            this.ldata = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // vt3
            // 
            this.vt3.AutoSize = true;
            this.vt3.Location = new System.Drawing.Point(417, 163);
            this.vt3.Name = "vt3";
            this.vt3.Size = new System.Drawing.Size(58, 13);
            this.vt3.TabIndex = 44;
            this.vt3.Text = "Valor Total";
            // 
            // pr3
            // 
            this.pr3.AutoSize = true;
            this.pr3.Location = new System.Drawing.Point(304, 163);
            this.pr3.Name = "pr3";
            this.pr3.Size = new System.Drawing.Size(74, 13);
            this.pr3.TabIndex = 43;
            this.pr3.Text = "Preço Unitário";
            // 
            // q3
            // 
            this.q3.AutoSize = true;
            this.q3.Location = new System.Drawing.Point(209, 163);
            this.q3.Name = "q3";
            this.q3.Size = new System.Drawing.Size(62, 13);
            this.q3.TabIndex = 42;
            this.q3.Text = "Quantidade";
            // 
            // p3
            // 
            this.p3.AutoSize = true;
            this.p3.Location = new System.Drawing.Point(21, 163);
            this.p3.Name = "p3";
            this.p3.Size = new System.Drawing.Size(44, 13);
            this.p3.TabIndex = 41;
            this.p3.Text = "Produto";
            // 
            // vt2
            // 
            this.vt2.AutoSize = true;
            this.vt2.Location = new System.Drawing.Point(417, 141);
            this.vt2.Name = "vt2";
            this.vt2.Size = new System.Drawing.Size(58, 13);
            this.vt2.TabIndex = 40;
            this.vt2.Text = "Valor Total";
            // 
            // pr2
            // 
            this.pr2.AutoSize = true;
            this.pr2.Location = new System.Drawing.Point(304, 141);
            this.pr2.Name = "pr2";
            this.pr2.Size = new System.Drawing.Size(74, 13);
            this.pr2.TabIndex = 39;
            this.pr2.Text = "Preço Unitário";
            // 
            // q2
            // 
            this.q2.AutoSize = true;
            this.q2.Location = new System.Drawing.Point(209, 141);
            this.q2.Name = "q2";
            this.q2.Size = new System.Drawing.Size(62, 13);
            this.q2.TabIndex = 38;
            this.q2.Text = "Quantidade";
            // 
            // p2
            // 
            this.p2.AutoSize = true;
            this.p2.Location = new System.Drawing.Point(21, 141);
            this.p2.Name = "p2";
            this.p2.Size = new System.Drawing.Size(44, 13);
            this.p2.TabIndex = 37;
            this.p2.Text = "Produto";
            // 
            // vt1
            // 
            this.vt1.AutoSize = true;
            this.vt1.Location = new System.Drawing.Point(417, 118);
            this.vt1.Name = "vt1";
            this.vt1.Size = new System.Drawing.Size(58, 13);
            this.vt1.TabIndex = 36;
            this.vt1.Text = "Valor Total";
            // 
            // pr1
            // 
            this.pr1.AutoSize = true;
            this.pr1.Location = new System.Drawing.Point(304, 118);
            this.pr1.Name = "pr1";
            this.pr1.Size = new System.Drawing.Size(74, 13);
            this.pr1.TabIndex = 35;
            this.pr1.Text = "Preço Unitário";
            // 
            // q1
            // 
            this.q1.AutoSize = true;
            this.q1.Location = new System.Drawing.Point(209, 118);
            this.q1.Name = "q1";
            this.q1.Size = new System.Drawing.Size(62, 13);
            this.q1.TabIndex = 34;
            this.q1.Text = "Quantidade";
            // 
            // p1
            // 
            this.p1.AutoSize = true;
            this.p1.Location = new System.Drawing.Point(21, 118);
            this.p1.Name = "p1";
            this.p1.Size = new System.Drawing.Size(44, 13);
            this.p1.TabIndex = 33;
            this.p1.Text = "Produto";
            // 
            // label_totalCompra
            // 
            this.label_totalCompra.AutoSize = true;
            this.label_totalCompra.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label_totalCompra.Location = new System.Drawing.Point(20, 191);
            this.label_totalCompra.Name = "label_totalCompra";
            this.label_totalCompra.Size = new System.Drawing.Size(396, 24);
            this.label_totalCompra.TabIndex = 32;
            this.label_totalCompra.Text = "TOTAL:                                                R$";
            // 
            // label_data
            // 
            this.label_data.AutoSize = true;
            this.label_data.Location = new System.Drawing.Point(24, 290);
            this.label_data.Name = "label_data";
            this.label_data.Size = new System.Drawing.Size(79, 13);
            this.label_data.TabIndex = 31;
            this.label_data.Text = "Data e Horário:";
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.SystemColors.MenuHighlight;
            this.label2.Location = new System.Drawing.Point(137, 10);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(186, 16);
            this.label2.TabIndex = 30;
            this.label2.Text = "Supermercado Varejo Franca";
            // 
            // label_funcionario
            // 
            this.label_funcionario.AutoSize = true;
            this.label_funcionario.Location = new System.Drawing.Point(24, 259);
            this.label_funcionario.Name = "label_funcionario";
            this.label_funcionario.Size = new System.Drawing.Size(96, 13);
            this.label_funcionario.TabIndex = 29;
            this.label_funcionario.Text = "Nome Funcionário:";
            // 
            // label_cliente
            // 
            this.label_cliente.AutoSize = true;
            this.label_cliente.Location = new System.Drawing.Point(24, 229);
            this.label_cliente.Name = "label_cliente";
            this.label_cliente.Size = new System.Drawing.Size(73, 13);
            this.label_cliente.TabIndex = 28;
            this.label_cliente.Text = "Nome Cliente:";
            // 
            // label_valorTotal
            // 
            this.label_valorTotal.AutoSize = true;
            this.label_valorTotal.Location = new System.Drawing.Point(417, 87);
            this.label_valorTotal.Name = "label_valorTotal";
            this.label_valorTotal.Size = new System.Drawing.Size(58, 13);
            this.label_valorTotal.TabIndex = 27;
            this.label_valorTotal.Text = "Valor Total";
            // 
            // label_PrecoUnitario
            // 
            this.label_PrecoUnitario.AutoSize = true;
            this.label_PrecoUnitario.Location = new System.Drawing.Point(304, 87);
            this.label_PrecoUnitario.Name = "label_PrecoUnitario";
            this.label_PrecoUnitario.Size = new System.Drawing.Size(74, 13);
            this.label_PrecoUnitario.TabIndex = 26;
            this.label_PrecoUnitario.Text = "Preço Unitário";
            // 
            // label_quantidade
            // 
            this.label_quantidade.AutoSize = true;
            this.label_quantidade.Location = new System.Drawing.Point(209, 87);
            this.label_quantidade.Name = "label_quantidade";
            this.label_quantidade.Size = new System.Drawing.Size(62, 13);
            this.label_quantidade.TabIndex = 25;
            this.label_quantidade.Text = "Quantidade";
            // 
            // label_produto
            // 
            this.label_produto.AutoSize = true;
            this.label_produto.Location = new System.Drawing.Point(21, 87);
            this.label_produto.Name = "label_produto";
            this.label_produto.Size = new System.Drawing.Size(44, 13);
            this.label_produto.TabIndex = 24;
            this.label_produto.Text = "Produto";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(191, 51);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(128, 20);
            this.label1.TabIndex = 23;
            this.label1.Text = "CUPOM FISCAL";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.ldata);
            this.panel1.Controls.Add(this.lfuncionario);
            this.panel1.Controls.Add(this.lcliente);
            this.panel1.Controls.Add(this.label_valorCompra);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Location = new System.Drawing.Point(12, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(478, 305);
            this.panel1.TabIndex = 45;
            // 
            // lfuncionario
            // 
            this.lfuncionario.AutoSize = true;
            this.lfuncionario.Location = new System.Drawing.Point(114, 247);
            this.lfuncionario.Name = "lfuncionario";
            this.lfuncionario.Size = new System.Drawing.Size(47, 13);
            this.lfuncionario.TabIndex = 33;
            this.lfuncionario.Text = "Nenhum";
            // 
            // lcliente
            // 
            this.lcliente.AutoSize = true;
            this.lcliente.Location = new System.Drawing.Point(91, 217);
            this.lcliente.Name = "lcliente";
            this.lcliente.Size = new System.Drawing.Size(47, 13);
            this.lcliente.TabIndex = 32;
            this.lcliente.Text = "Nenhum";
            this.lcliente.Click += new System.EventHandler(this.lcliente_Click);
            // 
            // label_valorCompra
            // 
            this.label_valorCompra.AutoSize = true;
            this.label_valorCompra.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label_valorCompra.Location = new System.Drawing.Point(410, 185);
            this.label_valorCompra.Name = "label_valorCompra";
            this.label_valorCompra.Size = new System.Drawing.Size(60, 16);
            this.label_valorCompra.TabIndex = 31;
            this.label_valorCompra.Text = "             ";
            this.label_valorCompra.Click += new System.EventHandler(this.label_valorCompra_Click);
            // 
            // ldata
            // 
            this.ldata.AutoSize = true;
            this.ldata.Location = new System.Drawing.Point(98, 278);
            this.ldata.Name = "ldata";
            this.ldata.Size = new System.Drawing.Size(47, 13);
            this.ldata.TabIndex = 34;
            this.ldata.Text = "Nenhum";
            // 
            // Interface
            // 
            this.ClientSize = new System.Drawing.Size(502, 329);
            this.Controls.Add(this.vt3);
            this.Controls.Add(this.pr3);
            this.Controls.Add(this.q3);
            this.Controls.Add(this.p3);
            this.Controls.Add(this.vt2);
            this.Controls.Add(this.pr2);
            this.Controls.Add(this.q2);
            this.Controls.Add(this.p2);
            this.Controls.Add(this.vt1);
            this.Controls.Add(this.pr1);
            this.Controls.Add(this.q1);
            this.Controls.Add(this.p1);
            this.Controls.Add(this.label_totalCompra);
            this.Controls.Add(this.label_data);
            this.Controls.Add(this.label_funcionario);
            this.Controls.Add(this.label_cliente);
            this.Controls.Add(this.label_valorTotal);
            this.Controls.Add(this.label_PrecoUnitario);
            this.Controls.Add(this.label_quantidade);
            this.Controls.Add(this.label_produto);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.panel1);
            this.Name = "Interface";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Cupom Fiscal";
            this.Load += new System.EventHandler(this.Interface_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        private void Interface_Load(object sender, EventArgs e)
        {
            label_valorCompra.Text = "7.99";
            

            Cliente c = new Cliente("Josiel", "123.456.789-96");
            c.Endereco = "Av Ismael Alonso y Alonso";
            c.Telefone = "(16)3124-1087";
            //c.mostrarDados();
            lcliente.Text = c.Nome;
            
            

            Funcionario f = new Funcionario("Andreza", "456.123.789-52");
            f.Cargo = "Caixa";
            f.Salario = 990.50;
            //f.mostrarDados();
            lfuncionario.Text = f.Nome;
            


            Produto p = new Produto("Detergente", 1.00, "Ypê 200ml", "Limpeza");
            Produto p2 = new Produto("Sabão em Pó", 7.00, "1kg", "Limpeza");
            Produto p3 = new Produto("Bolacha Recheada", 2.09, "Negresco 80g", "Alimento");
            p.mostrarProduto();
            p2.mostrarProduto();
            p3.mostrarProduto();

            Item i = new Item(p, 3);
            Item i2 = new Item(p2, 4);
            Item i3 = new Item(p3, 2);

            List<Item> lista = new List<Item>();
            lista.Add(i);
            lista.Add(i2);
            lista.Add(i3);

            double valorCompra = 0;

            foreach (Item item in lista)
            {
                valorCompra = valorCompra + item.valorItem();
            }

            Compra compra = new Compra(lista, c, f, valorCompra);
            Console.WriteLine("Valor compra: R$" + valorCompra);
            compra.mostraCompra();

            
        }

        private void label_valorCompra_Click(object sender, EventArgs e)
        {
            
        }

        private void lcliente_Click(object sender, EventArgs e)
        {

        }
    }
}
