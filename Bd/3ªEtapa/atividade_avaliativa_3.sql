use classicmodels;

delimiter //

create procedure realizar_pedido_cliente_sem_credito (
    in p_cod_cliente int,
    in p_cod_vendedor int
)
begin
    declare v_pedido_id int;
    declare v_quantidade int default 461;
    declare done int default false;

    declare v_cod_produto int;
    declare v_estoque int;
    declare v_preco decimal(10,2);

    declare total decimal(10,2) default 0;

    declare produtos_cursor cursor for
        select productCode, quantityInStock, buyPrice
        from products
        order by quantityInStock desc
        limit 5;

    declare continue handler for not found set done = true;

    start transaction;

    update customers set credito = 100000 where cod_cliente = p_cod_cliente;

    insert into orders (cod_cliente, data_pedido) values (p_cod_cliente, curdate());
    set v_pedido_id = last_insert_id();

    open produtos_cursor;

    leitura_loop: loop
        fetch produtos_cursor into v_cod_produto, v_estoque, v_preco;
        if done then
            leave leitura_loop;
        end if;

        if v_estoque < v_quantidade then
            leave leitura_loop;
        end if;

        insert into orderitems (cod_pedido, cod_produto, quantidade) values (v_pedido_id, v_cod_produto, v_quantidade);

        update products set quantityInStock = quantityInStock - v_quantidade where productCode = v_cod_produto;

        set total = total + (v_preco * v_quantidade);
    end loop;

    close produtos_cursor;

    insert ignore into salespersonclients (cod_cliente, cod_vendedor) values (p_cod_cliente, p_cod_vendedor);

    insert into payments (cod_pedido, data_pagamento, valor_pagamento) values (v_pedido_id, curdate(), total);

    commit;

end //

delimiter ;