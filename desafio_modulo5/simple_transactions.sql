USE ecommerce;

SET @@autocommit = 0;

START TRANSACTION;
    
    INSERT INTO 
		clients(fName, mInit, lName, cpf, address) 
	VALUES
		('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
		('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores');
        
	SELECT
		*
	FROM clients;
    
COMMIT;

START TRANSACTION;
    
    UPDATE orders
		SET orderStatus = 'Confirmado'
        WHERE orderId = 1;
    
COMMIT;

SELECT * FROM orders;
