USE mechanical_workshop;

-- Retorna todos os dados dos clientes
SELECT * FROM clients;

-- Retorna todos os clientes que moram em ruas e não em avenidas
SELECT
	*
FROM 
	clients
WHERE
	address LIKE '%rua%';
    
-- Retorna quais clientes possuem carros
SELECT
	CONCAT(fName, ' ', lName) AS Nome, cpf AS CPF, type AS Veículo
FROM
	clients INNER JOIN vehicles ON clientId = clientsClientId
WHERE
	type = 'Carro';

-- Retorna a quantidade de pedidos dos clientes
SELECT
	CONCAT(fName, ' ', lName) AS Nome, cpf AS CPF, COUNT(*) AS Pedidos
FROM
	clients INNER JOIN serviceOrders ON clientId = clientsClientId
GROUP BY
	Nome, CPF;
    
-- Retorna o valor total gasto por cada cliente
SELECT
	CONCAT(fName, ' ', lName) AS Nome, cpf AS CPF, SUM(serviceCost) AS Valor_gasto
FROM
	clients INNER JOIN serviceOrders ON clientId = clientsClientId INNER JOIN referenceTable ON referenceTableId = refTableRefTableId
GROUP BY
	Nome, CPF
ORDER BY
	Valor_gasto;
    
-- Retorna as equipes de mecânicos e seus integrantes
SELECT 
	 typeOfService AS Equipe, CONCAT(fName, ' ', lName) AS Nome, speciality AS Especialidade
FROM
	mechanics INNER JOIN mechanicsTeam ON mechTeamMechTeamId = mechanicsTeamId;
    
-- Retorna quantos pedidos cada equipe de mecânicos realizou
SELECT 
	 typeOfService AS Equipe, COUNT(*) AS Número_de_pedidos
FROM
	mechanicsTeam INNER JOIN serviceOrders ON mechTeamMechTeamId = mechanicsTeamId
GROUP BY
	typeOfService
ORDER BY
	Número_de_pedidos;
    
-- Retorna os dados dos clientes que gastaram 120 reais ou mais na oficina
SELECT
	CONCAT(fName, ' ', lName) AS Nome, cpf AS CPF, SUM(serviceCost) AS Valor_gasto
FROM
	clients INNER JOIN serviceOrders ON clientId = clientsClientId INNER JOIN referenceTable ON referenceTableId = refTableRefTableId
GROUP BY
	Nome, CPF
HAVING
	Valor_gasto >= 120.00
ORDER BY
	Valor_gasto;
    
-- Retorna a data de emissão dos pedidos, dados sobre o pedido e a data de conclusão
SELECT
	serviceName AS Serviço, serviceCost AS Custo, emissionDate AS Data_de_emissão, status AS Status, conclusionDate AS Data_de_conclusão
FROM 
	serviceOrders INNER JOIN referenceTable ON refTableRefTableId = referenceTableId
ORDER BY
	Status;
