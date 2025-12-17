--  Q2.a
select 
    city.city_id,city.city,
    address.address,
    address.district 
from 
    city
join address on city.city_id = address.city_id;

-- Q2.b
select 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    address.address, 
    address.district 
from 
    customer
join address on customer.address_id = address.address_id;

-- Q2.c
select 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    payment.amount, 
    payment.payment_date 
from 
    customer
join payment on customer.customer_id = payment.customer_id;

-- Q2.d
select 
    payment.payment_id, 
    payment.amount, 
    payment.payment_date, 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name 
from
    payment
join customer on payment.customer_id = customer.customer_id;


-- Q2.e
select 
    film.film_id, 
    film.title, 
    language.name as language_name 
from 
    film
join language on film.language_id = language.language_id;

-- Q3.a
select 
    language.name as language_name, 
    count(film.film_id) as total_films 
from 
   film
join language on film.language_id = language.language_id
group by language.name;

-- Q3.b
select 
    store.store_id, 
    count(payment.payment_id) as total_payments 
from 
    payment
join customer on payment.customer_id = customer.customer_id
join store on customer.store_id = store.store_id
group by store.store_id;

-- Q3.c
select 
    store.store_id, 
    count(customer.customer_id) as total_customers 
from 
    customer
group by store.store_id;

-- Q3.d
select 
    avg(amount) as avg_payment, 
    sum(amount) as total_payment, 
    count(payment_id) as total_transactions, 
    max(amount) as max_payment, 
    min(amount) as min_payment 
from payment;

-- Q3.e
select 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    count(payment.payment_id) as total_payments 
from payment
join customer on payment.customer_id = customer.customer_id
group by customer.customer_id, customer.first_name, customer.last_name;


-- Q3.f
select 
    language.name as language_name, 
    count(film.film_id) as total_films 
from film
join language on film.language_id = language.language_id
where film.length between 100 and 150
group by language.name;

-- Q3.g
select 
    store.store_id, 
    count(payment.payment_id) as total_payments 
from payment
join customer on payment.customer_id = customer.customer_id
join store on customer.store_id = store.store_id
where month(payment.payment_date) in (8, 9)
group by store.store_id;

-- Q3.h
select 
    store.store_id, 
    count(customer.customer_id) as total_customers 
from customer
join store on customer.store_id = store.store_id
where customer.last_name like 'r%'
group by store.store_id;

-- Q4.a
select 
    city.city, 
    address.address, 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name 
from customer
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id;


-- Q4.b
select 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    payment.amount, 
    rental.rental_date 
from customer
join payment on customer.customer_id = payment.customer_id
join rental on customer.customer_id = rental.customer_id;

-- Q4.c
select 
    film.title, 
    category.name as category_name 
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id;

-- Q4.d
select 
    actor.actor_id, 
    actor.first_name, 
    actor.last_name, 
    film.title 
from film
join film_actor on film.film_id = film_actor.film_id
join actor on film_actor.actor_id = actor.actor_id;

-- Q4.e
select 
    city.city, 
    count(customer.customer_id) as total_customers 
from customer
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
where month(customer.create_date) = 2
group by city.city;


-- Q4.f
select 
    actor.actor_id, 
    actor.first_name, 
    actor.last_name, 
    count(film.film_id) as total_films 
from film
join film_actor on film.film_id = film_actor.film_id
join actor on film_actor.actor_id = actor.actor_id
where film.rental_duration in (3,7)
and film.length between 60 and 150 
and film.replacement_cost > 12.00
group by actor.actor_id, actor.first_name, actor.last_name;

-- Q4.g
select 
    category.name as category_name, 
    sum(film.replacement_cost) as total_replacement_cost 
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where film.rental_duration in (3,7)
and film.length between 60 and 150 
and film.replacement_cost > 12.00
group by category.name;

-- Q5.a
select 
    city.city, 
    address.address, 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    payment.amount, 
    payment.payment_date 
from city
join address on city.city_id = address.city_id
join customer on address.address_id = customer.address_id
join payment on customer.customer_id = payment.customer_id;

select 
    store.store_id, 
    payment.amount, 
    payment.payment_date, 
    rental.rental_date, 
    inventory.inventory_id, 
    film.title, 
    film.rental_duration 
from store
join payment on store.store_id = payment.staff_id
join rental on payment.rental_id = rental.rental_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id;

-- Q5.c
select 
    actor.actor_id, 
    actor.first_name, 
    actor.last_name, 
    film.title, 
    inventory.inventory_id, 
    rental.rental_date, 
    payment.amount, 
    customer.customer_id, 
    customer.first_name as customer_first_name, 
    customer.last_name as customer_last_name, 
    address.address, 
    city.city, 
    country.country 
from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film on film_actor.film_id = film.film_id
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
join customer on payment.customer_id = customer.customer_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;

-- Q8.6
select 
    category.name as categoria, 
    sum(payment.amount) as total_pagamento
from payment
join rental on payment.rental_id = rental.rental_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name;

-- Q8.7
select 
    country.country, 
    count(payment.payment_id) as quantidade_pagamentos
from payment
join customer on payment.customer_id = customer.customer_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
group by country.country;

