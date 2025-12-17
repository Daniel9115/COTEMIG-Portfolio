-- q1.a
create or replace view vw_produto_estoque as
select 
    p.productcode,
    sum(od.quantityordered) as quantityordered,
    p.quantityinstock,
    (sum(od.quantityordered) + p.quantityinstock) as estoquetotal
from products p
join orderdetails od on p.productcode = od.productcode
group by p.productcode, p.quantityinstock;

-- q1.b
create table tb_produto_estoque as
select * from vw_produto_estoque;

-- q1.c
create table tb_auditoria (
    id int auto_increment primary key,
    descricao varchar(255),
    datamodificacao datetime default current_timestamp
);

-- q1.d
alter table tb_produto_estoque
add column percentualvendido decimal(5,2),
add column observacao varchar(100);

-- q1.e
delimiter $$

create trigger trg_auditoria_estoque
after update on tb_produto_estoque
for each row
begin
    insert into tb_auditoria (descricao)
    values (concat('alteração no produto ', new.productcode, ' - percentual: ', new.percentualvendido, '%'));
end$$

delimiter ;

-- q1.f
delimiter $$

create function fn_percentual_vendido(totalvendidos int, estoquetotal int)
returns decimal(5,2)
deterministic
begin
    declare resultado decimal(5,2);
    if estoquetotal = 0 then
        set resultado = 0;
    else
        set resultado = (totalvendidos / estoquetotal) * 100;
    end if;
    return resultado;
end$$

delimiter ;

-- q1.g
delimiter $$

create procedure sp_atualiza_percentual()
begin
    declare v_code varchar(15);
    declare v_qtdevendida int;
    declare v_estoquetotal int;
    declare v_percentual decimal(5,2);
    declare v_obs varchar(100);
    declare fim int default 0;

    declare cur cursor for
        select productcode, quantityordered, estoquetotal from tb_produto_estoque;

    declare continue handler for not found set fim = 1;

    start transaction;

    open cur;

    loop_cursor: loop
        fetch cur into v_code, v_qtdevendida, v_estoquetotal;
        if fim = 1 then 
            leave loop_cursor;
        end if;

        set v_percentual = fn_percentual_vendido(v_qtdevendida, v_estoquetotal);

        if v_percentual > 70 then
            set v_obs = 'reposiÇÃO de estoque';
        elseif v_percentual between 50 and 70 then
            set v_obs = 'estoque em atenÇÃo';
        else
            set v_obs = 'produto controlado';
        end if;

        update tb_produto_estoque
        set percentualvendido = v_percentual,
            observacao = v_obs
        where productcode = v_code;
    end loop;

    close cur;
    commit;
end$$

delimiter ;

-- q1.h
call sp_atualiza_percentual();

select * from tb_produto_estoque;
select * from tb_auditoria;
