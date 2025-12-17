select datediff(cast('2025-04-10' as datetime),cast('2025-03-25' as datetime)) * 2 + 10 as resultado;

use sakila;

describe rental;
describe film;
describe inventory;
select datediff(return_date,rental_date) as dias from rental;
# crie uma consulta que retorne os seguintes dados:
# codido do cliente (rental)
# codigo do aluguel (rental)
# tempo de aluguel (rental_duration - film)
# dias que o filme ficou alugado (calculo)
# taxa de alguel (rental_rate - film)

#tabelas envolvidas: Film, inventory, rental
select 
   customer_id, 
   rental_id,
   rental_duration,
   ifnull(datediff(return_date,rental_date),9999) as dias,
   rental_rate, 
   replacement_cost, 
    0 as 'valor a pagar'
from 
   rental 
     inner join inventory using (inventory_id)
     inner join film using (film_id)
where 
 datediff(return_date,rental_date) is null;
 
 # modifique a consulta acima para que retorne o valor a ser pago, considerado os critérios abaixo:
 # se a quantidade de dias for maior que 0, multiplique os dias pela taxa de alguel.
 # se o dia for null, retorne o valor de reposição do filme (replacement_cost)
 
use sakila;
select 
   customer_id, 
   rental_id,
   rental_duration,
   ifnull(datediff(return_date,rental_date),9999) as dias,
   (cast(datediff(return_date,rental_date) as decimal) - cast(rental_duration as decimal)) as dias_atraso,
   rental_rate, 
   replacement_cost, 
   case 
     when datediff(return_date,rental_date) > rental_duration 
        then (cast(datediff(return_date,rental_date) as decimal) - cast(rental_duration as decimal)) * rental_rate
	 when ifnull(datediff(return_date,rental_date),'A') = 'A'
        then replacement_cost
	 else
         0 
   end as 'Valor a pagar'
from 
   rental 
     inner join inventory using (inventory_id)
     inner join film using (film_id);
  
# banco de dados classicmodels.
# crie uma consulta para retorna o nome do cliente e o texto 'Com crédito' ou 'Sem crédito'
select 
  customerName, 
  case 
     when creditlimit > 0 then 'Com crédito'
     else 'Sem crédito'
  end as situacao
from 
  classicmodels.customers;
  
  
# crie uma consula para trazer as informações abaixo;
# total de clientes sem vendedores
# total de produtos não vendidos
# total de vendedores sem clientes.


# primeira consulta: total de clientes sem vendedores
use classicmodels;
select 
  observacao, 
  count(observacao) as valor
from (
select 
  customerName, 'clientes sem vendores' as observacao
from 
   customers
     left join employees on salesrepemployeenumber = employeenumber
where 
  employeenumber is null
union  
# segunda consulta: total de produtos não vendidos
select 
  productName, 'produtos não vendidos' as observacao
from
  products 
    left join orderdetails using (productCode)
where 
   ordernumber is null
union   
# terceira consulta: total de vendedores sem clientes
select 
  concat(firstname, ' ', lastname) as nomeCompleto, 'vendedores sem clientes' as observacao
from 
  employees
    left join customers on SalesRepEmployeeNumber = EmployeeNumber
where 
    customerNumber is null
and jobtitle = 'Sales Rep') as resultado 
group by 
  observacao;

	
select 
  count(customerName), 'clientes sem vendores' as observacao
from 
   customers
     left join employees on salesrepemployeenumber = employeenumber
where 
  employeenumber is null
group by 
  observacao
union  
# segunda consulta: total de produtos não vendidos
select 
  count(productName), 'produtos não vendidos' as observacao
from
  products 
    left join orderdetails using (productCode)
where 
   ordernumber is null
group by 
  observacao
union   
# terceira consulta: total de vendedores sem clientes
select 
  count(concat(firstname, ' ', lastname)) as nomeCompleto, 'vendedores sem clientes' as observacao
from 
  employees
    left join customers on SalesRepEmployeeNumber = EmployeeNumber
where 
    customerNumber is null
and jobtitle = 'Sales Rep'group by 
  observacao
     
     
     