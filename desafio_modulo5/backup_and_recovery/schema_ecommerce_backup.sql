-- MySQL dump 10.13  Distrib 8.0.35, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `clientId` int NOT NULL AUTO_INCREMENT,
  `fName` varchar(10) DEFAULT NULL,
  `mInit` char(3) DEFAULT NULL,
  `lName` varchar(20) DEFAULT NULL,
  `cpf` char(11) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`clientId`),
  UNIQUE KEY `unique_cpf_client` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `save_deleted_clients` BEFORE DELETE ON `clients` FOR EACH ROW BEGIN
		INSERT INTO deleted_clients(fName, mInit, lName, cpf, address) VALUES(OLD.fName, OLD.mInit, OLD.lName, OLD.cpf, OLD.address);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `deleted_clients`
--

DROP TABLE IF EXISTS `deleted_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deleted_clients` (
  `clientId` int NOT NULL AUTO_INCREMENT,
  `fName` varchar(10) DEFAULT NULL,
  `mInit` char(3) DEFAULT NULL,
  `lName` varchar(20) DEFAULT NULL,
  `cpf` char(11) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`clientId`),
  UNIQUE KEY `unique_cpf_client` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `orderIdClient` int DEFAULT NULL,
  `orderStatus` enum('Cancelado','Confirmado','Em processamento') DEFAULT 'Em processamento',
  `orderDescription` varchar(255) DEFAULT NULL,
  `shipping` float DEFAULT '10',
  `paymentCash` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`orderId`),
  KEY `fk_orders_clients` (`orderIdClient`),
  CONSTRAINT `fk_orders_clients` FOREIGN KEY (`orderIdClient`) REFERENCES `clients` (`clientId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `pName` varchar(50) NOT NULL,
  `classificationKids` tinyint(1) DEFAULT '0',
  `category` enum('Eletrônicos','Vestimentas','Brinquedos','Alimentos','Móveis') NOT NULL,
  `rating` float DEFAULT '0',
  `size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productsorders`
--

DROP TABLE IF EXISTS `productsorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsorders` (
  `productsProductId` int NOT NULL,
  `ordersOrderId` int NOT NULL,
  `pOrderQuantity` int DEFAULT '1',
  `pOrderStatus` enum('Disponível','Sem estoque') DEFAULT 'Disponível',
  PRIMARY KEY (`productsProductId`,`ordersOrderId`),
  KEY `fk_productsOrders_orders` (`ordersOrderId`),
  CONSTRAINT `fk_productsOrders_orders` FOREIGN KEY (`ordersOrderId`) REFERENCES `orders` (`orderId`),
  CONSTRAINT `fk_productsOrders_products` FOREIGN KEY (`productsProductId`) REFERENCES `products` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productssellers`
--

DROP TABLE IF EXISTS `productssellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productssellers` (
  `sellersSellerId` int NOT NULL,
  `productsProductId` int NOT NULL,
  `prodQuantity` int DEFAULT '1',
  PRIMARY KEY (`sellersSellerId`,`productsProductId`),
  KEY `fk_productsSellers_products` (`productsProductId`),
  CONSTRAINT `fk_productsSellers_products` FOREIGN KEY (`productsProductId`) REFERENCES `products` (`productId`),
  CONSTRAINT `fk_productsSellers_sellers` FOREIGN KEY (`sellersSellerId`) REFERENCES `sellers` (`sellerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productsstorage`
--

DROP TABLE IF EXISTS `productsstorage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsstorage` (
  `prodStorageId` int NOT NULL AUTO_INCREMENT,
  `storageLocation` varchar(255) NOT NULL,
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`prodStorageId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productssuppliers`
--

DROP TABLE IF EXISTS `productssuppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productssuppliers` (
  `suppliersSupplierId` int NOT NULL,
  `productsProductId` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`suppliersSupplierId`,`productsProductId`),
  KEY `fk_productsSuppliers_products` (`productsProductId`),
  CONSTRAINT `fk_productsSuppliers_products` FOREIGN KEY (`productsProductId`) REFERENCES `products` (`productId`),
  CONSTRAINT `fk_productsSuppliers_suppliers` FOREIGN KEY (`suppliersSupplierId`) REFERENCES `suppliers` (`supplierId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sellers` (
  `sellerId` int NOT NULL AUTO_INCREMENT,
  `tradeName` varchar(255) NOT NULL,
  `businessName` varchar(255) DEFAULT NULL,
  `cnpj` char(15) DEFAULT NULL,
  `cpf` char(11) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `contact` char(11) NOT NULL,
  PRIMARY KEY (`sellerId`),
  UNIQUE KEY `unique_cnpj_seller` (`cnpj`),
  UNIQUE KEY `unique_cpf_seller` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storagelocations`
--

DROP TABLE IF EXISTS `storagelocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storagelocations` (
  `productsProductId` int NOT NULL,
  `pStoragePStorageId` int NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`productsProductId`,`pStoragePStorageId`),
  KEY `fk_storageLocations_productsStorage` (`pStoragePStorageId`),
  CONSTRAINT `fk_storageLocations_products` FOREIGN KEY (`productsProductId`) REFERENCES `products` (`productId`),
  CONSTRAINT `fk_storageLocations_productsStorage` FOREIGN KEY (`pStoragePStorageId`) REFERENCES `productsstorage` (`prodStorageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplierId` int NOT NULL AUTO_INCREMENT,
  `businessName` varchar(255) NOT NULL,
  `cnpj` char(15) NOT NULL,
  `contact` char(11) NOT NULL,
  PRIMARY KEY (`supplierId`),
  UNIQUE KEY `unique_supplier` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'ecommerce'
--

--
-- Dumping routines for database 'ecommerce'
--
/*!50003 DROP PROCEDURE IF EXISTS `clients_data_insertion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clients_data_insertion`(
	IN fName_p VARCHAR(10),
    IN mInit_p CHAR(1),
    IN lName_p VARCHAR(20),
    IN cpf_p CHAR(11),
	IN address_p VARCHAR(100)
)
BEGIN
        
		DECLARE sqlError TINYINT DEFAULT FALSE;
        
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sqlError = TRUE;
        
		START TRANSACTION;
        
        INSERT INTO
			clients(fName, mInit, lName, cpf, address)
		VALUES
			(fName_p, mInit_p, lName_p, cpf_p, address_p);
            
		SAVEPOINT clientsInsertion;
            
		IF sqlError = FALSE THEN
			COMMIT;
            SELECT * FROM clients;
		ELSE
			ROLLBACK TO SAVEPOINT clientsInsertion;
			SELECT 'Erro na transação' AS Resultado;
		END IF;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clients_data_manipulation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clients_data_manipulation`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `orders_status_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `orders_status_update`(
	IN orderStatus_p ENUM('Cancelado', 'Confirmado', 'Em processamento'),
    IN orderId_p INT
)
BEGIN
        
		DECLARE sqlError TINYINT DEFAULT FALSE;
        
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET sqlError = TRUE;
        
		START TRANSACTION;
			
		UPDATE orders
			SET orderStatus = orderStatus_p
            WHERE orderId = orderId_p;
            
		SAVEPOINT orderUpdate;
            
		IF sqlError = FALSE THEN
			COMMIT;
            SELECT * FROM orders;
		ELSE
			ROLLBACK TO SAVEPOINT orderUpdate;
			SELECT 'Erro na transação' AS Resultado;
		END IF;
		
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-24 16:43:08
