-- Código de criação do banco de dados ecommerce está no diretório do desafio01 do módulo03
USE ecommerce;

-- Objetivo: Criar uma procedure que possua as instruções de inserção, remoção e atualização de dados no banco de dados. As instruções devem estar dentro de estruturas condicionais (como CASE ou IF).  
-- Além das variáveis de recebimento das informações, a procedure deverá possuir uma variável de controle. Essa variável de controle irá determinar a ação a ser executada. Ex: opção 1 – select, 2 – update, 3 – delete.

DELIMITER //
CREATE PROCEDURE clients_data_manipulation(
	IN action_option INT,
	IN fName_p VARCHAR(10),
    IN mInit_p CHAR(3),
    IN lName_p VARCHAR(20),
    IN cpf_p CHAR(11),
	IN address_p VARCHAR(100)
)
BEGIN
    CASE action_option
		WHEN 1 THEN
			SELECT * FROM clients;
        WHEN 2 THEN
			UPDATE clients
				SET fName = fName_p
                WHERE cpf = cpf_p;
			UPDATE clients
				SET mInit = mInit_p
                WHERE cpf = cpf_p;
			UPDATE clients
				SET lName = lName_p
                WHERE cpf = cpf_p;
			UPDATE clients
				SET address = address_p
                WHERE cpf = cpf_p;
			
            SELECT * FROM clients WHERE cpf = cpf_p;
        WHEN 3 THEN
			DELETE FROM clients
				WHERE cpf = cpf_p;
			
            SELECT * FROM clients;
	END CASE;
END //
DELIMITER ;

CALL clients_data_manipulation(1, NULL, NULL, NULL, NULL, NULL);
CALL clients_data_manipulation(2, 'Maria', 'M', 'Silva', 12346789, 'Rua Tal');
CALL clients_data_manipulation(3, NULL, NULL, NULL, 12346789, NULL);