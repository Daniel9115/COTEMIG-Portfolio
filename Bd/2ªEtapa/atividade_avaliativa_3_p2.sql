use classicmodels;

-- q1.a
create or replace view v_q1_a_faturamento_empregados as
select
  o.officecode,
  o.city,
  sum(p.amount) as total_recebido,
  (select count(*) from employees e where e.officecode = o.officecode) as qtd_empregados
from payments p
join customers c on p.customerNumber = c.customerNumber
join employees emp on c.salesRe pEmployeeNumber = emp.employeeNumber
join offices o on emp.officeCode = o.officeCode
where o.country = 'USA'
  and p.paymentDate between '2004-04-01' and '2004-06-30'
group by o.officecode, o.city;

-- ----------------------------------------

-- q1.b
create or replace view v_q1_b_pagamentos_por_cliente_escritorio as
select
  o.officecode,
  o.city,
  c.customerNumber,
  sum(p.amount) as total_recebido_por_cliente
from payments p
join customers c on p.customerNumber = c.customerNumber
join employees emp on c.salesRepEmployeeNumber = emp.employeeNumber
join offices o on emp.officeCode = o.officeCode
where o.country = 'USA'
  and p.paymentDate between '2004-04-01' and '2004-06-30'
group by o.officecode, o.city, c.customerNumber;

with pagamentos as (
  select * from v_q1_b_pagamentos_por_cliente_escritorio
),
pedidos as (
  select
    o.officecode,
    o.city,
    od.customerNumber,
    count(distinct od.orderNumber) as total_pedidos_por_cliente
  from orders od
  join customers c on od.customerNumber = c.customerNumber
  join employees emp on c.salesRepEmployeeNumber = emp.employeeNumber
  join offices o on emp.officeCode = o.officeCode
  where od.orderDate between '2004-04-01' and '2004-06-30'
  group by o.officecode, o.city, od.customerNumber
)
select
  p.officecode,
  p.city,
  sum(p.total_recebido_por_cliente) as total_recebido_por_escritorio,
  coalesce(sum(pd.total_pedidos_por_cliente),0) as total_pedidos_por_escritorio
from pagamentos p
left join pedidos pd
  on p.officecode = pd.officecode and p.customerNumber = pd.customerNumber
group by p.officecode, p.city;

-- ----------------------------------------

-- q1.c.1
create or replace view v_q1_c_motorcycles_precos_por_escritorio as
select
  o.city as escritorio,
  od.productCode as produto,
  avg(od.priceEach) as media_priceeach,
  p.msrp
from orderdetails od
join orders ord on od.orderNumber = ord.orderNumber
join customers c on ord.customerNumber = c.customerNumber
join employees emp on c.salesRepEmployeeNumber = emp.employeeNumber
join offices o on emp.officeCode = o.officeCode
join products p on od.productCode = p.productCode
where p.productLine = 'Motorcycles'
group by o.city, od.productCode, p.msrp;

-- q1.c.2 
create table analise_perda (
  escritorio varchar(30),
  produto varchar(10),
  observacao varchar(200)
);

-- ----------------------------------------

-- q1.c.3
delimiter $$
create procedure proc_analisar_perda()
begin
  
  declare done boolean default false;
  declare v_escritorio varchar(30);
  declare v_produto varchar(10);
  declare v_media_priceeach decimal(15,4);
  declare v_msrp decimal(15,4);
  declare v_percentual decimal(10,2);
  declare v_obs varchar(200);

  declare cur cursor for
    select escritorio, produto, media_priceeach, msrp
    from v_q1_c_motorcycles_precos_por_escritorio;

  declare continue handler for not found set done = true;

  open cur;
  read_loop: repeat
    fetch cur into v_escritorio, v_produto, v_media_priceeach, v_msrp;
    if done then
      leave read_loop;
    end if;

    set v_percentual = (1 - (format(v_media_priceeach,2) / v_msrp)) * 100;
    set v_percentual = format(v_percentual,2);

    set v_obs = case
      when v_percentual < 5 then 'Aceitável.'
      when v_percentual >= 5 and v_percentual <= 10 then 'Atenção produtos com risco'
      when v_percentual > 10 then 'Solicitar reunião com os vendedores!'
      else 'Sem classificação'
    end;

    insert into analise_perda(escritorio, produto, observacao)
    values (v_escritorio, v_produto, v_obs);

  until done end repeat;
  close cur;
end$$
delimiter ;

-- ----------------------------------------

-- q1.d
use sakila;
delimiter $$
create procedure proc_sakila_faturamento_por_pais_loja(in p_store_id int)
begin
  select
    co.country as pais,
    sum(pay.amount) as valor_faturado
  from payment pay
  join rental r on pay.rental_id = r.rental_id
  join inventory inv on r.inventory_id = inv.inventory_id
  join customer c on pay.customer_id = c.customer_id
  join address a on c.address_id = a.address_id
  join city ci on a.city_id = ci.city_id
  join country co on ci.country_id = co.country_id
  where inv.store_id = p_store_id
  group by co.country;
end$$
delimiter ;

-- ----------------------------------------

-- q2
use world;
create table polynesia_falantes as
select
  country.code as country_code,
  country.name as country_name,
  sum(countrylanguage.percentage * country.population / 100) as total_pessoas_falantes
from countrylanguage
join country on countrylanguage.countrycode = country.code
where country.region = 'Polynesia'
group by country.code, country.name;



