USE ecommerce;

SET @@autocommit = 0;

DELIMITER //
CREATE PROCEDURE clients_data_insertion(
	IN fName_p VARCHAR(10),
    IN mInit_p CHAR(1),
    IN lName_p VARCHAR(20),
    IN cpf_p CHAR(11),
	IN address_p VARCHAR(100)
)
	BEGIN
        
		DECLARE sqlError TINYINT DEFAULT FALSE;
        
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sqlError = TRUE;
        
		START TRANSACTION;
        
        INSERT INTO
			clients(fName, mInit, lName, cpf, address)
		VALUES
			(fName_p, mInit_p, lName_p, cpf_p, address_p);
            
		SAVEPOINT clientsInsertion;
            
		IF sqlError = FALSE THEN
			COMMIT;
            SELECT * FROM clients;
		ELSE
			ROLLBACK TO SAVEPOINT clientsInsertion;
			SELECT 'Erro na transação' AS Resultado;
		END IF;
		
	END //
DELIMITER ;	

CALL clients_data_insertion('Jennyfer','L','Olimpo', 787123456,'rua lareijras 643, Centro - Cidade das flores');

DELIMITER //
CREATE PROCEDURE orders_status_update(
	IN orderStatus_p ENUM('Cancelado', 'Confirmado', 'Em processamento'),
    IN orderId_p INT
)
	BEGIN
        
		DECLARE sqlError TINYINT DEFAULT FALSE;
        
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sqlError = TRUE;
        
		START TRANSACTION;
			
		UPDATE orders
			SET orderStatus = orderStatus_p
            WHERE orderId = orderId_p;
            
		SAVEPOINT orderUpdate;
            
		IF sqlError = FALSE THEN
			COMMIT;
            SELECT * FROM orders;
		ELSE
			ROLLBACK TO SAVEPOINT orderUpdate;
			SELECT 'Erro na transação' AS Resultado;
		END IF;
		
	END //
DELIMITER ;	

CALL orders_status_update('Cancelado', 5);