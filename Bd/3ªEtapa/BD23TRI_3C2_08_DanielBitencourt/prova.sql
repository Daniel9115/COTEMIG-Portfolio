use classicmodels;

-- q1.a --------------------------------------------
create table Gifts(
	 id int not null auto_increment primary key, 
     descrition text
);

 insert into Gifts (id, descrition)
      values (default, "Trip of Cancún"), (default, "Iphone 13"), (default, "TV 50");
      
select * from Gifts;


-- q1.b --------------------------------------------
create or replace view questao_b
as
SELECT
   customerNumber,
   employeeNumber,
   amount,
   offices.city,
   orderDate
FROM 
	customers
    inner join payments using (customerNumber)
	inner join employees on employeeNumber = salesRepEmployeeNumber
    inner join offices using (officeCode)
    inner join orders using (customerNumber)
where
	offices.city = 'Paris'
    and year(orderDate) = '2003'
    and month(orderDate) between 7 and 12;

select * from questao_b;


-- q1.c --------------------------------------------
create table auditoria(
	 id int not null auto_increment primary key, 
     descricao text,
     dataModificacao date
);


--  q1.d --------------------------------------------
create table questao_d as
select 
	customerNumber,
	employeeNumber,
	amount as valor
from questao_b;

alter table questao_d
add column gift int,
add column percentual decimal(10,2);

select * from questao_d;


-- q1.e --------------------------------------------
delimiter $$
create trigger trg_auditoria
after update on questao_d
for each row
begin
    insert into auditoria (descricao)
    values (concat('alteração no gift ', new.gift, ' - percentual: ', new.percentual, '%'));
end$$


-- q1.f --------------------------------------------
delimiter $
create function percentual_faturado_cliente (totalpago decimal(10,2), faturamentoEscritorio int) returns decimal
begin
	declare lucro decimal(10,2) default 0;
	set lucro = totalpago * faturamentoEscritorio;
	return lucro;
end$

delimiter $$