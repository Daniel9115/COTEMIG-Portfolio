use classicmodels;
create or replace view ANALISE_PERCENTUAL_LUCRO (NOME_PRODUTO, PRECO_UNITARIO, PRECO_COMPRA, PRECO_SUGERIDO, PERCENTUAL_COMPRA, PERCENTUAL_PRECO_SUGERIDO)
as
select
	productName,
    priceeach,
    buyPrice,
    MSRP,
    round(((priceEach/buyPrice)*100)-1, 2) as percentualCompra,
    round(((priceEach/MSRP)*100)-1, 2) as percentualPrecosug
    
from
	products
    inner join orderdetails using(productCode)
    inner join orders using(orderNumber)
    inner join customers using(customerNumber)
    inner join employees on salesRepEmployeeNumber = employeeNumber
    inner join offices using(officeCode)
        
where
	offices.city in ('San Francisco', 'Tokyo', 'Paris')
    and	month(orderDate) in (10, 11, 12)
    and year(orderDate) in (2004, 2005);
    
select * from ANALISE_PERCENTUAL_LUCRO;

create or replace view ANALISE_MEDIA_PERCENTUAL
as
select
	nome_produto,
    round(avg(percentual_preco_sugerido), 2) as media_percentual_sugerido,
    round(avg(percentual_compra), 2) as media_percentual_compra
from 
	analise_percentual_lucro
group by
	nome_produto;
    
select * from ANALISE_MEDIA_PERCENTUAL;
