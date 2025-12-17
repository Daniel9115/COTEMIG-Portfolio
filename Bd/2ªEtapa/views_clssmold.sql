use classicmodels;

drop view cliente;

create or replace view vw_cliente (codigo, nome, telefone, endereco, employeenumber)
as
select
	customerNumber, customerName, phone, addressLine1, salesRepEmployeeNumber
from 
	customers;

select * 
from 
	vw_cliente
inner join 
	employees using(employeenumber);

-- ---------------------------------------------------------------------------------

create or replace view vw_pagamento(codigo, valor, datapagamento)
as
select
	customerNumber, amount, paymentdate
from 
	payments;

select * from vw_pagamento;
    
-- ---------------------------------------------------------------------------------
    
create or replace view vw_total_pg_cliente(nome, total)
as
select
	nome,
    sum(valor)
from 
	vw_cliente
inner join
	vw_pagamento using(codigo)
group by
	nome;

select * from vw_total_pg_cliente;

-- ---------------------------------------------------------------------------------

create or replace view vw_total_produtos(nome, total)
as
select
	productcode,
    sum(quantityordered)
from 
	orderdetails
group by
	productCode;
    
select sum(total) as total, 'total pago' as observacao from vw_total_pg_cliente
union
select sum(total) as total, 'quantidade vendida' as observacao from vw_total_produtos;


select 
	nome,
    sum(valor)
from
	vw_cliente
inner join
	vw_pagamento using(codigo)
group by
	nome;