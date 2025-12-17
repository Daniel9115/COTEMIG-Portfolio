use sakila;

DROP TABLE IF EXISTS filme_detalhes;
CREATE TABLE filme_detalhes AS
SELECT 
    film_id AS codigo,
    GROUP_CONCAT(CONCAT(first_name, ' ', last_name) SEPARATOR ', ') AS relacao_atores,
    category.name AS categoria,
    rental_rate AS taxa_aluguel,
    0 AS atraso,
    CAST(0 AS DECIMAL(10,2)) AS taxa_calculada
FROM film
INNER JOIN film_actor USING (film_id)
INNER JOIN actor USING (actor_id)
INNER JOIN film_category USING (film_id)
INNER JOIN category USING (category_id)
GROUP BY film_id, category.name, rental_rate
LIMIT 100;

DROP TABLE IF EXISTS log_filme_detalhes;
CREATE TABLE log_filme_detalhes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE VIEW vw_filme_detalhes_estoque AS
SELECT 
    codigo,
    relacao_atores,
    categoria,
    taxa_aluguel,
    atraso,
    taxa_calculada,
    COUNT(inventory_id) AS quantidade_estoque
FROM filme_detalhes
LEFT JOIN inventory ON film_id = codigo
GROUP BY 
    codigo, relacao_atores, categoria, taxa_aluguel, atraso, taxa_calculada;


DROP FUNCTION IF EXISTS fn_calcula_taxa;
DROP TRIGGER IF EXISTS trg_log_update_filme_detalhes;

DELIMITER $$

CREATE FUNCTION fn_calcula_taxa(
    quantidade_filmes INT,
    taxa_aluguel DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE resultado DECIMAL(10,2);
    
    IF quantidade_filmes >= 6 THEN
        SET resultado = quantidade_filmes * POW(taxa_aluguel, 2);
    ELSE
        SET resultado = quantidade_filmes * taxa_aluguel;
    END IF;
    
    RETURN resultado;
END$$


CREATE TRIGGER trg_log_update_filme_detalhes
AFTER UPDATE ON filme_detalhes
FOR EACH ROW
BEGIN
    -- Verifica se houve alteração em atraso ou taxa_calculada
    IF (OLD.atraso <> NEW.atraso) OR (OLD.taxa_calculada <> NEW.taxa_calculada) THEN
        INSERT INTO log_filme_detalhes (descricao)
        VALUES (
            CONCAT(
                'Filme ID: ', NEW.codigo,
                ' | Atraso: ', OLD.atraso, ' -> ', NEW.atraso,
                ' | Taxa Calculada: ', OLD.taxa_calculada, ' -> ', NEW.taxa_calculada
            )
        );
    END IF;
END$$

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_atualiza_filme_detalhes;

DELIMITER $$

CREATE PROCEDURE sp_atualiza_filme_detalhes()
BEGIN
    DECLARE v_codigo INT;
    DECLARE v_quantidade INT;
    DECLARE v_taxa_aluguel DECIMAL(10,2);
    DECLARE v_taxa_calculada DECIMAL(10,2);
    DECLARE fim_cursor BOOLEAN DEFAULT FALSE;
    
    DECLARE cur CURSOR FOR
        SELECT codigo, quantidade_estoque, taxa_aluguel
        FROM vw_filme_detalhes_estoque;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_cursor = TRUE;

    OPEN cur;

    -- Loop principal
    loop_filmes: LOOP
        FETCH cur INTO v_codigo, v_quantidade, v_taxa_aluguel;

        IF fim_cursor THEN
            LEAVE loop_filmes;
        END IF;

        SET v_taxa_calculada = fn_calcula_taxa(v_quantidade, v_taxa_aluguel);

        UPDATE filme_detalhes
        SET atraso = v_quantidade,
            taxa_calculada = v_taxa_calculada
        WHERE codigo = v_codigo;
    END LOOP loop_filmes;

    CLOSE cur;
END$$

DELIMITER ;

CALL sp_atualiza_filme_detalhes();

SELECT *
FROM filme_detalhes
LIMIT 10;

SELECT * FROM log_filme_detalhes;




