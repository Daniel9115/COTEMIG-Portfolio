create table log_table (
    id int auto_increment primary key,
    table_name varchar(50),
    operation varchar(10),
    old_data varchar(255),
    new_data varchar(255),
    change_date datetime
);

delimiter $
create procedure aluguel_5clientes_inativos()
begin
    declare done int default 0;
    declare customer_id int;
    declare film_id int;
    declare rental_duration int;
    declare rental_price decimal(5,2);
    declare cur cursor for 
        select c.customer_id
        from customer c
        join payment p on c.customer_id = p.customer_id
        where c.active = 0
        group by c.customer_id
        having sum(p.amount) > 20
        limit 5;
    declare film_cur cursor for 
        select f.film_id, f.rental_duration, f.rental_rate
        from film f
        join inventory i on f.film_id = i.film_id
        left join rental r on i.inventory_id = r.inventory_id
        group by f.film_id
        order by count(r.rental_id) desc
        limit 5;
    declare continue handler for not found set done = 1;

    start transaction;

    open cur;
    fetch cur into customer_id;

    while not done do
        open film_cur;
        fetch film_cur into film_id, rental_duration, rental_price;

        while not done do
            insert into rental (rental_date, inventory_id, customer_id, return_date, staff_id)
            values (now(), (select inventory_id from inventory where film_id = film_id limit 1), customer_id, date_add(now(), interval rental_duration day), 1);

            insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
            values (customer_id, 1, last_insert_id(), rental_price, now());

            fetch film_cur into film_id, rental_duration, rental_price;
        end while;

        close film_cur;
        set done = 0;
        fetch cur into customer_id;
    end while;

    close cur;

    commit;
end $

create trigger trg_customer_update
after update on customer
for each row
begin
    insert into log_table (table_name, operation, old_data, new_data, change_date)
    values ('customer', 'update', old.active, new.active, now());
end $

create trigger trg_payment_insert
after insert on payment
for each row
begin
    insert into log_table (table_name, operation, old_data, new_data, change_date)
    values ('payment', 'insert', null, new.amount, now());
end $

create trigger trg_rental_insert
after insert on rental
for each row
begin
    insert into log_table (table_name, operation, old_data, new_data, change_date)
    values ('rental', 'insert', null, new.rental_date, now());
end $
delimiter ;