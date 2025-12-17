use sakila;
select 
actor_id as codigo, 
first_name as primeiro_nome,
last_name as ultimo_nome,
concat(first_name, ' ' ,last_name) as nome_completo
from actor as ator;

# comentário
/*
Faço um comentário
de várias linhas
*/


select 
format(rental_rate * 1.10,2) as rental_duration_calculate, 
 rental_rate, film.*
from film
where
# title like '%__E%' em qualquer lugar no meio da palavra
# title like 'AP__%' no inicio da palavra
#title like '%A_C' no final da palavra
title like 'AL%'
AND rental_duration in (3,6) # So inclui os valores listados
AND length between 50 and 150 # inclui as estremidades
AND rating in ('NC-17', 'PG-13');


Select distinct #mostra só a primeira ocorrencia de um valor
rental_duration from film;

select * from film limit 10 offset 3; #Pega so 10 registros saltando os 3 primeiros  

select payment_date, day(payment_date) as dia, month(payment_date) as mes, year(payment_date) as ano
from payment 
where
year(payment_date) = 2005
and month(payment_date) in (7,8,9); 