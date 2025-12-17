use classicmodels;

-- a
create or replace view produtos_mais_vendidos_20 as
select
	productname,
    sum(quantityordered) qtde
from
	products
	inner join orderdetails using(productcode)
    inner join orders using(ordernumber)
    inner join customers using(customernumber)
    inner join payments using (customernumber)
where
	year(paymentdate) = 2003
group by 
	productName
order by
	sum(quantityOrdered) desc
limit 20;

update produtos_mais_vendidos_20 
set qtde = 30 
where productName = '1992 Ferrari 360 Spider red';

-- Erro: não é possível fazer UPDATE porque a view usa GROUP BY e função de agregação (SUM)
-- Views com agregação não podem ser atualizadas diretamente

delete from produtos_mais_vendidos_20 
where productName = '1992 Ferrari 360 Spider red';

-- Erro: não é possível fazer DELETE em view com GROUP BY e agregações


-- b
create or replace view venda_mensal_paris_2004 as
select
    month(orderdate) as mes,
    avg(quantityordered * priceeach) as media,
    max(quantityordered * priceeach) as maximo,
    min(quantityordered * priceeach) as minimo
from 
	orderdetails 
	join orders using (ordernumber)
	join customers using (customernumber)
	join employees on customers.salesrepemployeenumber = employees.employeenumber
	join offices on employees.officecode = offices.officecode
where
	year(orderdate) = 2004 
    and offices.city = 'paris'
group by 
	mes;

update venda_mensal_paris_2004 set media = 500 where mes = 6;
-- Erro: não é possível atualizar colunas com AVG, MAX ou MIN
-- Views com funções de agregação não podem ser atualizadas

delete from venda_mensal_paris_2004 where mes = 6;
-- Erro: não é possível fazer DELETE em views com agregações e GROUP BY


-- c
create or replace view vendas_segundo_semestre as
select 
	productcode, sum(quantityordered) as total
from 
	orderdetails
	join orders using (ordernumber)
where 
	month(requireddate) between 8 and 12
group by 
	productcode;

update vendas_segundo_semestre set total = 100 where productcode = 'S10_1949';
-- Erro: coluna 'total' é resultado de SUM, não pode ser atualizada

delete from vendas_segundo_semestre where productcode = 'S10_1949';
-- Erro: não é possível deletar dados diretamente de uma view com GROUP BY


-- d
create or replace view clientes_por_escritorio as
select 
	offices.officecode, count(customernumber) as total_clientes
from 
	customers
	join employees on customers.salesrepemployeenumber = employees.employeenumber
	join offices on employees.officecode = offices.officecode
group by 
	offices.officecode;

update clientes_por_escritorio set total_clientes = 100 where officecode = 1;
-- Erro: total_clientes é resultado de COUNT, não pode ser alterado

delete from clientes_por_escritorio where officecode = 1;
-- Erro: não pode deletar linha de view com GROUP BY e COUNT

-- e
create or replace view produtos_menos_vendidos_1sem_2004 as
select 
	productcode, sum(quantityordered) as total_vendido
from 
	orderdetails
	join orders using (ordernumber)
where 
	year(orderdate) = 2004 
    and month(orderdate) between 1 and 6
group by 
	productcode
order by 
	total_vendido asc
limit 15;

update produtos_menos_vendidos_1sem_2004 set total_vendido = 10 where productcode = 'S18_1749';
-- Erro: não é possível atualizar soma (SUM), pois é cálculo, não dado original

delete from produtos_menos_vendidos_1sem_2004 where productcode = 'S18_1749';
-- Erro: não pode deletar registros diretamente de views com agregação e LIMIT

-- f
create or replace view estatisticas_tokyo_2003 as
select
    avg(quantityordered * priceeach) as media,
    max(quantityordered * priceeach) as maximo,
    min(quantityordered * priceeach) as minimo
from orderdetails
	join orders using (ordernumber)
	join customers using (customernumber)
	join employees on customers.salesrepemployeenumber = employees.employeenumber
	join offices on employees.officecode = offices.officecode
where
	year(orderdate) = 2003 
    and offices.city = 'tokyo';

update estatisticas_tokyo_2003 set media = 100;
-- Erro: não pode alterar valores de funções agregadas como AVG

delete from estatisticas_tokyo_2003;
-- Erro: não pode deletar dados de view sem tabela base direta

-- g
create or replace view menor_qtde_entre_set_dez as
select 
	productcode, min(quantityordered) as menor_quantidade
from 
	orderdetails
	join orders using (ordernumber)
where
	month(requireddate) between 9 and 12
group by 
	productcode;

update menor_qtde_entre_set_dez set menor_quantidade = 1 where productcode = 'S18_2795';
-- Erro: não pode atualizar valor de função MIN (mínimo)

delete from menor_qtde_entre_set_dez where productcode = 'S18_2795';
-- Erro: não pode deletar dados diretamente da view com GROUP BY

-- h 
create or replace view clientes_por_escritorio_h as
select 
	offices.officecode, count(customernumber) as total_clientes
from 
	customers
	join employees on customers.salesrepemployeenumber = employees.employeenumber
	join offices on employees.officecode = offices.officecode
group by 
	offices.officecode;

update clientes_por_escritorio_h set total_clientes = 200 where officecode = 2;
-- Erro: count() é função agregada, valor não pode ser atualizado manualmente

delete from clientes_por_escritorio_h where officecode = 2;
-- Erro: não pode deletar de view com contagem e agrupamento
