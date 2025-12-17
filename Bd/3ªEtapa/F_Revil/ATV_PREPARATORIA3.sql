CREATE OR REPLACE VIEW Aluno_Detalhes As
	select 
		nomeAluno,
        nomeDisciplina,
        nomeDepartamento,
        ano,
        nomeSituacao
	from
		Matricula_Aluno
        inner join Aluno ON codigoAluno = codigoAlunoMatricula
        inner join Situacao on codigoSituacao = situacaoMatricula
        inner join disciplina on codigoDisciplina = codigoDisciplinaMatricula
        inner join departamento on codigoDepartamento = codigoDepartamentoDisciplina;
        
CREATE OR REPLACE VIEW Qtd_alunos_Por_situacao As
	select 
		ano,
        nomeSituacao,
		count(codigoAluno) as qtdAlunos
	from
		Matricula_Aluno
        inner join Aluno ON codigoAluno = codigoAlunoMatricula
        inner join Situacao on codigoSituacao = situacaoMatricula
        inner join disciplina on codigoDisciplina = codigoDisciplinaMatricula
	group by
		ano, nomeSituacao;
        
create table Disciplinas_Por_departamento as
	select
		nomeDepartamento,
		count(codigoDisciplina) as QtdDisciplinas
	from
		disciplina
        inner join departamento on codigoDepartamento = codigoDepartamentoDisciplina
	group by nomeDepartamento;
    
create table recuperacao (
	codigoAlunoRecuperacao INT NOT NULL,
    codigoDisciplinaRecuperacao INT NOT NULL,
    nota decimal(10,2),
    PRIMARY KEY (codigoAlunoRecuperacao, codigoDisciplinaRecuperacao),
	FOREIGN KEY  (codigoAlunoRecuperacao) REFERENCES Aluno(codigoAluno),
	FOREIGN KEY (codigoDisciplinaRecuperacao) REFERENCES Disciplina(codigoDisciplina)
) ENGINE=InnoDB;

CREATE TABLE log_recuperacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao TEXT NOT NULL,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER before_insert_recuperacao
BEFORE INSERT ON recuperacao
FOR EACH ROW
BEGIN
    DECLARE nome_aluno VARCHAR(100);
    DECLARE nome_disciplina VARCHAR(100);

    SELECT nomeAluno INTO nome_aluno
    FROM Aluno
    WHERE codigoAluno = NEW.codigoAlunoRecuperacao;

    SELECT nomeDisciplina INTO nome_disciplina
    FROM Disciplina
    WHERE codigoDisciplina = NEW.codigoDisciplinaRecuperacao;

    INSERT INTO log_recuperacao(descricao, data)
    VALUES (CONCAT('Foi incluído na recuperação: ', nome_aluno, ' - para a disciplina: ', nome_disciplina),
            CURRENT_TIMESTAMP());
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_update_recuperacao
AFTER UPDATE ON recuperacao
FOR EACH ROW
BEGIN
    DECLARE nome_aluno VARCHAR(100);
    DECLARE nome_disciplina VARCHAR(100);

    SELECT nomeAluno INTO nome_aluno
    FROM Aluno
    WHERE codigoAluno = NEW.codigoAlunoRecuperacao;

    SELECT nomeDisciplina INTO nome_disciplina
    FROM Disciplina
    WHERE codigoDisciplina = NEW.codigoDisciplinaRecuperacao;

    INSERT INTO log_recuperacao(descricao, data)
    VALUES (CONCAT('Foi alterada a nota do aluno: ', nome_aluno,
                   ' - disciplina: ', nome_disciplina,
                   ' - nota antiga: ', OLD.nota,
                   ' - nota nova: ', NEW.nota),
            CURRENT_TIMESTAMP());
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_delete_matricula
AFTER DELETE ON Matricula_Aluno
FOR EACH ROW
BEGIN
    DECLARE nome_disciplina VARCHAR(100);

    SELECT nomeDisciplina INTO nome_disciplina
    FROM Disciplina
    WHERE codigoDisciplina = OLD.codigoDisciplinaMatricula;

    INSERT INTO log_recuperacao(descricao, data)
    VALUES (CONCAT('A disciplina: ', nome_disciplina, ' - foi excluída'),
            CURRENT_TIMESTAMP());
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE incluir_alunos_recuperacao()
BEGIN
    DECLARE v_codigoAluno INT;
    DECLARE v_codigoDisciplina INT;
    DECLARE v_done INT DEFAULT 0;

    DECLARE cur_alunos CURSOR FOR
        SELECT codigoAlunoMatricula, codigoDisciplinaMatricula
        FROM Matricula_Aluno
        WHERE situacaoMatricula = (
            SELECT codigoSituacao
            FROM Situacao
            WHERE nomeSituacao = 'Reprovado'
        );

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    OPEN cur_alunos;

    loop_alunos: LOOP
        FETCH cur_alunos INTO v_codigoAluno, v_codigoDisciplina;

        IF v_done = 1 THEN
            LEAVE loop_alunos;
        END IF;

        INSERT INTO recuperacao(codigoAlunoRecuperacao, codigoDisciplinaRecuperacao, nota)
        VALUES (v_codigoAluno, v_codigoDisciplina, NULL);
    END LOOP loop_alunos;

    CLOSE cur_alunos;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION avaliar_aluno(notaAluno DECIMAL(10,2))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(100);

    IF notaAluno >= 60 THEN
        SET resultado = 'Aprovado - Boas Férias';
    ELSE
        SET resultado = 'Ainda há mais uma chance! Bora estudar';
    END IF;

    RETURN resultado;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE excluir_matriculas_por_ano(IN p_ano YEAR)
BEGIN
    DELETE FROM Matricula_Aluno
    WHERE ano = p_ano;
END$$

DELIMITER ;

CALL excluir_matriculas_por_ano(2022);
select * from log_recuperacao;

