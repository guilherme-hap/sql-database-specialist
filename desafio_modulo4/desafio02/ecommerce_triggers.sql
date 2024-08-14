USE ecommerce;

-- Criação de triggers de remoção e atualização

-- Remoção: usuários podem excluir suas contas por algum motivo. Dessa forma, para não perder as informações sobre estes usuários, cria-se um gatilho before delete

-- Criação de uma tabela para salvar dados do usuário antes da remoção
CREATE TABLE deleted_clients(
	clientId INT AUTO_INCREMENT PRIMARY KEY,
	fName VARCHAR(10),
    mInit CHAR(3),
    lName VARCHAR(20),
    cpf CHAR(11) NOT NULL,
	address VARCHAR(100),
    CONSTRAINT unique_cpf_client UNIQUE(cpf)
);

DELIMITER \\
CREATE TRIGGER save_deleted_clients BEFORE DELETE ON ecommerce.clients
FOR EACH ROW
	BEGIN
		INSERT INTO deleted_clients(fName, mInit, lName, cpf, address) VALUES(OLD.fName, OLD.mInit, OLD.lName, OLD.cpf, OLD.address);
    END \\
DELIMITER ;

SELECT * FROM clients;

DELETE FROM clients WHERE clientId = 4;

SELECT * FROM deleted_clients;

USE company;

-- Atualização: atualização do salário base
drop trigger update_clients_salary;
DELIMITER \\
CREATE TRIGGER update_clients_salary BEFORE UPDATE ON employees
FOR EACH ROW
	BEGIN
		IF NEW.dNo = 1 THEN
			SET NEW.salary = NEW.salary * 1.10;
		ELSEIF NEW.dNo = 4 THEN
			SET NEW.salary = NEW.salary * 1.05;
		ELSEIF NEW.dNo = 5 THEN
			SET NEW.salary = NEW.salary + 0;
		END IF;
    END \\
DELIMITER ;

SELECT * FROM employees;

UPDATE employees
	SET salary = 25000.00
    WHERE ssn = '987987987';
    
SELECT * FROM employees;

SHOW TRIGGERS FROM ecommerce;
