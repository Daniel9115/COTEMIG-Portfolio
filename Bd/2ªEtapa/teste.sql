-- Q1.A
create or replace view vw_produtos_comprados as
select 
    p.productName as nome_produto,
    p.productCode as codigo_produto,
    sum(od.quantityordered) as quantidade_comprada,
    sum(od.priceEach * od.quantityordered) as total_pago
from
    orders o
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
where 
    o.orderDate between '2003-01-01' and '2003-01-31'
    or o.orderDate between '2003-05-01' and '2003-05-31'
    or o.orderDate between '2003-10-01' and '2003-10-31'
group by
    p.productName, p.productCode;

-- Questão 1 - B
with cte_produtos_comprados as (
    select 
        p.productName as nome_produto,
        p.productCode as codigo_produto,
        sum(od.quantityordered) as quantidade_comprada,
        sum(od.priceEach * od.quantityordered) as total_pago
    from
        orders o
    join orderdetails od on o.orderNumber = od.orderNumber
    join products p on od.productCode = p.productCode
    where 
        o.orderDate between '2003-01-01' and '2003-01-31'
        or o.orderDate between '2003-05-01' and '2003-05-31'
        or o.orderDate between '2003-10-01' and '2003-10-31'
    group by
        p.productName, p.productCode
)
select 
    c.customerName,
    e.firstName as nome_funcionario,
    o.city as cidade_escritorio,
    cp.nome_produto,
    cp.codigo_produto,
    cp.quantidade_comprada,
    cp.total_pago
from
    cte_produtos_comprados cp
join customers c on c.customerNumber = o.customerNumber
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
join offices o on e.officeCode = o.officeCode
where 
    o.city in ('Tokyo', 'London');

-- Q1.C
create or replace view vw_produtos_comprados_com_estoque as
select 
    p.productName as nome_produto,
    p.productCode as codigo_produto,
    sum(od.quantityordered) as quantidade_comprada,
    sum(od.priceEach * od.quantityordered) as total_pago,
    p.quantityinStock
from
    orders o
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
group by
    p.productName, p.productCode, p.quantityinStock;

create table ANALISE_ESTOQUE (
    CodigoProduto varchar(10),
    OBSERVACAO varchar(200)
);

delimiter //
create procedure avaliar_estoque(in ano int)
begin
    declare done int default false;
    declare codigo_produto varchar(10);
    declare quantidade_vendida int;
    declare quantidade_estoque int;
    declare percentual decimal(5,2);
    
    declare cur cursor for 
        select 
            p.productCode, 
            sum(od.quantityordered) as quantidade_vendida, 
            p.quantityinStock as quantidade_estoque
        from 
            orders o
        join orderdetails od on o.orderNumber = od.orderNumber
        join products p on od.productCode = p.productCode
        where year(o.orderDate) = ano
        group by p.productCode;

    declare continue handler for not found set done = true;

    open cur;

    read_loop: loop
        fetch cur into codigo_produto, quantidade_vendida, quantidade_estoque;
        if done THEN
            leave read_loop;
        end if;

        set percentual = format(quantidade_vendida / (quantidade_vendida + quantidade_estoque) * 100, 2);

        if percentual > 70 then
            insert into ANALISE_ESTOQUE (CodigoProduto, OBSERVACAO) 
            VALUES (codigo_produto, 'O produto precisa ser reposto impediatamente! Ligue agora para o fornecedor!');
        elseif percentual > 60 then
            insert into ANALISE_ESTOQUE (CodigoProduto, OBSERVACAO) 
            VALUES (codigo_produto, 'Atenção produto está precisando ser reposto. Por favor, solicite ao fornecedor!');
        elseif percentual < 50 then
            insert into ANALISE_ESTOQUE (CodigoProduto, OBSERVACAO) 
            values (codigo_produto, 'Produto controlado');
        end if;
    end loop;

    close cur;
end //
delimiter ;

-- Q1.D
create procedure listar_filmes_por_categoria(in categoria_nome varchar(50))
begin
    select 
        f.title as titulo_filme,
        COUNT(a.actor_id) as quantidade_atores
    from 
        film f
    join film_category fc on f.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
    join film_actor fa on f.film_id = fa.film_id
    join actor a on fa.actor_id = a.actor_id
    where 
        c.name = categoria_nome
    group by 
        f.title
end //
delimiter ;

-- Q2
create table total_falantes_linguas (
    lingua varchar(50),
    total_falantes int
);
insert into total_falantes_linguas (lingua, total_falantes)
select 
    cl.language as lingua,
    sum(cl.percentage * c.population) / 100 as total_falantes
from
    countrylanguage cl
join country c on cl.countryCode = c.code
where 
    cl.language in ('German', 'Italian', 'Japanese') and c.name = 'Brazil'
group by
    cl.language;