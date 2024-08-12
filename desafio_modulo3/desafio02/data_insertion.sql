-- INSERÇÃO DE DADOS
USE mechanical_workshop;

SHOW TABLES;

INSERT INTO 
	clients(fName, mInit, lName, cpf, address) 
VALUES
	('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
	('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
	('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
	('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
	('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
	('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');
    
INSERT INTO 
	vehicles(clientsClientId, type, model, year, number) 
VALUES
	(1, 'Carro', 'Civic', 2018, 23124123),
    (1, 'Moto', 'XJ', 2021, 52357425),
	(2, 'Carro', 'Gol', 2020, 52315732),
	(3, 'Carro', 'Uno', 2015, 14234324),
    (3, 'Moto', 'CG', 2023, 68392760),
	(4, 'Carro', 'Picasso', 2016, 57291785),
    (4, 'Moto', 'Pop', 2020, 18472053),
    (4, 'Caminhão', 'VM', 2024, 82993413),
	(5, 'Caminhão', 'FH', 2011, 56820918),
	(6, 'Moto', 'Biz', 2019, 70194891);
    
INSERT INTO
	mechanicsTeam(size, typeOfService)
VALUES
	(3, 'Serviços para caminhão'),
    (2, 'Serviços para carro'),
    (2, 'Serviços para moto');
    
INSERT INTO
	mechanics(mechTeamMechTeamId, code, fName, mInit, lName, speciality)
VALUES
	(1, '0001', 'João', 'J', 'Souza', 'Diagnóstico e reparo de sistemas de freios a ar'),
    (1, '0002', 'Ana', 'A', 'Pereira', 'Manutenção e ajuste de motores a diesel'),
    (1, '0003', 'Carlos', 'L', 'Lima', 'Alinhamento e balanceamento de rodas de grande porte'),
    (2, '0004', 'Fernanda', 'G', 'Oliveira', 'Diagnóstico e reparo de sistemas eletrônicos de injeção'),
    (2, '0005', 'Paulo', 'L', 'Costa', 'Substituição e ajuste de sistemas de embreagem'),
    (3, '0006', 'Beatriz', 'K', 'Mendes', 'Ajuste e reparo de sistemas de suspensão'),
    (3, '0007', 'Isabel','E','Santos', 'Manutenção e ajuste de motores de dois e quatro tempos');
    
INSERT INTO
	referenceTable(serviceName, serviceCost)
VALUES
	('Troca de óleo para carro', 120.00),
    ('Ajuste de freios de moto', 80.00),
    ('Alinhamento e balanceamento de caminhão', 250.00);
    
INSERT INTO 
	serviceOrders(clientsClientId, mechTeamMechTeamId, refTableRefTableId, number, emissionDate, status, conclusionDate)
VALUES
	(1, 3, 2, '01', DEFAULT, 'Em andamento', '2024-08-30'),
    (2, 2, 1, '02', DEFAULT, 'Concluído', '2024-08-11'),
    (3, 3, 2, '03', DEFAULT, 'Adiado', '2024-10-10'),
    (4, 1, 3, '04', DEFAULT, 'Concluído', '2024-08-07'),
    (5, 1, 3, '05', DEFAULT, 'Concluído', '2024-08-05'),
    (6, 3, 2, '06', DEFAULT, 'Em andamento', '2024-08-21'),
    (4, 2, 1, '07', DEFAULT, 'Em andamento', '2024-08-23');