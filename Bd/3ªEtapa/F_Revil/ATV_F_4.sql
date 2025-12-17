use CLASSICMODELS;

CREATE or replace  VIEW vw_produtos_estoque AS
SELECT 
    productCode,
    SUM(quantityOrdered) AS quantityOrdered,
    quantityInStock,
    (SUM(quantityOrdered) + quantityInStock) AS EstoqueTotal
FROM products
INNER JOIN orderdetails USING (productCode)
GROUP BY productCode, quantityInStock;

drop table if exists tabela_produtos_estoque;
CREATE TABLE tabela_produtos_estoque AS
SELECT * FROM vw_produtos_estoque;

select * FROM tabela_produtos_estoque;

drop table if exists auditoria_produtos_estoque;
CREATE TABLE auditoria_produtos_estoque (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(255),
    dataModificacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE tabela_produtos_estoque
ADD COLUMN percentualVendido DECIMAL(5,2),
ADD COLUMN observacao VARCHAR(255);

drop TRIGGER if exists trg_auditoria_produtos_estoque;
DELIMITER $$

CREATE TRIGGER trg_auditoria_produtos_estoque
AFTER UPDATE ON tabela_produtos_estoque
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_produtos_estoque (Descricao, dataModificacao)
    VALUES (
        CONCAT('Alteração no produto ', NEW.productCode, 
               ': Estoque total anterior = ', OLD.EstoqueTotal,
               ', novo estoque total = ', NEW.EstoqueTotal),
        NOW()
    );
END$$

DELIMITER ;

drop FUNCTION if exists fn_percentual_vendido;

DELIMITER $$

CREATE FUNCTION fn_percentual_vendido(totalDeProdutoVendidos INT, estoqueTotal INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE resultado DECIMAL(5,2);

    IF estoqueTotal = 0 THEN
        SET resultado = 0;
    ELSE
        SET resultado = (totalDeProdutoVendidos / estoqueTotal) * 100;
    END IF;

    RETURN resultado;
END$$

DELIMITER ;

drop PROCEDURE if exists prc_atualiza_percentual_estoque;
DELIMITER $$

CREATE PROCEDURE prc_atualiza_percentual_estoque()
BEGIN
    DECLARE v_productCode VARCHAR(15);
    DECLARE v_quantityOrdered INT;
    DECLARE v_quantityInStock INT;
    DECLARE v_estoqueTotal INT;
    DECLARE v_percentual DECIMAL(5,2);
    DECLARE v_observacao VARCHAR(255);
    DECLARE fim_cursor BOOLEAN DEFAULT FALSE;

    -- Cursor com base na tabela criada na letra B
    DECLARE cur_prod CURSOR FOR
        SELECT productCode, quantityOrdered, quantityInStock, EstoqueTotal
        FROM tabela_produtos_estoque;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_cursor = TRUE;

    START TRANSACTION;

    OPEN cur_prod;

    read_loop: LOOP
        FETCH cur_prod INTO v_productCode, v_quantityOrdered, v_quantityInStock, v_estoqueTotal;
        IF fim_cursor THEN
            LEAVE read_loop;
        END IF;

        -- 4 - Chama a função de cálculo do percentual
        SET v_percentual = fn_percentual_vendido(v_quantityOrdered, v_estoqueTotal);

        -- 5 - Define observação conforme o percentual
        IF v_percentual > 70 THEN
            SET v_observacao = 'REPOSIÇÃO DE ESTOQUE';
        ELSEIF v_percentual BETWEEN 50 AND 70 THEN
            SET v_observacao = 'ESTOQUE EM ATENÇÃO';
        ELSE
            SET v_observacao = 'PRODUTO CONTROLADO';
        END IF;

        -- 6 - Atualiza os campos na tabela
        UPDATE tabela_produtos_estoque
        SET percentualVendido = v_percentual,
            observacao = v_observacao
        WHERE productCode = v_productCode;
    END LOOP;

    CLOSE cur_prod;

    -- 7 - Confirma as alterações
    COMMIT;
END$$

DELIMITER ;

call prc_atualiza_percentual_estoque();
select * from tabela_produtos_estoque;

