create database sinuca;
use sinuca;

-- tabela para armazenar as bolas de sinuca
create table sacola (
  numerobola int not null primary key, 
  cor varchar(10), 
  qtde int
) engine = innodb;

delimiter $

-- procedure para incluir bolas na sacola
create procedure incluir_bolas_sacola (
  in param_numerobola int, 
  in param_cor varchar(10), 
  in param_qtde int
)
begin
  declare var_capacidade_sacola int default 200;
  declare var_quantidade_atual int;
  declare var_quantidade_final_sacola int;
  declare var_espaco_disponivel int;
  declare var_existe_bola int;

  -- validações iniciais
  if param_numerobola is null or param_cor is null or param_qtde is null then
    select 'parâmetros inválidos: nenhum pode ser nulo.' as mensagem;
    leave proc;
  end if;

  if param_qtde <= 0 then
    select 'quantidade inválida: deve ser maior que zero.' as mensagem;
    leave proc;
  end if;

  -- verifica existência da bola
  select ifnull(numerobola, 0) into var_existe_bola
  from sacola where numerobola = param_numerobola;

  if var_existe_bola = 0 then
    select ifnull(sum(qtde), 0) into var_quantidade_atual from sacola;
    set var_quantidade_final_sacola = var_quantidade_atual + param_qtde;

    if var_quantidade_final_sacola <= var_capacidade_sacola then
      insert into sacola (numerobola, cor, qtde)
      values (param_numerobola, param_cor, param_qtde);
    else
      set var_espaco_disponivel = var_capacidade_sacola - var_quantidade_atual;
      if var_espaco_disponivel > 0 then
        insert into sacola (numerobola, cor, qtde)
        values (param_numerobola, param_cor, var_espaco_disponivel);
        select concat('você excedeu a capacidade em: ', (param_qtde - var_espaco_disponivel)) as mensagem;
      else
        select 'sacola já está cheia. nenhuma bola foi incluída.' as mensagem;
      end if;
    end if;
  else
    call alterar_bolas_sacola(param_numerobola, param_cor, param_qtde);
  end if;
end$

-- procedure para alterar quantidade de bolas
create procedure alterar_bolas_sacola (
  in param_numerobola int, 
  in param_cor varchar(10), 
  in param_qtde int
)
begin
  declare var_capacidade_sacola int default 200;
  declare var_quantidade_atual int;
  declare var_quantidade_final_sacola int;
  declare var_espaco_disponivel int;
  declare var_existe_bola int;
  declare var_quantidade_bolas_por_cor int;

  if param_numerobola is null or param_qtde is null then
    select 'parâmetros inválidos.' as mensagem;
    leave proc;
  end if;

  select ifnull(numerobola, 0) into var_existe_bola
  from sacola where numerobola = param_numerobola;

  if var_existe_bola > 0 then
    select ifnull(sum(qtde), 0) into var_quantidade_atual from sacola;
    set var_quantidade_final_sacola = var_quantidade_atual + param_qtde;

    if var_quantidade_final_sacola <= var_capacidade_sacola then
      select qtde into var_quantidade_bolas_por_cor
      from sacola where numerobola = param_numerobola;

      if (var_quantidade_bolas_por_cor + param_qtde) > 0 then
        update sacola
        set qtde = var_quantidade_bolas_por_cor + param_qtde
        where numerobola = param_numerobola;
      else
        call excluir_bolas_sacola(param_numerobola);
      end if;
    else
      set var_espaco_disponivel = var_capacidade_sacola - var_quantidade_atual;
      if var_espaco_disponivel > 0 then
        update sacola
        set qtde = var_espaco_disponivel
        where numerobola = param_numerobola;
        select concat('você excedeu a capacidade em: ', (param_qtde - var_espaco_disponivel)) as mensagem;
      else
        select 'sacola cheia. não foi possível alterar a quantidade.' as mensagem;
      end if;
    end if;
  else
    call incluir_bolas_sacola(param_numerobola, param_cor, param_qtde);
  end if;
end$

-- procedure para excluir bolas da sacola
create procedure excluir_bolas_sacola (
  in param_numerobola int
)
begin
  declare var_existe_bola int;

  if param_numerobola is null then
    select 'número da bola inválido.' as mensagem;
    leave proc;
  end if;

  select ifnull(numerobola, 0) into var_existe_bola
  from sacola where numerobola = param_numerobola;

  if var_existe_bola > 0 then
    delete from sacola where numerobola = param_numerobola;
  else
    select concat('a bola de número ', param_numerobola, ' não existe.') as mensagem;
  end if;
end$
delimiter ;


-- 1: Inserção comum
call incluir_bolas_sacola(1, 'vermelha', 10);

-- 2: Preencher até o limite
call incluir_bolas_sacola(2, 'azul', 190);

-- 3: Inserção acima da capacidade
call incluir_bolas_sacola(3, 'amarela', 20);

-- 4: Alteração de quantidade (aumentar)
call incluir_bolas_sacola(1, 'vermelha', 5);

-- 5: Reduzir quantidade (sem excluir)
call incluir_bolas_sacola(1, 'vermelha', -5);

-- 6: Reduzir quantidade para 0 (excluir)
call incluir_bolas_sacola(1, 'vermelha', -5);

-- 7: Tentar excluir bola inexistente
call excluir_bolas_sacola(99);

-- 8: Inserção com quantidade inválida
call incluir_bolas_sacola(4, 'preta', 0);

-- 9: Inserção com parâmetros nulos
call incluir_bolas_sacola(null, null, null);

/*Sacola

1- pares de cores de bolas, exceto bola 8
2 - numeracao maxima
3 - (ifnull) -> somente com funcao de agregação
4 - teste: positivo(numerobola) e negativo(numerobola); positivo e negativo(qtde -> =,<,>) ->qtde
5 - bola nao existente chamada da procedure alterar
6 - excluir bola que não existe*/
