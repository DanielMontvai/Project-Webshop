CREATE DATABASE  IF NOT EXISTS `webshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `webshop`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: webshop
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'WOODWIND'),(2,'BRASS INSTRUMENTS'),(3,'PERCUSSION INSTRUMENTS'),(4,'KEYBOARD INSTRUMENTS'),(5,'GUITAR FAMILY'),(6,'BOWED STRINGS'),(7,'MISC'),(14,'TRADITIONAL');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `confirmation_token`
--

DROP TABLE IF EXISTS `confirmation_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `confirmation_token` (
  `id` bigint NOT NULL,
  `confirmed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `token` varchar(255) NOT NULL,
  `custom_user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfyg2wi5juqtgd4g7oalf0frnk` (`custom_user_id`),
  CONSTRAINT `FKfyg2wi5juqtgd4g7oalf0frnk` FOREIGN KEY (`custom_user_id`) REFERENCES `custom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confirmation_token`
--

LOCK TABLES `confirmation_token` WRITE;
/*!40000 ALTER TABLE `confirmation_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `confirmation_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `confirmation_token_sequence`
--

DROP TABLE IF EXISTS `confirmation_token_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `confirmation_token_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confirmation_token_sequence`
--

LOCK TABLES `confirmation_token_sequence` WRITE;
/*!40000 ALTER TABLE `confirmation_token_sequence` DISABLE KEYS */;
INSERT INTO `confirmation_token_sequence` VALUES (1),(2);
/*!40000 ALTER TABLE `confirmation_token_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_user`
--

DROP TABLE IF EXISTS `custom_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `enabled` bit(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `billing_address_id` bigint DEFAULT NULL,
  `shipping_address_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKomr5homgcfjr88ssy94bklmhp` (`billing_address_id`),
  KEY `FKmdge88nshd5k4d9egpb747r5x` (`shipping_address_id`),
  CONSTRAINT `FKmdge88nshd5k4d9egpb747r5x` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FKomr5homgcfjr88ssy94bklmhp` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_user`
--

LOCK TABLES `custom_user` WRITE;
/*!40000 ALTER TABLE `custom_user` DISABLE KEYS */;
INSERT INTO `custom_user` VALUES (1,'backend.admin@progmasters.hu',_binary '','$2a$12$/g8p/i8At7kLY.VBFvgdNeAOW8pqR.mQC6toCZvPcJhGqQbYigK12','admin',NULL,NULL),(2,'backend.user@progmasters.hu',_binary '','$2a$12$eyzSJMXSnSW5qq/CvJIEge9jS2b3w4ldlQul6xacpK/.dv4xTmGj2','user',NULL,NULL),(3,'ortaqbhnfjhptlwfuv@kvhrs.com',_binary '','$2a$10$G1QZ/f9ClmBaD1ZqSuXk0ul4x4vqoUBvT.UPc5t1ywoJiniXlklFm','exampleUser',NULL,NULL);
/*!40000 ALTER TABLE `custom_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `media_type` varchar(255) DEFAULT NULL,
  `original_file_name` varchar(255) DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgpextbyee3uk9u6o2381m7ft1` (`product_id`),
  CONSTRAINT `FKgpextbyee3uk9u6o2381m7ft1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--KSEvDOir--/v1662024032/17588294_Viola_and_bow_dkiafp_lhac6l.webp',133112,'image/webp','17588294_Viola_and_bow_dkiafp.webp',1),(3,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--jbRQoFRM--/v1662024923/800px-AGK_bass1_full_plefk8.jpg',81150,'image/jpeg','800px-AGK_bass1_full.jpg',3),(5,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--Z6xN9AB4--/v1662025513/klarin_t_rkibko.jpg',89122,'image/jpeg','klarinét.jpg',5),(6,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--eoIxxRY0--/v1662025726/9842376_800_jaohh3.jpg',13048,'image/jpeg','9842376_800.jpg',6),(7,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--O7fmdsxP--/v1662025920/trumpet-sullivan-tt100-golden-b-flat-with-case_ulywdu.jpg',44764,'image/jpeg','trumpet-sullivan-tt100-golden-b-flat-with-case.jpg',7),(8,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--KaXagsni--/v1662051433/guitar1_ksqxrb.jpg',79780,'image/jpeg','guitar1.jpg',8),(9,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--IpAbA0qN--/v1662051497/guitar2_pxkahj.jpg',49071,'image/jpeg','guitar2.jpg',9),(10,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--xQrngaEi--/v1662051613/guitar3_xmbrtz.jpg',38818,'image/jpeg','guitar3.jpg',10),(11,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s---BASYsM2--/v1662051648/guitar4_adyubo.jpg',83702,'image/jpeg','guitar4.jpg',11),(12,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--vn1ghcbJ--/v1662051853/bass1_be5vzt.jpg',137358,'image/jpeg','bass1.jpg',12),(13,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--dceqnZOo--/v1662051895/bass2_het2lv.jpg',12478,'image/jpeg','bass2.jpg',13),(14,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--om86mTm5--/v1662051931/bass3_dwebtn.jpg',99884,'image/jpeg','bass3.jpg',14),(15,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--3F04cfH4--/v1662051961/bass4_w9puho.jpg',37283,'image/jpeg','bass4.jpg',15),(16,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--BG6a_EKg--/v1662056765/traditional_1_w7z0jp.jpg',57226,'image/jpeg','traditional 1.jpg',16),(17,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--mIr1a5Mh--/v1662056952/traditonal2_mtwibn.jpg',6638,'image/jpeg','traditonal2.jpg',17),(18,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--7DHmnfiY--/v1662057060/traditional3_ppre0r.jpg',8432,'image/jpeg','traditional3.jpg',18),(19,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--pavFLLXM--/v1662057124/traditional4_bgmdrs.jpg',17448,'image/jpeg','traditional4.jpg',19),(20,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--_0fUak1y--/v1662063366/drums1_segnnd.jpg',35285,'image/jpeg','drums1.jpg',20),(21,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--fSe6cvEl--/v1662063474/drums2_zx1boz.jpg',57229,'image/jpeg','drums2.jpg',21),(22,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--ZbA7LwDe--/v1662063580/drums3_uuq9yq.jpg',30851,'image/jpeg','drums3.jpg',22),(23,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--_S4ljPQf--/v1662063815/drums5_bd9d5q.jpg',29439,'image/jpeg','drums5.jpg',23),(24,'https://res.cloudinary.com/dyacsfxsx/image/authenticated/s--9hgDC8oD--/v1662064079/keys_1_p2yy63.jpg',54974,'image/jpeg','keys 1.jpg',24);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `custom_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3ngrpdyay5s7sde5cq4hrk61w` (`custom_user_id`),
  CONSTRAINT `FK3ngrpdyay5s7sde5cq4hrk61w` FOREIGN KEY (`custom_user_id`) REFERENCES `custom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `deleted_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,NULL,'The viola is similar in material and construction to the violin. A full-size viola\'s body is between 25 mm (1 in) and 100 mm (4 in) longer than the body of a full-size violin (i.e., between 38 and 46 cm [15–18 in]), with an average length of 41 cm','Viola made of birch',90000),(3,NULL,'he bass is a transposing instrument and is typically notated one octave higher than tuned to avoid excessive ledger lines below the staff. The double bass is the only modern bowed string instrument that is tuned in fourths','Fine Double Bass',165000),(5,NULL,'Today, the oboe is commonly used as orchestral or solo instrument in symphony orchestras, concert bands and chamber ensembles. The oboe is especially used in classical music, film music, some genres of folk music, and is occasionally heard in jazz.','Renewed oboe',65000),(6,NULL,'as the name would suggest, the bass member of the woodwind family, and by far the largest, especially its lower-pitched relation, the extremely bulky double or contra-bassoon. Like the oboe, it is a double-reed instrument.','Black Basson',115000),(7,NULL,'one of the most ancient of all instruments. Played horizontally via a series of valves on the top of the instrument which are opened and closed in various combinations to create different pitches.','Trumpet',185000),(8,NULL,'Classical guitar pack with tuner and nylon cover, 100 Series. Guitar with a Linden body and top and Maple neck all finished in gloss finish. Ebonized fingerboard and bridge. Black body and neck binding. Size: 3/4. Finish: Natural','Valencia VC103 3/4 Natural',250),(9,NULL,'Electric guitar from ESP LTD. The LTD Black Metal Series are guitars that are comparable in build quality to our LTD Deluxe “1000 Series” instruments, but with a dark and menacing design theme of all-black finish, components, and hardware.','ESP LTD Arrow Black Metal',300),(10,NULL,'Stage-worthy electro-acoustic guitar with dreadnought body shape and soft Venetian cutaway that delivers plenty of volume and rich, full sound, ideal for all-around players and any playing style.','Takamine GD30CE Black',300),(11,NULL,'G5420LH Electromatic® Classic Hollow Body Single-Cut features a laminated maple body with vintage-inspired perimeters and refined arches, as well as all-new trestle block bracing to help reduce unwanted feedback.','Gretsch G5420LH Electromatic SC LRL Orange Stain',500),(12,NULL,'Powered by a Player Plus PJ pickup set, the Player Plus Precision Bass® delivers the punch and growl that defines Fender bass tone. A 3-band active EQ provides precise tone shaping with switchable active/passive operation for ultimate flexibility.','Fender Player Plus Precision Bass PF 3-Color Sunburst',600),(13,NULL,'The Ultra-Light is the smallest, lightest, full-scale travel bassguitar on the market. Its proprietary In-Body Tuning System uses standard tuning machines relocated into the body, eliminating the need for a headstock.','Traveler Guitar Ultra Light Bass Natural',550),(14,NULL,'The SRF700 from Ibanez is an electric, fretless bass guitar from the SR series. The instrument is one of the traditional models of the Ibanez brand with a characteristic body shape, which offers you great control and incredible sound.','Ibanez SRF700-BBF Brown Burst Flat',380),(15,NULL,'Acoustic four-string fretless bass guitar RockBass Alien Standard with pre-marked lines and Solid Black Satin finish. The individual parts of the bass guitar are made of quality spruce, agathis, mahogany and ebony wood.','Warwick RockBass Alien Standard FL Black',299),(16,NULL,'Offers the perfect synergy between traditional accordion playability and modern digital power and is jam-packed with features and enhancements developed with input from the world’s top players.','Roland FR-8x Black Piano accordion',5000),(17,NULL,'Irish Bouzouki. This instrument has a solid spruce top and walnut back and sides. The maple neck has 24 nickel silver frets with 0-fret and the scale legth is 660 mm.','VGS 513970 IR 8 Bouzouki',2500),(18,NULL,'Ethnic pipe called Irish whistle in the key of high D with six holes. The instrument is made of ABS resin in two-piece construction that allows for easy cleaning and tuning. Matt Black colour design.','Yamakawa SI-922 Ethnic whistle',3),(19,NULL,'21-string psaltery. The front part is made of spruce and the back of maple wood.','Hora D1004 21 Psalters',280),(20,NULL,'Child 5-piece drum-kit including cymbals and chairs. It consists of 16\" big drum, 6\" and 8\" Tom, 10\" Floor Tom, 10\" small drum, 8\" Hi-Hat and 10\" Crash cymbal. ','Stagg Tim Jr 5/16B Junior Drum Set Black Black',299),(21,NULL,'Snare drum from Tama Starclassic Maple series. In the \'80s TAMA\'s Superstars and Imperialstars reigned supreme - the perfect drums for the times.','Tama MRS1455-CCL Starclassic Maple 14\" Charcoal Swirl',69),(22,NULL,'When you’re serious about drumming, you need a kit to match your ambition. The V-Drums TD-17 series lets your technique shine through, backed up with training tools to push you further.','Roland TD-17KVX',1799),(23,NULL,'From the stage to the recording studio, the TAMA LSP32CS-TWS S.L.P. Fat Spruce shell pack excels wherever you need a fat, resonant drum sound with solid mids and a natural, pure tone.','Tama MA32CZS-FBK Starclassic Maple Flat Black',2999),(24,NULL,'Versatile arranger keyboard with 61 velocity-sensitive keys that was designed for musicians needing professional sounds and authentic backing styles from all over the world. ','Roland E-A7',1657);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `product_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  KEY `FKkud35ls1d40wpjb5htpp14q4e` (`category_id`),
  KEY `FK2k3smhbruedlcrvu6clued06x` (`product_id`),
  CONSTRAINT `FK2k3smhbruedlcrvu6clued06x` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKkud35ls1d40wpjb5htpp14q4e` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,6),(3,6),(5,1),(6,1),(7,2),(8,5),(9,5),(10,5),(11,5),(12,2),(13,2),(14,2),(15,2),(16,14),(17,14),(18,14),(19,14),(20,3),(21,3),(22,3),(23,3),(24,4);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_purchase`
--

DROP TABLE IF EXISTS `product_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_purchase` (
  `product_purchase_id` int NOT NULL AUTO_INCREMENT,
  `product_id` bigint DEFAULT NULL,
  `purchase_id` bigint DEFAULT NULL,
  PRIMARY KEY (`product_purchase_id`),
  KEY `FK2ceg0kva32705a9f5q70i3wvq` (`product_id`),
  KEY `FKit0ybykg2q7diha5kqpua72qq` (`purchase_id`),
  CONSTRAINT `FK2ceg0kva32705a9f5q70i3wvq` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKit0ybykg2q7diha5kqpua72qq` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_purchase`
--

LOCK TABLES `product_purchase` WRITE;
/*!40000 ALTER TABLE `product_purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contact_name` varchar(255) DEFAULT NULL,
  `delivery_info` varchar(255) DEFAULT NULL,
  `paying_method` varchar(255) DEFAULT NULL,
  `payment_id` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `time_stamp` datetime(6) DEFAULT NULL,
  `custom_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKe81utdcmof6glv03yihoqhub9` (`custom_user_id`),
  CONSTRAINT `FKe81utdcmof6glv03yihoqhub9` FOREIGN KEY (`custom_user_id`) REFERENCES `custom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` longtext,
  `time_stamp` datetime(6) DEFAULT NULL,
  `value` int DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlkuwie0au2dru36asng9nywmh` (`product_id`),
  CONSTRAINT `FKlkuwie0au2dru36asng9nywmh` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `custom_user_id` bigint NOT NULL,
  `roles` varchar(255) DEFAULT NULL,
  KEY `FKt2ossp14rv6qvn8nny0fx136u` (`custom_user_id`),
  CONSTRAINT `FKt2ossp14rv6qvn8nny0fx136u` FOREIGN KEY (`custom_user_id`) REFERENCES `custom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'ROLE_CUSTOMER'),(1,'ROLE_ADMIN'),(2,'ROLE_CUSTOMER'),(3,'ROLE_CUSTOMER');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-02 15:09:13
