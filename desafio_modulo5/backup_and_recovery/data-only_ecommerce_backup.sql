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
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (5,'Roberta','G','Assis','98745631','avenidade koller 19, Centro - Cidade das flores'),(6,'Isabela','M','Cruz','654789123','rua alemeda das flores 28, Centro - Cidade das flores'),(8,'Maria','M','Silva','12346789','rua silva de prata 29, Carangola - Cidade das flores'),(9,'Matheus','O','Pimentel','987654321','rua alemeda 289, Centro - Cidade das flores'),(10,'Ricardo','F','Silva','45678913','avenida alemeda vinha 1009, Centro - Cidade das flores'),(11,'Julia','S','França','789123456','rua lareijras 861, Centro - Cidade das flores'),(12,'Jennyfer','S','Olimpo','787123456','rua lareijras 643, Centro - Cidade das flores');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `deleted_clients`
--

LOCK TABLES `deleted_clients` WRITE;
/*!40000 ALTER TABLE `deleted_clients` DISABLE KEYS */;
INSERT INTO `deleted_clients` VALUES (1,'Julia','S','França','789123456','rua lareijras 861, Centro - Cidade das flores');
/*!40000 ALTER TABLE `deleted_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,NULL,'Confirmado','compra via aplicativo',NULL,1),(2,NULL,'Em processamento','compra via aplicativo',50,0),(3,NULL,'Confirmado',NULL,NULL,1),(4,NULL,'Em processamento','compra via web site',150,0),(5,NULL,'Cancelado','compra via aplicativo',NULL,1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Fone de ouvido',0,'Eletrônicos',4,NULL),(2,'Barbie Elsa',1,'Brinquedos',3,NULL),(3,'Body Carters',1,'Vestimentas',5,NULL),(4,'Microfone Vedo - Youtuber',0,'Eletrônicos',4,NULL),(5,'Sofá retrátil',0,'Móveis',3,'3x57x80'),(6,'Farinha de arroz',0,'Alimentos',2,NULL),(7,'Fire Stick Amazon',0,'Eletrônicos',3,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `productsorders`
--

LOCK TABLES `productsorders` WRITE;
/*!40000 ALTER TABLE `productsorders` DISABLE KEYS */;
INSERT INTO `productsorders` VALUES (1,1,2,NULL),(2,2,1,NULL),(3,4,1,NULL);
/*!40000 ALTER TABLE `productsorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `productssellers`
--

LOCK TABLES `productssellers` WRITE;
/*!40000 ALTER TABLE `productssellers` DISABLE KEYS */;
INSERT INTO `productssellers` VALUES (1,6,80),(2,7,10);
/*!40000 ALTER TABLE `productssellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `productsstorage`
--

LOCK TABLES `productsstorage` WRITE;
/*!40000 ALTER TABLE `productsstorage` DISABLE KEYS */;
INSERT INTO `productsstorage` VALUES (1,'Rio de Janeiro',1000),(2,'Rio de Janeiro',500),(3,'São Paulo',10),(4,'São Paulo',100),(5,'São Paulo',10),(6,'Brasília',60);
/*!40000 ALTER TABLE `productsstorage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `productssuppliers`
--

LOCK TABLES `productssuppliers` WRITE;
/*!40000 ALTER TABLE `productssuppliers` DISABLE KEYS */;
INSERT INTO `productssuppliers` VALUES (1,1,500),(1,2,400),(2,4,633),(2,5,10),(3,3,5);
/*!40000 ALTER TABLE `productssuppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `sellers`
--

LOCK TABLES `sellers` WRITE;
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
INSERT INTO `sellers` VALUES (1,'Tech eletronics',NULL,'123456789456321',NULL,'Rio de Janeiro','219946287'),(2,'Botique Durgas',NULL,NULL,'123456783','Rio de Janeiro','219567895'),(3,'Kids World',NULL,'456789123654485',NULL,'São Paulo','1198657484');
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `storagelocations`
--

LOCK TABLES `storagelocations` WRITE;
/*!40000 ALTER TABLE `storagelocations` DISABLE KEYS */;
INSERT INTO `storagelocations` VALUES (1,2,'RJ'),(2,6,'GO');
/*!40000 ALTER TABLE `storagelocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Almeida e filhos','123456789123456','21985474'),(2,'Eletrônicos Silva','854519649143457','21985484'),(3,'Eletrônicos Valma','934567893934695','21975474');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-24 16:44:16
