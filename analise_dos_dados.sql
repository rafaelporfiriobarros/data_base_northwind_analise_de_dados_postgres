/********************************************* Vendas e Pedidos *********************************************/

/******************** 1. Qual foi o total de vendas por mês no último ano? ********************/

/* Primeiro fui buscar os dados referentes as datas das compras, 
   encontrei na tabela orders a coluna order_date. */

SELECT * FROM orders limit 5;

/* Em seguida fui buscar os dados das vendas
, 
   encontrei na tabela order_details a coluna unit_price, quantity e discount. */

SELECT * FROM order_details limit 5;

/* A pergunta de negócio é o total de vendas por mês no último ano,
   então procurei saber o último ano de vendas.
   O último ano de vendas foi 1998. */

select max(order_date) from orders;

/* Então criei a seguinte query juntando as duas tabelas através do join: */

SELECT 
    TO_CHAR(o.order_date, '1998-MM') AS mes_ano,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_vendas
FROM orders AS o
JOIN order_details AS od ON o.order_id = od.order_id
GROUP BY mes_ano
ORDER BY mes_ano;

/* 

- TO_CHAR(o.order_date, '1998-MM') - Converte a data para o formato YYYY-MM, permitindo agrupar por mês.

- SUM(od.unit_price * od.quantity * (1 - od.discount)) - Calcula o total de vendas considerando o preço unitário, a quantidade e o desconto.

- GROUP BY mes_ano - Agrupa os resultados por mês.

- ORDER BY mes_ano - Ordena os resultados cronologicamente. */

/******************** 2. Quais são os produtos mais vendidos em termos de quantidade? ********************/

/* Primeiro executei essa query para localizar a coluna product_name da tabela products */

SELECT * FROM products LIMIT 5;

/* Em seguida busquei na tabela order_details a coluna quantity */

SELECT * FROM order_details LIMIT 5;

/* Então criei a seguinte query juntando as duas tabelas através do join: */

SELECT p.product_name, 
       SUM(od.quantity) AS total_quantidade_vendida
FROM order_details AS od 
JOIN products AS p 
ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantidade_vendida DESC
LIMIT 10;

/* 

- Em SUM(od.quantity) - Soma a quantidade total vendida de cada produto.

- FROM order_details AS od JOIN products AS p ON od.product_id = p.product_id - Junta os detalhes do pedido com a tabela de produtos.

- GROUP BY p.product_name - Agrupa os resultados pelo nome do produto.

- ORDER BY total_quantidade_vendida DESC - Ordena do mais vendido para o menos vendido.

- LIMIT 10 - Retorna apenas os 10 produtos mais vendidos. */


/******************** 3. Quais são os clientes que mais compraram em valor total? ********************/


/* Primeiro executei a seguinte query para localizar a coluna company_name da tabela customers, 
   que são consideradas como os clientes. */
SELECT * FROM customers limit 10;

/* Em seguida, executei a seguinte query para puxar as colunas de orders */
SELECT * FROM orders limit 10;

/* Em seguida, executei a seguinte query pra puxar as colunas unit_price, quantity e discount,
   que são relacionadas as vendas. */
   SELECT * FROM order_details LIMIT 10;

/* Então criei a seguinte query juntando as três tabelas através do join: */
SELECT c.company_name AS cliente, 
	   SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_gasto
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id
JOIN order_details AS od ON o.order_id = od.order_id
GROUP BY c.company_name
ORDER BY total_gasto DESC
LIMIT 10;


/* 

- SUM(od.unit_price * od.quantity * (1 - od.discount)) - Calcula o valor total gasto por cada cliente.

- JOIN customers AS c ON o.customer_id = c.customer_id - Junta os pedidos com os clientes.

- JOIN order_details AS od ON o.order_id = od.order_id - Junta os detalhes do pedido para calcular os valores.

- GROUP BY c.company_name - Agrupa os resultados por cliente.

- ORDER BY total_gasto DESC - Ordena do cliente que mais gastou para o que menos gastou.

- LIMIT 10 - Retorna os 10 clientes que mais compraram.













