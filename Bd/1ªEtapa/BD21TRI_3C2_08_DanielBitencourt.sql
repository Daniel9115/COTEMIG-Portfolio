use classicmodels;

-- a
select 
	customers.customerName,
    amount,
    checknumber,
    (quantityordered * priceEach) as TOTAL_NOTA,
    customerNumber,
	count(distinct customerNumber) AS QTDE_CLIENTE, 
	sum(payments.amount) AS TOTAL_PAG, 
	case
		when TOTAL_PAG != TOTAL_NOTA then concat('Conversa com o representante:', ' ', customerName)
		else 'Tudo certo'
	end as analise
from  
	customers 
    inner join payments using (customerNumber)
    inner join orders using(customerNumber)
    inner join orderdetails using(orderNumber)
where
	year(PAYMENTDATE) = year(orderDate)
	and month(PAYMENTDATE) = month(orderDate)
order by
	checknumber
limit 20;

-- b
-- i
select
	products.productName as Produto,
	orderdetails.priceEach as Preco_Unitario,
	count(orderdetails.quantityOrdered * orderdetails.priceEach) as Total
from 
	orderdetails
join
	orders on orderdetails.orderNumber = orders.orderNumber
join
	customers on orders.customerNumber = customers.customerNumber
join
	employees on customers.salesRepEmployeeNumber = employees.employeeNumber
join
	products on orderdetails.productCode = products.productCode
where 
	year(orders.orderDate) = 2004
	and orderdetails.quantityOrdered * orderdetails.priceEach between 400 and 800
group by Total;

-- ii
select 
  CUSTOMERNAME as CLIENTE, 
  CITY as CIDADE 
from 
	CUSTOMERS
    inner join PAYMENTS using (CUSTOMERNUMBER)
	inner join offices using (city)
where  
	month(PAYMENTDATE) in (10, 11, 12)
	and year(PAYMENTDATE) = 2004
	or city = 'London'
	and city = 'San Francisco'
group by 
   CLIENTE
having SUM(AMOUNT) > 50000;
  
-- c
use sakila;
select * from  category group by name;
select 
	*,
    store.store_id as loja,
    category.name as categoria
from  
	film
inner join inventory using(film_id)
inner join film_category using(film_id)
inner join category using(category_id)
inner join store using(store_id)
where 
	category.name = 'Drama'
    and category.name = 'Comedy'
group by  
	categoria, loja;

-- d
create database questaoD;
use questaoD;
create table sala(
	CodigoSala int unsigned primary key auto_increment,
    Capacidade int,
    CodigoSerie int
) engine = InnoDB;

create table serie(
	CodigoSerie int unsigned primary key auto_increment,
    Unidade text not null,
    CodigoSala int
) engine = InnoDB;

create table serie_sala(
  fk_sala int unsigned not null, 
  fk_serie int unsigned not null, 

  foreign key (fk_sala) references sala (CodigoSala) On Delete restrict,
  foreign key (fk_serie) references serie (CodigoSerie) On Delete restrict
) engine = InnoDB;

