use classicmodels;

drop procedure proc_cliente_produtos;

delimiter $
create procedure proc_cliente_produtos(inout param_valor int)
begin
    declare counter int default 0;    
    
    repeat
		select 
			customerName
		from
			customers
		limit 1 offset counter;
        
        set counter = counter + 1;
        
	until counter = 10
    end repeat;
end$
delimiter ;

select * from customers limit 10;
-- Lando of Toys Inc.

call proc_cliente_produtos();