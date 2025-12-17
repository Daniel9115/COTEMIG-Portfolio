use classicmodels; 

/*
crie uma view para a consulta baixo: 

Retorne o nome do produto, o preço unitário, o preço de compra e o msrp (preço sugerido). 
Além disso, também crie uma coluna na sua view para calcular o percentual de lucro considerando o preço sugerido. 
Outro campo, será o percentual de lucro em cima do preço de compra. 
Por fim, faça uma analise considerando o critério abaixo:
Tudo isso deverá ser para o escritório de Paris, Tokyo e San Franscico. Além disso, você dever observar
o ano do pedido que deverá estar entre 2004 e 2005, apenas para quarto trimestre.

percentual de lucro no preço sugerido: [(priceEach/msrp) * 100 ]- 1
percentual de lucro no preço de compra: [(priceEach/buyprice) * 100] - 1

*/
use classicmodels;
create or replace view analise_lucro
as
select 
  productname as produto, 
  priceEach as preco_unitario, 
  buyprice as preco_compra, 
  msrp as preco_sugerido, 
  round(((priceEach/msrp) * 100 )- 1,2) as percental_lucro_sug,
  round(((priceEach/buyprice) * 100) - 1,2) as precentual_lucro_comp
from 
  products 
    inner join orderdetails using (productcode)
    inner join orders using (ordernumber)
    inner join customers using (customernumber)
    inner join employees on SalesRepEmployeeNumber = EmployeeNumber
    inner join offices using (officecode)
where 
    offices.city in ('Paris', 'Tokyo', 'San Francisco')
and year(orderdate) in (2004, 2005)
and month(orderdate) in (10,11,12);



select * from analise_lucro order by produto;


/*
usando a view anterior você deverá calcular a média do percentual de preço de compra e a 
média do percentual do preço do sugerido por produto.

Dê o nome de view de analise_lucro_medio. 
*/

create or replace view analise_lucro_medio
as
select produto, 
round(avg(percental_lucro_sug),2) as media_perc_sug, 
round(avg(precentual_lucro_comp),2) as media_perc_comp
from analise_lucro group by produto;


select * from analise_lucro_medio;

update analise_lucro_medio set media_perc_sug = 100 where produto = '1952 Alpine Renault 1300';


create table tb_analise_lucro
select * from analise_lucro_medio;


select * from tb_analise_lucro;

update tb_analise_lucro set media_perc_sug = 100 where produto = '1952 Alpine Renault 1300';