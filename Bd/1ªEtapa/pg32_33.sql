-- 02
SELECT * FROM film WHERE rental_rate = 2.99;
use sakila;
-- 03
SELECT * FROM film ORDER BY length DESC LIMIT 10;

-- 04
SELECT name FROM category ORDER BY name ASC;

-- 05
SELECT f.* FROM film f JOIN film_category fc ON f.film_id = fc.film_id JOIN category c ON fc.category_id = c.category_id WHERE c.name = 'Comedy';

-- 06
SELECT * FROM film WHERE language_id = 'English' ORDER BY title DESC;

-- 07
SELECT customer_id AS ID, first_name AS "Primeiro Nome", email, active 
FROM customer 
ORDER BY first_name ASC;

-- 08
SELECT CONCAT(first_name, ' ', last_name) AS "Nome Completo" FROM customer WHERE active = 0;

-- 09
SELECT amount AS ValorOriginal,  amount * 0.10 AS ValoCom10PorCento, payment_date AS DataDePgto FROM payment;

-- 10
SELECT * FROM actor ORDER BY actor_id ASC LIMIT 15;

-- 11
SELECT * FROM actor ORDER BY actor_id DESC LIMIT 20;