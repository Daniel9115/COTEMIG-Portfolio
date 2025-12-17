use classicmodels;

select * from orderdetails where ordernumber = 10100;

select sum(quantityordered * priceEach) as total from orderdetails where ordernumber = 10100;
select * from orders where ordernumber = 10100;

select 
   customerName, 
   amount, 
   sum(quantityordered * priceEach) as total,
   case 
     when sum(quantityordered * priceEach) = amount then 'Valor correto'
     when sum(quantityordered * priceEach) < amount then 'Pagamento menor'
     else 'Pagamento maior'
   end as Verificacao
from 
   orderdetails 
     inner join orders using (ordernumber)
     inner join customers using (customerNumber)
     inner join payments using (customerNumber)
where
    year(paymentdate) = 2003
and month(paymentdate) = month(orderdate)
group by 
  customerName, amount;
  
#Modifique a consulta acima, incluindo um novo campo chamado verificao.
# Neste você deverá considerar os critérios definidos abaxio:
# Se o valor total for igual ao valor pago (amount), então escreva: "Valor correto"
# Se o valor total for menor que o valor pagp, então escreva: "Pagamento menor"
# Do contrário, escreva "Pagamento maior".