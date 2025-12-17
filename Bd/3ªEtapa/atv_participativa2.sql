use sakila;

delimiter //

create procedure AlugarFilmesNaoVistos(
    in p_customer_id int,
    in p_category_name varchar(25)
)
begin
    insert into rental (rental_date, inventory_id, customer_id, staff_id)
    select 
        now(),
        i.inventory_id,
        p_customer_id,
        1 -- staff_id padrão
    from inventory i
    inner join film f on i.film_id = f.film_id
    inner join film_category fc on f.film_id = fc.film_id
    inner join category c on fc.category_id = c.category_id
    where c.name = p_category_name
    and i.inventory_id not in (
        select distinct r.inventory_id
        from rental r
        where r.customer_id = p_customer_id
        and r.inventory_id is not null
    );
end //

delimiter ;

call AlugarFilmesNaoVistos(1, 'Action');
