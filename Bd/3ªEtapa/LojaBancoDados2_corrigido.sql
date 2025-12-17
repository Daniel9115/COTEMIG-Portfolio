create database lojabancodados2_corrigido;
use lojabancodados2_corrigido;

create table produto (
    codigoproduto int primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    qtde_estoque int default 0
) engine=InnoDB;

create table cliente (
    codigocliente int primary key auto_increment,
    nome varchar(100) not null,
    email varchar(100),
    cpf varchar(11) unique
) engine=InnoDB;

create table funcionario (
    codigofuncionario int primary key auto_increment,
    nome varchar(100) not null,
    funcao varchar(50),
    cidade varchar(50)
) engine=InnoDB;

create table pedido (
    codigopedido int primary key auto_increment,
    codigocliente int,
    codigofuncionario int,
    datapedido date not null,
    status varchar(20) default 'pendente',
    foreign key (codigocliente) references cliente(codigocliente),
    foreign key (codigofuncionario) references funcionario(codigofuncionario)
) engine=InnoDB;

create table itempedido (
    codigopedido int,
    codigoproduto int,
    precovenda decimal(10,2),
    qtde int,
    primary key (codigopedido, codigoproduto),
    foreign key (codigopedido) references pedido(codigopedido),
    foreign key (codigoproduto) references produto(codigoproduto)
) engine=InnoDB;

create table auditoria (
    id int primary key auto_increment,
    datamodificacao datetime default current_timestamp,
    nometabela varchar(50),
    historico text
) engine=InnoDB;

create table carrinho (
    id int primary key auto_increment,
    carrinho_json json
) engine=InnoDB;

delimiter //

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

create procedure sp_processar_pedido(
    in p_data_pedido date,
    in p_carrinho_json json
)
begin
    declare v_codigo_pedido int;
    declare v_codigo_produto int;
    declare v_codigo_cliente int;
    declare v_codigo_vendedor int;
    declare v_qtde int;
    declare v_preco decimal(10,2);
    declare v_estoque int;

    set v_codigo_produto = json_extract(p_carrinho_json, '$.codigoproduto');
    set v_codigo_cliente = json_extract(p_carrinho_json, '$.codigocliente');
    set v_codigo_vendedor = json_extract(p_carrinho_json, '$.codigovendedor');
    set v_qtde = json_extract(p_carrinho_json, '$.qtde');

    if (select count(*) from cliente where codigocliente = v_codigo_cliente) = 0 then
        signal sqlstate '45000' set message_text = 'Cliente inexistente';
    end if;

    if (select count(*) from funcionario where codigofuncionario = v_codigo_vendedor) = 0 then
        signal sqlstate '45000' set message_text = 'Vendedor inexistente';
    end if;

    if v_qtde <= 0 then
        signal sqlstate '45000' set message_text = 'Quantidade inválida';
    end if;

    if (select count(*) from produto where codigoproduto = v_codigo_produto) = 0 then
        signal sqlstate '45000' set message_text = 'Produto inexistente';
    end if;

    select qtde_estoque into v_estoque from produto where codigoproduto = v_codigo_produto;
    if v_estoque < v_qtde then
        signal sqlstate '45000' set message_text = 'Estoque insuficiente';
    end if;

    start transaction;

    insert into pedido (datapedido, codigocliente, codigofuncionario, status) 
    values (p_data_pedido, v_codigo_cliente, v_codigo_vendedor, 'processando');
    set v_codigo_pedido = last_insert_id();

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

insert into carrinho (carrinho_json) 
values ('{"codigoproduto": 1, "codigocliente": 1, "codigovendedor": 1, "qtde": 2}');

call sp_processar_pedido('2024-01-15', '{"codigoproduto":1,"codigocliente":1,"codigovendedor":1,"qtde":2}');

-- ---------------------------------------------
-- Teste
-- ---------------------------------------------


insert into produto (nome, descricao, qtde_estoque) values 
('Mouse Gamer', 'Mouse com sensor óptico', 10),
('Teclado Mecânico', 'Switch blue', 5);

insert into cliente (nome, email, cpf) values 
('João Silva', 'joao@email.com', '12345678901');

insert into funcionario (nome, funcao, cidade) values 
('Maria Souza', 'Vendedora', 'Belo Horizonte');


call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":1,"codigovendedor":1,"qtde":2}');

select * from pedido order by codigopedido desc;
select * from itempedido order by codigopedido desc;
select * from produto where codigoproduto = 1;

-- Esperado: erro “Quantidade inválida”
call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":1,"codigovendedor":1,"qtde":-3}');

-- Esperado: erro “Estoque insuficiente”
call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":1,"codigovendedor":1,"qtde":999}');

-- Esperado: erro “Cliente inexistente”
call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":999,"codigovendedor":1,"qtde":1}');

-- Esperado: erro “Vendedor inexistente”
call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":1,"codigovendedor":999,"qtde":1}');


create database lojabancodados2_corrigido;
use lojabancodados2_corrigido;

