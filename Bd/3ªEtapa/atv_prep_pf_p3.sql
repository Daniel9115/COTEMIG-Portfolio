use Cotemig;

-- 1.a
create or replace view vw_aluno_detalhes as
select 
    a.nomealuno,
    d.nomemdisciplina as nomedisciplina,
    ma.ano,
    s.nomesituacao,
    dep.nomedepertamento as nomedepartamento
from matricula_aluno ma
inner join aluno a on ma.codigoalunomatricula = a.codigoaluno
inner join disciplina d on ma.codigodisciplinamatricula = d.codigodisciplina
inner join situacao s on ma.situacaomatricula = s.codigosituacao
inner join departamento dep on d.codigodepartamentodisciplina = dep.codigodepartamento;

-- 1.b
create or replace view vw_qtd_alunos_ano_situacao as
select 
    ma.ano,
    s.nomesituacao,
    count(ma.codigoalunomatricula) as quantidade_alunos
from matricula_aluno ma
inner join situacao s on ma.situacaomatricula = s.codigosituacao
group by ma.ano, s.nomesituacao;

-- 1.c
create table qtd_disciplinas_departamento as
select 
    dep.codigodepartamento,
    dep.nomedepertamento,
    count(d.codigodisciplina) as quantidade_disciplinas
from departamento dep
left join disciplina d on dep.codigodepartamento = d.codigodepartamentodisciplina
group by dep.codigodepartamento, dep.nomedepertamento;

-- 1.d
create table recuperacao (
    codigoalunorecuperacao int,
    codigodisciplinarecuperacao int,
    nota decimal(5,2)
);

-- 1.e
create table log_recuperacao (
    idlog int auto_increment primary key,
    descricao text,
    data timestamp default current_timestamp
);

-- 1.f
delimiter $$

create trigger trg_insert_recuperacao
before insert on recuperacao
for each row
begin
    declare v_nomealuno varchar(100);
    declare v_nomedisciplina varchar(100);

    select nomealuno into v_nomealuno from aluno where codigoaluno = new.codigoalunorecuperacao;
    select nomedisciplina into v_nomedisciplina from disciplina where codigodisciplina = new.codigodisciplinarecuperacao;

    insert into log_recuperacao (descricao, data)
    values (
        concat('foi incluído na recuperação: ', v_nomealuno, ' - para a disciplina: ', v_nomedisciplina),
        current_timestamp()
    );
end$$

delimiter ;

-- 1.g
delimiter $$

create trigger trg_update_recuperacao
after update on recuperacao
for each row
begin
    declare v_nomealuno varchar(100);

    select nomealuno into v_nomealuno from aluno where codigoaluno = new.codigoalunorecuperacao;

    insert into log_recuperacao (descricao, data)
    values (
        concat('foi alterada a nota do aluno: ', v_nomealuno, 
               ' - nota antiga: ', old.nota, 
               ' - nota nova: ', new.nota),
        current_timestamp()
    );
end$$

delimiter ;

-- 1.h
delimiter $$

create trigger trg_delete_matricula
after delete on matricula_aluno
for each row
begin
    declare v_nomedisciplina varchar(100);

    select nomedisciplina into v_nomedisciplina 
    from disciplina 
    where codigodisciplina = old.codigodisciplinamatricula;

    insert into log_recuperacao (descricao, data)
    values (
        concat('a disciplina: ', v_nomedisciplina, ' - foi excluída'),
        current_timestamp()
    );
end$$

delimiter ;

-- 1.i
delimiter $$

create procedure sp_incluir_recuperacao()
begin
    declare v_aluno int;
    declare v_disciplina int;
    declare fim int default 0;

    declare cur cursor for
        select codigoalunomatricula, codigodisciplinamatricula
        from matricula_aluno
        where situacaomatricula = (select codigosituacao from situacao where nomesituacao = 'recuperação');

    declare continue handler for not found set fim = 1;

    open cur;

    loop_inserir: loop
        fetch cur into v_aluno, v_disciplina;
        if fim = 1 then 
            leave loop_inserir;
        end if;

        insert into recuperacao (codigoalunorecuperacao, codigodisciplinarecuperacao, nota)
        values (v_aluno, v_disciplina, null);
    end loop loop_inserir;

    close cur;
end$$

delimiter ;

-- 1.j
delimiter $$

create function fn_avaliar_aluno(notaaluno decimal(5,2))
returns varchar(100)
deterministic
begin
    declare resultado varchar(100);

    if notaaluno >= 60 then
        set resultado = 'aprovado - boas férias';
    else
        set resultado = 'ainda há mais uma chance! bora estudar';
    end if;

    return resultado;
end$$

delimiter ;

-- 1.k
delimiter $$

create procedure sp_excluir_por_ano(p_ano int)
begin
    delete from matricula_aluno where ano = p_ano;
end$$

delimiter ;