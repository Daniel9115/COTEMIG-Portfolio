use classicmodels;

-- q1.a
create view view_credito_cliente as
select 
    c.customerName as cliente,
    sum(p.amount) as total_pago,
    c.creditLimit as limite_credito
from customers c
join payments p on c.customerNumber = p.customerNumber
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
join offices o on e.officeCode = o.officeCode
where year(p.paymentDate) in (2003, 2005)
  and c.creditLimit > 100000
group by c.customerName, c.creditLimit;

create table credito_cliente (
    cliente varchar(50),
    total decimal(10,2),
    limite_credito decimal(10,2),
    analise varchar(100)
);

delimiter //
create procedure proc_credito_cliente(in p_funcao varchar(50), in p_escritorio varchar(50))
begin
    declare done int default 0;
    declare v_cliente varchar(50);
    declare v_total decimal(10,2);
    declare v_limite decimal(10,2);
    declare v_offset int default 0;

    repeat
        -- inserir registros com base na view
        insert into credito_cliente (cliente, total, limite_credito, analise)
        select cliente, total_pago, limite_credito,
               case 
                    when (limite_credito - total_pago) < 0 then 'entrar em contato com o cliente'
                    else 'sugerir aumento de crédito'
               end
        from view_credito_cliente
        where cliente in (
            select c.customerName
            from customers c
            join employees e on c.salesRepEmployeeNumber = e.employeeNumber
            join offices o on e.officeCode = o.officeCode
            where e.jobTitle = p_funcao
              and o.city = p_escritorio
            limit 5 offset v_offset
        );
        set v_offset = v_offset + 5;
        if v_offset >= (select count(*) from view_credito_cliente) then
            set done = 1;
        end if;
    until done end repeat;
end;
//
delimiter ;

-- q1.b
create table analise_lucro (
    produto varchar(50),
    media decimal(10,2),
    analise varchar(100)
);

delimiter //
create procedure proc_analise_lucro(in p_escritorio varchar(50), in p_pais varchar(50))
begin
    declare done int default 0;
    declare v_offset int default 0;

    repeat
        insert into analise_lucro (produto, media, analise)
        select p.productName,
               round(avg(((od.priceEach / p.buyPrice) - 1) * 100), 2) as media,
               case
                   when round(avg(((od.priceEach / p.buyPrice) - 1) * 100), 2) < 30 then 'chamar o representante imediatamente'
                   when round(avg(((od.priceEach / p.buyPrice) - 1) * 100), 2) < 50 then 'aumentar margem de lucro'
                   when round(avg(((od.priceEach / p.buyPrice) - 1) * 100), 2) < 100 then 'manter o valor'
                   else 'conceder mais 10% de desconto'
               end
        from orderdetails od
        join products p on od.productCode = p.productCode
        join orders o on od.orderNumber = o.orderNumber
        join customers c on o.customerNumber = c.customerNumber
        join employees e on c.salesRepEmployeeNumber = e.employeeNumber
        join offices ofc on e.officeCode = ofc.officeCode
        where ofc.city = p_escritorio
          and c.country = p_pais
        group by p.productName
        limit 5 offset v_offset;

        set v_offset = v_offset + 5;
        if v_offset >= (
            select count(distinct p.productName)
            from orderdetails od
            join products p on od.productCode = p.productCode
            join orders o on od.orderNumber = o.orderNumber
            join customers c on o.customerNumber = c.customerNumber
            join employees e on c.salesRepEmployeeNumber = e.employeeNumber
            join offices ofc on e.officeCode = ofc.officeCode
            where ofc.city = p_escritorio
              and c.country = p_pais
        ) then
            set done = 1;
        end if;
    until done end repeat;
end;
//
delimiter ;
