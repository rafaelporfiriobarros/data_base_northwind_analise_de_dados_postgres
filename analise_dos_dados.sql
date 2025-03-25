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

- LIMIT 10 - Retorna os 10 clientes que mais compraram. */


/******************** 4. Quais funcionários realizaram o maior número de vendas? ********************/

/* Primeiro executei a seguinte query para localizar a coluna first_name e last_name da tabela employees, 
   que são consideradas como os nomes dos funcionários. */

SELECT * FROM employees limit 10;

/* Em seguida fui buscar os dados das ordens de vendas, 
   encontrei na tabela orders a coluna order_id. */

SELECT * FROM orders limit 5;

/* Então criei a seguinte query juntando as duas tabelas através do join: */
SELECT 
    e.first_name || ' ' || e.last_name AS funcionario,
    COUNT(o.order_id) AS total_vendas
FROM orders AS o
JOIN employees AS e ON o.employee_id = e.employee_id
GROUP BY funcionario
ORDER BY total_vendas DESC
LIMIT 10;

/* 

- e.first_name || ' ' || e.last_name AS funcionario - Junção do nome e sobrenome de cada funcionário e um alias funcionario

- COUNT(o.order_id) - Conta o número total de pedidos realizados por cada funcionário.

- JOIN employees e ON o.employee_id = e.employee_id - Junta os pedidos com a tabela de funcionários.

- GROUP BY funcionario - Agrupa os resultados por funcionário.

- ORDER BY total_vendas DESC - Ordena do funcionário com mais vendas para o que tem menos.

- LIMIT 1 - Retorna apenas o funcionário com o maior número de vendas.

*/


/******************** 5. Qual foi o ticket médio das compras nos últimos meses? ********************/

/* A pergunta de negócio é o ticket médio das compras nos últimos meses,
   então procurei saber o último ano de vendas.
   O último ano de vendas foi 1998, então filtrei os últimos 12 meses. */

select max(order_date) from orders;

/* Em seguida, executei a seguinte query pra puxar as colunas unit_price, quantity e discount,
   que são relacionadas as vendas. */
   
SELECT * FROM order_details limit 10;


/* Então criei a seguinte query juntando as duas tabelas através do join: */

SELECT 
    TO_CHAR(o.order_date, '1998-MM') AS mes_ano,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) / COUNT(DISTINCT o.order_id) AS ticket_medio
FROM orders AS o
JOIN order_details AS od ON o.order_id = od.order_id
WHERE o.order_date BETWEEN '1998-01-01' AND '1998-12-31'   
GROUP BY mes_ano
ORDER BY mes_ano;

/* 

Nessa query calculei o ticket médio filtrando pelos últimos 12 meses da base, que é no período de 1998.

- TO_CHAR(o.order_date, '1998-MM') - Agrupa as vendas por mês.

- SUM(od.unit_price * od.quantity * (1 - od.discount)) - Calcula o total de vendas.

- COUNT(DISTINCT o.order_id) - Conta o número de pedidos distintos.

- Divisão total de vendas / número de pedidos - Calcula o ticket médio.

- WHERE o.order_date BETWEEN '1998-01-01' AND '1998-12-31'  - Considera apenas os últimos 12 meses.

- ORDER BY mes_ano - Organiza os resultados cronologicamente. */


/******************** 6. Quais produtos tiveram maior desconto médio nos pedidos? ********************/

/* Primeiro executei essa query para localizar a coluna product_name da tabela products */

SELECT * FROM products LIMIT 5;

/* Em seguida, executei a seguinte query pra puxar a coluna discount,
   que é relacionada as vendas. */
   
SELECT * FROM order_details LIMIT 10;

/* Então criei a seguinte query juntando as duas tabelas através do join: */

SELECT 
    p.product_name,
    AVG(od.discount) AS desconto_medio
FROM order_details AS od
JOIN products AS p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY desconto_medio DESC
LIMIT 10;

/* 

AVG(od.discount) - Calcula a média dos descontos aplicados para cada produto.

JOIN products p ON od.product_id = p.product_id - Junta os detalhes do pedido com a tabela de produtos.

GROUP BY p.product_name - Agrupa os resultados por nome do produto.

ORDER BY desconto_medio DESC - Ordena do maior para o menor desconto médio.

LIMIT 10 - Retorna apenas os 10 produtos mais descontados.

*/



/******************** 7. Quais foram os cinco produtos mais vendidos em cada categoria? ********************/

/* Primeiramente busquei na tabela products a coluna product_name */
SELECT * FROM products limit 10;

/* Em seguida, busquei na tabela categories a coluna category_name */

SELECT * FROM categories limit 10;

/* E em seguida busquei na tabela order_details a coluna quantity pois é relacionada as vendas */
SELECT * FROM order_details limit 10;


/* Então criei a seguinte query utilizando neste caso o uso de window function: */
WITH ranking AS (
    SELECT 
        c.category_name,
        p.product_name,
        SUM(od.quantity) AS total_vendido,
        RANK() OVER (PARTITION BY c.category_name ORDER BY SUM(od.quantity) DESC) AS posicao
    FROM order_details AS od
    JOIN products AS p ON od.product_id = p.product_id
    JOIN categories AS c ON p.category_id = c.category_id
    GROUP BY c.category_name, p.product_name
)
SELECT 
    category_name, 
    product_name, 
    total_vendido
FROM ranking
WHERE posicao <= 5
ORDER BY category_name, posicao;

/* 

- SUM(od.quantity) - Calcula o total de unidades vendidas por produto.

- PARTITION BY c.category_name - Separa a classificação dentro de cada categoria.

- RANK() OVER (ORDER BY SUM(od.quantity) DESC) - Classifica os produtos do mais vendido para o menos vendido dentro da categoria.

- WHERE posicao <= 5 - Filtra apenas os 5 mais vendidos por categoria.

- Ordenação por category_name e posicao - Garante que os resultados estejam bem organizados.

*/ 


