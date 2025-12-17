use classicmodels;

delimiter $
create trigger trg_incluir_novo_pedido before insert on OrderDetails for each row
begin
	declare var_estoque int;
    
    select quantityOrdered into var_estoque
    from products where productCode = new.productCode;
    
    if new.quantityOrdered <= var_estoque then
		insert into  log_modificacao(idModificacao, modifcacao)
		values(default, concat("O produto de id ", new.productCode, " foi vendido no pedido de ", new.ordernumber, ". A quantidade vendida foi de ", new.quantityOrdered));

		update products set quantityInStock = var_estoque - new.quantityOrdered where productCode = new.productCode;
    else
		SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Não existe quantidade para este pedido. Ação abortada';

	end if;
end$

create trigger trg_alteracao_produto after update on Products for each row
begin
	insert into log_modificacao(idModificacao, modificacao)
	values(default, concat("O produto de id ", new.productcode, " sofreu alteração no estoque. O valor antigo era ", old.quantityInStock, " e o valor atual é ", new.quantityInStock));
end$

delimiter;

ssss
-- ------------------------------------------------------------


use classicmodels;
drop table log_modificacao;
create table log_modificacao(
	idmodificacao int not null auto_increment primary key,
    modificacao text
) engine = InnoDB;

delimiter $
create trigger trg_atualizar_cliente before update on customers for each row
begin
	insert into log_modificacao(idmodificacao, modificacao)
    values(default, concat("O cliente de id igual ", old.customernumber, " sofreu uma mudança no campo cidade. O valor antigo era ", old.city, " foi atualizado para ", new.city));
end$
delimiter ;

update customers set city = "Belo Horizonte" where customernumber = 112;

select * from log_modificacao;