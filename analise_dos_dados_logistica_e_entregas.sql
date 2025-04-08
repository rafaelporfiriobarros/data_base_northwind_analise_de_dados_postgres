/********************************************* Logística e Entregas *********************************************/

/******************** 1. Qual o tempo médio em dias entre a data do pedido e a data de entrega? ********************/

/* Primeiro busquei a tabela referente as datas de compras, encontrei na tabela orders a coluna order_date e shipped_date */
select * from orders limit 5;


/* como precisamos saber o tempo médio em dias entre order_date e shipped_date, então fiz a seguinte query: */
select avg(shipped_date - order_date) as tempo_medio_dias
from orders
where shipped_date is not null;

-- shipped_date - order_date retorna um intervalo em dias.
-- AVG(...) calcula a média desse intervalo.
-- WHERE shipped_date IS NOT NULL evita considerar pedidos ainda não enviados.





/******************** 2. Qual transportadora (shipper) entrega mais rápido em média? ********************/

-- Primeiro busquei os dados da tabela shippers
select * from shippers limit 10;

-- Depois peguei os dados da tabela orders
select * from orders limit 10;

/* como precisamos saber qual transportadora (shipper) entrega mais rápido em média, então fiz a seguinte query: */
select s.company_name as transportadora, 
       avg(o.shipped_date - o.order_date) as tempo_medio_entrega_dias
from orders as o
join shippers as s
on o.ship_via = s.shipper_id
where o.shipped_date is not null
group by s.company_name
order by tempo_medio_entrega_dias;

-- AVG(o.shipped_date - o.order_date) - Tempo médio de entrega em dias.
-- JOIN shippers - Junta a tabela de pedidos com a de transportadoras.
-- GROUP BY s.company_name - Agrupa os dados por nome da transportadora.
-- ORDER BY tempo_medio_entrega_dias - Mostra da mais rápida para a mais lenta.





/******************** 3. Qual é o percentual de pedidos entregues após o prazo esperado? ********************/


select * from orders limit 10;



SELECT 
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE shipped_date > required_date) / COUNT(*),
        2
    ) AS percentual_atrasos
FROM orders
WHERE shipped_date IS NOT NULL AND required_date IS NOT NULL;

-- shipped_date > required_date - Verifica se o pedido foi entregue após o prazo.

-- FILTER (WHERE ...) - Conta só os atrasados dentro do COUNT(*).

-- 100.0 * ... / COUNT(*) - Calcula o percentual.

-- ROUND(..., 2) - Arredonda para 2 casas decimais.

-- WHERE shipped_date IS NOT NULL AND required_date IS NOT NULL - Garante que só pedidos com ambas as datas sejam considerados.


/******************** 4. Quais cidades possuem maior volume de pedidos? ********************/


SELECT 
    ship_city,
    COUNT(*) AS total_pedidos
FROM orders
WHERE ship_city IS NOT NULL
GROUP BY ship_city
ORDER BY total_pedidos DESC
LIMIT 10;

-- ship_city - Cidade para onde o pedido foi enviado.

-- COUNT(*) - Conta quantos pedidos foram feitos para cada cidade.

-- GROUP BY ship_city - Agrupa os pedidos por cidade.

-- ORDER BY total_pedidos DESC - Ordena da cidade com mais pedidos para a com menos.

-- LIMIT 10 - Mostra só as 10 com maior volume.


/******************** 5. Quais regiões possuem maior número de clientes ativos? ********************/

SELECT 
    c.region,
    COUNT(DISTINCT c.customer_id) AS clientes_ativos
FROM customers as c
JOIN orders as o ON c.customer_id = o.customer_id
WHERE c.region IS NOT NULL
GROUP BY c.region
ORDER BY clientes_ativos DESC;

-- JOIN com orders - Considera apenas os clientes que fizeram pedidos.

-- COUNT(DISTINCT c.customer_id) - Garante que cada cliente seja contado uma vez por região.

-- GROUP BY c.region - Agrupa por região.

-- ORDER BY clientes_ativos DESC - Mostra as regiões com mais clientes ativos no topo.

