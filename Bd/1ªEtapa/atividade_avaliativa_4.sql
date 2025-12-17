-- Q1

-- left inclusive

select * from customer left join rental on customer.customer_id = rental.customer_id;

-- left exclusive

select * from customer left join rental on customer.customer_id = rental.customer_id
where rental.rental_id is null;

-- right inclusive

select * from customer right join rental on customer.customer_id = rental.customer_id;

-- right exclusive

select * from customer right join rental on customer.customer_id = rental.customer_id
where customer.customer_id is null;

-- full outer inclusive

select * from customer left join rental on customer.customer_id = rental.customer_id

union

select * from customer right join rental on customer.customer_id = rental.customer_id;

-- full outer exclusive

select * from customer left join rental on customer.customer_id = rental.customer_id
where rental.rental_id is null

union

select * from customer right join rental on customer.customer_id = rental.customer_id
where customer.customer_id is null;

-- inner join

select * from customer inner join rental on customer.customer_id = rental.customer_id;



-- Q4

-- a
select productcode, sum(quantityordered) as total vendido from orderdetails join orders using (ordernumber)
where year(orderdate) = 2003 group by productcode order by total_vendido desc
limit 20;


-- b
select
    month(orderdate) as mes,
    avg(quantityordered * priceeach) as media,
    max(quantityordered * priceeach) as maximo,
    min(quantityordered * priceeach) as minimo
from orderdetails 
join orders using (ordernumber)
join customers using (customernumber)
join employees on customers.salesrepemployeenumber = employees.employeenumber
join offices on employees.officecode = offices.officecode
where year(orderdate) = 2004 and city = 'paris'
group by mes;


-- c
select productcode, sum(quantityordered) as total
from orderdetails
join orders using (ordernumber)
where month(requireddate) between 9 and 12
group by productcode;

-- d
select offices.officecode, count(customernumber) as total_clientes
from customers
join employees on customers.salesrepemployeenumber = employees.employeenumber
join offices on employees.officecode = offices.officecode
group by offices.officecode
order by total_clientes desc;

-- e
select productcode, sum(quantityordered) as total_vendido
from orderdetails
join orders using (ordernumber)
where year(orderdate) = 2004 and month(orderdate) between 1 and 6
group by productcode
order by total_vendido asc
limit 15;

-- f
select
    avg(quantityordered * priceeach) as media,
    max(quantityordered * priceeach) as maximo,
    min(quantityordered * priceeach) as minimo
from orderdetails
join orders using (ordernumber)
join customers using (customernumber)
join employees on customers.salesrepemployeenumber = employees.employeenumber
join offices on employees.officecode = offices.officecode
where year(orderdate) = 2003 and city = 'tokyo';

-- g
select productcode, min(quantityordered) as menor_quantidade
from orderdetails
join orders using (ordernumber)
where month(requireddate) between 9 and 12
group by productcode;

-- h 
select offices.officecode, count(customernumber) as total_clientes
from customers
join employees on customers.salesrepemployeenumber = employees.employeenumber
join offices on employees.officecode = offices.officecode
group by offices.officecode
order by total_clientes desc;

