use classicmodels;
select * from payments;
select * from customers; 
select * from employees;
select * from offices;
select * from orders;
select * from orderdetails;
select * from products;
select * from productlines;

select 
	sum(amount) as faturado,
    concat(firstName, ' ', lastName) as nomeCompleto
    from
    payments
    inner join customers using(customerNumber)
    inner join employees on (salesRepEmployeeNumber = EmployeeNumber)
    where
    jobTitle = 'Sales Rep'
    group by
		nomeCompleto
	having Faturado > 500000;
    
    
    
select * from customers; 
select * from employees;
select * from offices;
select * from orders;
select * from orderdetails;
select * from products;
select * from productlines;

select 
	sum(amount) as faturado,
    o.city
    from
    payments as p
    inner join customers as c using(customerNumber)
    inner join employees as e on (salesRepEmployeeNumber = EmployeeNumber)
    inner join offices as o using (officeCode)
    where
    jobTitle = 'Sales Rep'
    group by
		o.city
	having Faturado > 1000000;

select 
	customerName,
    employeeNumber
from employees
	right join customers on (salesRepEmployeeNumber = EmployeeNumber)
where
	employeenumber is null;



#Produtos que não foram vendidos
select 
	productName
from products
	left join orderdetails using (productCode)
where
	orderNumber is null;
    
    
    
#Filmes que não estão no estoque. Lembre-se de entrar na base de dados Sakila
use sakila;
select 
	count(title) 
from film
	left join inventory using (film_id)
where
	inventory_id is null;
    
#utilize a base do classicmodels e retorne as informações abaixo.
#Retorme a relação de clientes e valor pago para as compras realizadas no primeiro trimestre de 2003 a 2005;
#Retorme os esritorios e seus faturamento no ano de 2004 no terceiro trimestre;

(select 
	customerName,
    sum(amount) as totalPago
from
	customers
    inner join payments using (customerNumber)
where
	year(paymentdate) between 2003 and 2005
    and month(paymentdate) in (1, 2, 3)
group by
	customerNumber
limit 5)
union
(select
	offices.city,
    sum(amount) as totalFaturado
    from
    payments
    inner join customers using (customerNumber)
    inner join employees on (salesRepEmployeeNumber = EmployeeNumber)
    inner join offices using (officeCode)
    where
    year(paymentdate) = 2004
    and month(paymentdate) in (1, 2, 3)
    group by offices.city
);

#utilizando a base sakila, realize uma consulta unificando as informações abaixo
#retorne nome dos clientes ativos que tiveram pagamento entre agosto e outubro de 2005 e o país comece com a letra A;
#retorne o nome dos clientes inativas que estão nos países que comece com a letra C

select 
	concat(first_name, ' ', last_name) as nomeCompleto
from
	country
    inner join city using (country_id)
    inner join address using (city_id)
    inner join customer using (address_id)
    inner join payment using (customer_id)
       
where
    month(payment_date) in (8, 9, 10)
	and year(payment_date) = 2005
    and country like 'A%'
    and active = 1

union

select
	concat(first_name, ' ', last_name) as nomeCompleto
from
	country
    inner join city using (country_id)
    inner join address using (city_id)
    inner join customer using (address_id)
       
where
	country like 'C%'
and active = 0;
