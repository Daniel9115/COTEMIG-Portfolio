use classicmodels;

-- COMMOM TABLE EXPRESSION(CTE)

select * from customers;

with cte_cliente(codigo, nome, telefone, endereco) as
(select 
	customerNumber,
    customerName,
    phone,
    addressLine1
    from customers
    where
		creditlimit > 50000),
    cte_pagamento(codigo, valor) as
(select
	customerNumber,
    sum(amount)
	from 
		payments
    where
		year(paymentdate) in (2004, 2005)
	group by
		customerNumber)
 
select 
	*
from 
	cte_cliente
	inner join cte_pagamento using(codigo);
    
    
    
-- -------------------------------------------
    
    
    
create or replace view analise_lucro_produto
as
with 
cte_produto(codigoProduto, nomeProduto, preco_compra, preco_sugerido)
as(
	select
    productCode,
    productName,
    buyprice,
    msrp
    from
    products
),
cte_itemProduto (codigoProduto, numeronota, preco_unitario)
as(
	select
    productCode,
    ordernumber,
    priceEach
    from orderdetails
),
cte_pedido(numeronota, codigoCliente, dataPedido)
as(
	select
    ordernumber,
    customernumber,
    orderdate
    from
    orders
    where
    year(orderdate) in (2004, 2005
    and month(orderdate) in (10, 11))
),

cte_cliente(codigoCliente, codigoVendedor)
as(
	select
    customerNumber,
    salesRepEmployeeNumber
    from
	customers
),

cte_vendedor(codigoVendedor, codigoEscritorio)
as(
	select
    employeeNumber,
    officeCode
    from
    employees
),
cte_escritorio(codigoEscritorio, Escritorio)
as(
	select
	officeCode,
    city
    from
    offices
    where
    city in ('San Francisco', 'Tokyo', 'Paris')
)

select
	nomeProduto,
    preco_unitario,
    preco_compra,
    preco_sugerido,
    round(((preco_unitario/preco_compra) -1) * 100, 1) as lucro_prec_compra,
    round(((preco_unitario/preco_sugerido) -1) * 100, 1) as lucro_prec_sugerido
from
	cte_produto
		inner join cte_itemProduto using(codigoProduto)
		inner join cte_pedido using(numeroNota)
		inner join cte_cliente using(codigoCliente)
		inner join cte_vendedor using(codigoVendedor)
		inner join cte_escritorio using(codigoEscritorio);
        
select * from analise_lucro_produto;      
