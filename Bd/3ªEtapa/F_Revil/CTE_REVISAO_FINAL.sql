-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CLASSICMODELS - cte
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

USE CLASSICMODELS;

WITH cte_itemPedido (numeroNota, preco_unitario, qtdProduto) AS (
    SELECT
        orderNumber,
        priceEach,
        quantityOrdered
    FROM 
        orderdetails
    GROUP BY orderNumber, priceEach, quantityOrdered
),
cte_pedido (numeroNota, codigoCliente, dataPedido) AS (
    SELECT
        orderNumber,
        customerNumber,
        orderDate
    FROM
        orders
),
cte_cliente (codigoCliente, nomeCliente, codigoVendedor) AS (
    SELECT 
        customerNumber,
        customerName,
        salesRepEmployeeNumber
    FROM 
        customers
),
cte_pagamento (codigoCliente, valorNota, numeroPagamento, dataPagamento) AS (
    SELECT
        customerNumber,
        amount,
        checkNumber,
        paymentDate
    FROM
        payments
),
cte_vendedor (codigoVendedor, nomeVendedor) AS (
    SELECT
        employeeNumber,
        CONCAT(firstName, ' ', lastName)
    FROM
        employees
)
SELECT 
    nomeCliente,
    valorNota,
    SUM(preco_unitario * qtdProduto) AS TOTAL_NOTA,
    numeroPagamento,
    CASE
        WHEN SUM(preco_unitario * qtdProduto) <> valorNota
            THEN CONCAT('Conversa com o representante: ', nomeVendedor)
        ELSE 'Tudo certo'
    END AS analise
FROM 
    cte_itemPedido
    INNER JOIN cte_pedido USING (numeroNota)
    INNER JOIN cte_cliente USING (codigoCliente)
    INNER JOIN cte_pagamento USING (codigoCliente)
    INNER JOIN cte_vendedor USING (codigoVendedor)
WHERE 
    YEAR(dataPedido) = YEAR(dataPagamento)
    AND MONTH(dataPedido) = MONTH(dataPagamento)
GROUP BY 
    nomeCliente, valorNota, numeroPagamento, nomeVendedor
ORDER BY 
    numeroPagamento
LIMIT 20;

with cte_produto (CodigoProduto, NomeProduto) as (
select
	productCode,
    ProductName
from
	products
),
cte_itemPedido (CodigoProduto, Quantidade, NumeroNota) as (
select
	productCode,
    quantityOrdered,
    orderNumber
from
	orderdetails
),
cte_pedido (NumeroNota, DataPedido) as (
select
	orderNumber,
    orderDate
from
	orders),
cte_cliente (CodigoCliente, NomeCliente, CodigoVendedor) as (
select
	customerNumber,
    customerName,
    salesRepEmployeeNumber
from
	customers
),
cte_pagamento (CodigoCliente, Valor, DataPagamento) as (
select
	customerNumber,
    amount,
    paymentDate
 from 
	payments
),
cte_vendedor (CodigoVendedor, CodigoEscritorio, NomeVendedor) as (
select
	employeeNumber,
    officeCode,
    concat(firstName, ' ', lastName)
from
	employees
),
cte_escritorio (CodigoEscritorio, Escritorio) as (
select
	officeCode,
    city
from 
	offices
)

SELECT 
  observacao, 
  COUNT(observacao)
FROM 
(
select 
	sum(Quantidade) total,
    NomeProduto,
    'PRODUTO' as observacao
from 
	cte_produto
    inner join cte_itemPedido using (CodigoProduto)
    inner join cte_pedido using (NumeroNota)
where
	year(DataPedido) = 2004
group by
	NomeProduto
having
	total between 400 and 800
    
UNION

select
	sum(valor) total,
    NomeCliente,
    'CLIENTE' as observacao
from 
	cte_cliente
      inner join cte_pagamento using (CodigoCliente)
	  inner join cte_vendedor using (CodigoVendedor)
      INNER JOIN cte_escritorio USING (CodigoEscritorio)
WHERE
	MONTH(DataPagamento) IN (10, 11, 12)
    AND YEAR (DataPagamento) = 2004
    AND Escritorio IN ('London', 'San Francisco')
group by
	NomeCliente
having
	total > 5000
    
UNION

Select
	Sum(valor) total,
    NomeVendedor,
    'VENDEDOR' as observacao
from 
	cte_pagamento
       inner join cte_cliente using (CodigoCliente)
       inner join cte_vendedor using (CodigoVendedor)
where 
	year(DataPagamento) = 2005
group by
	NomeVendedor
having
	total > 200000
) as RESULTADO
group by
	Observacao;
   
   
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Sakila - cte
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

USE SAKILA;

