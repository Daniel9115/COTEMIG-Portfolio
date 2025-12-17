use sakila;
/*função count - Necessário o uso de group by para permitir 
  o agrupamento pelo campo que não está sendo usado na função de agregação
*/
select active as ativo, 
 count(*) as cliente
from customer
group by active;


select 
   category_id, 
   count(film_id)
from 
   film_category
group by 
  category_id;
  
/*
  funções de agregação: sum, max, min, avg
  novamente necessário incluir o group by para permitir 
  o agrupamento pelo campo que não está sendo usado na função de agregação
*/  
select 
 rental_duration,
 sum(rental_rate) as total, 
 max(rental_rate) as maiorValor, 
 min(rental_rate) as menorValor,
 avg(rental_rate) as media
from film
group by 
  rental_duration;
  
/* 
  função de agregação count, utilizando inner join.
  Isso permite fazer contagem por dados que estão em outra tabela
*/
select 
   name, 
   count(film_id)
from 
   film_category
     inner join category on (category.category_id = film_category.category_id)
group by 
  name;
  
  
select 
  title, 
  count(actor_id)
from 
  film 
   inner join film_actor on (film.film_id = film_actor.film_id)
group by
  title;
  
/* 
  função de agregação compondo o calculo de valor previsto.
  novamente utilizada o inner join para compreender quantos filmes existentes no estoque. 
  Na sequência, a quantidade de filmes é multiplicada pela taxa do aluguel. 
  Por fim, é criada uma subconsulta que retorna o totalprevisto
*/  
select 
  sum(total_previsto)
from (
select 
  title as filme, 
  count(inventory.film_id) as qtde_filme, 
  rental_rate as taxa_aluguel,
  count(inventory.film_id) * rental_rate as total_previsto
from 
  film 
    inner join inventory using (film_id)
group by
  title, rental_rate) as resultado;
  
/* 
  função de agregação utilizando mais tabelas no join.
*/ 
 
select 
  country, 
  sum(amount) as total
from 
  country 
     inner join city using (country_id)
     inner join address using (city_id)
     inner join customer using (address_id)
     inner join payment using (customer_id)
group by 
  country;