-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: cinemadb
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `movietbl`
--

DROP TABLE IF EXISTS `movietbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movietbl` (
  `MOVIE_ID` char(5) NOT NULL,
  `MOVIE_NAME` varchar(100) NOT NULL,
  `MOVIE_DIRECTOR` varchar(10) DEFAULT NULL,
  `MOVIE_LEAD` varchar(10) DEFAULT NULL,
  `MOVIE_DISTRIBUTOR` varchar(25) DEFAULT NULL,
  `MOVIE_RUNNINGTIME` int NOT NULL,
  `MOVIE_RATING` tinyint NOT NULL,
  PRIMARY KEY (`MOVIE_ID`),
  UNIQUE KEY `MOVIE_NAME` (`MOVIE_NAME`),
  CONSTRAINT `movietbl_chk_1` CHECK ((`MOVIE_RATING` in (0,12,15,18)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movietbl`
--

LOCK TABLES `movietbl` WRITE;
/*!40000 ALTER TABLE `movietbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `movietbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymenttbl`
--

DROP TABLE IF EXISTS `paymenttbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymenttbl` (
  `PAYMENT_ID` int NOT NULL AUTO_INCREMENT,
  `PAYMENT_DATE` date NOT NULL,
  `PAYMENT_METHOD` varchar(20) NOT NULL,
  `PAYMENT_PRICE` int NOT NULL,
  `PAYMENT_REFUND` tinyint(1) NOT NULL DEFAULT '0',
  `TICKET_ID` int NOT NULL,
  `USER_ID` char(10) NOT NULL,
  PRIMARY KEY (`PAYMENT_ID`),
  KEY `TICKET_ID` (`TICKET_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `paymenttbl_ibfk_1` FOREIGN KEY (`TICKET_ID`) REFERENCES `tickettbl` (`TICKET_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `paymenttbl_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `usertbl` (`USER_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `paymenttbl_chk_1` CHECK ((`PAYMENT_METHOD` in (_utf8mb4'카드',_utf8mb4'쿠폰',_utf8mb4'현금',_utf8mb4'모바일',_utf8mb4'포인트')))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymenttbl`
--

LOCK TABLES `paymenttbl` WRITE;
/*!40000 ALTER TABLE `paymenttbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `paymenttbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playingtbl`
--

DROP TABLE IF EXISTS `playingtbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playingtbl` (
  `THEATER_ID` char(5) NOT NULL,
  `MOVIE_ID` char(5) NOT NULL,
  KEY `THEATER_ID` (`THEATER_ID`),
  KEY `MOVIE_ID` (`MOVIE_ID`),
  CONSTRAINT `playingtbl_ibfk_1` FOREIGN KEY (`THEATER_ID`) REFERENCES `theatertbl` (`THEATER_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `playingtbl_ibfk_2` FOREIGN KEY (`MOVIE_ID`) REFERENCES `movietbl` (`MOVIE_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playingtbl`
--

LOCK TABLES `playingtbl` WRITE;
/*!40000 ALTER TABLE `playingtbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `playingtbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomtbl`
--

DROP TABLE IF EXISTS `roomtbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomtbl` (
  `ROOM_ID` char(5) NOT NULL,
  `ROOM_NAME` varchar(50) NOT NULL,
  `ROOM_SEATS` int NOT NULL,
  `THEATER_ID` char(5) NOT NULL,
  PRIMARY KEY (`ROOM_ID`),
  KEY `THEATER_ID` (`THEATER_ID`),
  CONSTRAINT `roomtbl_ibfk_1` FOREIGN KEY (`THEATER_ID`) REFERENCES `theatertbl` (`THEATER_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomtbl`
--

LOCK TABLES `roomtbl` WRITE;
/*!40000 ALTER TABLE `roomtbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `roomtbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduletbl`
--

DROP TABLE IF EXISTS `scheduletbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduletbl` (
  `SCHEDULE_ID` char(20) NOT NULL,
  `SCHEDULE_START` datetime NOT NULL,
  `SCHEDULE_END` datetime NOT NULL,
  `MOVIE_ID` char(5) NOT NULL,
  `ROOM_ID` char(5) NOT NULL,
  PRIMARY KEY (`SCHEDULE_ID`),
  KEY `MOVIE_ID` (`MOVIE_ID`),
  KEY `ROOM_ID` (`ROOM_ID`),
  CONSTRAINT `scheduletbl_ibfk_1` FOREIGN KEY (`MOVIE_ID`) REFERENCES `movietbl` (`MOVIE_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `scheduletbl_ibfk_2` FOREIGN KEY (`ROOM_ID`) REFERENCES `roomtbl` (`ROOM_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduletbl`
--

LOCK TABLES `scheduletbl` WRITE;
/*!40000 ALTER TABLE `scheduletbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduletbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seattbl`
--

DROP TABLE IF EXISTS `seattbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seattbl` (
  `SEAT_ID` int NOT NULL AUTO_INCREMENT,
  `SEAT_NUMBER` char(3) NOT NULL,
  `SEAT_BOOK` tinyint(1) NOT NULL DEFAULT '0',
  `SCHEDULE_ID` char(20) NOT NULL,
  PRIMARY KEY (`SEAT_ID`),
  KEY `SCHEDULE_ID` (`SCHEDULE_ID`),
  CONSTRAINT `seattbl_ibfk_1` FOREIGN KEY (`SCHEDULE_ID`) REFERENCES `scheduletbl` (`SCHEDULE_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3361 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seattbl`
--

LOCK TABLES `seattbl` WRITE;
/*!40000 ALTER TABLE `seattbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `seattbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theatertbl`
--

DROP TABLE IF EXISTS `theatertbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theatertbl` (
  `THEATER_ID` char(5) NOT NULL,
  `THEATER_NAME` varchar(20) NOT NULL,
  `THEATER_ADDR` varchar(50) DEFAULT NULL,
  `THEATER_CALL` char(13) DEFAULT NULL,
  `THEATER_ROOMS` tinyint NOT NULL,
  PRIMARY KEY (`THEATER_ID`),
  UNIQUE KEY `THEATER_NAME` (`THEATER_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theatertbl`
--

LOCK TABLES `theatertbl` WRITE;
/*!40000 ALTER TABLE `theatertbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `theatertbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickettbl`
--

DROP TABLE IF EXISTS `tickettbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickettbl` (
  `TICKET_ID` int NOT NULL AUTO_INCREMENT,
  `SEAT_ID` int NOT NULL,
  PRIMARY KEY (`TICKET_ID`),
  KEY `SEAT_ID` (`SEAT_ID`),
  CONSTRAINT `tickettbl_ibfk_1` FOREIGN KEY (`SEAT_ID`) REFERENCES `seattbl` (`SEAT_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickettbl`
--

LOCK TABLES `tickettbl` WRITE;
/*!40000 ALTER TABLE `tickettbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickettbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertbl`
--

DROP TABLE IF EXISTS `usertbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usertbl` (
  `USER_ID` char(10) NOT NULL,
  `USER_ADULT` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertbl`
--

LOCK TABLES `usertbl` WRITE;
/*!40000 ALTER TABLE `usertbl` DISABLE KEYS */;
/*!40000 ALTER TABLE `usertbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-03  0:32:57
