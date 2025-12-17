use classicmodels;
-- q1
-- a
select
	customerName as Cliente,
    city as Cidade,
    IFNULL(SUM(payments.amount), 0) as Total_Pago
from 
    customers   
left join 
	 payments on customers.customerNumber = payments.customerNumber
where 
    (year(payments.paymentDate) = 2005 or customers.creditLimit = 0)
group by
	customers.customerName, customers.city
having
	Total_Pago > 100000;
-- b
select
	concat(employees.firstName, ' ', employees.lastName) as Empregado,
    offices.city as Escritório,
    sum(orderdetails.quantityOrdered * orderdetails.priceEach) as Total_Vendas,
    sum(orderdetails.quantityOrdered * orderdetails.priceEach) * 0.25 as Bônus,
    month(orders.orderDate) as Mes 
from
	employees
join
	offices on employees.officeCode = offices.officeCode
join
	customers on employees.employeeNumber = customers.salesRepEmployeeNumber
join
	orders on customers.customerNumber = orders.customerNumber
join
	orderdetails on orders.orderNumber = orderdetails.orderNumber
WHERE
	year(orders.orderDate) = 2004
    and month(orders.orderDate) between 7 and 9
    and offices.city IN ('San Francisco', 'Paris')
group by
	Empregado, Escritório, Mes
order by
	Mes;
    
-- c

-- d
select
	products.productName as Produto,
	orderdetails.priceEach as Preco_Unitario,
	orderdetails.quantityOrdered * orderdetails.priceEach as Total_Vendido
from
	orderdetails
join
	orders on orderdetails.orderNumber = orders.orderNumber
join
	customers on orders.customerNumber = customers.customerNumber
join
	employees on customers.salesRepEmployeeNumber = employees.employeeNumber
join
	offices on employees.officeCode = offices.officeCode
join
	products on orderdetails.productCode = products.productCode
where
	year(orders.orderDate) = 2004
	and month(orders.orderDate) between 10 and 12
	and offices.city = 'Boston'
union
select
	products.productName as Produto,
	orderdetails.priceEach as Preco_Unitario,
	orderdetails.quantityOrdered * orderdetails.priceEach as Total_Vendido
from
	orderdetails
join
	orders on orderdetails.orderNumber = orders.orderNumber
join
	customers on orders.customerNumber = customers.customerNumber
join
	employees on customers.salesRepEmployeeNumber = employees.employeeNumber
join
	offices on employees.officeCode = offices.officeCode
join
	products on orderdetails.productCode = products.productCode
where
	year(orders.orderDate) = 2005
	and month(orders.orderDate) between 4 and 6
	and offices.city = 'Tokyo';

-- q2
use world;
select
	Name as Pais,
    Region as Regiao,
    SUM((countrylanguagemployeesPercentage * country.Population) / 100 ) as Total_Falantes
from
	countrylanguagecountrylanguage
join
	country on countrylanguagemployeescountryCode = country.Code
where
	countrylanguagemployeesLanguage = 'English'
    and
    country.Continent = 'asia'
group by
	country.Name, country.Region;