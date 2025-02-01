-- MySQL dump 10.13  Distrib 8.4.3, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: domjudge
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `CONTEST`
--

DROP TABLE IF EXISTS `CONTEST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTEST` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `CREATE` bigint NOT NULL,
  `ACTIVE` bigint NOT NULL,
  `START` bigint NOT NULL,
  `END` bigint NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTEST`
--

LOCK TABLES `CONTEST` WRITE;
/*!40000 ALTER TABLE `CONTEST` DISABLE KEYS */;
INSERT INTO `CONTEST` (`ID`, `NAME`, `CREATE`, `ACTIVE`, `START`, `END`) VALUES (1,'TEST1',1737361436,1735660800,1735660800,1767196800),(2,'SAMPLE',0,1735660800,1735660800,1735660800);
/*!40000 ALTER TABLE `CONTEST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COUNTRY`
--

DROP TABLE IF EXISTS `COUNTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COUNTRY` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT 'Number id',
  `NICKNAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `FULLNAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `CODE2` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `CODE3` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `SN` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COUNTRY`
--

LOCK TABLES `COUNTRY` WRITE;
/*!40000 ALTER TABLE `COUNTRY` DISABLE KEYS */;
INSERT INTO `COUNTRY` (`ID`, `NICKNAME`, `FULLNAME`, `CODE2`, `CODE3`, `SN`) VALUES (1,'Afghanistan','the Islamic Republic of Afghanistan','AF','AFG','004'),(2,'Aland Islands','','AX','ALA','248'),(3,'Albania','the Republic of Albania','AL','ALB','008'),(4,'Algeria','the People\'s Democratic Republic of Algeria','DZ','DZA','012'),(5,'American Samoa','','AS','ASM','016'),(6,'Andorra','the Principality of Andorra','AD','AND','020'),(7,'Angola','the Republic of Angola','AO','AGO','024'),(8,'Anguilla','','AI','AIA','660'),(9,'Antarctica','','AQ','ATA','010'),(10,'Antigua and Barbuda','','AG','ATG','028'),(11,'Argentina','the Argentine Republic','AR','ARG','032'),(12,'Armenia','the Republic of Armenia','AM','ARM','051'),(13,'Aruba','','AW','ABW','533'),(14,'Australia','','AU','AUS','036'),(15,'Austria','the Republic of Austria','AT','AUT','040'),(16,'Azerbaijan','the Republic of Azerbaijan','AZ','AZE','031'),(17,'Bahamas (The)','the Commonwealth of The Bahamas','BS','BHS','044'),(18,'Bahrain','the Kingdom of Bahrain','BH','BHR','048'),(19,'Bangladesh','the People\'s Republic of Bangladesh','BD','BGD','050'),(20,'Barbados','','BB','BRB','052'),(21,'Belarus','the Republic of Belarus','BY','BLR','112'),(22,'Belgium','the Kingdom of Belgium','BE','BEL','056'),(23,'Belize','','BZ','BLZ','084'),(24,'Benin','the Republic of Benin','BJ','BEN','204'),(25,'Bermuda','','BM','BMU','060'),(26,'Bhutan','the Kingdom of Bhutan','BT','BTN','064'),(27,'Bolivia','the Republic of Bolivia','BO','BOL','068'),(28,'Bosnia and Herzegovina','','BA','BIH','070'),(29,'Botswana','the Republic of Botswana','BW','BWA','072'),(30,'Bouvet Island','','BV','BVT','074'),(31,'Brazil','the Federative Republic of Brazil','BR','BRA','076'),(32,'British Indian Ocean Territory (the)','','IO','IOT','086'),(33,'Brunei Darussalam','','BN','BRN','096'),(34,'Bulgaria','the Republic of Bulgaria','BG','BGR','100'),(35,'Burkina Faso','Burkina Faso','BF','BFA','854'),(36,'Burundi','the Republic of Burundi','BI','BDI','108'),(37,'Cambodia','the Kingdom of Cambodia','KH','KHM','116'),(38,'Cameroon','the Republic of Cameroon','CM','CMR','120'),(39,'Canada','','CA','CAN','124'),(40,'Cape Verde','the Republic of Cape Verde','CV','CPV','132'),(41,'Cayman Islands (the)','','KY','CYM','136'),(42,'Central African Republic (the)','the Central African Republic','CF','CAF','140'),(43,'Chad','the Republic of Chad','TD','TCD','148'),(44,'Chile','the Republic of Chile','CL','CHL','152'),(45,'China','the People\'s Republic of China','CN','CHN','156'),(46,'Christmas Island','','CX','CXR','162'),(47,'Cocos (Keeling) Islands (the)','','CC','CCK','166'),(48,'Colombia','the Republic of Colombia','CO','COL','170'),(49,'Comoros','the Union of the Comoros','KM','COM','174'),(50,'Congo','the Republic of the Congo','CG','COG','178'),(51,'Congo (the Democratic Republic of the)','the Democratic Republic of the Congo','CD','COD','180'),(52,'Cook Islands (the)','','CK','COK','184'),(53,'Costa Rica','the Republic of Costa Rica','CR','CRI','188'),(54,'Côte d\'Ivoire','the Republic of Côte d\'Ivoire','CI','CIV','384'),(55,'Croatia','the Republic of Croatia','HR','HRV','191'),(56,'Cuba','the Republic of Cuba','CU','CUB','192'),(57,'Cyprus','the Republic of Cyprus','CY','CYP','196'),(58,'Czech Republic (the)','the Czech Republic','CZ','CZE','203'),(59,'Denmark','the Kingdom of Denmark','DK','DNK','208'),(60,'Djibouti','the Republic of Djibouti','DJ','DJI','262'),(61,'Dominica','the Commonwealth of Dominica','DM','DMA','212'),(62,'Dominican Republic (the)','the Dominican Republic','DO','DOM','214'),(63,'Ecuador','the Republic of Ecuador','EC','ECU','218'),(64,'Egypt','the Arab Republic of Egypt','EG','EGY','818'),(65,'El Salvador','the Republic of El Salvador','SV','SLV','222'),(66,'Equatorial Guinea','the Republic of Equatorial Guinea','GQ','GNQ','226'),(67,'Eritrea','','ER','ERI','232'),(68,'Estonia','the Republic of Estonia','EE','EST','233'),(69,'Ethiopia','the Federal Democratic Republic of Ethiopia','ET','ETH','231'),(70,'Falkland Islands (the) [Malvinas]','','FK','FLK','238'),(71,'Faroe Islands (the)','','FO','FRO','234'),(72,'Fiji','the Republic of the Fiji Islands','FJ','FJI','242'),(73,'Finland','the Republic of Finland','FI','FIN','246'),(74,'France','the French Republic','FR','FRA','250'),(75,'French Guiana','','GF','GUF','254'),(76,'French Polynesia','','PF','PYF','258'),(77,'French Southern Territories (the)','','TF','ATF','260'),(78,'Gabon','the Gabonese Republic','GA','GAB','266'),(79,'Gambia (The)','the Republic of The Gambia','GM','GMB','270'),(80,'Georgia','','GE','GEO','268'),(81,'Germany','he Federal Republic of Germany','DE','DEU','276'),(82,'Ghana','the Republic of Ghana','GH','GHA','288'),(83,'Gibraltar','','GI','GIB','292'),(84,'Greece','the Hellenic Republic','GR','GRC','300'),(85,'Greenland','','GL','GRL','304'),(86,'Grenada','','GD','GRD','308'),(87,'Guadeloupe','','GP','GLP','312'),(88,'Guam','','GU','GUM','316'),(89,'Guatemala','the Republic of Guatemala','GT','GTM','320'),(90,'Guernsey','','GG','GGY','831'),(91,'Guinea','the Republic of Guinea','GN','GIN','324'),(92,'Guinea-Bissau','the Republic of Guinea-Bissau','GW','GNB','624'),(93,'Guyana','the Republic of Guyana','GY','GUY','328'),(94,'Haiti','the Republic of Haiti','HT','HTI','332'),(95,'Heard Island and McDonald Islands','','HM','HMD','334'),(96,'Holy See (the) [Vatican City State]','','VA','VAT','336'),(97,'Honduras','the Republic of Honduras','HN','HND','340'),(98,'Hong Kong','the Hong Kong Special Administrative Region of China','HK','HKG','344'),(99,'Hungary','the Republic of Hungary','HU','HUN','348'),(100,'Iceland','the Republic of Iceland','IS','ISL','352'),(101,'India','the Republic of India','IN','IND','356'),(102,'Indonesia','the Republic of Indonesia','ID','IDN','360'),(103,'Iran (the Islamic Republic of)','the Islamic Republic of Iran','IR','IRN','364'),(104,'Iraq','the Republic of Iraq','IQ','IRQ','368'),(105,'Ireland','','IE','IRL','372'),(106,'Isle of Man','','IM','IMN','833'),(107,'Israel','the State of Israel','IL','ISR','376'),(108,'Italy','the Republic of Italy','IT','ITA','380'),(109,'Jamaica','','JM','JAM','388'),(110,'Japan','','JP','JPN','392'),(111,'Jersey','','JE','JEY','832'),(112,'Jordan','the Hashemite Kingdom of Jordan','JO','JOR','400'),(113,'Kazakhstan','the Republic of Kazakhstan','KZ','KAZ','398'),(114,'Kenya','the Republic of Kenya','KE','KEN','404'),(115,'Kiribati','the Republic of Kiribati','KI','KIR','296'),(116,'Korea (the Democratic People\'s Republic of)','the Democratic People\'s Republic of Korea','KP','PRK','408'),(117,'Korea (the Republic of)','the Republic of Korea','KR','KOR','410'),(118,'Kuwait','he State of Kuwait','KW','KWT','414'),(119,'Kyrgyzstan','the Kyrgyz Republic','KG','KGZ','417'),(120,'Lao People\'s Democratic Republic (the)','the Lao People\'s Democratic Republic','LA','LAO','418'),(121,'Latvia','the Republic of Latvia','LV','LVA','428'),(122,'Lebanon','the Lebanese Republic','LB','LBN','422'),(123,'Lesotho','the Kingdom of Lesotho','LS','LSO','426'),(124,'Liberia','the Republic of Liberia','LR','LBR','430'),(125,'Libyan Arab Jamahiriya (the)','the Socialist People\'s Libyan Arab Jamahiriya','LY','LBY','434'),(126,'Liechtenstein','the Principality of Liechtenstein','LI','LIE','438'),(127,'Lithuania','the Republic of Lithuania','LT','LTU','440'),(128,'Luxembourg','the Grand Duchy of Luxembourg','LU','LUX','442'),(129,'Macao','Macao Special Administrative Region of China','MO','MAC','446'),(130,'Macedonia (the former Yugoslav Republic of)','the former Yugoslav Republic of Macedonia','MK','MKD','807'),(131,'Madagascar','the Republic of Madagascar','MG','MDG','450'),(132,'Malawi','the Republic of Malawi','MW','MWI','454'),(133,'Malaysia','','MY','MYS','458'),(134,'Maldives','the Republic of Maldives','MV','MDV','462'),(135,'Mali','the Republic of Mali','ML','MLI','466'),(136,'Malta','the Republic of Malta','MT','MLT','470'),(137,'Marshall Islands (the)','the Republic of the Marshall Islands','MH','MHL','584'),(138,'Martinique','','MQ','MTQ','474'),(139,'Mauritania','the Islamic Republic of Mauritania','MR','MRT','478'),(140,'Mauritius','the Republic of Mauritius','MU','MUS','480'),(141,'Mayotte','','YT','MYT','175'),(142,'Mexico','the United Mexican States','MX','MEX','484'),(143,'Micronesia (the Federated States of)','the Federated States of Micronesia','FM','FSM','583'),(144,'Moldova (the Republic of)','the Republic of Moldova','MD','MDA','498'),(145,'Monaco','the Principality of Monaco','MC','MCO','492'),(146,'Mongolia','','MN','MNG','496'),(147,'Montenegro','he Republic of Montenegro','ME','MNE','499'),(148,'Montserrat','','MS','MSR','500'),(149,'Morocco','the Kingdom of Morocco','MA','MAR','504'),(150,'Mozambique','the Republic of Mozambique','MZ','MOZ','508'),(151,'Myanmar','the Union of Myanmar','MM','MMR','104'),(152,'Namibia','the Republic of Namibia','NA','NAM','516'),(153,'Nauru','the Republic of Nauru','NR','NRU','520'),(154,'Nepal','Nepal','NP','NPL','524'),(155,'Netherlands (the)','the Kingdom of the Netherlands','NL','NLD','528'),(156,'Netherlands Antilles (the)','','AN','ANT','530'),(157,'New Caledonia','','NC','NCL','540'),(158,'New Zealand','','NZ','NZL','554'),(159,'Nicaragua','the Republic of Nicaragua','NI','NIC','558'),(160,'Niger (the)','the Republic of the Niger','NE','NER','562'),(161,'Nigeria','the Federal Republic of Nigeria','NG','NGA','566'),(162,'Niue','the Republic of Niue','NU','NIU','570'),(163,'Norfolk Island','','NF','NFK','574'),(164,'Northern Mariana Islands (the)','the Commonwealth of the Northern Mariana Islands','MP','MNP','580'),(165,'Norway','the Kingdom of Norway','NO','NOR','578'),(166,'Oman','the Sultanate of Oman','OM','OMN','512'),(167,'Pakistan','the Islamic Republic of Pakistan','PK','PAK','586'),(168,'Palau','the Republic of Palau','PW','PLW','585'),(169,'Palestinian Territory (the Occupied)','the Occupied Palestinian Territory','PS','PSE','275'),(170,'Panama','the Republic of Panama','PA','PAN','591'),(171,'Papua New Guinea','','PG','PNG','598'),(172,'Paraguay','the Republic of Paraguay','PY','PRY','600'),(173,'Peru','the Republic of Peru','PE','PER','604'),(174,'Philippines (the)','the Republic of the Philippines','PH','PHL','608'),(175,'Pitcairn','','PN','PCN','612'),(176,'Poland','the Republic of Poland','PL','POL','616'),(177,'Portugal','the Portuguese Republic','PT','PRT','620'),(178,'Puerto Rico','','PR','PRI','630'),(179,'Qatar','the State of Qatar','QA','QAT','634'),(180,'Réunion','','RE','REU','638'),(181,'Romania','','RO','ROU','642'),(182,'Russian Federation (the)','the Russian Federation','RU','RUS','643'),(183,'Rwanda','the Republic of Rwanda','RW','RWA','646'),(184,'Saint Helena','','SH','SHN','654'),(185,'Saint Kitts and Nevis','','KN','KNA','659'),(186,'Saint Lucia','','LC','LCA','662'),(187,'Saint Pierre and Miquelon','','PM','SPM','666'),(188,'Saint Vincent and the Grenadines','','VC','VCT','670'),(189,'Samoa','the Independent State of Samoa','WS','WSM','882'),(190,'San Marino','the Republic of San Marino','SM','SMR','674'),(191,'Sao Tome and Principe','the Democratic Republic of Sao Tome and Principe','ST','STP','678'),(192,'Saudi Arabia','the Kingdom of Saudi Arabia','SA','SAU','682'),(193,'Senegal','the Republic of Senegal','SN','SEN','686'),(194,'Serbia','the Republic of Serbia','RS','SRB','688'),(195,'Seychelles','the Republic of Seychelles','SC','SYC','690'),(196,'Sierra Leone','the Republic of Sierra Leone','SL','SLE','694'),(197,'Singapore','the Republic of Singapore','SG','SGP','702'),(198,'Slovakia','the Slovak Republic','SK','SVK','703'),(199,'Slovenia','the Republic of Slovenia','SI','SVN','705'),(200,'Solomon Islands (the)','','SB','SLB','090'),(201,'Somalia','the Somali Republic','SO','SOM','706'),(202,'South Africa','the Republic of South Africa','ZA','ZAF','710'),(203,'South Georgia and the South Sandwich Islands','','GS','SGS','239'),(204,'Spain','the Kingdom of Spain','ES','ESP','724'),(205,'Sri Lanka','the Democratic Socialist Republic of Sri Lanka','LK','LKA','144'),(206,'Sudan (the)','the Republic of the Sudan','SD','SDN','736'),(207,'Suriname','the Republic of Suriname','SR','SUR','740'),(208,'Svalbard and Jan Mayen','','SJ','SJM','744'),(209,'Swaziland','the Kingdom of Swaziland','SZ','SWZ','748'),(210,'Sweden','the Kingdom of Sweden','SE','SWE','752'),(211,'Switzerland','the Swiss Confederation','CH','CHE','756'),(212,'Syrian Arab Republic (the)','the Syrian Arab Republic','SY','SYR','760'),(213,'Taiwan (Province of China)','','TW','TWN','158'),(214,'Tajikistan','the Republic of Tajikistan','TJ','TJK','762'),(215,'Tanzania,United Republic of','the United Republic of Tanzania','TZ','TZA','834'),(216,'Thailand','the Kingdom of Thailand','TH','THA','764'),(217,'Timor-Leste','the Democratic Republic of Timor-Leste','TL','TLS','626'),(218,'Togo','the Togolese Republic','TG','TGO','768'),(219,'Tokelau','','TK','TKL','772'),(220,'Tonga','the Kingdom of Tonga','TO','TON','776'),(221,'Trinidad and Tobago','the Republic of Trinidad and Tobago','TT','TTO','780'),(222,'Tunisia','the Republic of Tunisia','TN','TUN','788'),(223,'Turkey','the Republic of Turkey','TR','TUR','792'),(224,'Turkmenistan','','TM','TKM','795'),(225,'Turks and Caicos Islands (the)','','TC','TCA','796'),(226,'Tuvalu','','TV','TUV','798'),(227,'Uganda','the Republic of Uganda','UG','UGA','800'),(228,'Ukraine','','UA','UKR','804'),(229,'United Arab Emirates (the)','the United Arab Emirates','AE','ARE','784'),(230,'United Kingdom (the)','the United Kingdom of Great Britain and Northern Ireland','GB','GBR','826'),(231,'United States (the)','the United States of America','US','USA','840'),(232,'United States Minor Outlying Islands (the)','','UM','UMI','581'),(233,'Uruguay','the Eastern Republic of Uruguay','UY','URY','858'),(234,'Uzbekistan','the Republic of Uzbekistan','UZ','UZB','860'),(235,'Vanuatu','the Republic of Vanuatu','VU','VUT','548'),(236,'Venezuela','the Bolivarian Republic of Venezuela','VE','VEN','862'),(237,'Viet Nam','the Socialist Republic of Viet Nam','VN','VNM','704'),(238,'Virgin Islands (British)','British Virgin Islands (the)','VG','VGB','092'),(239,'Virgin Islands (U.S.)','the Virgin Islands of the United States','VI','VIR','850'),(240,'Wallis and Futuna','Wallis and Futuna Islands','WF','WLF','876'),(241,'Western Sahara','','EH','ESH','732'),(242,'Yemen','the Republic of Yemen','YE','YEM','887'),(243,'Zambia','the Republic of Zambia','ZM','ZMB','894'),(244,'Zimbabwe','the Republic of Zimbabwe','ZW','ZWE','716');
/*!40000 ALTER TABLE `COUNTRY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CPROBLEM`
--

DROP TABLE IF EXISTS `CPROBLEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CPROBLEM` (
  `PID` int NOT NULL,
  `CID` int NOT NULL,
  `IDX` int NOT NULL,
  `NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `COLOR` int NOT NULL DEFAULT '16777215',
  PRIMARY KEY (`CID`,`IDX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CPROBLEM`
--

LOCK TABLES `CPROBLEM` WRITE;
/*!40000 ALTER TABLE `CPROBLEM` DISABLE KEYS */;
INSERT INTO `CPROBLEM` (`PID`, `CID`, `IDX`, `NAME`, `COLOR`) VALUES (1,1,1,'AAA',16777215),(2,1,2,'BBB',16777215),(3,1,3,'CCC',16777215);
/*!40000 ALTER TABLE `CPROBLEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROBLEM`
--

DROP TABLE IF EXISTS `PROBLEM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROBLEM` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROBLEM`
--

LOCK TABLES `PROBLEM` WRITE;
/*!40000 ALTER TABLE `PROBLEM` DISABLE KEYS */;
INSERT INTO `PROBLEM` (`ID`, `NAME`) VALUES (1,'AAA'),(2,'BBB'),(3,'CCC');
/*!40000 ALTER TABLE `PROBLEM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUBMISSION`
--

DROP TABLE IF EXISTS `SUBMISSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUBMISSION` (
  `ID` bigint NOT NULL AUTO_INCREMENT COMMENT 'Increment id',
  `STATUS` tinyint NOT NULL COMMENT 'Submission status\n0 - AC\n1 - WA\n2 - TLE\n3 - MLE\n4 - Waiting\n5 - Judging',
  `CONTEST` int NOT NULL,
  `PROBLEM` tinyint NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Submission record';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUBMISSION`
--

LOCK TABLES `SUBMISSION` WRITE;
/*!40000 ALTER TABLE `SUBMISSION` DISABLE KEYS */;
INSERT INTO `SUBMISSION` (`ID`, `STATUS`, `CONTEST`, `PROBLEM`) VALUES (114,0,1,1);
/*!40000 ALTER TABLE `SUBMISSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEAM`
--

DROP TABLE IF EXISTS `TEAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEAM` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `CATEGORY` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `AFFILIATION` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `COUNTRY` char(2) COLLATE utf8mb4_bin DEFAULT NULL,
  `LOCATION` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAM`
--

LOCK TABLES `TEAM` WRITE;
/*!40000 ALTER TABLE `TEAM` DISABLE KEYS */;
INSERT INTO `TEAM` (`ID`, `NAME`, `CATEGORY`, `AFFILIATION`, `COUNTRY`, `LOCATION`) VALUES (52,'Treenity','NWERC - Eindhoven University of Technology','University of Cambridge','GB','Room: AUD 12, Row: 6, Col: l'),(117,'_=_=>_+_<<_;_(-~{})+[]+(++[[]][+[]]+~[]*~[])','NWERC - Eindhoven University of Technology','Technische Universitaet Muenchen','DE','Room: AUD 16, Row: 1, Col: r');
/*!40000 ALTER TABLE `TEAM` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-01 18:15:28