create table produto (
    codigoproduto int primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    qtde_estoque int default 0
) engine=InnoDB;

create table cliente (
    codigocliente int primary key auto_increment,
    nome varchar(100) not null,
    email varchar(100),
    cpf varchar(11) unique
) engine=InnoDB;

create table funcionario (
    codigofuncionario int primary key auto_increment,
    nome varchar(100) not null,
    funcao varchar(50),
    cidade varchar(50)
) engine=InnoDB;

create table pedido (
    codigopedido int primary key auto_increment,
    codigocliente int,
    codigofuncionario int,
    datapedido date not null,
    status varchar(20) default 'pendente',
    foreign key (codigocliente) references cliente(codigocliente),
    foreign key (codigofuncionario) references funcionario(codigofuncionario)
) engine=InnoDB;

create table itempedido (
    codigopedido int,
    codigoproduto int,
    precovenda decimal(10,2),
    qtde int,
    primary key (codigopedido, codigoproduto),
    foreign key (codigopedido) references pedido(codigopedido),
    foreign key (codigoproduto) references produto(codigoproduto)
) engine=InnoDB;

create table auditoria (
    id int primary key auto_increment,
    datamodificacao datetime default current_timestamp,
    nometabela varchar(50),
    historico text
) engine=InnoDB;

create table carrinho (
    id int primary key auto_increment,
    carrinho_json json
) engine=InnoDB;

delimiter //

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

create procedure sp_processar_pedido(
    in p_data_pedido date,
    in p_carrinho_json json
)
begin
    declare v_codigo_pedido int;
    declare v_codigo_produto int;
    declare v_codigo_cliente int;
    declare v_codigo_vendedor int;
    declare v_qtde int;
    declare v_preco decimal(10,2);
    declare v_estoque int;

    set v_codigo_produto = json_extract(p_carrinho_json, '$.codigoproduto');
    set v_codigo_cliente = json_extract(p_carrinho_json, '$.codigocliente');
    set v_codigo_vendedor = json_extract(p_carrinho_json, '$.codigovendedor');
    set v_qtde = json_extract(p_carrinho_json, '$.qtde');

    if (select count(*) from cliente where codigocliente = v_codigo_cliente) = 0 then
        signal sqlstate '45000' set message_text = 'Cliente inexistente';
    end if;

    if (select count(*) from funcionario where codigofuncionario = v_codigo_vendedor) = 0 then
        signal sqlstate '45000' set message_text = 'Vendedor inexistente';
    end if;

    if v_qtde <= 0 then
        signal sqlstate '45000' set message_text = 'Quantidade inválida';
    end if;

    if (select count(*) from produto where codigoproduto = v_codigo_produto) = 0 then
        signal sqlstate '45000' set message_text = 'Produto inexistente';
    end if;

    select qtde_estoque into v_estoque from produto where codigoproduto = v_codigo_produto;
    if v_estoque < v_qtde then
        signal sqlstate '45000' set message_text = 'Estoque insuficiente';
    end if;

    start transaction;

    insert into pedido (datapedido, codigocliente, codigofuncionario, status) 
    values (p_data_pedido, v_codigo_cliente, v_codigo_vendedor, 'processando');
    set v_codigo_pedido = last_insert_id();

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

insert into carrinho (carrinho_json) 
values ('{"codigoproduto": 1, "codigocliente": 1, "codigovendedor": 1, "qtde": 2}');

call sp_processar_pedido('2024-01-15', '{"codigoproduto":1,"codigocliente":1,"codigovendedor":1,"qtde":2}');

-- ---------------------------------------------
-- Teste
-- ---------------------------------------------


insert into produto (nome, descricao, qtde_estoque) values 
('Mouse Gamer', 'Mouse com sensor óptico', 10),
('Teclado Mecânico', 'Switch blue', 5);

insert into cliente (nome, email, cpf) values 
('João Silva', 'joao@email.com', '12345678901');

insert into funcionario (nome, funcao, cidade) values 
('Maria Souza', 'Vendedora', 'Belo Horizonte');


call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":1,"codigovendedor":1,"qtde":2}');

select * from pedido order by codigopedido desc;
select * from itempedido order by codigopedido desc;
select * from produto where codigoproduto = 1;

-- Esperado: erro “Quantidade inválida”
call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":1,"codigovendedor":1,"qtde":-3}');

-- Esperado: erro “Estoque insuficiente”
call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":1,"codigovendedor":1,"qtde":999}');

-- Esperado: erro “Cliente inexistente”
call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":999,"codigovendedor":1,"qtde":1}');

-- Esperado: erro “Vendedor inexistente”
call sp_processar_pedido('2024-01-15', 
'{"codigoproduto":1,"codigocliente":1,"codigovendedor":999,"qtde":1}');

-- Esperado: erro "Produto inexistente"
call sp_processar_pedido('2024-01-15', '{"codigoproduto":999,"codigocliente":1,"codigovendedor":1,"qtde":2}');  -- Esperado: Erro "Produto inexistente"


