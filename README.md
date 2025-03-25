# Análise de Dados - Northwind com PostgreSQL

## Descrição do Projeto
Este projeto tem como objetivo realizar uma análise exploratória do banco de dados Northwind, utilizando PostgreSQL para consultas e manipulação dos dados. O Northwind é um banco de dados fictício clássico que simula uma pequena empresa de comércio, contendo informações sobre produtos, pedidos, clientes, fornecedores e funcionários.

## Tecnologias Utilizadas
- **PostgreSQL** - Sistema de gerenciamento de banco de dados relacional
- **PgAdmin** - Ferramentas para gerenciar e visualizar o banco de dados

## Instalação
1. Baixe e instale o PostgreSQL.
2. Faça o download do banco de dados (data_base.sql) Northwind adaptado para PostgreSQL.
3. Importe o banco de dados para o PostgreSQL utilizando o comando:
   ```sh
   psql -U seu_usuario -d nome_do_banco -f caminho_para_o_arquivo/data_base.sql
   ```

## Estrutura do Banco de Dados
O banco de dados Northwind contém as seguintes tabelas principais:
- **Customers** - Clientes da empresa
- **Employees** - Funcionários
- **Orders** - Pedidos realizados
- **OrderDetails** - Detalhes dos pedidos
- **Products** - Produtos vendidos
- **Suppliers** - Fornecedores dos produtos
- **Categories** - Categorias dos produtos

![northwind-diagram](images/northwind-er-diagram.png)

