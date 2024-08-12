-- Criação do banco de dados para o cenário de e-commerce
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Criação da tabela clients
CREATE TABLE clients(
	clientId INT AUTO_INCREMENT PRIMARY KEY,
    fName VARCHAR(10),
    mInit CHAR(3),
    lName VARCHAR(20),
    cpf CHAR(11) NOT NULL,
	address VARCHAR(100),
    CONSTRAINT unique_cpf_client UNIQUE(cpf)
);

ALTER TABLE clients AUTO_INCREMENT = 1;

-- Criação da tabela products
CREATE TABLE products(
	productId INT AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(50) NOT NULL,
    classificationKids BOOL DEFAULT FALSE,
    category ENUM('Eletrônicos', 'Vestimentas', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    rating FLOAT DEFAULT 0,
    size VARCHAR(10) -- Dimensão do produto
);

-- Criação da tabela orders
CREATE TABLE orders(
	orderId INT AUTO_INCREMENT PRIMARY KEY,
    orderIdClient INT,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    orderDescription VARCHAR(255),
    shipping FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_clients FOREIGN KEY(orderIdClient) REFERENCES clients(clientId)
);

-- Criação da tabela productsStorage
CREATE TABLE productsStorage(
	prodStorageId INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255) NOT NULL,
    quantity INT DEFAULT 0
);

-- Criação da tabela suppliers
CREATE TABLE suppliers(
	supplierId INT AUTO_INCREMENT PRIMARY KEY,
    businessName VARCHAR(255) NOT NULL,
    cnpj CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE(cnpj)
);

-- Criação da tabela sellers
CREATE TABLE sellers(
	sellerId INT AUTO_INCREMENT PRIMARY KEY,
    tradeName VARCHAR(255) NOT NULL,
    businessName VARCHAR(255),
    cnpj CHAR(15),
    cpf CHAR(11),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE(cnpj),
    CONSTRAINT unique_cpf_seller UNIQUE(cpf)
);

-- Criação da tabela productsSellers
CREATE TABLE productsSellers(
	sellersSellerId INT,
    productsProductId INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY(sellersSellerId, productsProductId),
    CONSTRAINT fk_productsSellers_sellers FOREIGN KEY(sellersSellerId) REFERENCES sellers(sellerId),
    CONSTRAINT fk_productsSellers_products FOREIGN KEY(productsProductId) REFERENCES products(productId)
);

-- Criação da tabela productsOrders
CREATE TABLE productsOrders(
	productsProductId INT,
    ordersOrderId INT,
    pOrderQuantity INT DEFAULT 1,
    pOrderStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY(productsProductId, ordersOrderId),
    CONSTRAINT fk_productsOrders_products FOREIGN KEY(productsProductId) REFERENCES products(productId),
    CONSTRAINT fk_productsOrders_orders FOREIGN KEY(ordersOrderId) REFERENCES orders(orderId)
);

-- Criação da tabela storageLocations
CREATE TABLE storageLocations(
	productsProductId INT,
    pStoragePStorageId INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY(productsProductId, pStoragePStorageId),
    CONSTRAINT fk_storageLocations_products FOREIGN KEY(productsProductId) REFERENCES products(productId),
    CONSTRAINT fk_storageLocations_productsStorage FOREIGN KEY(pStoragePStorageId) REFERENCES productsStorage(prodStorageId)
);

-- Criação da tabela productsSuppliers
CREATE TABLE productsSuppliers(
	suppliersSupplierId INT,
	productsProductId INT,
    quantity INT NOT NULL,
    PRIMARY KEY(suppliersSupplierId, productsProductId),
    CONSTRAINT fk_productsSuppliers_suppliers FOREIGN KEY(suppliersSupplierId) REFERENCES suppliers(supplierId),
    CONSTRAINT fk_productsSuppliers_products FOREIGN KEY(productsProductId) REFERENCES products(productId)
);


