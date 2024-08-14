USE company;

-- Criação de views para o database company

-- Número de empregados por departamento e localidade 
CREATE OR REPLACE VIEW employee_per_dept_location_view AS
	SELECT
		dName AS Departamento, dLocation AS Localização, COUNT(*) AS Número_de_empregados
	FROM
		employees 
		INNER JOIN departments
		ON dNo = dNumber
		NATURAL JOIN deptLocations
	GROUP BY
		dLocation, dName;
        
SELECT * FROM employee_per_dept_location_view;
        
-- Criando usuários e atribuindo permissões
CREATE USER	'diretor_de_planejamento'@localhost IDENTIFIED BY '123456789';
GRANT ALL PRIVILEGES ON company.employee_per_dept_location_view TO 'diretor_de_planejamento'@localhost;

-- Lista de departamentos e seus gerentes
CREATE OR REPLACE VIEW departments_managers_view AS
	SELECT
		dName AS Departamento, dNumber AS Número_do_departamento, CONCAT(fName, ' ', mInit, ' ', lName) AS Gerente
	FROM
		departments
		INNER JOIN employees
		ON mgrSsn = ssn
	ORDER BY
		dNumber;

SELECT * FROM departments_managers_view;

-- Criando usuários e atribuindo permissões
CREATE USER	'diretor_de_rh'@localhost IDENTIFIED BY '987654321';
GRANT ALL PRIVILEGES ON company.departments_managers_view TO 'diretor_de_rh'@localhost;

-- Projetos com maior número de empregados (ex: por ordenação desc) 
CREATE OR REPLACE VIEW projects_with_most_employees_view AS
	SELECT
		pName AS Projeto, COUNT(*) AS Número_de_empregados
	FROM
		projects
		INNER JOIN worksOn
		ON pNumber = pNo
		INNER JOIN employees
		ON eSsn = ssn
	GROUP BY
		pName
	ORDER BY
		Número_de_empregados DESC;
        
SELECT * FROM projects_with_most_employees_view;

-- Criando usuários e atribuindo permissões
CREATE USER	'diretor_de_projetos'@localhost IDENTIFIED BY '214365879';
GRANT ALL PRIVILEGES ON company.departments_managers_view TO 'diretor_de_projetos'@localhost;

-- Lista de projetos, departamentos e gerentes
CREATE OR REPLACE VIEW projects_depts_managers_view AS	
    SELECT
		pName AS Projeto, dName AS Departamento, dNumber AS Número_do_departamento, CONCAT(fName, ' ', mInit, ' ', lName) AS Gerente
	FROM
		departments
		INNER JOIN employees
		ON mgrSsn = ssn
        INNER JOIN projects
        ON dNumber = dNum
	ORDER BY
		pName, dNumber;
        
SELECT * FROM projects_depts_managers_view;
    
-- Criando usuários e atribuindo permissões 
CREATE USER	'CEO'@localhost IDENTIFIED BY '987612345';
GRANT ALL PRIVILEGES ON company.projects_depts_managers_view TO 'CEO'@localhost;

-- Quais empregados possuem dependentes e se são gerentes 
CREATE OR REPLACE VIEW employees_dependents_view AS
	SELECT 
		DISTINCT CONCAT(fName, ' ', mInit, ' ', lName) AS Nome, superSsn AS Gerente 
	FROM
		employees
		INNER JOIN dependents
        ON ssn = eSsn;
        
SELECT * FROM employees_dependents_view;

-- Criando usuários e atribuindo permissões
CREATE USER	'diretora_de_pessoas_e_cultura'@localhost IDENTIFIED BY '123459876';
GRANT ALL PRIVILEGES ON company.employees_dependents_view TO 'diretora_de_pessoas_e_cultura'@localhost;

SELECT * FROM mysql.user;
