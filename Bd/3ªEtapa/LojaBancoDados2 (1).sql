-- Revisor: Eduarda de Oliveira 

create database lojabancodados2;
use lojabancodados2;

create table produto (
    codigoproduto int primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    qtde_estoque int default 0
);

create table cliente (
    codigocliente int primary key auto_increment,
    nome varchar(100) not null,
    email varchar(100),
    cpf varchar(11) unique
);

create table funcionario (
    codigofuncionario int primary key auto_increment,
    nome varchar(100) not null,
    funcao varchar(50),
    cidade varchar(50)
);

create table pedido (
    codigopedido int primary key auto_increment,
    datapedido date not null,
    status varchar(20) default 'pendente'
);

create table itempedido (
    codigopedido int,
    codigoproduto int,
    precovenda decimal(10,2),
    qtde int,
    primary key (codigopedido, codigoproduto),
    foreign key (codigopedido) references pedido(codigopedido),
    foreign key (codigoproduto) references produto(codigoproduto)
);

create table auditoria (
    id int primary key auto_increment,
    datamodificacao datetime default current_timestamp,
    nometabela varchar(50),
    historico text
);

delimiter //

create trigger tr_produto_insert after insert on produto
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('produto', concat('insert: ', new.codigoproduto, ' - ', new.nome));
end//

create trigger tr_produto_update after update on produto
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('produto', concat('update: ', new.codigoproduto, ' - ', old.nome, ' -> ', new.nome));
end//

create trigger tr_produto_delete after delete on produto
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('produto', concat('delete: ', old.codigoproduto, ' - ', old.nome));
end//

create trigger tr_cliente_insert after insert on cliente
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('cliente', concat('insert: ', new.codigocliente, ' - ', new.nome));
end//

create trigger tr_cliente_update after update on cliente
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('cliente', concat('update: ', new.codigocliente, ' - ', old.nome, ' -> ', new.nome));
end//

create trigger tr_cliente_delete after delete on cliente
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('cliente', concat('delete: ', old.codigocliente, ' - ', old.nome));
end//

create trigger tr_pedido_insert after insert on pedido
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('pedido', concat('insert: ', new.codigopedido, ' - ', new.datapedido));
end//

create trigger tr_pedido_update after update on pedido
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('pedido', concat('update: ', new.codigopedido, ' - ', old.status, ' -> ', new.status));
end//

create trigger tr_pedido_delete after delete on pedido
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('pedido', concat('delete: ', old.codigopedido, ' - ', old.datapedido));
end//

create trigger tr_itempedido_insert after insert on itempedido
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('itempedido', concat('insert: pedido ', new.codigopedido, ' - produto ', new.codigoproduto));
end//

create trigger tr_itempedido_update after update on itempedido
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('itempedido', concat('update: pedido ', new.codigopedido, ' - produto ', new.codigoproduto));
end//

create trigger tr_itempedido_delete after delete on itempedido
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('itempedido', concat('delete: pedido ', old.codigopedido, ' - produto ', old.codigoproduto));
end//

create trigger tr_funcionario_insert after insert on funcionario
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('funcionario', concat('insert: ', new.codigofuncionario, ' - ', new.nome));
end//

create trigger tr_funcionario_update after update on funcionario
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('funcionario', concat('update: ', new.codigofuncionario, ' - ', old.nome, ' -> ', new.nome));
end//

create trigger tr_funcionario_delete after delete on funcionario
for each row
begin
    insert into auditoria (nometabela, historico) 
    values ('funcionario', concat('delete: ', old.codigofuncionario, ' - ', old.nome));
end//

create procedure sp_inserir_produto(
    in p_nome varchar(100),
    in p_descricao text,
    in p_qtde_estoque int
)
begin
    insert into produto (nome, descricao, qtde_estoque) 
    values (p_nome, p_descricao, p_qtde_estoque);
end//

create procedure sp_inserir_cliente(
    in p_nome varchar(100),
    in p_email varchar(100),
    in p_cpf varchar(11)
)
begin
    insert into cliente (nome, email, cpf) 
    values (p_nome, p_email, p_cpf);
end//

create procedure sp_inserir_funcionario(
    in p_nome varchar(100),
    in p_funcao varchar(50),
    in p_cidade varchar(50)
)
begin
    insert into funcionario (nome, funcao, cidade) 
    values (p_nome, p_funcao, p_cidade);
end//

create table carrinho (
    id int primary key auto_increment,
    carrinho_json json
);

create procedure sp_extrair_carrinho(in p_json json)
begin
    select 
        json_extract(p_json, '$.codigoproduto') as codigoproduto,
        json_extract(p_json, '$.codigocliente') as codigocliente,
        json_extract(p_json, '$.codigovendedor') as codigovendedor,
        json_extract(p_json, '$.qtde') as qtde;
end//

create procedure sp_processar_pedido(
    in p_data_pedido date,
    in p_carrinho_json json
)
begin
    declare v_codigo_pedido int;
    declare v_codigo_produto int;
    declare v_qtde int;
    declare v_preco decimal(10,2);
    declare v_estoque int;
    declare done int default false;
    
    declare cur_itens cursor for
        select 
            json_extract(p_carrinho_json, '$.codigoproduto'),
            json_extract(p_carrinho_json, '$.qtde');
    
    declare continue handler for not found set done = true;
    
    start transaction;
    
    insert into pedido (datapedido, status) values (p_data_pedido, 'processando');
    set v_codigo_pedido = last_insert_id();
    
    set v_codigo_produto = json_extract(p_carrinho_json, '$.codigoproduto');
    set v_qtde = json_extract(p_carrinho_json, '$.qtde');
    
    select qtde_estoque into v_estoque from produto where codigoproduto = v_codigo_produto;
    
    if v_estoque < v_qtde then
        rollback;
        signal sqlstate '45000' set message_text = 'estoque insuficiente';
    end if;
    
    set v_preco = 10.00;
    
    insert into itempedido (codigopedido, codigoproduto, precovenda, qtde)
    values (v_codigo_pedido, v_codigo_produto, v_preco, v_qtde);
    
    update produto set qtde_estoque = qtde_estoque - v_qtde 
    where codigoproduto = v_codigo_produto;
    
    update pedido set status = 'concluido' where codigopedido = v_codigo_pedido;
    
    commit;
    
    select v_codigo_pedido as pedidocriado;
end//

create view vw_produtos_mais_vendidos as
select 
    p.codigoproduto,
    p.nome,
    sum(ip.qtde) as total_vendido
from produto p
inner join itempedido ip on p.codigoproduto = ip.codigoproduto
group by p.codigoproduto, p.nome
order by total_vendido desc//

delimiter ;

select * from vw_produtos_mais_vendidos;