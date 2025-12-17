create database colegio;

use colegio;

# comentário 1 linha
-- comentário 2 linha

/*
	comentário
    de várias linhas
*/

create table aluno (
	id_aluno int unsigned not null auto_increment primary key,
    nome varchar(200),
    idade int
) engine = InnoDB;

create table disciplina (
	id_disciplina int unsigned not null auto_increment primary key,
    nome varchar(200),
    idade int
) engine = InnoDB;

create table aluno_disciplina (
	fk_aluno int unsigned not null,
	fk_disciplina int unsigned not null,
    ano int,
    
    foreign key(fk_aluno) references alunos(id_aluno) on Delete restrict,
    foreign key(fk_disciplina) references alunos(id_disciplina) on Delete cascade
) engine = InnoDB;


insert into aluno(id_aluno, nome, idade) values (default, 'Bernado', 100);
insert into disciplina(id_disciplina, nome) values (default, '802'), (default, 'MAT');

select * from aluno;
select * from disciplina;

insert into aluno_disciplina (fk_aluno, fk_disciplina, ano)
	values(1, 2, 2025), (1, 3, 2025);
    
select * from aluno_disciplina;

delete from aluno where id_aluno = 1;
delete from disciplina where id_disciplina = 1;
delete from aluno_disciplina where fk_aluno = 1;

alter table disciplina add column status int default 0;