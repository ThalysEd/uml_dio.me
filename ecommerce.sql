-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idcliente` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(10) DEFAULT NULL,
  `minit` char(3) DEFAULT NULL,
  `Lname` varchar(20) DEFAULT NULL,
  `cpf` char(11) NOT NULL,
  `address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE KEY `unique_cpf_client` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'João','A','Silva','12345678901','Rua A, 123'),(2,'Maria','B','Oliveira','23456789012','Rua B, 456'),(3,'Pedro','C','Souza','34567890123','Av. Central, 789');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `idorder` int NOT NULL AUTO_INCREMENT,
  `idorderclient` int DEFAULT NULL,
  `orderstatus` enum('Cancelado','Confirmado','Em processamento') NOT NULL DEFAULT 'Em processamento',
  `orderdescription` varchar(255) DEFAULT NULL,
  `sendvalue` float DEFAULT '10',
  `paymentcash` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`idorder`),
  KEY `fk_orders_client` (`idorderclient`),
  CONSTRAINT `fk_orders_client` FOREIGN KEY (`idorderclient`) REFERENCES `cliente` (`idcliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'Confirmado','Compra de eletrônicos',20,0),(2,2,'Em processamento','Roupas infantis',10,1),(3,3,'Cancelado','Itens diversos',15,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `idClient` int NOT NULL,
  `idpayment` int NOT NULL,
  `typePayment` enum('Boleto','Cartão','Dois cartões') NOT NULL,
  `limitAvailable` float DEFAULT NULL,
  PRIMARY KEY (`idClient`,`idpayment`),
  CONSTRAINT `fk_payment_client` FOREIGN KEY (`idClient`) REFERENCES `cliente` (`idcliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,'Cartão',1500),(2,1,'Boleto',0),(3,1,'Dois cartões',1000);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `idproduct` int NOT NULL AUTO_INCREMENT,
  `Pname` varchar(10) DEFAULT NULL,
  `classification_kids` tinyint(1) DEFAULT '0',
  `category` enum('Eletrônico','Vestimenta','Brinquedos','Alimentos') NOT NULL DEFAULT 'Eletrônico',
  `avaliacao` float DEFAULT '0',
  `size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idproduct`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'TV LG',0,'Eletrônico',4.5,'42\"'),(2,'Camiseta',0,'Vestimenta',4.2,'M'),(3,'Boneca',1,'Brinquedos',4.8,'Pequena'),(4,'Biscoito',1,'Alimentos',4.1,'200g');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productorder`
--

DROP TABLE IF EXISTS `productorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productorder` (
  `idpoproduct` int NOT NULL,
  `idpoorder` int NOT NULL,
  `poquantity` int DEFAULT '1',
  `postatus` enum('Disponivel','Sem estoque') DEFAULT 'Disponivel',
  PRIMARY KEY (`idpoproduct`,`idpoorder`),
  KEY `fk_productorder_order` (`idpoorder`),
  CONSTRAINT `fk_productorder_order` FOREIGN KEY (`idpoorder`) REFERENCES `orders` (`idorder`),
  CONSTRAINT `fk_productorder_product` FOREIGN KEY (`idpoproduct`) REFERENCES `product` (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productorder`
--

LOCK TABLES `productorder` WRITE;
/*!40000 ALTER TABLE `productorder` DISABLE KEYS */;
INSERT INTO `productorder` VALUES (1,1,1,'Disponivel'),(2,2,2,'Disponivel'),(3,3,1,'Sem estoque');
/*!40000 ALTER TABLE `productorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productseller`
--

DROP TABLE IF EXISTS `productseller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productseller` (
  `idpseller` int NOT NULL,
  `idpproduct` int NOT NULL,
  `prodquantity` int DEFAULT '1',
  PRIMARY KEY (`idpseller`,`idpproduct`),
  KEY `fk_product_product` (`idpproduct`),
  CONSTRAINT `fk_product_product` FOREIGN KEY (`idpproduct`) REFERENCES `product` (`idproduct`),
  CONSTRAINT `fk_product_seller` FOREIGN KEY (`idpseller`) REFERENCES `seller` (`idseller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productseller`
--

LOCK TABLES `productseller` WRITE;
/*!40000 ALTER TABLE `productseller` DISABLE KEYS */;
INSERT INTO `productseller` VALUES (1,1,10),(1,2,20),(2,3,15),(2,4,25);
/*!40000 ALTER TABLE `productseller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productstorage`
--

DROP TABLE IF EXISTS `productstorage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productstorage` (
  `idprodstorage` int NOT NULL AUTO_INCREMENT,
  `storagelocation` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`idprodstorage`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productstorage`
--

LOCK TABLES `productstorage` WRITE;
/*!40000 ALTER TABLE `productstorage` DISABLE KEYS */;
INSERT INTO `productstorage` VALUES (1,'Depósito 1',100),(2,'Depósito 2',50),(3,'Depósito 3',200);
/*!40000 ALTER TABLE `productstorage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `idseller` int NOT NULL AUTO_INCREMENT,
  `socialname` varchar(255) NOT NULL,
  `abstname` varchar(255) DEFAULT NULL,
  `cpf` char(11) DEFAULT NULL,
  `cnpj` char(14) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `contact` varchar(11) NOT NULL,
  PRIMARY KEY (`idseller`),
  UNIQUE KEY `unique_cnpj_seller` (`cnpj`),
  UNIQUE KEY `unique_cpf_seller` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (1,'Vendedor A Ltda','VendA','45678901234','34567890000197','São Paulo','11999990003'),(2,'Vendedor B ME','VendB','56789012345','45678901000198','Rio de Janeiro','11999990004');
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storagelocation`
--

DROP TABLE IF EXISTS `storagelocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storagelocation` (
  `idlproduct` int NOT NULL,
  `idlstorage` int NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`idlproduct`,`idlstorage`),
  KEY `fk_storage_location_storage` (`idlstorage`),
  CONSTRAINT `fk_storage_location_product` FOREIGN KEY (`idlproduct`) REFERENCES `product` (`idproduct`),
  CONSTRAINT `fk_storage_location_storage` FOREIGN KEY (`idlstorage`) REFERENCES `productstorage` (`idprodstorage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storagelocation`
--

LOCK TABLES `storagelocation` WRITE;
/*!40000 ALTER TABLE `storagelocation` DISABLE KEYS */;
INSERT INTO `storagelocation` VALUES (1,1,'Prateleira A'),(2,2,'Prateleira B'),(3,3,'Caixa C');
/*!40000 ALTER TABLE `storagelocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `idsupplier` int NOT NULL AUTO_INCREMENT,
  `socialname` varchar(255) NOT NULL,
  `cnpj` char(14) NOT NULL,
  `contact` varchar(11) NOT NULL,
  PRIMARY KEY (`idsupplier`),
  UNIQUE KEY `unique_supplier` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Fornecedor A','12345678000195','11999990001'),(2,'Fornecedor B','23456789000196','11999990002');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-10 12:13:01
