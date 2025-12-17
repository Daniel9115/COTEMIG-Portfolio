use sakila;

-- 1.a
create table filme_atores as
select 
    f.film_id as codigo,
    group_concat(concat(a.first_name, ' ', a.last_name) separator ', ') as relacao_atores,
    c.name as categoria,
    f.rental_rate as taxa_aluguel,
    0 as atraso,
    cast(0 as decimal(10,2)) as taxa_calculada
from film f
inner join film_actor fa on f.film_id = fa.film_id
inner join actor a on a.actor_id = fa.actor_id
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
group by f.film_id, c.name, f.rental_rate
limit 100;

-- 1.b
create table log_filme (
    id int auto_increment primary key,
    descricao varchar(255),
    data timestamp default current_timestamp
);

-- 1.c
create or replace view vw_filme_estoque as
select 
    f.*,
    count(i.inventory_id) as quantidade_filmes
from filme_atores f
left join inventory i on f.codigo = i.film_id
group by f.codigo;

-- 1.d
delimiter $$

create function fn_taxa_calculada(quantidade_filmes int, taxa_aluguel decimal(10,2))
returns decimal(10,2)
deterministic
begin
    declare resultado decimal(10,2);

    if quantidade_filmes >= 6 then
        set resultado = quantidade_filmes * (taxa_aluguel * taxa_aluguel);
    else
        set resultado = quantidade_filmes * taxa_aluguel;
    end if;

    return resultado;
end$$

delimiter ;

-- 1.e
delimiter $$

create trigger trg_update_filme
after update on filme_atores
for each row
begin
    if (old.atraso <> new.atraso) or (old.taxa_calculada <> new.taxa_calculada) then
        insert into log_filme (descricao, data)
        values (
            concat('atualização no filme id ', new.codigo,
                   ' | atraso: ', old.atraso, ' -> ', new.atraso,
                   ' | taxa: ', old.taxa_calculada, ' -> ', new.taxa_calculada),
            current_timestamp()
        );
    end if;
end$$

delimiter ;

-- 1.f
delimiter $$

create procedure sp_atualizar_filmes()
begin
    declare v_codigo int;
    declare v_quantidade int;
    declare v_taxa decimal(10,2);
    declare v_taxa_calc decimal(10,2);
    declare fim int default 0;

    declare cur cursor for
        select codigo, quantidade_filmes, taxa_aluguel from vw_filme_estoque;

    declare continue handler for not found set fim = 1;

    open cur;

    loop_filmes: loop
        fetch cur into v_codigo, v_quantidade, v_taxa;
        if fim = 1 then 
            leave loop_filmes;
        end if;

        set v_taxa_calc = fn_taxa_calculada(v_quantidade, v_taxa);

        update filme_atores
        set atraso = v_quantidade,
            taxa_calculada = v_taxa_calc
        where codigo = v_codigo;
    end loop loop_filmes;

    close cur;
end$$

delimiter ;