with cte_categoria (CategoriaNome, CodigoCategoria) as (
select
	name,
    category_id
from
	category
where
	name in ('Comedy', 'Drama')
),
cte_CategoriaFilme (CodigoCategoria, CodigoFilme) as (
select
	category_id,
    film_id
from
	film_category
),
cte_filme (CodigoFilme) as (
select
	film_id
from
	film
),
cte_inventario (CodigoFilme, CodigoInventario, CodigoLoja) as (
select
	film_id,
    inventory_id,
    store_id
from
	inventory
)
select
	CategoriaNome, 
	CodigoLoja,
    count(CodigoInventario) as qtde
from
	cte_categoria
    inner join cte_CategoriaFilme using (CodigoCategoria)
    inner join cte_filme using (CodigoFilme)
    inner join cte_inventario using (CodigoFilme)
group by
	CategoriaNome, CodigoLoja;


with cte_cliente (NomeCliente, CodigoCliente) as (
select
	CONCAT(FIRST_NAME, ' ', LAST_NAME),
    customer_id
from
	customer
),
cte_pagamento (valor, CodigoCliente, CodigoAluguel, DataPagamento) as (
select
	amount,
    customer_id,
    rental_id,
    payment_date
from
	payment
WHERE 
	YEAR(PAYMENT_DATE) = 2005
	AND MONTH(PAYMENT_DATE) = 8
),
cte_aluguel (CodigoAluguel, CodigoInventario, DataDeRetorno, DataEmprestimo) as
(
select
	rental_id,
    inventory_id,
    return_date,
    rental_date
from
	rental
),
cte_inventario (CodigoInventario, CodigoFilme) as
(
select
	inventory_id,
    film_id
from
	inventory
),
cte_filme (CodigoFilme, DuracaoEmprestimo, TaxaDeAluguel) as
(
select
	film_id,
    rental_duration,
    rental_rate
from
	film
)
select
	NomeCliente,
    sum(valor) AS VALOR_PAGO,
    IFNULL( DuracaoEmprestimo - CAST(DATEDIFF(DataDeRetorno, DataEmprestimo) AS DECIMAL), 999) AS ANALISE_DIA,
    CASE
      WHEN sum(valor) = TaxaDeAluguel THEN 'Valor Correto'
      ELSE 'Investigar'
	END AS ANALISE
from
	cte_cliente
    inner join cte_pagamento using (CodigoCliente)
    inner join cte_aluguel using (CodigoAluguel)
    inner join cte_inventario using (CodigoInventario)
    inner join cte_filme using (CodigoFilme)
GROUP BY
	NomeCliente, ANALISE_DIA, TaxaDeAluguel
order by
	ANALISE_DIA ASC
LIMIT 10;

#Letra B 

with cte_categoria (CodigoCategoria, nomeCategoria) as
(
select
	category_id,
    name
from
	category
),
cte_FilmeCategoria (CodigoCategoria, CodigoFilme) as
(
select
	category_id,
    film_id
from
	film_category
),
cte_Filme (CodigoFilme, Titulo) as
(
select
	film_id,
    title
from
	film
),
cte_inventario (CodigoFilme, CodigoInventario, CodigoLoja) as 
(
select
	film_id,
    inventory_id,
    store_id
from
	inventory
),
cte_Emprestimo(CodigoInventario, CodigoEmprestimo) as
(
select
	inventory_id,
    rental_id
from
	rental
)

select
	Titulo,
    CodigoLoja,
    nomeCategoria,
    count(CodigoInventario) AS QTDE
from 
	cte_categoria
    inner join cte_FilmeCategoria using (CodigoCategoria)
    inner join cte_Filme using (CodigoFilme)
    inner join cte_inventario using (CodigoFilme)
    LEFT JOIN cte_Emprestimo using (CodigoInventario)
where 
	CodigoEmprestimo is null
group by
	Titulo, CodigoLoja, nomeCategoria;
    
#Letra c

with cte_cliente (CodigoCliente, atividade) as (
select
    customer_id,
    active
from
	customer
WHERE 
	ACTIVE = 0
),
cte_filme (CodigoFilme) as
(
select
	film_id
from
	film
),
cte_inventario (CodigoFilme, CodigoInventario) as
(
select
	film_id,
    inventory_id
from
	inventory
),
cte_emprestimo (CodigoEmprestimo, DataDeRetorno) as
(
select 
	rental_id,
    return_date
from
	RENTAL
WHERE
   RETURN_DATE IS NULL
)
select
	count(CodigoCliente) as qtd,
    'Total de clientes inativos' AS OBSERVACAO
from
	cte_cliente
    
union

select
	count(CodigoFilme),
    'Total de filmes faltantes no estoque'
FROM 
  cte_filme 
    LEFT JOIN cte_inventario USING (CodigoFilme)
WHERE 
  CodigoInventario IS NULL
  
union

select
	count(CodigoEmprestimo),
    'Total de aluguéis sem data de retorno'
FROM 
    cte_emprestimo;