# Atividade preparatória para prova final - 01
use sakila;

#A.
DROP TABLE IF EXISTS resumo_pagamentos;
CREATE TABLE resumo_pagamentos AS
SELECT 
    CONCAT(first_name, ' ', last_name) AS cliente,
    MONTHNAME(payment_date) AS mes,
    rental_id,
    SUM(amount) AS total_valor_pago,
    0 AS lucro_esperado
FROM payment
INNER JOIN customer USING (customer_id)
INNER JOIN rental USING (rental_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film USING (film_id)
WHERE payment_date BETWEEN '2005-03-01' AND '2005-09-30'
GROUP BY cliente, mes, rental_id;

#B.

DROP TABLE IF EXISTS log_resumo_pagamentos;
CREATE TABLE log_resumo_pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

#C

CREATE OR REPLACE VIEW vw_resumo_pagamentos_filmes AS
SELECT 
    cliente,
    mes,
    rental_id,
    SUM(total_valor_pago) AS total_valor_pago,
    ROUND(AVG(lucro_esperado), 2) AS lucro_esperado_medio,
    COUNT(DISTINCT film_id) AS quantidade_filmes
FROM resumo_pagamentos
INNER JOIN rental USING (rental_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film USING (film_id)
GROUP BY cliente, mes, rental_id;


#D
DROP FUNCTION IF EXISTS fn_calcula_lucro;
DELIMITER $$

CREATE FUNCTION fn_calcula_lucro(total_valor_pago DECIMAL(10,2), quantidade_filmes INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE lucro DECIMAL(10,2);

    IF quantidade_filmes > 30 THEN
        SET lucro = total_valor_pago * 0.10;
    ELSEIF quantidade_filmes > 20 THEN
        SET lucro = total_valor_pago * 0.05;
    ELSE
        SET lucro = total_valor_pago * 0.02;
    END IF;

    RETURN lucro;
END $$

DELIMITER ;

#E

DROP TRIGGER IF EXISTS trg_resumo_pagamentos_log;
DELIMITER $$

CREATE TRIGGER trg_resumo_pagamentos_log
AFTER INSERT ON resumo_pagamentos
FOR EACH ROW
BEGIN
    INSERT INTO log_resumo_pagamentos (descricao)
    VALUES (
        CONCAT('Novo registro inserido com lucro_esperado = ', NEW.lucro_esperado)
    );
END $$

DELIMITER ;

#F

DROP PROCEDURE IF EXISTS sp_atualiza_lucro;
DELIMITER $$

CREATE PROCEDURE sp_atualiza_lucro()
BEGIN
    -- Declara variáveis para armazenar os dados do cursor
    DECLARE v_cliente VARCHAR(100);
    DECLARE v_mes VARCHAR(20);
    DECLARE v_rental_id INT;
    DECLARE v_total_valor_pago DECIMAL(10,2);
    DECLARE v_quantidade_filmes INT;
    DECLARE v_lucro DECIMAL(10,2);

    -- Variável de controle do loop
    DECLARE done INT DEFAULT 0;

    -- Declarar cursor
    DECLARE cur_pagamentos CURSOR FOR
        SELECT cliente, mes, rental_id, total_valor_pago, quantidade_filmes
        FROM vw_resumo_pagamentos_filmes;

    -- Handler para sair do loop
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Abrir cursor
    OPEN cur_pagamentos;

    read_loop: LOOP
        FETCH cur_pagamentos INTO v_cliente, v_mes, v_rental_id, v_total_valor_pago, v_quantidade_filmes;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Chamar função para calcular lucro
        SET v_lucro = fn_calcula_lucro(v_total_valor_pago, v_quantidade_filmes);

        -- Atualizar tabela resumo_pagamentos
        UPDATE resumo_pagamentos
        SET lucro_esperado = v_lucro
        WHERE cliente = v_cliente
          AND mes = v_mes
          AND rental_id = v_rental_id;

    END LOOP;

    -- Fechar cursor
    CLOSE cur_pagamentos;
END $$

DELIMITER ;


#Testes


-- Teste 1: Verificar dados iniciais (lucro_esperado = 0)
SELECT cliente, mes, rental_id, total_valor_pago, lucro_esperado
FROM resumo_pagamentos
ORDER BY cliente, mes
LIMIT 10;

-- Teste 2: Executar a procedure
CALL sp_atualiza_lucro();

-- Teste 3: Verificar atualização de lucro
SELECT cliente, mes, rental_id, total_valor_pago, lucro_esperado
FROM resumo_pagamentos
ORDER BY cliente, mes
LIMIT 10;

-- Teste 4: Verificar log de inserção
SELECT * 
FROM log_resumo_pagamentos
ORDER BY data DESC
LIMIT 10;

-- Teste 5: Validar função fn_calcula_lucro
SELECT cliente, total_valor_pago, quantidade_filmes, 
       fn_calcula_lucro(total_valor_pago, quantidade_filmes) AS lucro_calculado
FROM vw_resumo_pagamentos_filmes
ORDER BY cliente
LIMIT 10;