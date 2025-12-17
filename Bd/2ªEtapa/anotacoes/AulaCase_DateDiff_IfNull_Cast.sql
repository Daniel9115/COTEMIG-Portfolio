use sakila;

# UTILIZANDO O DATEDIFF
select datediff('2025-05-05', '2025-04-03') * 2 + 10 as resultado;

# FUNÇÃO PARA RETORNAR OS DIAS ENTRE DATAS
# DATEDIFF(DATAFINAL, DATAINICIAL)

describe rental;
-- rental_date
-- return_date

# quantos dias o cliente ficou com filme alugado.

select 
  datediff(return_date, rental_date) as dias_aluguel
from 
  rental;
  
# crie uma consulta para retornar os dados abaixo:
# codigo do cliente - customer_id
# codigo do aluguel - rental_id
# titulo do filme - title
# taxa de aluguel - rental_rate
# taxa de reposição do filme - replacement_cost
# tempo de aluguel - rental_duration
# dias de aluguel - cálculo

select 
  customer_id, 
  rental_id, 
  title, 
  rental_rate, 
  replacement_cost, 
  rental_duration, 
  datediff(return_date, rental_date) as dias_aluguel
from 
  rental 
    inner join inventory using (inventory_id)
    inner join film using (film_id);
    
# modifique a consulta acima para incluir um novo campo de cálculo - dias_atraso
# Calculo: dias_aluguel - tempo de aluguel


select 
  customer_id, 
  rental_id, 
  title, 
  rental_rate, 
  replacement_cost, 
  rental_duration, 
  ifnull(datediff(return_date, rental_date),999) as dias_aluguel, 
  ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) as dias_atraso
from 
  rental 
    inner join inventory using (inventory_id)
    inner join film using (film_id);

# informando quais são os clientes ativos e inativos

select 
  concat(first_name, ' ', last_name) as NomeCompleto, 
  case 
    when active = 1 then 'Ativo'
    else 'Inativo'
  end as situacao_cliente
from 
  customer;
  
# Modifique a consulta acima para retorna a situação do cliente quanto ao aluguel, conforme a verificação abaixo: 
# Se o valor de dias em atraso for negativo ou igual a 999, escrever: Caloteiro
# Do contrário, escreve: Gente boa

select 
  customer_id, 
  rental_id, 
  title, 
  rental_rate, 
  replacement_cost, 
  rental_duration, 
  ifnull(datediff(return_date, rental_date),999) as dias_aluguel, 
  ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) as dias_atraso, 
  case 
    when ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) < 0 
    or ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) = 999
	   then 'Caloteiro'
    else 'Gente boa'
  end as situacao_cliente
from 
  rental 
    inner join inventory using (inventory_id)
    inner join film using (film_id);

# Modifique a consulta para incluir o campo multa de acordo com a verificação abaixo:
# Se o valor do calculo de dias em atraso for menor que 0, multiplique o resultado pela taxa de aluguel e por -1
# Se o valor do calculo for igual a 999, coloque o taxa de reposição
# Do contrário a multa será zero.

select 
  customer_id, 
  rental_id, 
  title, 
  rental_rate, 
  replacement_cost, 
  rental_duration, 
  ifnull(datediff(return_date, rental_date),999) as dias_aluguel, 
  ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) as dias_atraso, 
  case 
    when ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) < 0 
    or ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) = 999
	   then 'Caloteiro'
    else 'Gente boa'
  end as situacao_cliente, 
  case 
     when ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) < 0 
       then (rental_duration - cast(datediff(return_date, rental_date) as decimal) ) * rental_rate * -1 
	 when ifnull(rental_duration - cast(datediff(return_date, rental_date) as decimal), 999) = 999
       then replacement_cost
	 else 0
  end as multa
from 
  rental 
    inner join inventory using (inventory_id)
    inner join film using (film_id);



