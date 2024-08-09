-- INSERÇÃO DE DADOS E QUERIES
USE ecommerce;

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
	products(pName, classificationKids, category, rating, size)
VALUES
	('Fone de ouvido',FALSE,'Eletrônicos','4',NULL),
	('Barbie Elsa',TRUE,'Brinquedos','3',NULL),
	('Body Carters',TRUE,'Vestimentas','5',NULL),
	('Microfone Vedo - Youtuber',FALSE,'Eletrônicos','4',NULL),
	('Sofá retrátil',FALSE,'Móveis','3','3x57x80'),
	('Farinha de arroz',FALSE,'Alimentos','2',NULL),
	('Fire Stick Amazon',FALSE,'Eletrônicos','3',NULL);

SELECT * FROM clients;
SELECT * FROM products;

DELETE FROM orders WHERE orderIdClient IN (1,2,3,4);

INSERT INTO 
	orders(orderIdClient, orderStatus, orderDescription, shipping, paymentCash)
VALUES 
	(1, DEFAULT,'compra via aplicativo',NULL,1),
	(2,DEFAULT,'compra via aplicativo',50,0),
	(3,'Confirmado',NULL,NULL,1),
	(4,DEFAULT,'compra via web site',150,0);

SELECT * FROM orders;

INSERT INTO 
	productsOrders(productsProductId, ordersOrderId, pOrderQuantity, pOrderStatus)
VALUES
	(1,1,2,NULL),
	(2,2,1,NULL),
	(3,4,1,NULL);

INSERT INTO 
	productsStorage(storageLocation, quantity) 
VALUES 
	('Rio de Janeiro',1000),
	('Rio de Janeiro',500),
	('São Paulo',10),
	('São Paulo',100),
	('São Paulo',10),
	('Brasília',60);

INSERT INTO 
	storageLocations(productsProductId, pStoragePStorageId, location)
VALUES
	(1,2,'RJ'),
	(2,6,'GO');

INSERT INTO 
	suppliers(businessName, cnpj, contact) 
VALUES 
	('Almeida e filhos', 123456789123456,'21985474'),
	('Eletrônicos Silva',854519649143457,'21985484'),
	('Eletrônicos Valma', 934567893934695,'21975474');
                            
SELECT * FROM suppliers;

INSERT INTO
	productsSuppliers(suppliersSupplierId, productsProductId, quantity)
VALUES
	(1,1,500),
	(1,2,400),
	(2,4,633),
	(3,3,5),
	(2,5,10);


INSERT INTO
	sellers(tradeName, businessName, cnpj, cpf, location, contact)
VALUES 
	('Tech eletronics', NULL, 123456789456321, NULL, 'Rio de Janeiro', 219946287),
	('Botique Durgas',NULL,NULL,123456783,'Rio de Janeiro', 219567895),
	('Kids World',NULL,456789123654485,NULL,'São Paulo', 1198657484);

SELECT * FROM sellers;

INSERT INTO
	productsSellers(sellersSellerId, productsProductId, prodQuantity)
VALUES 
	(1,6,80),
	(2,7,10);

SELECT * FROM productsSellers;

SELECT COUNT(*) FROM clients;

SELECT
	* 
FROM 
	clients c, orders o 
WHERE
	c.clientId = o.orderIdClient;

SELECT 
	fName, lName, orderId, orderStatus 
FROM 
	clients c, orders o 
WHERE 
	c.clientId = o.orderIdClient;
    
SELECT 	
	CONCAT(fName, ' ',lName) AS Client, orderId AS Request, orderStatus AS Status 
FROM 
	clients c, orders o 
WHERE
	c.clientId = o.orderIdClient;

INSERT INTO 
	orders(orderIdClient, orderStatus, orderDescription, shipping, paymentCash) 
VALUES 
	(2, DEFAULT, 'compra via aplicativo', NULL, 1);
                             
SELECT 
	COUNT(*) 
FROM 
	clients c, orders o 
WHERE
	c.clientId = o.orderIdClient;

SELECT * FROM orders;

-- Recuperação de pedido com produto associado
SELECT 
	* 
FROM
	clients c 
	INNER JOIN orders o ON c.clientId = o.orderIdClient
	INNER JOIN productsOrders p ON p.ordersOrderId = o.orderId; 
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
SELECT 
	c.clientId, fName, COUNT(*) AS Number_of_orders 
FROM 
	clients c 
	INNER JOIN orders o ON c.clientId = o.orderIdClient
GROUP BY c.clientId;

