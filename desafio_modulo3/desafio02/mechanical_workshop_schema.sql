CREATE DATABASE IF NOT EXISTS mechanical_workshop;
USE mechanical_workshop;

CREATE TABLE clients(
	clientId INT PRIMARY KEY AUTO_INCREMENT,
    fName VARCHAR(10),
    mInit CHAR(3),
    lName VARCHAR(20),
    cpf CHAR(11) NOT NULL,
	address VARCHAR(100),
    CONSTRAINT unique_cpf_client UNIQUE(cpf)
);

CREATE TABLE vehicles(
	vehicleId INT PRIMARY KEY AUTO_INCREMENT,
    clientsClientId INT,
    type ENUM('Carro', 'Moto', 'Caminhão') NOT NULL,
    model VARCHAR(30),
    year INT,
    number INT NOT NULL,
    CONSTRAINT fk_vehicles_clients FOREIGN KEY(clientsClientId) REFERENCES clients(clientId)
);

CREATE TABLE mechanicsTeam(
	mechanicsTeamId INT PRIMARY KEY AUTO_INCREMENT,
    size INT,
    typeOfService ENUM('Serviços para caminhão', 'Serviços para moto', 'Serviços para carro') NOT NULL
);

CREATE TABLE mechanics(
	mechanicId INT PRIMARY KEY AUTO_INCREMENT,
    mechTeamMechTeamId INT,
    code VARCHAR(20),	
	fName VARCHAR(10),
    mInit CHAR(3),
    lName VARCHAR(20),
    speciality VARCHAR(100),
    CONSTRAINT fk_mechanics_mechanicsTeam FOREIGN KEY(mechTeamMechTeamId) REFERENCES mechanicsTeam(mechanicsTeamId)
);

CREATE TABLE referenceTable(
	referenceTableId INT PRIMARY KEY AUTO_INCREMENT,
    serviceName VARCHAR(40) NOT NULL,
    serviceCost FLOAT NOT NULL DEFAULT 0
);

CREATE TABLE serviceOrders(
	serviceOrderId INT PRIMARY KEY AUTO_INCREMENT,
    clientsClientId INT,
    mechTeamMechTeamId INT,
    refTableRefTableId INT,
    number VARCHAR(30) NOT NULL,
    emissionDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Em andamento', 'Adiado', 'Concluído'),
    conclusionDate DATE,
    CONSTRAINT fk_serviceOrders_clients FOREIGN KEY(clientsClientId) REFERENCES clients(clientId),
    CONSTRAINT fk_serviceOrders_mechanicsTeam FOREIGN KEY(mechTeamMechTeamId) REFERENCES mechanicsTeam(mechanicsTeamId),
    CONSTRAINT fk_serviceOrders_referenceTable FOREIGN KEY(refTableRefTableId) REFERENCES referenceTable(referenceTableId)
);
