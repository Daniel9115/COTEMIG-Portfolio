-- questão pa - a
use classicmodels;

with
itemPedido as (
    select 
		orderNumber,
        priceEach,
        quantityOrdered
    from 
		orderdetails
),
pedido as (
    select
		orderNumber,
        customerNumber,
        orderDate
    from
		orders
),
cliente as (
    select
		customerNumber,
		salesRepEmployeeNumber,
		customerName
    from 
		customers
),
pagamento as (
    select c
		ustomerNumber,
        amount,
        checkNumber,
        paymentDate
    from
		payments
),
vendedor as (
    select
		employeeNumber,
        concat(firstName, ' ', lastName) as nome
    from
		employees
)

select
    customerName,
    amount,
    sum(priceEach * quantityOrdered),
    checkNumber,
    case
        when sum(priceEach * quantityOrdered) <> amount then concat('Conversa com o representante: ', nome)
        else 'Tudo certo'
    end
from
    itemPedido
    inner join pedido using(orderNumber)
    inner join cliente using(customerNumber)
    inner join pagamento using(customerNumber)
    inner join vendedor on cliente.salesRepEmployeeNumber = vendedor.employeeNumber
where
    year(paymentDate) = year(orderDate)
    and month(paymentDate) = month(orderDate)
group by
    customerName, amount, checkNumber, nome
order by
    checkNumber
limit 20;

-- questão pa - b
with
produtos as (
    select 
		'PRODUTOS' as obs
    from 
		orders
		inner join orderdetails using(orderNumber)
		inner join products using(productCode)
    where
		year(orderDate) = 2004
    group by
		productName
    having 
		sum(quantityOrdered) between 400 and 800
),
clientes as (
    select 
		'CLIENTE' as obs
    from
		payments
    inner join customers using(customerNumber)
    inner join employees on customers.salesRepEmployeeNumber = employees.employeeNumber
    inner join offices using(officeCode)
    where
		month(paymentDate) in (10, 11, 12)
		and year(paymentDate) = 2004
		and offices.city in ('London', 'San Francisco')
    group by
		customerName
    having
		sum(amount) > 50000
),
vendedores as (
    select 
		'VENDEDORES' as obs
    from
		payments
		inner join customers using(customerNumber)
		inner join employees on customers.salesRepEmployeeNumber = employees.employeeNumber
	where
		year(paymentDate) = 2005
    group by
		concat(firstName, ' ', lastName)
    having 
		sum(amount) > 200000
)

select 
	obs, count(*)
from (
    select * from produtos
    union
    select * from clientes
    union
    select * from vendedores
) resultado
group by 
	obs;

-- questão pa - c
use sakila;

with
categoria as (
    select 
		category_id,
        name
    from 
		category
    where 
		name in ('Comedy', 'Drama')
),
filme_categoria as (
    select 
		film_id,
		category_id
    from
		film_category
),
inventario as (
    select 
		inventory_id, film_id, store_id
    from
		inventory
)

select
    name,
    store_id,
    count(inventory_id)
from
    categoria
    inner join filme_categoria using(category_id)
    inner join film using(film_id)
    inner join inventario using(film_id)
group by
    name, store_id;

-- questão pb - a
with
cliente as (
    select
		customer_id,
        concat(first_name, ' ', last_name) as nome
    from
		customer
),
pagamento as (
    select
		payment_id, customer_id,
        amount,
        payment_date
    from
		payment
    where
		year(payment_date) = 2005 
        and month(payment_date) = 8
),
rental as (
    select 
		rental_id,
        rental_date, 
        return_date, 
        inventory_id, 
        customer_id
    from 
		rental
),
inventario as (
    select 
		inventory_id,
        film_id
    from
		inventory
),
filme as (
    select
		film_id,
        rental_duration,
        rental_rate
    from
		film
)

select
    nome,
    sum(amount),
    ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999),
    case
        when sum(amount) = rental_rate then 'Valor Correto'
        else 'Investigar'
    end
from
    pagamento
    inner join cliente using(customer_id)
    inner join rental using(customer_id)
    inner join inventario using(inventory_id)
    inner join filme using(film_id)
group by
    nome, rental_duration, rental_rate, return_date, rental_date
order by
    3
limit 10;

-- questão pb - b
with
categoria as (
    select 
		category_id, 
		name
    from 
		category
),
filme_categoria as (
    select 
		film_id, 
		category_id
    from 
		film_category
),
filme as (
    select
		film_id,
        title
    from
		film
),
inventario as (
    select 
		inventory_id, 
        film_id, 
        store_id
    from 
		inventory
),
aluguel as (
    select 
		inventory_id
    from 
		rental
)

select
    title,
    store_id,
    name,
    count(inventory_id)
from
    categoria
    inner join filme_categoria using(category_id)
    inner join filme using(film_id)
    inner join inventario using(film_id)
    left join aluguel using(inventory_id)
where
    aluguel.inventory_id is null
group by
    title, store_id, name;

-- questão pb - c
with
inativos as (
    select 
		'Total de clientes inativos' as obs
    from 
		customer
    where 
		active = 0
),
faltando as (
    select 
		'Total de filmes faltantes no estoque' as obs
    from 
		film
		left join inventory using(film_id)
    where 
		inventory_id is null
),
pendentes as (
    select 
		'Total de aluguéis sem data de retorno' as obs
    from 
		rental
    where 
		return_date is null
)

select obs, count(*)
from (
    select * from inativos
    union
    select * from faltando
    union
    select * from pendentes
) resultado
group by obs;
