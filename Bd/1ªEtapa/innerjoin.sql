use sakila;

select distinct active, count(*) from customer group by active;

select category_id, count(film_id) from film_category group by category_id;

select name, count(film_id) from film_category inner join category on (category.category_id = film_category.category_id) group by name;

select 
title,
count(actor_id) from film inner join film_actor on (film.film_id = film_actor.film_id) group by title;

select sum(total_previsto) from(
	select title as filme, count(inventory.film_id) as qtd_filme,
	rental_rate as taxa_aluguel,
	count(inventory.film_id) * rental_rate as total_previsto
	from film inner join inventory using (film_id) group by title, rental) as resultado;

select 
rental_duration,
sum(rantel_rate) as total,
max(rantel_rate) as maiorValor,
min(rantel_rate) as menorValor,
avg(rantel_rate) as media from film group by rental_duration;

select country, sum(amount) as total
from country 
inner join city using(country_id)
inner join address using(city_id)
inner join customer using(address_id)
inner join payment using(customer_id)
group by country; #Total arrecadado por país