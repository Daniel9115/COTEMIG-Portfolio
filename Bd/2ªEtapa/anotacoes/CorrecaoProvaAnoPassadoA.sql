/* Prova B - Correção */
use classicmodels;
-- questão a
create or replace view qestao1
as
select 
  concat(firstname, ' ', lastname) as nome_empregado, 
  count(ordernumber) as quantidade_pedido, 
  sum(priceEach * quantityOrdered) as faturamento, 
  sum(quantityOrdered) as total_produto
from 
  orderdetails 
    inner join orders using (ordernumber)
    inner join customers using (customernumber)
    inner join employees on (salesRepEmployeeNumber = employeeNumber)
where 
    reportsTo = 1102
and year(orderdate) = 2003
group by 
  nome_empregado;
  
  
  -- questão b
 create or replace view questao2 
 as
  select 
     productname, 
     productcode
  from 
     products left join orderdetails using (productcode)
  where 
     ordernumber is null;
     
     
-- questão c
create or replace view questao3_1 (produto, precovenda, precofabrica) 	
as
select 
  productcode, 
  priceEach, 
  MSRP
from 
  products
    inner join orderdetails using (productcode)
    inner join orders using (ordernumber) 
where 
  year(orderdate) = 2004;
  
create table ANALISE_DE_VENDA (
CodigoProduto VARCHAR(10), 
OBSERVACAO VARCHAR(300))
engine = InnoDB;


drop procedure percentual_lucro_produto;
delimiter $
create procedure percentual_lucro_produto()
begin
  declare total_registros int default 0;
  declare contador int default 0;
  declare var_produto varchar(10);
  declare var_analise varchar(300);
  
  select ifnull(count(*),0) into total_registros from questao3_1;
  
 
  repeat
     select 
       produto, 
       case
         when FORMAT((1-(PRECOVENDA/PRECOFABRICA)) * 100,2) < 5 then 'Produto com margem próxima do sugerido'
         when FORMAT((1-(PRECOVENDA/PRECOFABRICA)) * 100,2) between 5 and 10 then 'Produto está saindo da margem sugerida!'
         else 'Revendedores fiquem atentos aos valores negociados!.'
	   end as analise
       into var_produto, var_analise
	 from questao3_1
     limit 1 offset contador;
     
     insert into ANALISE_DE_VENDA values (var_produto, var_analise);
     
	 set contador = contador + 1;
     
  until contador >= total_registros
  end repeat;

end$
delimiter ;



call percentual_lucro_produto();

delete  from ANALISE_DE_VENDA;

select * from ANALISE_DE_VENDA;


-- questão d
use sakila;

delimiter $
create procedure film_categoria_loja (in param_store_id int)
begin
   
   select 
      category.name as categoria, 
      count(inventory_id) qtde_filme
   from 
     category
       inner join film_category using (category_id)
       inner join film using (film_id)
       inner join inventory using (film_id)
	where 
       store_id = param_store_id
	group by
      cateogy.name;
end$
delimiter ;


-- questao e
use world;

create table faltantes_porgutues_northAmercia
select 
  name as pais, 
  format(sum(percentage * population)/100,2) as falantes, 
  region as regiao
from 
   country inner join countryLanguage on code = countrycode
where 
    language = 'portuguese'
and Region = 'North America'
group by
  pais;
  
  
select * from faltantes_porgutues_northAmercia;


with cte_produto as (select productcode, productname from products), 
    cte_itemProduto as (select productcode, quantityordered, priceEach from orderdetails)
    select productname, quantityOrdered, priceEach
    from cte_produto inner join cte_itemProduto;