use classicmodels;
select
	observacao,
    count(observacao) qtde
from(
select 
	customerName as cliente, 'clientes sem vendedores' as observacao
from
	customers
    left join employees on salesRepEmployeeNumber = employeeNumber
where 
    employeeNumber is null
union
select 
	productName as produto
from 
	products
	left join orderdetails using(productCode)
where
	ordernumber is null
union
select
	concat(firstname, ' ', lastName) as vendedores, 'vendedores sem clientes' as observacao
from
	employees
    left join customers on salesRepEmployeeNumber = employeeNumber
where
	jobtitle = 'Sales Rep'
    and customerName is null) as resulatdo
	group by observacao;
    
#Utilização do CASE

use sakila;
select
	concat(first_name, ' ', last_name) as nomeCliente,
    
case
	when active = 1 then 'Ativo'
    else 'inativo'
end as Tipo_cliente
from
	customer;
    
use classicmodels;
select
		concat(contactLastName, ' ', contactFirstName) as nomeCliente,
    
case
	when creditLimit > 0 then 'Cliente com crédito'
    else 'Cliente sem crédito'
end as Tipo_cliente
from
	customers;
    
#Usando DATEDIFF
use sakila;
select
	datediff(return_date, rental_date) as dias
from rental;

# Construa uma consultaque retorne os filmes que estão no prazo e fora do prazo.
# dica: Utilizar o DateChiff
# Utilizar Inner  JOIN
# Utilizar Case
# Comprar os valores do campo renta_duration com o resultado da DateChiff

select 
	title,
	datediff(return_date, rental_date) as dias,
    rental_duration,
    rental_id,
    case
		when datediff(return_date, rental_date) <= rental_duration then 'Dentro do prazo'
        else 'Fora do prazo'
	end as Situacao_aluguel
from
	rental
    inner join inventory using(inventory_id)
    inner join film using(film_id);
    
# mdoifique a consulta acima para que seja aplicada uma multa de dias de atraso.
# no caso, você deverá identificar quantos dias estão fora do prazo e multiplicá-lo pela taxa de aluguel(rental_rate)