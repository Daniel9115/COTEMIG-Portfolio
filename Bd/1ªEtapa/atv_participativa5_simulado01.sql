use classicmodels;

select * from orders;

select * from orderdetails where orderNumber = 10100;

select sum(quantityOrdered * priceEach) as valor_total from orderdetails where orderNumber = 10100;

select * from orders where orderNumber = 10100;
select * from payments where customerNumber = 363;

select 
	customerNumber, 
    amount,
    sum(quantityOrdered * priceEach) as valor_total,
    paymentDate,
    orderDate,
    case
		when sum(quantityOrdered * priceEach) = amount then "Valor Correto"
        when sum(quantityOrdered * priceEach) = amount < amount then "Valor Inferior"
        else "Valor Superior"
	end as Coferencia
from 
	payments
    inner join customers using(customerNumber)
    inner join orders using(customerNumber)
    inner join orderdetails using(orderNumber)
where year(paymentdate) = 2003
and month(paymentdate) = month(orderdate)
group by customerName, paymentDate, orderDate;

#Simulado

select 
	officeCode 
from 
	offices 
    inner join employees using(officeCode)
    where month(orderDate) = 2003
    group by officeCode;
