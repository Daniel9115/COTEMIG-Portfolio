use sakila;
drop table pagamento_cliente;
CREATE TABLE pagamento_cliente 
SELECT 
   concat(first_name, ' ', last_name) as cliente, 
   month(payment_date) as mes, 
   sum(amount) as total_valor_pago, 
   rental_id, 
   0 as lucroesperado
FROM 
   customer 
      inner join payment using (customer_id)
WHERE 
    year(payment_date) = 2005
and month(payment_date) between 3 and 9
GROUP BY
   cliente, mes, lucroesperado;
   
   
create table log_modificacao (
  id int not null auto_increment primary key, 
  descricao text, 
  data datetime default current_timestamp
) engine = InnoDB;

create or replace view pgt_cliente_qte_filme
as
SELECT
   count(inventory_id) qtde, 
   cliente, 
   mes, 
   sum(total_valor_pago) total, 
   lucroesperado
FROM 
   pagamento_cliente
      inner join rental using (rental_id)
      inner join inventory using (inventory_id)
GROUP BY
  cliente, mes, lucroesperado;
  
delimiter $
create function calcula_percentual_lucro (total decimal(10,2), qtde int) returns decimal
begin
  declare lucro decimal(10,2) default 0;
  
  if qtde > 30 then
     set lucro = total * 1.1;
  elseif qtde > 20 then
     set lucro = total * 1.05;
  else 
     set lucro = total * 1.02;
  end if;
  
  return lucro;
   
end$

create trigger tgr_update_cliente_lucro after Update on pagamento_cliente for each row
begin

   insert into log_modificacao (id, descricao)
      values (default, concat("Foi alterado o lucro do cliente ", old.cliente, "o valor antigo era ", old.lucroesperado, "o valor novo é ", new.lucroesperado));
end$

create procedure p_rotina_calculo_lucro()
begin
  declare done boolean default false;
  declare var_total decimal(10,2) default 0;
  declare var_qtde int default 0;
  declare var_cliente varchar(100);
  
  declare cursor_cliente_pgt_lucro cursor for
    select cliente, total, qtde from pgt_cliente_qte_filme;
  
  declare continue handler for
    not found set done = true;
  
  open cursor_cliente_pgt_lucro;
  
  processa_cliente : loop
    fetch cursor_cliente_pgt_lucro into var_cliente, var_total, var_qtde;
  
	if done = true then
      leave processa_cliente;
	end if;
    
    update  pagamento_cliente set lucroesperado = calcula_percentual_lucro(var_total, var_qtde) where cliente = var_cliente;
    
  end loop;
  
  close cursor_cliente_pgt_lucro;

end$
delimiter ;