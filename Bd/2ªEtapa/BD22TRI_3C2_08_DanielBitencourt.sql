-- A
use classicmodels;
create or replace view QUESTAO_A
as
select 
	orderdetails.priceEach
from 
  products 
    inner join orderdetails using (productcode)
    inner join orders using (ordernumber)
    inner join customers using (customernumber)
    inner join employees on SalesRepEmployeeNumber = EmployeeNumber
    inner join offices using (officecode)
where 
    year(orderDate) = year(requiredDate) 
	and month(orderdate) = month(requiredDate);
select * from QUESTAO_A;
-- B
DELIMITER $
CREATE PROCEDURE QUESTAO_B(IN cod_loja INT, in mes date)
BEGIN
	select concat('No mês de: ', mes, ' a loja: ', cod_loja, ' teve: ')
END$
DELIMITER ;

-- C
DELIMITER $
CREATE PROCEDURE QUESTAO_C(IN cod_cliente INT, in cod_vendedor int, in limite_credito int)
BEGIN
	/* ... */
END$
DELIMITER ;

-- D
DELIMITER $
CREATE PROCEDURE QUESTAO_D(IN cod_loja INT, in mes date)
BEGIN
	/*case 
		when GovernmentFrom = 'Federal Republic' then 'Passaporte Liberado'
		else 'Conversar com o consulado do país'
	end as Analise	*/
END$
DELIMITER ;

-- E
DELIMITER $

CREATE PROCEDURE QUESTAO_E(in dia_atual date)
begin
	DECLARE passo1 VARCHAR(200);
	DECLARE passo2 VARCHAR(200);
	DECLARE passo3 VARCHAR(200);
	DECLARE passo4 VARCHAR(200);
	DECLARE passo5 VARCHAR(200);
    set passo1 = 'Acordar';
	set passo2 = 'Tomar Banho';
	set passo3 = 'Colocar Roupa';
    set passo4 = 'Tomar Café';
    set passo5 = 'Escovar os Dentes';
	 
    select concat('Dia: ', dia_atual, ' - ', passo1, ' - ', passo2, ' - ', passo3, ' - ', passo4, ' - ', passo5) as Rotina;
END$
DELIMITER ;

call QUESTAO_E('2025-08-25');