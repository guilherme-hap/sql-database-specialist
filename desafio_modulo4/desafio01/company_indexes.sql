USE company;

-- Criando indíces para respostas perguntas

-- Qual o departamento com maior número de pessoas? 
SELECT
	dNo AS Departamento, COUNT(*) AS Número_de_funcionários
FROM
	employees
GROUP BY
	dNo
ORDER BY
	Número_de_funcionários;
    
-- Percebe-se que o departamento com o maior número de funcionários é o 5
-- Criação de index para número de departamento para facilitar acesso a informações
CREATE INDEX dNumber_index ON departments(dNumber) USING HASH;

-- Quais são os departamentos por cidade?
SELECT
	dName AS Departamento, dLocation AS Cidade
FROM deptLocations
	 NATURAL JOIN departments;
     
-- Criação de index para acessar mais rapidamente o nome do departamento pesquisado
CREATE INDEX dName_index ON departments(dName) USING BTREE;

-- Relação de empregrados por departamento
SELECT
	CONCAT(fName , ' ', mInit, ' ', fName) AS Nome, dName AS Departamento
FROM
	employees
    INNER JOIN departments
    ON dNo = dNumber
;

-- Criação de index para acessar rapidamente funcionário
CREATE INDEX ssn_index ON employees(ssn) USING BTREE;

SHOW INDEX FROM employees;
SHOW INDEX FROM departments;