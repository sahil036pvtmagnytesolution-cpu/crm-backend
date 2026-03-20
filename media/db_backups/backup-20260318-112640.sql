-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: ms_crm
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=669 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add business',7,'add_business'),(26,'Can change business',7,'change_business'),(27,'Can delete business',7,'delete_business'),(28,'Can view business',7,'view_business'),(29,'Can add activity log',8,'add_activitylog'),(30,'Can change activity log',8,'change_activitylog'),(31,'Can delete activity log',8,'delete_activitylog'),(32,'Can view activity log',8,'view_activitylog'),(33,'Can add announcements',9,'add_announcements'),(34,'Can change announcements',9,'change_announcements'),(35,'Can delete announcements',9,'delete_announcements'),(36,'Can view announcements',9,'view_announcements'),(37,'Can add clients',10,'add_clients'),(38,'Can change clients',10,'change_clients'),(39,'Can delete clients',10,'delete_clients'),(40,'Can view clients',10,'view_clients'),(41,'Can add consent purposes',11,'add_consentpurposes'),(42,'Can change consent purposes',11,'change_consentpurposes'),(43,'Can delete consent purposes',11,'delete_consentpurposes'),(44,'Can view consent purposes',11,'view_consentpurposes'),(45,'Can add consents',12,'add_consents'),(46,'Can change consents',12,'change_consents'),(47,'Can delete consents',12,'delete_consents'),(48,'Can view consents',12,'view_consents'),(49,'Can add contact permissions',13,'add_contactpermissions'),(50,'Can change contact permissions',13,'change_contactpermissions'),(51,'Can delete contact permissions',13,'delete_contactpermissions'),(52,'Can view contact permissions',13,'view_contactpermissions'),(53,'Can add contacts',14,'add_contacts'),(54,'Can change contacts',14,'change_contacts'),(55,'Can delete contacts',14,'delete_contacts'),(56,'Can view contacts',14,'view_contacts'),(57,'Can add contract comments',15,'add_contractcomments'),(58,'Can change contract comments',15,'change_contractcomments'),(59,'Can delete contract comments',15,'delete_contractcomments'),(60,'Can view contract comments',15,'view_contractcomments'),(61,'Can add contract renewals',16,'add_contractrenewals'),(62,'Can change contract renewals',16,'change_contractrenewals'),(63,'Can delete contract renewals',16,'delete_contractrenewals'),(64,'Can view contract renewals',16,'view_contractrenewals'),(65,'Can add contracts',17,'add_contracts'),(66,'Can change contracts',17,'change_contracts'),(67,'Can delete contracts',17,'delete_contracts'),(68,'Can view contracts',17,'view_contracts'),(69,'Can add contracts types',18,'add_contractstypes'),(70,'Can change contracts types',18,'change_contractstypes'),(71,'Can delete contracts types',18,'delete_contractstypes'),(72,'Can view contracts types',18,'view_contractstypes'),(73,'Can add countries',19,'add_countries'),(74,'Can change countries',19,'change_countries'),(75,'Can delete countries',19,'delete_countries'),(76,'Can view countries',19,'view_countries'),(77,'Can add creditnote refunds',20,'add_creditnoterefunds'),(78,'Can change creditnote refunds',20,'change_creditnoterefunds'),(79,'Can delete creditnote refunds',20,'delete_creditnoterefunds'),(80,'Can view creditnote refunds',20,'view_creditnoterefunds'),(81,'Can add creditnotes',21,'add_creditnotes'),(82,'Can change creditnotes',21,'change_creditnotes'),(83,'Can delete creditnotes',21,'delete_creditnotes'),(84,'Can view creditnotes',21,'view_creditnotes'),(85,'Can add credits',22,'add_credits'),(86,'Can change credits',22,'change_credits'),(87,'Can delete credits',22,'delete_credits'),(88,'Can view credits',22,'view_credits'),(89,'Can add currencies',23,'add_currencies'),(90,'Can change currencies',23,'change_currencies'),(91,'Can delete currencies',23,'delete_currencies'),(92,'Can view currencies',23,'view_currencies'),(93,'Can add customer admins',24,'add_customeradmins'),(94,'Can change customer admins',24,'change_customeradmins'),(95,'Can delete customer admins',24,'delete_customeradmins'),(96,'Can view customer admins',24,'view_customeradmins'),(97,'Can add customer groups',25,'add_customergroups'),(98,'Can change customer groups',25,'change_customergroups'),(99,'Can delete customer groups',25,'delete_customergroups'),(100,'Can view customer groups',25,'view_customergroups'),(101,'Can add customers groups',26,'add_customersgroups'),(102,'Can change customers groups',26,'change_customersgroups'),(103,'Can delete customers groups',26,'delete_customersgroups'),(104,'Can view customers groups',26,'view_customersgroups'),(105,'Can add customfields',27,'add_customfields'),(106,'Can change customfields',27,'change_customfields'),(107,'Can delete customfields',27,'delete_customfields'),(108,'Can view customfields',27,'view_customfields'),(109,'Can add customfieldsvalues',28,'add_customfieldsvalues'),(110,'Can change customfieldsvalues',28,'change_customfieldsvalues'),(111,'Can delete customfieldsvalues',28,'delete_customfieldsvalues'),(112,'Can view customfieldsvalues',28,'view_customfieldsvalues'),(113,'Can add departments',29,'add_departments'),(114,'Can change departments',29,'change_departments'),(115,'Can delete departments',29,'delete_departments'),(116,'Can view departments',29,'view_departments'),(117,'Can add dismissed announcements',30,'add_dismissedannouncements'),(118,'Can change dismissed announcements',30,'change_dismissedannouncements'),(119,'Can delete dismissed announcements',30,'delete_dismissedannouncements'),(120,'Can view dismissed announcements',30,'view_dismissedannouncements'),(121,'Can add emaillists',31,'add_emaillists'),(122,'Can change emaillists',31,'change_emaillists'),(123,'Can delete emaillists',31,'delete_emaillists'),(124,'Can view emaillists',31,'view_emaillists'),(125,'Can add emailtemplates',32,'add_emailtemplates'),(126,'Can change emailtemplates',32,'change_emailtemplates'),(127,'Can delete emailtemplates',32,'delete_emailtemplates'),(128,'Can view emailtemplates',32,'view_emailtemplates'),(129,'Can add estimates',33,'add_estimates'),(130,'Can change estimates',33,'change_estimates'),(131,'Can delete estimates',33,'delete_estimates'),(132,'Can view estimates',33,'view_estimates'),(133,'Can add events',34,'add_events'),(134,'Can change events',34,'change_events'),(135,'Can delete events',34,'delete_events'),(136,'Can view events',34,'view_events'),(137,'Can add expenses',35,'add_expenses'),(138,'Can change expenses',35,'change_expenses'),(139,'Can delete expenses',35,'delete_expenses'),(140,'Can view expenses',35,'view_expenses'),(141,'Can add expenses categories',36,'add_expensescategories'),(142,'Can change expenses categories',36,'change_expensescategories'),(143,'Can delete expenses categories',36,'delete_expensescategories'),(144,'Can view expenses categories',36,'view_expensescategories'),(145,'Can add files',37,'add_files'),(146,'Can change files',37,'change_files'),(147,'Can delete files',37,'delete_files'),(148,'Can view files',37,'view_files'),(149,'Can add form question box',38,'add_formquestionbox'),(150,'Can change form question box',38,'change_formquestionbox'),(151,'Can delete form question box',38,'delete_formquestionbox'),(152,'Can view form question box',38,'view_formquestionbox'),(153,'Can add form question box description',39,'add_formquestionboxdescription'),(154,'Can change form question box description',39,'change_formquestionboxdescription'),(155,'Can delete form question box description',39,'delete_formquestionboxdescription'),(156,'Can view form question box description',39,'view_formquestionboxdescription'),(157,'Can add form questions',40,'add_formquestions'),(158,'Can change form questions',40,'change_formquestions'),(159,'Can delete form questions',40,'delete_formquestions'),(160,'Can view form questions',40,'view_formquestions'),(161,'Can add form results',41,'add_formresults'),(162,'Can change form results',41,'change_formresults'),(163,'Can delete form results',41,'delete_formresults'),(164,'Can view form results',41,'view_formresults'),(165,'Can add gdpr requests',42,'add_gdprrequests'),(166,'Can change gdpr requests',42,'change_gdprrequests'),(167,'Can delete gdpr requests',42,'delete_gdprrequests'),(168,'Can view gdpr requests',42,'view_gdprrequests'),(169,'Can add goals',43,'add_goals'),(170,'Can change goals',43,'change_goals'),(171,'Can delete goals',43,'delete_goals'),(172,'Can view goals',43,'view_goals'),(173,'Can add invoicepaymentrecords',44,'add_invoicepaymentrecords'),(174,'Can change invoicepaymentrecords',44,'change_invoicepaymentrecords'),(175,'Can delete invoicepaymentrecords',44,'delete_invoicepaymentrecords'),(176,'Can view invoicepaymentrecords',44,'view_invoicepaymentrecords'),(177,'Can add invoices',45,'add_invoices'),(178,'Can change invoices',45,'change_invoices'),(179,'Can delete invoices',45,'delete_invoices'),(180,'Can view invoices',45,'view_invoices'),(181,'Can add itemable',46,'add_itemable'),(182,'Can change itemable',46,'change_itemable'),(183,'Can delete itemable',46,'delete_itemable'),(184,'Can view itemable',46,'view_itemable'),(185,'Can add items',47,'add_items'),(186,'Can change items',47,'change_items'),(187,'Can delete items',47,'delete_items'),(188,'Can view items',47,'view_items'),(189,'Can add items groups',48,'add_itemsgroups'),(190,'Can change items groups',48,'change_itemsgroups'),(191,'Can delete items groups',48,'delete_itemsgroups'),(192,'Can view items groups',48,'view_itemsgroups'),(193,'Can add item tax',49,'add_itemtax'),(194,'Can change item tax',49,'change_itemtax'),(195,'Can delete item tax',49,'delete_itemtax'),(196,'Can view item tax',49,'view_itemtax'),(197,'Can add knowedge base article feedback',50,'add_knowedgebasearticlefeedback'),(198,'Can change knowedge base article feedback',50,'change_knowedgebasearticlefeedback'),(199,'Can delete knowedge base article feedback',50,'delete_knowedgebasearticlefeedback'),(200,'Can view knowedge base article feedback',50,'view_knowedgebasearticlefeedback'),(201,'Can add knowledge base',51,'add_knowledgebase'),(202,'Can change knowledge base',51,'change_knowledgebase'),(203,'Can delete knowledge base',51,'delete_knowledgebase'),(204,'Can view knowledge base',51,'view_knowledgebase'),(205,'Can add knowledge base groups',52,'add_knowledgebasegroups'),(206,'Can change knowledge base groups',52,'change_knowledgebasegroups'),(207,'Can delete knowledge base groups',52,'delete_knowledgebasegroups'),(208,'Can view knowledge base groups',52,'view_knowledgebasegroups'),(209,'Can add lead activity log',53,'add_leadactivitylog'),(210,'Can change lead activity log',53,'change_leadactivitylog'),(211,'Can delete lead activity log',53,'delete_leadactivitylog'),(212,'Can view lead activity log',53,'view_leadactivitylog'),(213,'Can add lead integration emails',54,'add_leadintegrationemails'),(214,'Can change lead integration emails',54,'change_leadintegrationemails'),(215,'Can delete lead integration emails',54,'delete_leadintegrationemails'),(216,'Can view lead integration emails',54,'view_leadintegrationemails'),(217,'Can add leads',55,'add_leads'),(218,'Can change leads',55,'change_leads'),(219,'Can delete leads',55,'delete_leads'),(220,'Can view leads',55,'view_leads'),(221,'Can add leads email integration',56,'add_leadsemailintegration'),(222,'Can change leads email integration',56,'change_leadsemailintegration'),(223,'Can delete leads email integration',56,'delete_leadsemailintegration'),(224,'Can view leads email integration',56,'view_leadsemailintegration'),(225,'Can add leads sources',57,'add_leadssources'),(226,'Can change leads sources',57,'change_leadssources'),(227,'Can delete leads sources',57,'delete_leadssources'),(228,'Can view leads sources',57,'view_leadssources'),(229,'Can add leads status',58,'add_leadsstatus'),(230,'Can change leads status',58,'change_leadsstatus'),(231,'Can delete leads status',58,'delete_leadsstatus'),(232,'Can view leads status',58,'view_leadsstatus'),(233,'Can add listemails',59,'add_listemails'),(234,'Can change listemails',59,'change_listemails'),(235,'Can delete listemails',59,'delete_listemails'),(236,'Can view listemails',59,'view_listemails'),(237,'Can add maillistscustomfields',60,'add_maillistscustomfields'),(238,'Can change maillistscustomfields',60,'change_maillistscustomfields'),(239,'Can delete maillistscustomfields',60,'delete_maillistscustomfields'),(240,'Can view maillistscustomfields',60,'view_maillistscustomfields'),(241,'Can add maillistscustomfieldvalues',61,'add_maillistscustomfieldvalues'),(242,'Can change maillistscustomfieldvalues',61,'change_maillistscustomfieldvalues'),(243,'Can delete maillistscustomfieldvalues',61,'delete_maillistscustomfieldvalues'),(244,'Can view maillistscustomfieldvalues',61,'view_maillistscustomfieldvalues'),(245,'Can add mail queue',62,'add_mailqueue'),(246,'Can change mail queue',62,'change_mailqueue'),(247,'Can delete mail queue',62,'delete_mailqueue'),(248,'Can view mail queue',62,'view_mailqueue'),(249,'Can add migrations',63,'add_migrations'),(250,'Can change migrations',63,'change_migrations'),(251,'Can delete migrations',63,'delete_migrations'),(252,'Can view migrations',63,'view_migrations'),(253,'Can add milestones',64,'add_milestones'),(254,'Can change milestones',64,'change_milestones'),(255,'Can delete milestones',64,'delete_milestones'),(256,'Can view milestones',64,'view_milestones'),(257,'Can add modules',65,'add_modules'),(258,'Can change modules',65,'change_modules'),(259,'Can delete modules',65,'delete_modules'),(260,'Can view modules',65,'view_modules'),(261,'Can add newsfeed comment likes',66,'add_newsfeedcommentlikes'),(262,'Can change newsfeed comment likes',66,'change_newsfeedcommentlikes'),(263,'Can delete newsfeed comment likes',66,'delete_newsfeedcommentlikes'),(264,'Can view newsfeed comment likes',66,'view_newsfeedcommentlikes'),(265,'Can add newsfeed post comments',67,'add_newsfeedpostcomments'),(266,'Can change newsfeed post comments',67,'change_newsfeedpostcomments'),(267,'Can delete newsfeed post comments',67,'delete_newsfeedpostcomments'),(268,'Can view newsfeed post comments',67,'view_newsfeedpostcomments'),(269,'Can add newsfeed post likes',68,'add_newsfeedpostlikes'),(270,'Can change newsfeed post likes',68,'change_newsfeedpostlikes'),(271,'Can delete newsfeed post likes',68,'delete_newsfeedpostlikes'),(272,'Can view newsfeed post likes',68,'view_newsfeedpostlikes'),(273,'Can add newsfeed posts',69,'add_newsfeedposts'),(274,'Can change newsfeed posts',69,'change_newsfeedposts'),(275,'Can delete newsfeed posts',69,'delete_newsfeedposts'),(276,'Can view newsfeed posts',69,'view_newsfeedposts'),(277,'Can add notes',70,'add_notes'),(278,'Can change notes',70,'change_notes'),(279,'Can delete notes',70,'delete_notes'),(280,'Can view notes',70,'view_notes'),(281,'Can add notifications',71,'add_notifications'),(282,'Can change notifications',71,'change_notifications'),(283,'Can delete notifications',71,'delete_notifications'),(284,'Can view notifications',71,'view_notifications'),(285,'Can add options',72,'add_options'),(286,'Can change options',72,'change_options'),(287,'Can delete options',72,'delete_options'),(288,'Can view options',72,'view_options'),(289,'Can add payment modes',73,'add_paymentmodes'),(290,'Can change payment modes',73,'change_paymentmodes'),(291,'Can delete payment modes',73,'delete_paymentmodes'),(292,'Can view payment modes',73,'view_paymentmodes'),(293,'Can add pinned projects',74,'add_pinnedprojects'),(294,'Can change pinned projects',74,'change_pinnedprojects'),(295,'Can delete pinned projects',74,'delete_pinnedprojects'),(296,'Can view pinned projects',74,'view_pinnedprojects'),(297,'Can add project activity',75,'add_projectactivity'),(298,'Can change project activity',75,'change_projectactivity'),(299,'Can delete project activity',75,'delete_projectactivity'),(300,'Can view project activity',75,'view_projectactivity'),(301,'Can add projectdiscussioncomments',76,'add_projectdiscussioncomments'),(302,'Can change projectdiscussioncomments',76,'change_projectdiscussioncomments'),(303,'Can delete projectdiscussioncomments',76,'delete_projectdiscussioncomments'),(304,'Can view projectdiscussioncomments',76,'view_projectdiscussioncomments'),(305,'Can add projectdiscussions',77,'add_projectdiscussions'),(306,'Can change projectdiscussions',77,'change_projectdiscussions'),(307,'Can delete projectdiscussions',77,'delete_projectdiscussions'),(308,'Can view projectdiscussions',77,'view_projectdiscussions'),(309,'Can add project files',78,'add_projectfiles'),(310,'Can change project files',78,'change_projectfiles'),(311,'Can delete project files',78,'delete_projectfiles'),(312,'Can view project files',78,'view_projectfiles'),(313,'Can add project members',79,'add_projectmembers'),(314,'Can change project members',79,'change_projectmembers'),(315,'Can delete project members',79,'delete_projectmembers'),(316,'Can view project members',79,'view_projectmembers'),(317,'Can add project notes',80,'add_projectnotes'),(318,'Can change project notes',80,'change_projectnotes'),(319,'Can delete project notes',80,'delete_projectnotes'),(320,'Can view project notes',80,'view_projectnotes'),(321,'Can add projects',81,'add_projects'),(322,'Can change projects',81,'change_projects'),(323,'Can delete projects',81,'delete_projects'),(324,'Can view projects',81,'view_projects'),(325,'Can add project settings',82,'add_projectsettings'),(326,'Can change project settings',82,'change_projectsettings'),(327,'Can delete project settings',82,'delete_projectsettings'),(328,'Can view project settings',82,'view_projectsettings'),(329,'Can add proposal comments',83,'add_proposalcomments'),(330,'Can change proposal comments',83,'change_proposalcomments'),(331,'Can delete proposal comments',83,'delete_proposalcomments'),(332,'Can view proposal comments',83,'view_proposalcomments'),(333,'Can add proposals',84,'add_proposals'),(334,'Can change proposals',84,'change_proposals'),(335,'Can delete proposals',84,'delete_proposals'),(336,'Can view proposals',84,'view_proposals'),(337,'Can add related items',85,'add_relateditems'),(338,'Can change related items',85,'change_relateditems'),(339,'Can delete related items',85,'delete_relateditems'),(340,'Can view related items',85,'view_relateditems'),(341,'Can add reminders',86,'add_reminders'),(342,'Can change reminders',86,'change_reminders'),(343,'Can delete reminders',86,'delete_reminders'),(344,'Can view reminders',86,'view_reminders'),(345,'Can add roles',87,'add_roles'),(346,'Can change roles',87,'change_roles'),(347,'Can delete roles',87,'delete_roles'),(348,'Can view roles',87,'view_roles'),(349,'Can add sales activity',88,'add_salesactivity'),(350,'Can change sales activity',88,'change_salesactivity'),(351,'Can delete sales activity',88,'delete_salesactivity'),(352,'Can view sales activity',88,'view_salesactivity'),(353,'Can add services',89,'add_services'),(354,'Can change services',89,'change_services'),(355,'Can delete services',89,'delete_services'),(356,'Can view services',89,'view_services'),(357,'Can add sessions',90,'add_sessions'),(358,'Can change sessions',90,'change_sessions'),(359,'Can delete sessions',90,'delete_sessions'),(360,'Can view sessions',90,'view_sessions'),(361,'Can add shared customer files',91,'add_sharedcustomerfiles'),(362,'Can change shared customer files',91,'change_sharedcustomerfiles'),(363,'Can delete shared customer files',91,'delete_sharedcustomerfiles'),(364,'Can view shared customer files',91,'view_sharedcustomerfiles'),(365,'Can add spam filters',92,'add_spamfilters'),(366,'Can change spam filters',92,'change_spamfilters'),(367,'Can delete spam filters',92,'delete_spamfilters'),(368,'Can view spam filters',92,'view_spamfilters'),(369,'Can add staff',93,'add_staff'),(370,'Can change staff',93,'change_staff'),(371,'Can delete staff',93,'delete_staff'),(372,'Can view staff',93,'view_staff'),(373,'Can add staff departments',94,'add_staffdepartments'),(374,'Can change staff departments',94,'change_staffdepartments'),(375,'Can delete staff departments',94,'delete_staffdepartments'),(376,'Can view staff departments',94,'view_staffdepartments'),(377,'Can add staff permissions',95,'add_staffpermissions'),(378,'Can change staff permissions',95,'change_staffpermissions'),(379,'Can delete staff permissions',95,'delete_staffpermissions'),(380,'Can view staff permissions',95,'view_staffpermissions'),(381,'Can add subscriptions',96,'add_subscriptions'),(382,'Can change subscriptions',96,'change_subscriptions'),(383,'Can delete subscriptions',96,'delete_subscriptions'),(384,'Can view subscriptions',96,'view_subscriptions'),(385,'Can add surveyresultsets',97,'add_surveyresultsets'),(386,'Can change surveyresultsets',97,'change_surveyresultsets'),(387,'Can delete surveyresultsets',97,'delete_surveyresultsets'),(388,'Can view surveyresultsets',97,'view_surveyresultsets'),(389,'Can add surveys',98,'add_surveys'),(390,'Can change surveys',98,'change_surveys'),(391,'Can delete surveys',98,'delete_surveys'),(392,'Can view surveys',98,'view_surveys'),(393,'Can add surveysemailsendcron',99,'add_surveysemailsendcron'),(394,'Can change surveysemailsendcron',99,'change_surveysemailsendcron'),(395,'Can delete surveysemailsendcron',99,'delete_surveysemailsendcron'),(396,'Can view surveysemailsendcron',99,'view_surveysemailsendcron'),(397,'Can add surveysendlog',100,'add_surveysendlog'),(398,'Can change surveysendlog',100,'change_surveysendlog'),(399,'Can delete surveysendlog',100,'delete_surveysendlog'),(400,'Can view surveysendlog',100,'view_surveysendlog'),(401,'Can add taggables',101,'add_taggables'),(402,'Can change taggables',101,'change_taggables'),(403,'Can delete taggables',101,'delete_taggables'),(404,'Can view taggables',101,'view_taggables'),(405,'Can add tags',102,'add_tags'),(406,'Can change tags',102,'change_tags'),(407,'Can delete tags',102,'delete_tags'),(408,'Can view tags',102,'view_tags'),(409,'Can add task assigned',103,'add_taskassigned'),(410,'Can change task assigned',103,'change_taskassigned'),(411,'Can delete task assigned',103,'delete_taskassigned'),(412,'Can view task assigned',103,'view_taskassigned'),(413,'Can add task checklist items',104,'add_taskchecklistitems'),(414,'Can change task checklist items',104,'change_taskchecklistitems'),(415,'Can delete task checklist items',104,'delete_taskchecklistitems'),(416,'Can view task checklist items',104,'view_taskchecklistitems'),(417,'Can add task comments',105,'add_taskcomments'),(418,'Can change task comments',105,'change_taskcomments'),(419,'Can delete task comments',105,'delete_taskcomments'),(420,'Can view task comments',105,'view_taskcomments'),(421,'Can add task followers',106,'add_taskfollowers'),(422,'Can change task followers',106,'change_taskfollowers'),(423,'Can delete task followers',106,'delete_taskfollowers'),(424,'Can view task followers',106,'view_taskfollowers'),(425,'Can add tasks',107,'add_tasks'),(426,'Can change tasks',107,'change_tasks'),(427,'Can delete tasks',107,'delete_tasks'),(428,'Can view tasks',107,'view_tasks'),(429,'Can add tasks checklist templates',108,'add_taskschecklisttemplates'),(430,'Can change tasks checklist templates',108,'change_taskschecklisttemplates'),(431,'Can delete tasks checklist templates',108,'delete_taskschecklisttemplates'),(432,'Can view tasks checklist templates',108,'view_taskschecklisttemplates'),(433,'Can add taskstimers',109,'add_taskstimers'),(434,'Can change taskstimers',109,'change_taskstimers'),(435,'Can delete taskstimers',109,'delete_taskstimers'),(436,'Can view taskstimers',109,'view_taskstimers'),(437,'Can add taxes',110,'add_taxes'),(438,'Can change taxes',110,'change_taxes'),(439,'Can delete taxes',110,'delete_taxes'),(440,'Can view taxes',110,'view_taxes'),(441,'Can add ticket attachments',111,'add_ticketattachments'),(442,'Can change ticket attachments',111,'change_ticketattachments'),(443,'Can delete ticket attachments',111,'delete_ticketattachments'),(444,'Can view ticket attachments',111,'view_ticketattachments'),(445,'Can add ticket replies',112,'add_ticketreplies'),(446,'Can change ticket replies',112,'change_ticketreplies'),(447,'Can delete ticket replies',112,'delete_ticketreplies'),(448,'Can view ticket replies',112,'view_ticketreplies'),(449,'Can add tickets',113,'add_tickets'),(450,'Can change tickets',113,'change_tickets'),(451,'Can delete tickets',113,'delete_tickets'),(452,'Can view tickets',113,'view_tickets'),(453,'Can add tickets pipe log',114,'add_ticketspipelog'),(454,'Can change tickets pipe log',114,'change_ticketspipelog'),(455,'Can delete tickets pipe log',114,'delete_ticketspipelog'),(456,'Can view tickets pipe log',114,'view_ticketspipelog'),(457,'Can add tickets predefined replies',115,'add_ticketspredefinedreplies'),(458,'Can change tickets predefined replies',115,'change_ticketspredefinedreplies'),(459,'Can delete tickets predefined replies',115,'delete_ticketspredefinedreplies'),(460,'Can view tickets predefined replies',115,'view_ticketspredefinedreplies'),(461,'Can add tickets priorities',116,'add_ticketspriorities'),(462,'Can change tickets priorities',116,'change_ticketspriorities'),(463,'Can delete tickets priorities',116,'delete_ticketspriorities'),(464,'Can view tickets priorities',116,'view_ticketspriorities'),(465,'Can add tickets status',117,'add_ticketsstatus'),(466,'Can change tickets status',117,'change_ticketsstatus'),(467,'Can delete tickets status',117,'delete_ticketsstatus'),(468,'Can view tickets status',117,'view_ticketsstatus'),(469,'Can add todos',118,'add_todos'),(470,'Can change todos',118,'change_todos'),(471,'Can delete todos',118,'delete_todos'),(472,'Can view todos',118,'view_todos'),(473,'Can add tracked mails',119,'add_trackedmails'),(474,'Can change tracked mails',119,'change_trackedmails'),(475,'Can delete tracked mails',119,'delete_trackedmails'),(476,'Can view tracked mails',119,'view_trackedmails'),(477,'Can add user auto login',120,'add_userautologin'),(478,'Can change user auto login',120,'change_userautologin'),(479,'Can delete user auto login',120,'delete_userautologin'),(480,'Can view user auto login',120,'view_userautologin'),(481,'Can add user meta',121,'add_usermeta'),(482,'Can change user meta',121,'change_usermeta'),(483,'Can delete user meta',121,'delete_usermeta'),(484,'Can view user meta',121,'view_usermeta'),(485,'Can add vault',124,'add_vault'),(486,'Can change vault',124,'change_vault'),(487,'Can delete vault',124,'delete_vault'),(488,'Can view vault',124,'view_vault'),(489,'Can add views tracking',125,'add_viewstracking'),(490,'Can change views tracking',125,'change_viewstracking'),(491,'Can delete views tracking',125,'delete_viewstracking'),(492,'Can view views tracking',125,'view_viewstracking'),(493,'Can add web to lead',126,'add_webtolead'),(494,'Can change web to lead',126,'change_webtolead'),(495,'Can delete web to lead',126,'delete_webtolead'),(496,'Can view web to lead',126,'view_webtolead'),(497,'Can add user profile',122,'add_userprofile'),(498,'Can change user profile',122,'change_userprofile'),(499,'Can delete user profile',122,'delete_userprofile'),(500,'Can view user profile',122,'view_userprofile'),(501,'Can add user token',123,'add_usertoken'),(502,'Can change user token',123,'change_usertoken'),(503,'Can delete user token',123,'delete_usertoken'),(504,'Can view user token',123,'view_usertoken'),(505,'Can add Token',127,'add_token'),(506,'Can change Token',127,'change_token'),(507,'Can delete Token',127,'delete_token'),(508,'Can view Token',127,'view_token'),(509,'Can add Token',128,'add_tokenproxy'),(510,'Can change Token',128,'change_tokenproxy'),(511,'Can delete Token',128,'delete_tokenproxy'),(512,'Can view Token',128,'view_tokenproxy'),(513,'Can add email template',129,'add_emailtemplate'),(514,'Can change email template',129,'change_emailtemplate'),(515,'Can delete email template',129,'delete_emailtemplate'),(516,'Can view email template',129,'view_emailtemplate'),(517,'Can add role',130,'add_role'),(518,'Can change role',130,'change_role'),(519,'Can delete role',130,'delete_role'),(520,'Can view role',130,'view_role'),(521,'Can add business',131,'add_business'),(522,'Can change business',131,'change_business'),(523,'Can delete business',131,'delete_business'),(524,'Can view business',131,'view_business'),(525,'Can add proposal',132,'add_proposal'),(526,'Can change proposal',132,'change_proposal'),(527,'Can delete proposal',132,'delete_proposal'),(528,'Can view proposal',132,'view_proposal'),(529,'Can add staff profile',133,'add_staffprofile'),(530,'Can change staff profile',133,'change_staffprofile'),(531,'Can delete staff profile',133,'delete_staffprofile'),(532,'Can view staff profile',133,'view_staffprofile'),(533,'Can add expense',134,'add_expense'),(534,'Can change expense',134,'change_expense'),(535,'Can delete expense',134,'delete_expense'),(536,'Can view expense',134,'view_expense'),(537,'Can add lead',135,'add_lead'),(538,'Can change lead',135,'change_lead'),(539,'Can delete lead',135,'delete_lead'),(540,'Can view lead',135,'view_lead'),(541,'Can add client',136,'add_client'),(542,'Can change client',136,'change_client'),(543,'Can delete client',136,'delete_client'),(544,'Can view client',136,'view_client'),(545,'Can add estimate',137,'add_estimate'),(546,'Can change estimate',137,'change_estimate'),(547,'Can delete estimate',137,'delete_estimate'),(548,'Can view estimate',137,'view_estimate'),(549,'Can add calendar event',138,'add_calendarevent'),(550,'Can change calendar event',138,'change_calendarevent'),(551,'Can delete calendar event',138,'delete_calendarevent'),(552,'Can view calendar event',138,'view_calendarevent'),(553,'Can add email campaign',139,'add_emailcampaign'),(554,'Can change email campaign',139,'change_emailcampaign'),(555,'Can delete email campaign',139,'delete_emailcampaign'),(556,'Can view email campaign',139,'view_emailcampaign'),(557,'Can add email recipient',140,'add_emailrecipient'),(558,'Can change email recipient',140,'change_emailrecipient'),(559,'Can delete email recipient',140,'delete_emailrecipient'),(560,'Can view email recipient',140,'view_emailrecipient'),(561,'Can add invoice',141,'add_invoice'),(562,'Can change invoice',141,'change_invoice'),(563,'Can delete invoice',141,'delete_invoice'),(564,'Can view invoice',141,'view_invoice'),(565,'Can add invoice reminder',142,'add_invoicereminder'),(566,'Can change invoice reminder',142,'change_invoicereminder'),(567,'Can delete invoice reminder',142,'delete_invoicereminder'),(568,'Can view invoice reminder',142,'view_invoicereminder'),(569,'Can add invoice task',143,'add_invoicetask'),(570,'Can change invoice task',143,'change_invoicetask'),(571,'Can delete invoice task',143,'delete_invoicetask'),(572,'Can view invoice task',143,'view_invoicetask'),(573,'Can add invoice email log',144,'add_invoiceemaillog'),(574,'Can change invoice email log',144,'change_invoiceemaillog'),(575,'Can delete invoice email log',144,'delete_invoiceemaillog'),(576,'Can view invoice email log',144,'view_invoiceemaillog'),(577,'Can add invoice payment',145,'add_invoicepayment'),(578,'Can change invoice payment',145,'change_invoicepayment'),(579,'Can delete invoice payment',145,'delete_invoicepayment'),(580,'Can view invoice payment',145,'view_invoicepayment'),(581,'Can add customer',146,'add_customer'),(582,'Can change customer',146,'change_customer'),(583,'Can delete customer',146,'delete_customer'),(584,'Can view customer',146,'view_customer'),(585,'Can add contact',147,'add_contact'),(586,'Can change contact',147,'change_contact'),(587,'Can delete contact',147,'delete_contact'),(588,'Can view contact',147,'view_contact'),(589,'Can add credit note reminder',149,'add_creditnotereminder'),(590,'Can change credit note reminder',149,'change_creditnotereminder'),(591,'Can delete credit note reminder',149,'delete_creditnotereminder'),(592,'Can view credit note reminder',149,'view_creditnotereminder'),(593,'Can add credit note',148,'add_creditnote'),(594,'Can change credit note',148,'change_creditnote'),(595,'Can delete credit note',148,'delete_creditnote'),(596,'Can view credit note',148,'view_creditnote'),(597,'Can add credit note task',150,'add_creditnotetask'),(598,'Can change credit note task',150,'change_creditnotetask'),(599,'Can delete credit note task',150,'delete_creditnotetask'),(600,'Can view credit note task',150,'view_creditnotetask'),(601,'Can add item',151,'add_item'),(602,'Can change item',151,'change_item'),(603,'Can delete item',151,'delete_item'),(604,'Can view item',151,'view_item'),(605,'Can add item group',152,'add_itemgroup'),(606,'Can change item group',152,'change_itemgroup'),(607,'Can delete item group',152,'delete_itemgroup'),(608,'Can view item group',152,'view_itemgroup'),(609,'Can add contract',153,'add_contract'),(610,'Can change contract',153,'change_contract'),(611,'Can delete contract',153,'delete_contract'),(612,'Can view contract',153,'view_contract'),(613,'Can add contract type',154,'add_contracttype'),(614,'Can change contract type',154,'change_contracttype'),(615,'Can delete contract type',154,'delete_contracttype'),(616,'Can view contract type',154,'view_contracttype'),(617,'Can add contract attachment',155,'add_contractattachment'),(618,'Can change contract attachment',155,'change_contractattachment'),(619,'Can delete contract attachment',155,'delete_contractattachment'),(620,'Can view contract attachment',155,'view_contractattachment'),(621,'Can add contract comment',156,'add_contractcomment'),(622,'Can change contract comment',156,'change_contractcomment'),(623,'Can delete contract comment',156,'delete_contractcomment'),(624,'Can view contract comment',156,'view_contractcomment'),(625,'Can add contract note',157,'add_contractnote'),(626,'Can change contract note',157,'change_contractnote'),(627,'Can delete contract note',157,'delete_contractnote'),(628,'Can view contract note',157,'view_contractnote'),(629,'Can add contract renewal',158,'add_contractrenewal'),(630,'Can change contract renewal',158,'change_contractrenewal'),(631,'Can delete contract renewal',158,'delete_contractrenewal'),(632,'Can view contract renewal',158,'view_contractrenewal'),(633,'Can add contract task',159,'add_contracttask'),(634,'Can change contract task',159,'change_contracttask'),(635,'Can delete contract task',159,'delete_contracttask'),(636,'Can view contract task',159,'view_contracttask'),(637,'Can add project',160,'add_project'),(638,'Can change project',160,'change_project'),(639,'Can delete project',160,'delete_project'),(640,'Can view project',160,'view_project'),(641,'Can add activity log',161,'add_activitylog'),(642,'Can change activity log',161,'change_activitylog'),(643,'Can delete activity log',161,'delete_activitylog'),(644,'Can view activity log',161,'view_activitylog'),(645,'Can add legacy business',166,'add_legacybusiness'),(646,'Can change legacy business',166,'change_legacybusiness'),(647,'Can delete legacy business',166,'delete_legacybusiness'),(648,'Can view legacy business',166,'view_legacybusiness'),(649,'Can add Client',162,'add_adminclient'),(650,'Can change Client',162,'change_adminclient'),(651,'Can delete Client',162,'delete_adminclient'),(652,'Can view Client',162,'view_adminclient'),(653,'Can add Contact',163,'add_admincontact'),(654,'Can change Contact',163,'change_admincontact'),(655,'Can delete Contact',163,'delete_admincontact'),(656,'Can view Contact',163,'view_admincontact'),(657,'Can add Knowledge Base Group',164,'add_knowledgebasegroupproxy'),(658,'Can change Knowledge Base Group',164,'change_knowledgebasegroupproxy'),(659,'Can delete Knowledge Base Group',164,'delete_knowledgebasegroupproxy'),(660,'Can view Knowledge Base Group',164,'view_knowledgebasegroupproxy'),(661,'Can add Knowledge Base Article',165,'add_knowledgebaseproxy'),(662,'Can change Knowledge Base Article',165,'change_knowledgebaseproxy'),(663,'Can delete Knowledge Base Article',165,'delete_knowledgebaseproxy'),(664,'Can view Knowledge Base Article',165,'view_knowledgebaseproxy'),(665,'Can add Staff',167,'add_staffproxy'),(666,'Can change Staff',167,'change_staffproxy'),(667,'Can delete Staff',167,'delete_staffproxy'),(668,'Can view Staff',167,'view_staffproxy');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$x51udr2uON7FS3XwKGhhI4$VHrhYTUr/jovNHxJfwcAw6OQTkpUQRIYdV0Mkx1aCXg=','2026-03-05 05:09:23.284230',1,'SahilDate','','','',1,1,'2026-02-03 09:42:21.190072'),(2,'pbkdf2_sha256$1200000$YeElvW94eTliXcvP7CBqJ7$F0QRIpChIJQbKfzSlhYTPPX6iVGh59ViCdlMSRspLIc=',NULL,0,'stark123@gmail.com','','','stark123@gmail.com',0,1,'2026-02-05 06:59:10.954121'),(5,'pbkdf2_sha256$1200000$7IbbrqGdPitzeqfnQdXffM$C4OTedpoJn6Uk8LWOiION89mp3iE/X8QNBg6Y6VifE8=',NULL,0,'jay@gmail.com','','','jay@gmail.com',0,1,'2026-02-05 09:17:14.371310'),(6,'pbkdf2_sha256$1200000$X0OaOJ9hPZpuJImq6W0ctG$TdjmXHdOhokmuWmBQFIhcf2fGG9LqY49mbZG4otCd24=',NULL,0,'kabir@gmail.com','','','kabir@gmail.com',0,1,'2026-02-09 10:35:37.740083'),(7,'pbkdf2_sha256$1200000$CKlTOkXsB6xfds833Ppuar$QZyTv2h/wapePyie4lHQ2NhwP6o5kEaHGJdTKjl9r/U=',NULL,0,'ranbir@gmail.com','','','ranbir@gmail.com',0,1,'2026-02-09 17:08:43.363400'),(8,'pbkdf2_sha256$1200000$dLG7QdZjFwoPfamIcN7tbp$MP38GEDR8P3BGEiefzF14OLT+NtNc9U4b7oSz5VUJKU=',NULL,0,'divya12@gmail.com','','','divya12@gmail.com',0,0,'2026-02-10 07:02:02.859942'),(9,'pbkdf2_sha256$1200000$lcWwpfdZnv0k4NfawtANye$//g1sKfCn+f9flQII4ICoa1M+jn91miisLOE+EJ+7Jo=',NULL,0,'divine10@gmail.com','','','divine10@gmail.com',0,1,'2026-02-10 12:18:15.262666'),(10,'pbkdf2_sha256$1200000$vlO20EObCliCQptcvnMvfz$Ys1+8SfbOglxYDbHIA4mmIbJDDPRMEKJM2D4IhZLBis=',NULL,0,'mikefoot@gmail.com','','','mikefoot@gmail.com',0,1,'2026-02-10 13:00:39.602914'),(11,'pbkdf2_sha256$1200000$dFpNnmA01CfyxgKLbOTxxD$hAAQSnxkGFLc1sbYEDQ2NHOeSC8bOpSZMrSSg6TuM3o=',NULL,0,'mahindramoto@gmail.com','','','mahindramoto@gmail.com',0,1,'2026-02-11 05:44:23.388824'),(12,'pbkdf2_sha256$1200000$Kjv2w0K8pO2RDFVj8rs6sF$eELK2qOUOC9U0JNSO3noB9BVjsey+6CvKrDvTrRWKdA=',NULL,0,'john90@gmail.com','','','john90@gmail.com',0,0,'2026-02-11 07:08:53.082472'),(13,'pbkdf2_sha256$1200000$BFpczWKpokM8mqqTcPfA5n$U6W7pz5Fh92zgxFtNstpiKMqHE87l6+3pUU8iOXETtI=',NULL,0,'steve11@gmail.com','','','steve11@gmail.com',0,1,'2026-02-11 07:24:14.051078'),(14,'pbkdf2_sha256$1200000$0wa7wUfPN5udnwwKGv2R3C$lIPnzTzXI52dbQ3753I+MQ+yI8P/xSfwrjrDcgjWzMM=',NULL,0,'test@gmail.com','','','test@gmail.com',0,0,'2026-02-11 10:23:57.633864'),(15,'pbkdf2_sha256$1200000$3Z62XCJR2ESeLGdu4aQEdI$9IYlIQuE/W+ssmBZLqxrMWm8zx0BolUhhJfNPpz2S0E=',NULL,0,'test1@gmail.com','','','test1@gmail.com',0,0,'2026-02-11 10:35:23.670647'),(16,'pbkdf2_sha256$1200000$jCIxldykwmHhmN4x1eIbru$/6EJ7xfcVWO/YncHW2GCCNIS3rxtJGPufq8Fc3/B9rw=',NULL,0,'user@gmail.com','','','user@gmail.com',0,0,'2026-02-11 10:55:13.277297'),(17,'pbkdf2_sha256$1200000$wpsjm61sj3a8Cpqtm5yqgW$HPq1n9w0tZ156hGetTRHj14X2V8j2dxaXGSkelbzL88=',NULL,0,'user1@gmail.com','','','user1@gmail.com',0,0,'2026-02-11 11:09:39.674892'),(18,'pbkdf2_sha256$1200000$JwrxfdSm6m3ZaHLybSUEvi$P/f+NKGYGyzuRn3/nrJP/DW1x9h361gDkB5ZV8uaVz8=',NULL,0,'business@gmail.com','','','business@gmail.com',0,1,'2026-02-11 11:27:40.316980'),(19,'pbkdf2_sha256$1200000$heZ3BcMI4BTE9Wfr7abfO3$zKd1wAD5pxWE2SNzwqqXn5h4wQntblO47+DhAqOIiC4=',NULL,0,'parth07@gmail.com','','','parth07@gmail.com',0,1,'2026-02-13 06:01:11.861768'),(20,'pbkdf2_sha256$1200000$4AGZqEQJtOPW9mSTgFh3io$pptoFp31OxYg8ogd8B/84yG85cSZVhBg/YqpyhKZvgw=',NULL,0,'krishna01@gmail.com','','','krishna01@gmail.com',0,1,'2026-02-16 05:26:43.538682'),(21,'pbkdf2_sha256$1200000$Z7uUSdALAD17XDy25kRuV0$/9uDIQW/OINi4xx7sog4zYsrp3eKUVwHvmr4qaHM/Rs=',NULL,0,'veeru@gmail.com','','','veeru@gmail.com',0,1,'2026-02-19 20:01:53.998600'),(28,'pbkdf2_sha256$1200000$P0IR2WeDY6rmJklQsWOC1w$q771DlvFhCcHIC3pD4MYAnJW0CddEFvE3MAYb/ISPgQ=',NULL,0,'nancy@gmail.com','','','nancy@gmail.com',0,1,'2026-02-27 14:31:51.277580'),(33,'pbkdf2_sha256$1200000$rHOEsxHpQlmcQwkbFLenvo$UPF0NJwB/8qVYm2VF2xtY//PypRpG10c+n4eSvMI1sE=',NULL,0,'21bca231@vtcbb.edu.in','','','21bca231@vtcbb.edu.in',0,1,'2026-02-28 09:43:37.713267'),(36,'pbkdf2_sha256$1200000$3QVXNx0Ozeg8avSCo4WLlx$VEr5pkOCtV8ZPR6b6HSHkkagN/HplSCG99+PWbPuGeg=',NULL,0,'jay01@gmail.com','','','jay01@gmail.com',0,1,'2026-03-11 11:42:47.461208');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_activity_log`
--

DROP TABLE IF EXISTS `core_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_activity_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_activity_log_user_id_3c616f6c_fk_auth_user_id` (`user_id`),
  KEY `core_activity_log_created_at_ffcf42b6` (`created_at`),
  CONSTRAINT `core_activity_log_user_id_3c616f6c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_activity_log`
--

LOCK TABLES `core_activity_log` WRITE;
/*!40000 ALTER TABLE `core_activity_log` DISABLE KEYS */;
INSERT INTO `core_activity_log` VALUES (1,'Staff Login [Email: krishna01@gmail.com]','2026-03-17 11:42:32.359698',20),(2,'Staff Login [Email: krishna01@gmail.com]','2026-03-18 05:03:56.594627',20),(3,'Staff Login [Email: krishna01@gmail.com]','2026-03-18 07:04:43.071462',20),(4,'Staff Login [Email: krishna01@gmail.com]','2026-03-18 09:06:06.309805',20),(5,'Staff Login [Email: krishna01@gmail.com]','2026-03-18 11:16:27.776493',20);
/*!40000 ALTER TABLE `core_activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_business`
--

DROP TABLE IF EXISTS `core_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_business` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `db_name` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `core_business_email_7d23db71_uniq` (`email`),
  UNIQUE KEY `core_business_db_name_9948327e_uniq` (`db_name`),
  KEY `core_business_created_at_6fcad137` (`created_at`),
  KEY `core_business_is_approved_af231d2a` (`is_approved`),
  KEY `core_busine_email_6f5879_idx` (`email`,`is_approved`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_business`
--

LOCK TABLES `core_business` WRITE;
/*!40000 ALTER TABLE `core_business` DISABLE KEYS */;
INSERT INTO `core_business` VALUES (1,'https://bananasit.com/','ts0279190@gmail.com','Sahil',1,'ms_crm_https://bananasit.com/','2026-02-03 06:38:35.571495'),(6,'https://starkindustries.com/','stark123@gmail.com','Stark',1,'ms_crm_https://starkindustries.com/','2026-02-05 06:59:12.433718'),(7,'https://jayind.com/','jay@gmail.com','jay',1,'ms_crm_https://jayind.com/','2026-02-05 09:17:16.961883'),(8,'https://kabirind.com/','kabir@gmail.com','kabir',1,'ms_crm_8','2026-02-09 10:35:39.295188'),(9,'https://rkfasion.com/','ranbir@gmail.com','Ranbir',1,NULL,'2026-02-09 17:08:45.186504'),(10,'https://divyanews.com/','divya12@gmail.com','Divya Bhaskar',0,NULL,'2026-02-10 07:02:05.731282'),(11,'https://divines.com/','divine10@gmail.com','Divine',1,NULL,'2026-02-10 12:18:16.659500'),(12,'https://mikefootweares.com/','mikefoot@gmail.com','Mickal',1,NULL,'2026-02-10 13:00:42.173403'),(13,'http://mahindramotors.com/','mahindramoto@gmail.com','Mahindra',1,NULL,'2026-02-11 05:44:26.034266'),(14,'https://applesit.com/','john90@gmail.com','John',0,NULL,'2026-02-11 07:08:54.400102'),(15,'https://steve.com/','steve11@gmail.com','Steve',1,NULL,'2026-02-11 07:24:15.340653'),(20,'Business','business@gmail.com','Sahil',1,NULL,'2026-02-11 11:27:41.254530'),(21,'https://parthind.com/','parth07@gmail.com','parth',1,NULL,'2026-02-13 06:01:13.163747'),(22,'https://helloworld.com/','krishna01@gmail.com','Krishna',1,NULL,'2026-02-16 05:26:46.282177'),(23,'https://pinaplesit.com/','veeru@gmail.com','Veeru',1,NULL,'2026-02-19 20:01:55.346867'),(24,'https://usersit.com/','sahildate92@gmail.com','User',1,NULL,'2026-02-27 05:42:51.638818'),(30,'https://petshop.com/','nancy@gmail.com','Nancy',1,NULL,'2026-02-27 14:31:53.927892'),(35,'https://foodspot.com/','21bca231@vtcbb.edu.in','Sahi Date',1,NULL,'2026-02-28 09:43:39.047923'),(38,'Applesit','jay01@gmail.com','jay',1,NULL,'2026-03-11 11:42:49.960131');
/*!40000 ALTER TABLE `core_business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_calendarevent`
--

DROP TABLE IF EXISTS `core_calendarevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_calendarevent` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `color` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_calendarevent`
--

LOCK TABLES `core_calendarevent` WRITE;
/*!40000 ALTER TABLE `core_calendarevent` DISABLE KEYS */;
INSERT INTO `core_calendarevent` VALUES (1,'Meeting with Client','2026-03-17','#0e4ee1'),(2,'Get together and also to manage the event on words.','2026-05-14','#ec0909');
/*!40000 ALTER TABLE `core_calendarevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_client`
--

DROP TABLE IF EXISTS `core_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_client` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL,
  `vat_number` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `default_language` varchar(50) DEFAULT NULL,
  `billing_address` longtext,
  `shipping_address` longtext,
  `created_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_client`
--

LOCK TABLES `core_client` WRITE;
/*!40000 ALTER TABLE `core_client` DISABLE KEYS */;
INSERT INTO `core_client` VALUES (1,'Softinfotech','ATU12345678','9512839679','Surat, Gujarat','Gujarat','394210','India','3','English','','','2026-02-24 11:12:51.587987',1),(2,'infoTech','ATU12345678','9512839679','Surat, Gujarat','Gujarat','394210','India','3','English','Plot no. 72 Gayatri Society Opp. English Medium School Udhna, Surat, Gujarat.','33-1/26, Shop No. 3, Khan Saheb Ni Wadi, Ambika Niketan, Athwalines, Surat, Gujarat.','2026-02-24 11:49:09.590386',1),(3,'Tesla','GB123456789','9512839679','Surat, Gujarat','Gujarat','394210','India','3','English','Plot no. 72 Gayatri Society Opp. English Medium School Udhna, Surat, Gujarat.','D-19 Bhairavngar Nr, Bhairavnath temple bhestan, surat, gujarat.','2026-03-06 07:30:10.843539',1),(4,'Banana Infotech','GB123456789','9512839679','Surat, Gujarat','Gujarat','394210','India','3','English','Plot no. 72 Gayatri Society Opp. English Medium School Udhna, Surat, Gujarat.','D-19 Bhairavnagar Nr. Bhairavnath temple Bhestan, Surat, Gujarat.','2026-03-11 06:23:24.957719',1),(5,'Magnyte Solutions',NULL,'9512839679','','','','',NULL,NULL,'','','2026-03-13 09:08:22.736127',1),(6,'bananasit',NULL,'9512839679','','','','',NULL,NULL,'','','2026-03-13 09:10:18.920717',1);
/*!40000 ALTER TABLE `core_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contact`
--

DROP TABLE IF EXISTS `core_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstname` varchar(191) NOT NULL,
  `lastname` varchar(191) NOT NULL,
  `email` varchar(254) NOT NULL,
  `company` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `direction` varchar(10) DEFAULT NULL,
  `invoice_emails` tinyint(1) NOT NULL,
  `estimate_emails` tinyint(1) NOT NULL,
  `credit_note_emails` tinyint(1) NOT NULL,
  `contract_emails` tinyint(1) NOT NULL,
  `task_emails` tinyint(1) NOT NULL,
  `project_emails` tinyint(1) NOT NULL,
  `ticket_emails` tinyint(1) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contact`
--

LOCK TABLES `core_contact` WRITE;
/*!40000 ALTER TABLE `core_contact` DISABLE KEYS */;
INSERT INTO `core_contact` VALUES (1,'Sahilraj','Date','sahildate@gmail.com','Magnyte Solutions','9512839679','Manager','sahilraj@123',1,1,NULL,1,1,0,1,0,0,0,'2026-03-13 09:08:22.739765','2026-03-13 09:08:22.740311'),(2,'Sahil','Date','ts0279190@gmail.com','bananasit','9512839679','CEO','',0,0,NULL,0,0,0,0,0,0,0,'2026-03-13 09:10:18.923469','2026-03-13 09:10:18.923745'),(3,'Krishna','Patel','krishna01@gmail.com','Softinfotech','9512839679','Snr.Manager','Krishna@01',1,1,NULL,1,1,0,1,0,0,0,'2026-03-13 11:27:43.572134','2026-03-13 11:27:43.573201'),(4,'Elon','Musk','elonmusk@gmail.com','Tesla','9765432102','CEO','Elon@123',1,1,NULL,1,1,0,1,0,0,0,'2026-03-13 11:29:03.868969','2026-03-13 11:29:03.869320'),(5,'Ronak','Panchal','ronak@gmail.com','Banana Infotech','1236547895','CEO','ronak@123',1,1,NULL,1,1,0,1,0,0,0,'2026-03-13 11:30:05.112622','2026-03-13 11:30:05.113046'),(6,'Shubham','Patel','sbhubham@gmail.com','infoTech','9876543215','Employee','shubham@123',1,1,NULL,1,1,0,1,0,0,0,'2026-03-13 11:33:18.525196','2026-03-13 11:33:18.525508');
/*!40000 ALTER TABLE `core_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contract`
--

DROP TABLE IF EXISTS `core_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_contract` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `contract_type` varchar(100) DEFAULT NULL,
  `contract_value` decimal(12,2) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `description` longtext,
  `hide_from_customer` tinyint(1) NOT NULL,
  `is_trashed` tinyint(1) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `customer_ref_id` bigint DEFAULT NULL,
  `content` longtext,
  PRIMARY KEY (`id`),
  KEY `core_contract_customer_ref_id_a62b7ac4_fk_core_client_id` (`customer_ref_id`),
  CONSTRAINT `core_contract_customer_ref_id_a62b7ac4_fk_core_client_id` FOREIGN KEY (`customer_ref_id`) REFERENCES `core_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contract`
--

LOCK TABLES `core_contract` WRITE;
/*!40000 ALTER TABLE `core_contract` DISABLE KEYS */;
INSERT INTO `core_contract` VALUES (1,'Magnyte Solutions','SmartTech','Service',311603.00,'2026-02-20','2026-04-20',NULL,'Providing the service of technical support.',0,0,'Draft','2026-03-16 05:34:46.805444',5,NULL),(2,'Magnyte Solutions','SmartTech','Service',311603.00,'2026-02-20','2026-04-20',NULL,'Providing the service of technical support.',0,0,'Draft','2026-03-16 05:35:45.191146',5,NULL),(3,'Magnyte Solutions','SmartTech','Service',311603.00,'2026-02-20','2026-04-20',NULL,'Providing the service of technical support.',0,1,'Draft','2026-03-16 05:35:46.841949',5,NULL),(4,'Magnyte Solutions','SmartTech','Service',311603.00,'2026-02-20','2026-04-20',NULL,'Providing the Services',0,0,'Draft','2026-03-16 06:04:28.725022',5,'Providing the services to tech support.'),(5,'infoTech','SmartTech','Support',150000.00,'2026-02-20','2026-04-20',NULL,'Tech Supports.',0,0,'Draft','2026-03-16 06:07:29.031982',2,NULL);
/*!40000 ALTER TABLE `core_contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contract_attachment`
--

DROP TABLE IF EXISTS `core_contract_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_contract_attachment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `uploaded_by` varchar(191) DEFAULT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `contract_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_contract_attach_contract_id_a1d19277_fk_core_cont` (`contract_id`),
  CONSTRAINT `core_contract_attach_contract_id_a1d19277_fk_core_cont` FOREIGN KEY (`contract_id`) REFERENCES `core_contract` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contract_attachment`
--

LOCK TABLES `core_contract_attachment` WRITE;
/*!40000 ALTER TABLE `core_contract_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_contract_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contract_comment`
--

DROP TABLE IF EXISTS `core_contract_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_contract_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` longtext NOT NULL,
  `created_by` varchar(191) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `contract_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_contract_comment_contract_id_ae77115e_fk_core_contract_id` (`contract_id`),
  CONSTRAINT `core_contract_comment_contract_id_ae77115e_fk_core_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `core_contract` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contract_comment`
--

LOCK TABLES `core_contract_comment` WRITE;
/*!40000 ALTER TABLE `core_contract_comment` DISABLE KEYS */;
INSERT INTO `core_contract_comment` VALUES (1,'Good as providing supports','krishna01@gmail.com','2026-03-16 06:08:26.027362',5);
/*!40000 ALTER TABLE `core_contract_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contract_note`
--

DROP TABLE IF EXISTS `core_contract_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_contract_note` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `note` longtext NOT NULL,
  `created_by` varchar(191) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `contract_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_contract_note_contract_id_a2cfc2fc_fk_core_contract_id` (`contract_id`),
  CONSTRAINT `core_contract_note_contract_id_a2cfc2fc_fk_core_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `core_contract` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contract_note`
--

LOCK TABLES `core_contract_note` WRITE;
/*!40000 ALTER TABLE `core_contract_note` DISABLE KEYS */;
INSERT INTO `core_contract_note` VALUES (1,'Goode for taking Support','krishna01@gmail.com','2026-03-16 06:10:56.407924',5);
/*!40000 ALTER TABLE `core_contract_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contract_renewal`
--

DROP TABLE IF EXISTS `core_contract_renewal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_contract_renewal` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `old_start_date` date DEFAULT NULL,
  `new_start_date` date DEFAULT NULL,
  `old_end_date` date DEFAULT NULL,
  `new_end_date` date DEFAULT NULL,
  `old_value` decimal(12,2) DEFAULT NULL,
  `new_value` decimal(12,2) DEFAULT NULL,
  `notes` longtext,
  `renewed_by` varchar(191) DEFAULT NULL,
  `renewed_at` datetime(6) NOT NULL,
  `contract_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_contract_renewal_contract_id_6b4685d8_fk_core_contract_id` (`contract_id`),
  CONSTRAINT `core_contract_renewal_contract_id_6b4685d8_fk_core_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `core_contract` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contract_renewal`
--

LOCK TABLES `core_contract_renewal` WRITE;
/*!40000 ALTER TABLE `core_contract_renewal` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_contract_renewal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contract_task`
--

DROP TABLE IF EXISTS `core_contract_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_contract_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL,
  `description` longtext,
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `priority` varchar(20) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `is_billable` tinyint(1) NOT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `created_by` varchar(191) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `contract_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_contract_task_contract_id_6f5868a8_fk_core_contract_id` (`contract_id`),
  CONSTRAINT `core_contract_task_contract_id_6f5868a8_fk_core_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `core_contract` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contract_task`
--

LOCK TABLES `core_contract_task` WRITE;
/*!40000 ALTER TABLE `core_contract_task` DISABLE KEYS */;
INSERT INTO `core_contract_task` VALUES (1,'Contract Overview','Items can renew with Invoices updates','2026-03-16','2026-05-21','Medium',1,1,'','krishna01@gmail.com','2026-03-16 06:10:34.701290',5);
/*!40000 ALTER TABLE `core_contract_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contract_type`
--

DROP TABLE IF EXISTS `core_contract_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_contract_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contract_type`
--

LOCK TABLES `core_contract_type` WRITE;
/*!40000 ALTER TABLE `core_contract_type` DISABLE KEYS */;
INSERT INTO `core_contract_type` VALUES (1,'Service','2026-03-16 05:30:47.992468'),(2,'Support','2026-03-16 05:30:47.994285');
/*!40000 ALTER TABLE `core_contract_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_creditnote`
--

DROP TABLE IF EXISTS `core_creditnote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_creditnote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `deleted_customer_name` varchar(255) DEFAULT NULL,
  `number` int unsigned NOT NULL,
  `prefix` varchar(20) NOT NULL,
  `number_format` varchar(30) DEFAULT NULL,
  `datecreated` datetime(6) NOT NULL,
  `date` date NOT NULL,
  `duedate` date DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `total_tax` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `adjustment` decimal(12,2) NOT NULL,
  `addedfrom` int DEFAULT NULL,
  `status` int NOT NULL,
  `clientnote` longtext,
  `adminnote` longtext,
  `terms` longtext,
  `currency` varchar(20) DEFAULT NULL,
  `discount_percent` decimal(12,2) NOT NULL,
  `discount_total` decimal(12,2) NOT NULL,
  `discount_type` varchar(30) DEFAULT NULL,
  `billing_street` varchar(255) DEFAULT NULL,
  `billing_city` varchar(100) DEFAULT NULL,
  `billing_state` varchar(100) DEFAULT NULL,
  `billing_zip` varchar(30) DEFAULT NULL,
  `billing_country` varchar(100) DEFAULT NULL,
  `shipping_street` varchar(255) DEFAULT NULL,
  `shipping_city` varchar(100) DEFAULT NULL,
  `shipping_state` varchar(100) DEFAULT NULL,
  `shipping_zip` varchar(30) DEFAULT NULL,
  `shipping_country` varchar(100) DEFAULT NULL,
  `include_shipping` tinyint(1) NOT NULL,
  `show_shipping_on_credit_note` tinyint(1) NOT NULL,
  `show_quantity_as` varchar(30) DEFAULT NULL,
  `email_signature` longtext,
  `items` json NOT NULL,
  `client_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_creditnote_client_id_2e62174f_fk_core_client_id` (`client_id`),
  CONSTRAINT `core_creditnote_client_id_2e62174f_fk_core_client_id` FOREIGN KEY (`client_id`) REFERENCES `core_client` (`id`),
  CONSTRAINT `core_creditnote_chk_1` CHECK ((`number` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_creditnote`
--

LOCK TABLES `core_creditnote` WRITE;
/*!40000 ALTER TABLE `core_creditnote` DISABLE KEYS */;
INSERT INTO `core_creditnote` VALUES (2,'Banana Infotech',1,'CN-','','2026-03-13 09:57:40.162735','2026-03-13','2026-03-20',NULL,'Reference by compony to traveling from office to visiting site',150000.00,7500.00,157500.00,0.00,0,1,'Happy with Purchase ','Assadnlsdjps','Approved By Magnyte Solution ','INR',0.00,0.00,'Before Tax','Plot no. 72 Gayatri Society Opp. English Medium School Udhna, Surat, Gujarat.','Surat, Gujarat','Gujarat','394210','India','D-19 Bhairannagar Nr. Bhairavnath Temple Bhestan, Surat Gujarat.','Surat','Gujarat','394210','India',0,0,'Qty','','[{\"qty\": 1, \"tax\": \"5%\", \"rate\": 150000, \"amount\": 150000, \"description\": \"T.V\", \"longDescription\": \"Smart Tech\"}]',4);
/*!40000 ALTER TABLE `core_creditnote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_creditnote_reminder`
--

DROP TABLE IF EXISTS `core_creditnote_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_creditnote_reminder` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext,
  `date` datetime(6) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `credit_note_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_creditnote_remi_credit_note_id_ce2d502e_fk_core_cred` (`credit_note_id`),
  CONSTRAINT `core_creditnote_remi_credit_note_id_ce2d502e_fk_core_cred` FOREIGN KEY (`credit_note_id`) REFERENCES `core_creditnote` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_creditnote_reminder`
--

LOCK TABLES `core_creditnote_reminder` WRITE;
/*!40000 ALTER TABLE `core_creditnote_reminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_creditnote_reminder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_creditnote_task`
--

DROP TABLE IF EXISTS `core_creditnote_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_creditnote_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext,
  `date` datetime(6) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `credit_note_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_creditnote_task_credit_note_id_0a6f61c7_fk_core_cred` (`credit_note_id`),
  CONSTRAINT `core_creditnote_task_credit_note_id_0a6f61c7_fk_core_cred` FOREIGN KEY (`credit_note_id`) REFERENCES `core_creditnote` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_creditnote_task`
--

LOCK TABLES `core_creditnote_task` WRITE;
/*!40000 ALTER TABLE `core_creditnote_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_creditnote_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_customer`
--

DROP TABLE IF EXISTS `core_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL,
  `primary_contact` varchar(255) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customer`
--

LOCK TABLES `core_customer` WRITE;
/*!40000 ALTER TABLE `core_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_emailcampaign`
--

DROP TABLE IF EXISTS `core_emailcampaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_emailcampaign` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_emailcampaign`
--

LOCK TABLES `core_emailcampaign` WRITE;
/*!40000 ALTER TABLE `core_emailcampaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_emailcampaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_emailrecipient`
--

DROP TABLE IF EXISTS `core_emailrecipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_emailrecipient` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `is_sent` tinyint(1) NOT NULL,
  `sent_at` datetime(6) DEFAULT NULL,
  `campaign_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_emailrecipient_campaign_id_48ff735c_fk_core_emai` (`campaign_id`),
  CONSTRAINT `core_emailrecipient_campaign_id_48ff735c_fk_core_emai` FOREIGN KEY (`campaign_id`) REFERENCES `core_emailcampaign` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_emailrecipient`
--

LOCK TABLES `core_emailrecipient` WRITE;
/*!40000 ALTER TABLE `core_emailrecipient` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_emailrecipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_emailtemplate`
--

DROP TABLE IF EXISTS `core_emailtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_emailtemplate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `module` varchar(50) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `language` varchar(20) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_emailtemplate_module_slug_language_bf4e2407_uniq` (`module`,`slug`,`language`),
  KEY `core_emailt_module_211275_idx` (`module`,`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_emailtemplate`
--

LOCK TABLES `core_emailtemplate` WRITE;
/*!40000 ALTER TABLE `core_emailtemplate` DISABLE KEYS */;
INSERT INTO `core_emailtemplate` VALUES (1,'client','new-client-created','english','Welcome Client','New client created successfully'),(2,'ticket','ticket-reply','english','Ticket Reply','You have a new ticket reply');
/*!40000 ALTER TABLE `core_emailtemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_estimate`
--

DROP TABLE IF EXISTS `core_estimate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_estimate` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `estimate_number` varchar(100) NOT NULL,
  `customer_id` bigint NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `total_tax` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `status` varchar(100) NOT NULL,
  `items` json NOT NULL DEFAULT (_utf8mb4'[]'),
  PRIMARY KEY (`id`),
  KEY `core_estimate_customer_id_33c8c666` (`customer_id`),
  CONSTRAINT `core_estimate_customer_id_33c8c666_fk_core_client_id` FOREIGN KEY (`customer_id`) REFERENCES `core_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_estimate`
--

LOCK TABLES `core_estimate` WRITE;
/*!40000 ALTER TABLE `core_estimate` DISABLE KEYS */;
INSERT INTO `core_estimate` VALUES (2,'1623-1021',2,630.00,0.00,'2026-03-03','2026-07-15','Draft','[]'),(3,'1623-1021',2,72000.00,0.00,'2026-03-05','2026-05-21','Draft','[]'),(4,'1021-1623',3,22500.00,0.00,'2026-03-06','2026-05-29','Draft','[]'),(5,'2316-2112',4,14850.00,0.00,'2026-03-11','2026-05-29','Draft','[]');
/*!40000 ALTER TABLE `core_estimate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_expense`
--

DROP TABLE IF EXISTS `core_expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_expense` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `customer` varchar(255) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `currency` varchar(20) NOT NULL,
  `note` longtext,
  `reference` varchar(255) DEFAULT NULL,
  `repeat_every` varchar(50) DEFAULT NULL,
  `tax1` varchar(50) DEFAULT NULL,
  `tax2` varchar(50) DEFAULT NULL,
  `customer_ref_id` bigint DEFAULT NULL,
  `invoice_ref_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_expense_customer_ref_id_beb93da2_fk_core_client_id` (`customer_ref_id`),
  KEY `core_expense_invoice_ref_id_4a90cace_fk_core_invoice_id` (`invoice_ref_id`),
  CONSTRAINT `core_expense_customer_ref_id_beb93da2_fk_core_client_id` FOREIGN KEY (`customer_ref_id`) REFERENCES `core_client` (`id`),
  CONSTRAINT `core_expense_invoice_ref_id_4a90cace_fk_core_invoice_id` FOREIGN KEY (`invoice_ref_id`) REFERENCES `core_invoice` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_expense`
--

LOCK TABLES `core_expense` WRITE;
/*!40000 ALTER TABLE `core_expense` DISABLE KEYS */;
INSERT INTO `core_expense` VALUES (1,'sanjay','Office',350.00,'2026-02-21','Customer A','Bank','Not Invoiced','2026-02-21 17:46:31.128031','INR ₹',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'sanjay','Office',350.00,'2026-02-21','Customer A','Bank','Not Invoiced','2026-02-21 17:46:31.128031','INR ₹',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'sanjay','Office',350.00,'2026-02-21','Customer A','Bank','Not Invoiced','2026-02-21 17:46:31.128031','INR ₹',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'sanjay','Office',350.00,'2026-02-21','Customer A','Bank','Not Invoiced','2026-02-21 17:46:31.128031','INR ₹',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Dev','Travel',500.00,'2026-02-22','Customer A','Cash','Not Invoiced','2026-02-21 18:08:51.420900','INR ₹','Prompt pdf','Reference by compony to traveling from office to visiting site','Monthly','5%','No Tax',NULL,NULL),(6,'steve','Food',1000.00,'2026-02-24','Customer B','Bank','Not Invoiced','2026-02-25 05:43:50.271715','USD $','This is monthly budget summery','Reference by compony to traveling from office to visiting site','Monthly','5%','10%',NULL,NULL);
/*!40000 ALTER TABLE `core_expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_invoice`
--

DROP TABLE IF EXISTS `core_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_invoice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `customer_id` bigint NOT NULL,
  `due_date` date NOT NULL,
  `invoice_date` date NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_mode` varchar(20) NOT NULL,
  `reference_estimate_id` bigint DEFAULT NULL,
  `items` json NOT NULL DEFAULT (_utf8mb4'[]'),
  PRIMARY KEY (`id`),
  KEY `core_invoice_customer_id_53184093_fk_core_client_id` (`customer_id`),
  KEY `core_invoice_reference_estimate_id_ebfca259_fk_core_estimate_id` (`reference_estimate_id`),
  CONSTRAINT `core_invoice_customer_id_53184093_fk_core_client_id` FOREIGN KEY (`customer_id`) REFERENCES `core_client` (`id`),
  CONSTRAINT `core_invoice_reference_estimate_id_ebfca259_fk_core_estimate_id` FOREIGN KEY (`reference_estimate_id`) REFERENCES `core_estimate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_invoice`
--

LOCK TABLES `core_invoice` WRITE;
/*!40000 ALTER TABLE `core_invoice` DISABLE KEYS */;
INSERT INTO `core_invoice` VALUES (4,'003','Unpaid','2026-03-06 06:43:11.505025',3,'2026-05-29','2026-03-06',599.00,0.00,541.00,'Auto',NULL,'[]'),(7,'002','Unpaid','2026-03-06 09:36:21.021249',2,'2026-07-29','2026-03-06',400.00,0.00,361.00,'Auto',NULL,'[]'),(8,'002','Unpaid','2026-03-09 16:12:59.545257',3,'2026-05-20','2026-03-09',150000.00,0.00,148501.00,'Bank',NULL,'[]'),(9,'INV-1623-1021','Unpaid','2026-03-11 09:58:30.225173',2,'2026-07-15','2026-03-03',630.00,0.00,630.00,'Bank',2,'[]'),(10,'INV-1623-1021','Unpaid','2026-03-11 09:58:30.242387',2,'2026-05-21','2026-03-05',72000.00,0.00,72000.00,'Bank',3,'[]'),(11,'INV-1021-1623','Unpaid','2026-03-11 09:58:30.249047',3,'2026-05-29','2026-03-06',22500.00,0.00,22500.00,'Bank',4,'[]'),(12,'INV-2316-2112','Unpaid','2026-03-11 09:58:30.255158',4,'2026-05-29','2026-03-11',14850.00,0.00,14850.00,'Bank',5,'[]'),(13,'INV-CON-4','Draft','2026-03-16 06:06:47.263765',5,'2026-03-16','2026-03-16',311603.00,0.00,311603.00,'Null',NULL,'[{\"qty\": 1, \"rate\": 311603.0, \"description\": \"SmartTech\", \"long_description\": \"Providing the services to tech support.\"}]'),(14,'INV-CON-5','Unpaid','2026-03-16 06:11:04.469690',2,'2026-03-16','2026-03-16',150000.00,0.00,150000.00,'Null',NULL,'[{\"qty\": 1, \"rate\": 150000.0, \"description\": \"SmartTech\", \"long_description\": \"Tech Supports.\"}]');
/*!40000 ALTER TABLE `core_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_invoiceemaillog`
--

DROP TABLE IF EXISTS `core_invoiceemaillog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_invoiceemaillog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `message` longtext NOT NULL,
  `sent_at` datetime(6) NOT NULL,
  `invoice_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_invoiceemaillog_invoice_id_da411941_fk_core_invoice_id` (`invoice_id`),
  CONSTRAINT `core_invoiceemaillog_invoice_id_da411941_fk_core_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `core_invoice` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_invoiceemaillog`
--

LOCK TABLES `core_invoiceemaillog` WRITE;
/*!40000 ALTER TABLE `core_invoiceemaillog` DISABLE KEYS */;
INSERT INTO `core_invoiceemaillog` VALUES (1,'sahildate92@gmail.com','Dear Client,\n\nInvoice Number: 001\nDue Date: 2026-05-29\n\nKind Regards,\nCRM Team','2026-03-06 17:20:56.627169',7),(2,'ts0279190@gmail.com','Dear Client,\n\nInvoice Number: 001\nDue Date: 2026-05-29\n\nKind Regards,\nCRM Team','2026-03-06 17:27:47.864652',7),(3,'ts0279190@gmail.com','Dear Client,\n\nInvoice Number: 001\nDue Date: 2026-05-29\n\nKind Regards,\nCRM Team','2026-03-06 17:29:54.813567',7),(4,'ts0279190@gmail.com','Dear Client,\n\nInvoice Number: 001\nDue Date: 2026-05-29\n\nKind Regards,\nCRM Team','2026-03-06 17:48:30.997526',7);
/*!40000 ALTER TABLE `core_invoiceemaillog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_invoicepayment`
--

DROP TABLE IF EXISTS `core_invoicepayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_invoicepayment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_mode` varchar(20) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `invoice_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_invoicepayment_invoice_id_ef4798c7_fk_core_invoice_id` (`invoice_id`),
  CONSTRAINT `core_invoicepayment_invoice_id_ef4798c7_fk_core_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `core_invoice` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_invoicepayment`
--

LOCK TABLES `core_invoicepayment` WRITE;
/*!40000 ALTER TABLE `core_invoicepayment` DISABLE KEYS */;
INSERT INTO `core_invoicepayment` VALUES (1,'Auto','Auto-4',541.00,'2026-03-10',4),(2,'Auto','Auto-7',361.00,'2026-03-10',7),(3,'Bank','Bank-8',148501.00,'2026-03-10',8),(4,'Bank','Bank-9',630.00,'2026-03-11',9),(5,'Bank','Bank-10',72000.00,'2026-03-11',10),(6,'Bank','Bank-11',22500.00,'2026-03-11',11),(7,'Bank','Bank-12',14850.00,'2026-03-11',12),(8,'Null','Null-13',311603.00,'2026-03-16',13),(9,'Null','Null-14',150000.00,'2026-03-16',14);
/*!40000 ALTER TABLE `core_invoicepayment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_invoicereminder`
--

DROP TABLE IF EXISTS `core_invoicereminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_invoicereminder` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `date` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `invoice_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_invoicereminder_invoice_id_1ef3f115_fk_core_invoice_id` (`invoice_id`),
  CONSTRAINT `core_invoicereminder_invoice_id_1ef3f115_fk_core_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `core_invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_invoicereminder`
--

LOCK TABLES `core_invoicereminder` WRITE;
/*!40000 ALTER TABLE `core_invoicereminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_invoicereminder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_invoicetask`
--

DROP TABLE IF EXISTS `core_invoicetask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_invoicetask` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `invoice_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_invoicetask_invoice_id_780e271e_fk_core_invoice_id` (`invoice_id`),
  CONSTRAINT `core_invoicetask_invoice_id_780e271e_fk_core_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `core_invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_invoicetask`
--

LOCK TABLES `core_invoicetask` WRITE;
/*!40000 ALTER TABLE `core_invoicetask` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_invoicetask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_item`
--

DROP TABLE IF EXISTS `core_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `long_description` longtext,
  `rate` decimal(12,2) NOT NULL,
  `tax` varchar(50) DEFAULT NULL,
  `tax2` varchar(50) DEFAULT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `group_id` bigint DEFAULT NULL,
  `item_code` varchar(100) DEFAULT NULL,
  `item_name` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_item_group_id_86ef4429_fk_core_item_group_id` (`group_id`),
  KEY `core_item_item_code_7eebaa3e` (`item_code`),
  KEY `core_item_item_name_b2d22de3` (`item_name`),
  KEY `core_item_status_db560d8c` (`status`),
  CONSTRAINT `core_item_group_id_86ef4429_fk_core_item_group_id` FOREIGN KEY (`group_id`) REFERENCES `core_item_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_item`
--

LOCK TABLES `core_item` WRITE;
/*!40000 ALTER TABLE `core_item` DISABLE KEYS */;
INSERT INTO `core_item` VALUES (1,'Samsung','SmartPhone',150000.00,'5%','No Tax','1','2026-03-14 05:02:41.472986',NULL,NULL,'Samsung','active'),(2,'Xaomi','Martphone',20000.00,'5%','No Tax','2','2026-03-14 05:03:52.047087',2,NULL,'Xaomi','active'),(3,'Book1','Reading',350.00,'5%','No Tax','','2026-03-18 06:23:15.190101',NULL,NULL,'Book1','active'),(4,'Laptop','Smart tech multifocality device',80000.00,'No Tax','No Tax','','2026-03-18 06:52:40.459295',NULL,NULL,'Laptop','active'),(5,'MacBook','Smart tech',150000.00,'5%','No Tax','','2026-03-18 07:08:07.802960',NULL,NULL,'MacBook','active');
/*!40000 ALTER TABLE `core_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_item_group`
--

DROP TABLE IF EXISTS `core_item_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_item_group` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_item_group`
--

LOCK TABLES `core_item_group` WRITE;
/*!40000 ALTER TABLE `core_item_group` DISABLE KEYS */;
INSERT INTO `core_item_group` VALUES (2,'SmartTech','2026-03-14 05:03:19.779524');
/*!40000 ALTER TABLE `core_item_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_lead`
--

DROP TABLE IF EXISTS `core_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_lead` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `source` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_lead`
--

LOCK TABLES `core_lead` WRITE;
/*!40000 ALTER TABLE `core_lead` DISABLE KEYS */;
INSERT INTO `core_lead` VALUES (1,'Sahil Date','ts0279190@gmail.com','09512839679','Contacted','2026-02-24 07:18:30.521016','Online'),(2,'Krishna','krishna01@gmail.com','0569987564','Interested','2026-02-24 07:43:43.812976','Offline');
/*!40000 ALTER TABLE `core_lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_project`
--

DROP TABLE IF EXISTS `core_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `progress` smallint unsigned NOT NULL,
  `status` varchar(32) NOT NULL,
  `billing_type` varchar(32) NOT NULL,
  `total_rate` decimal(12,2) NOT NULL,
  `estimated_hours` decimal(10,2) NOT NULL,
  `start_date` date DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `description` longtext,
  `send_email` tinyint(1) NOT NULL,
  `visible_tabs` json NOT NULL,
  `settings` json NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `created_by_id` int DEFAULT NULL,
  `mentor_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_projec_client__f4eed2_idx` (`client_id`,`status`),
  KEY `core_project_created_by_id_3ae31859_fk_auth_user_id` (`created_by_id`),
  KEY `core_project_name_ebbd35d6` (`name`),
  KEY `core_project_status_4ccd8987` (`status`),
  KEY `core_project_created_at_05ddbca4` (`created_at`),
  KEY `core_project_updated_at_5f0d6b5c` (`updated_at`),
  KEY `core_project_mentor_id_629da69e_fk_auth_user_id` (`mentor_id`),
  CONSTRAINT `core_project_client_id_4ba9e455_fk_core_client_id` FOREIGN KEY (`client_id`) REFERENCES `core_client` (`id`),
  CONSTRAINT `core_project_created_by_id_3ae31859_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `core_project_mentor_id_629da69e_fk_auth_user_id` FOREIGN KEY (`mentor_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `core_project_chk_1` CHECK ((`progress` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_project`
--

LOCK TABLES `core_project` WRITE;
/*!40000 ALTER TABLE `core_project` DISABLE KEYS */;
INSERT INTO `core_project` VALUES (2,'CRM System',40,'Accepted','Fixed Rate',900000.00,245.00,'2026-01-20','2026-06-27','#CRM #Reference','<p>Project Name: - CRM system&nbsp;</p>\n<p>Estimate Time: - 20/01/2026 - 27/06/2026 (6 Months)</p>\n<p>Here we start the working on CRM system for improving e-commerce sites for reaching and mentaning all records and data&nbsp;</p>',1,'[\"Project Overview\", \"Tasks\", \"Timesheets\", \"Invoices\", \"Estimates\", \"Expenses\", \"Credit Notes\", \"Activity\", \"Notes\"]','[\"Allow customer to view tasks\", \"Allow customer to comment on project tasks\", \"Allow customer to view task checklist items\"]','2026-03-16 07:25:09.843520','2026-03-16 07:25:09.843564',1,20,NULL),(4,'Claibration Management System',35,'Sent','Fixed Rate',1000000.00,400.00,'2026-02-26','2026-07-30','#Machines #Managements','<p><strong>Project Title: -&nbsp;</strong>Calibration Management System</p>\n<p><strong>Estimted Timeline: -</strong> 26/02/2026 - 30/07/2026 (6 Months)</p>\n<p>This project is about to mentenance measuregment of industrial machines.&nbsp;</p>',1,'[\"Project Overview\", \"Tasks\", \"Timesheets\", \"Invoices\", \"Estimates\", \"Expenses\", \"Credit Notes\", \"Activity\"]','[\"Allow customer to view tasks\", \"Allow customer to comment on project tasks\", \"Allow customer to view task comments\", \"Allow customer to view task checklist items\", \"Allow customer to view task attachments\"]','2026-03-16 08:24:03.690063','2026-03-16 08:24:03.690143',2,20,33);
/*!40000 ALTER TABLE `core_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_project_members`
--

DROP TABLE IF EXISTS `core_project_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_project_members` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_project_members_project_id_user_id_3750979c_uniq` (`project_id`,`user_id`),
  KEY `core_project_members_user_id_25704107_fk_auth_user_id` (`user_id`),
  CONSTRAINT `core_project_members_project_id_9909b3ba_fk_core_project_id` FOREIGN KEY (`project_id`) REFERENCES `core_project` (`id`),
  CONSTRAINT `core_project_members_user_id_25704107_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_project_members`
--

LOCK TABLES `core_project_members` WRITE;
/*!40000 ALTER TABLE `core_project_members` DISABLE KEYS */;
INSERT INTO `core_project_members` VALUES (1,2,33),(4,4,28),(3,4,33);
/*!40000 ALTER TABLE `core_project_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_proposal`
--

DROP TABLE IF EXISTS `core_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_proposal` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL,
  `assigned_to_id` int DEFAULT NULL,
  `created_by_id` int DEFAULT NULL,
  `adjustment` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `discount_total` decimal(10,2) NOT NULL,
  `items` json NOT NULL DEFAULT (_utf8mb4'[]'),
  `status` varchar(20) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `proposal_to` varchar(191) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `comments` json DEFAULT NULL,
  `reminders` json DEFAULT NULL,
  `tasks` json DEFAULT NULL,
  `notes` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_proposal_assigned_to_id_59739e86_fk_auth_user_id` (`assigned_to_id`),
  KEY `core_proposal_created_by_id_b1be6922_fk_auth_user_id` (`created_by_id`),
  CONSTRAINT `core_proposal_assigned_to_id_59739e86_fk_auth_user_id` FOREIGN KEY (`assigned_to_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `core_proposal_created_by_id_b1be6922_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_proposal`
--

LOCK TABLES `core_proposal` WRITE;
/*!40000 ALTER TABLE `core_proposal` DISABLE KEYS */;
INSERT INTO `core_proposal` VALUES (1,'T.V',33,NULL,0.00,'2026-02-20 09:39:12.909347',0.00,'[{\"qty\": 1, \"tax\": \"5%\", \"rate\": 150000, \"description\": \"T.V\", \"longDescription\": \"Smart T.V\"}]','3',150000.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'Book1',NULL,NULL,0.00,'2026-02-20 09:39:12.909347',0.00,'[{\"qty\": 1, \"tax\": \"5%\", \"rate\": 350, \"description\": \"Book1\", \"longDescription\": \"Reading\", \"long_description\": \"Reading\"}]','1',350.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'Samsung',33,21,0.00,'2026-02-20 09:39:12.909347',220.00,'[{\"qty\": 1, \"tax\": \"5%\", \"rate\": 220000, \"description\": \"Samsung\", \"longDescription\": \"Electronic \"}]','3',219780.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'Xaomi',NULL,20,0.00,'2026-02-24 07:03:33.904066',5600.00,'[]','3',-5600.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'Laptop',13,NULL,0.00,'2026-03-18 06:52:40.447791',0.00,'[{\"qty\": 1, \"tax\": \"No Tax\", \"rate\": 80000, \"description\": \"Laptop\", \"longDescription\": \"Smart tech multifocality device \", \"long_description\": \"Smart tech multifocality device \"}]','3',80000.00,'ranbir','Plot no. 72 Gayatri Society Opp. English Medium School Udhna, Surat, Gujarat.','Surat, Gujarat','Gujarat','india','394210','21bca231@vtcbb.edu.in','9512839679','[{\"id\": 1773819004351, \"text\": \"Good to be purchasing the product.\", \"addedFrom\": \"You\", \"dateAdded\": \"3/18/2026, 1:00:04 PM\"}]','[{\"id\": 1773819042878, \"remindAt\": \"2026-03-18T07:35:00.000Z\", \"addedFrom\": \"Myself\", \"dateAdded\": \"3/18/2026, 1:00:42 PM\", \"sendEmail\": true, \"description\": \"Proposals Reminder\"}]','[{\"id\": 1773819092541, \"tags\": \"\", \"dueDate\": \"2026-03-30\", \"subject\": \"About Rate\", \"isPublic\": false, \"priority\": \"Medium\", \"addedFrom\": \"You\", \"dateAdded\": \"3/18/2026, 1:01:32 PM\", \"relatedTo\": \"Proposal\", \"startDate\": \"2026-03-18\", \"hourlyRate\": 49, \"isBillable\": true, \"description\": \"Your task\", \"proposalRef\": \"PRO-000001\", \"repeatEvery\": \"daily\"}]','[{\"id\": 1773819110617, \"text\": \"Have a nice day.!!!!!!!\", \"addedFrom\": \"You\", \"dateAdded\": \"3/18/2026, 1:01:50 PM\"}]'),(12,'MacBook',33,NULL,0.00,'2026-03-18 07:08:07.778600',7500.00,'[{\"qty\": 1, \"tax\": \"5%\", \"rate\": 150000, \"description\": \"MacBook\", \"longDescription\": \"Smart tech \", \"long_description\": \"Smart tech \"}]','3',142500.00,'ranbir','D-19 Bhairavnagar Nr. Bhairavnath temple Bhestan, Surat, Gujarat.','Surat, Gujarat','Gujarat','india','394210','21bca231@vtcbb.edu.in','9512839679',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `core_proposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_roles`
--

DROP TABLE IF EXISTS `core_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `permissions` longtext NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_roles`
--

LOCK TABLES `core_roles` WRITE;
/*!40000 ALTER TABLE `core_roles` DISABLE KEYS */;
INSERT INTO `core_roles` VALUES (1,'Admin','All',1,'2026-02-16 09:03:45.353429'),(2,'User','Basic',0,'2026-02-16 09:04:25.559794'),(3,'Manager','Seen for users',0,'2026-02-16 15:33:46.731298'),(4,'Super Admin','All',0,'2026-02-20 05:08:47.375040');
/*!40000 ALTER TABLE `core_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_staffprofile`
--

DROP TABLE IF EXISTS `core_staffprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_staffprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `manager_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `core_staffprofile_manager_id_cab1203e_fk_auth_user_id` (`manager_id`),
  CONSTRAINT `core_staffprofile_manager_id_cab1203e_fk_auth_user_id` FOREIGN KEY (`manager_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `core_staffprofile_user_id_571ae86a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_staffprofile`
--

LOCK TABLES `core_staffprofile` WRITE;
/*!40000 ALTER TABLE `core_staffprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_staffprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2026-02-04 11:02:05.786020','3','https://techsit.com/',3,'',7,1),(2,'2026-02-04 11:31:19.925800','2','https://applesit.com/',3,'',7,1),(3,'2026-02-04 11:31:58.089102','4','https://techindsit.com/',3,'',7,1),(4,'2026-02-05 07:17:51.732153','5','https://techindsit.com/',2,'[]',7,1),(5,'2026-02-05 07:19:20.965830','5','https://techindsit.com/',3,'',7,1),(6,'2026-02-05 09:21:18.918640','4','pots123@gmail.com',3,'',4,1),(7,'2026-02-05 09:21:26.879868','3','tony123@gmail.com',3,'',4,1),(8,'2026-02-12 05:16:45.249192','19','user1',3,'',7,1),(9,'2026-02-12 05:16:45.249256','18','user',3,'',7,1),(10,'2026-02-12 05:16:45.249285','17','Test1',3,'',7,1),(11,'2026-02-12 05:16:45.249307','16','Test Business',3,'',7,1),(12,'2026-02-16 09:03:45.355835','1','Admin',1,'[{\"added\": {}}]',130,1),(13,'2026-02-16 09:04:25.561217','2','User',1,'[{\"added\": {}}]',130,1),(14,'2026-02-28 09:39:22.084215','22','sahildate92@gmail.com',3,'',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(127,'authtoken','token'),(128,'authtoken','tokenproxy'),(5,'contenttypes','contenttype'),(161,'core','activitylog'),(162,'core','adminclient'),(163,'core','admincontact'),(7,'core','business'),(138,'core','calendarevent'),(136,'core','client'),(147,'core','contact'),(153,'core','contract'),(155,'core','contractattachment'),(156,'core','contractcomment'),(157,'core','contractnote'),(158,'core','contractrenewal'),(159,'core','contracttask'),(154,'core','contracttype'),(148,'core','creditnote'),(149,'core','creditnotereminder'),(150,'core','creditnotetask'),(146,'core','customer'),(139,'core','emailcampaign'),(140,'core','emailrecipient'),(129,'core','emailtemplate'),(137,'core','estimate'),(134,'core','expense'),(141,'core','invoice'),(144,'core','invoiceemaillog'),(145,'core','invoicepayment'),(142,'core','invoicereminder'),(143,'core','invoicetask'),(151,'core','item'),(152,'core','itemgroup'),(164,'core','knowledgebasegroupproxy'),(165,'core','knowledgebaseproxy'),(135,'core','lead'),(166,'core','legacybusiness'),(160,'core','project'),(132,'core','proposal'),(130,'core','role'),(133,'core','staffprofile'),(167,'core','staffproxy'),(8,'ms_crm_app','activitylog'),(9,'ms_crm_app','announcements'),(131,'ms_crm_app','business'),(10,'ms_crm_app','clients'),(11,'ms_crm_app','consentpurposes'),(12,'ms_crm_app','consents'),(13,'ms_crm_app','contactpermissions'),(14,'ms_crm_app','contacts'),(15,'ms_crm_app','contractcomments'),(16,'ms_crm_app','contractrenewals'),(17,'ms_crm_app','contracts'),(18,'ms_crm_app','contractstypes'),(19,'ms_crm_app','countries'),(20,'ms_crm_app','creditnoterefunds'),(21,'ms_crm_app','creditnotes'),(22,'ms_crm_app','credits'),(23,'ms_crm_app','currencies'),(24,'ms_crm_app','customeradmins'),(25,'ms_crm_app','customergroups'),(26,'ms_crm_app','customersgroups'),(27,'ms_crm_app','customfields'),(28,'ms_crm_app','customfieldsvalues'),(29,'ms_crm_app','departments'),(30,'ms_crm_app','dismissedannouncements'),(31,'ms_crm_app','emaillists'),(32,'ms_crm_app','emailtemplates'),(33,'ms_crm_app','estimates'),(34,'ms_crm_app','events'),(35,'ms_crm_app','expenses'),(36,'ms_crm_app','expensescategories'),(37,'ms_crm_app','files'),(38,'ms_crm_app','formquestionbox'),(39,'ms_crm_app','formquestionboxdescription'),(40,'ms_crm_app','formquestions'),(41,'ms_crm_app','formresults'),(42,'ms_crm_app','gdprrequests'),(43,'ms_crm_app','goals'),(44,'ms_crm_app','invoicepaymentrecords'),(45,'ms_crm_app','invoices'),(46,'ms_crm_app','itemable'),(47,'ms_crm_app','items'),(48,'ms_crm_app','itemsgroups'),(49,'ms_crm_app','itemtax'),(50,'ms_crm_app','knowedgebasearticlefeedback'),(51,'ms_crm_app','knowledgebase'),(52,'ms_crm_app','knowledgebasegroups'),(53,'ms_crm_app','leadactivitylog'),(54,'ms_crm_app','leadintegrationemails'),(55,'ms_crm_app','leads'),(56,'ms_crm_app','leadsemailintegration'),(57,'ms_crm_app','leadssources'),(58,'ms_crm_app','leadsstatus'),(59,'ms_crm_app','listemails'),(60,'ms_crm_app','maillistscustomfields'),(61,'ms_crm_app','maillistscustomfieldvalues'),(62,'ms_crm_app','mailqueue'),(63,'ms_crm_app','migrations'),(64,'ms_crm_app','milestones'),(65,'ms_crm_app','modules'),(66,'ms_crm_app','newsfeedcommentlikes'),(67,'ms_crm_app','newsfeedpostcomments'),(68,'ms_crm_app','newsfeedpostlikes'),(69,'ms_crm_app','newsfeedposts'),(70,'ms_crm_app','notes'),(71,'ms_crm_app','notifications'),(72,'ms_crm_app','options'),(73,'ms_crm_app','paymentmodes'),(74,'ms_crm_app','pinnedprojects'),(75,'ms_crm_app','projectactivity'),(76,'ms_crm_app','projectdiscussioncomments'),(77,'ms_crm_app','projectdiscussions'),(78,'ms_crm_app','projectfiles'),(79,'ms_crm_app','projectmembers'),(80,'ms_crm_app','projectnotes'),(81,'ms_crm_app','projects'),(82,'ms_crm_app','projectsettings'),(83,'ms_crm_app','proposalcomments'),(84,'ms_crm_app','proposals'),(85,'ms_crm_app','relateditems'),(86,'ms_crm_app','reminders'),(87,'ms_crm_app','roles'),(88,'ms_crm_app','salesactivity'),(89,'ms_crm_app','services'),(90,'ms_crm_app','sessions'),(91,'ms_crm_app','sharedcustomerfiles'),(92,'ms_crm_app','spamfilters'),(93,'ms_crm_app','staff'),(94,'ms_crm_app','staffdepartments'),(95,'ms_crm_app','staffpermissions'),(96,'ms_crm_app','subscriptions'),(97,'ms_crm_app','surveyresultsets'),(98,'ms_crm_app','surveys'),(99,'ms_crm_app','surveysemailsendcron'),(100,'ms_crm_app','surveysendlog'),(101,'ms_crm_app','taggables'),(102,'ms_crm_app','tags'),(103,'ms_crm_app','taskassigned'),(104,'ms_crm_app','taskchecklistitems'),(105,'ms_crm_app','taskcomments'),(106,'ms_crm_app','taskfollowers'),(107,'ms_crm_app','tasks'),(108,'ms_crm_app','taskschecklisttemplates'),(109,'ms_crm_app','taskstimers'),(110,'ms_crm_app','taxes'),(111,'ms_crm_app','ticketattachments'),(112,'ms_crm_app','ticketreplies'),(113,'ms_crm_app','tickets'),(114,'ms_crm_app','ticketspipelog'),(115,'ms_crm_app','ticketspredefinedreplies'),(116,'ms_crm_app','ticketspriorities'),(117,'ms_crm_app','ticketsstatus'),(118,'ms_crm_app','todos'),(119,'ms_crm_app','trackedmails'),(120,'ms_crm_app','userautologin'),(121,'ms_crm_app','usermeta'),(122,'ms_crm_app','userprofile'),(123,'ms_crm_app','usertoken'),(124,'ms_crm_app','vault'),(125,'ms_crm_app','viewstracking'),(126,'ms_crm_app','webtolead'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-01-29 05:12:42.662818'),(2,'auth','0001_initial','2026-01-29 05:12:43.616105'),(3,'admin','0001_initial','2026-01-29 05:12:43.834210'),(4,'admin','0002_logentry_remove_auto_add','2026-01-29 05:12:43.844745'),(5,'admin','0003_logentry_add_action_flag_choices','2026-01-29 05:12:43.858032'),(6,'contenttypes','0002_remove_content_type_name','2026-01-29 05:12:43.988027'),(7,'auth','0002_alter_permission_name_max_length','2026-01-29 05:12:44.088710'),(8,'auth','0003_alter_user_email_max_length','2026-01-29 05:12:44.129376'),(9,'auth','0004_alter_user_username_opts','2026-01-29 05:12:44.141953'),(10,'auth','0005_alter_user_last_login_null','2026-01-29 05:12:44.248089'),(11,'auth','0006_require_contenttypes_0002','2026-01-29 05:12:44.251847'),(12,'auth','0007_alter_validators_add_error_messages','2026-01-29 05:12:44.269947'),(13,'auth','0008_alter_user_username_max_length','2026-01-29 05:12:44.422634'),(14,'auth','0009_alter_user_last_name_max_length','2026-01-29 05:12:44.542171'),(15,'auth','0010_alter_group_name_max_length','2026-01-29 05:12:44.581469'),(16,'auth','0011_update_proxy_permissions','2026-01-29 05:12:44.600190'),(17,'auth','0012_alter_user_first_name_max_length','2026-01-29 05:12:44.714480'),(18,'core','0001_initial','2026-01-29 05:12:44.784516'),(19,'ms_crm_app','0001_initial','2026-01-29 05:12:45.160218'),(20,'sessions','0001_initial','2026-01-29 05:12:45.230342'),(21,'core','0002_business_password','2026-02-04 05:58:09.770580'),(22,'core','0003_remove_business_password','2026-02-04 06:31:48.591302'),(23,'authtoken','0001_initial','2026-02-04 10:20:22.949138'),(24,'authtoken','0002_auto_20160226_1747','2026-02-04 10:20:22.983130'),(25,'authtoken','0003_tokenproxy','2026-02-04 10:20:22.988647'),(26,'authtoken','0004_alter_tokenproxy_options','2026-02-04 10:20:22.996776'),(27,'core','0004_emailtemplate_alter_business_options_and_more','2026-02-10 08:58:55.736839'),(28,'ms_crm_app','0002_alter_activitylog_options_alter_userprofile_password','2026-02-10 08:58:55.781396'),(29,'core','0005_role_emailtemplate_core_emailt_module_211275_idx','2026-02-12 05:41:28.748968'),(30,'ms_crm_app','0003_rename_staffid_activitylog_staff_name','2026-02-12 06:34:02.310260'),(31,'ms_crm_app','0004_remove_activitylog_staff_name_activitylog_staffid','2026-02-12 06:34:02.343973'),(32,'ms_crm_app','0005_alter_activitylog_options','2026-02-12 06:34:02.348755'),(33,'ms_crm_app','0006_alter_roles_options','2026-02-12 09:43:11.505092'),(34,'ms_crm_app','0007_alter_roles_name_business','2026-02-13 05:36:39.154849'),(35,'core','0006_alter_role_name_alter_role_permissions','2026-02-16 15:33:03.152229'),(36,'ms_crm_app','0008_delete_business','2026-02-16 15:33:03.167632'),(37,'core','0007_proposal_staffprofile','2026-02-18 12:25:33.233214'),(38,'core','0008_remove_proposal_adjustment_and_more','2026-02-18 16:48:29.278450'),(39,'core','0009_rename_assigned_proposal_assigned_to_and_more','2026-02-20 05:55:08.477262'),(40,'core','0010_remove_proposal_status_remove_proposal_total_and_more','2026-02-20 06:56:09.931926'),(41,'core','0011_proposal_adjustment_proposal_created_at_and_more','2026-02-20 09:39:13.073617'),(42,'core','0012_expense','2026-02-20 15:57:35.011206'),(43,'core','0013_expense_created_at_expense_currency_expense_note_and_more','2026-02-21 17:46:31.359858'),(44,'core','0014_lead','2026-02-23 07:23:34.910304'),(45,'core','0015_lead_source','2026-02-23 09:24:21.614847'),(46,'core','0016_client','2026-02-24 09:15:28.200359'),(47,'core','0017_client_billing_city_client_billing_country_and_more','2026-02-24 11:36:45.602199'),(48,'core','0018_alter_client_city_alter_client_company_and_more','2026-02-24 11:48:17.779593'),(49,'core','0019_estimate','2026-02-25 15:30:34.139389'),(50,'core','0020_calendarevent','2026-02-26 07:38:28.652359'),(51,'core','0021_emailcampaign_emailrecipient','2026-03-02 09:09:55.690054'),(52,'core','0022_invoice','2026-03-05 06:58:53.415671'),(53,'core','0023_remove_invoice_total_invoice_due_date_and_more','2026-03-05 08:56:06.168305'),(54,'core','0024_alter_invoice_due_date_alter_invoice_invoice_date','2026-03-06 07:41:35.773011'),(55,'core','0025_invoicereminder_invoicetask','2026-03-06 11:22:51.146455'),(56,'core','0026_invoiceemaillog','2026-03-06 17:06:46.238093'),(57,'core','0027_alter_invoiceemaillog_invoice','2026-03-06 17:32:58.671218'),(58,'core','0028_invoicepayment','2026-03-09 06:05:43.194211'),(59,'core','0029_auto_20260310_1237','2026-03-10 07:25:42.565656'),(60,'core','0030_remove_client_billing_city_and_more','2026-03-11 07:21:07.311844'),(61,'core','0031_alter_estimate_customer_and_more','2026-03-11 09:31:51.376537'),(62,'core','0032_customer','2026-03-12 05:56:24.108827'),(63,'core','0033_client_is_active','2026-03-12 07:36:21.837429'),(64,'core','0034_alter_client_city_alter_client_country_and_more','2026-03-12 11:01:38.900678'),(65,'core','0035_contact','2026-03-13 08:53:47.828422'),(66,'core','0036_creditnote_creditnotereminder_creditnotetask','2026-03-13 09:22:24.108778'),(67,'core','0037_itemgroup_item','2026-03-13 11:48:24.179694'),(68,'core','0038_item_master_fields_and_sales_items','2026-03-13 12:52:33.570341'),(69,'core','0039_expense_customer_invoice_refs','2026-03-14 08:13:01.413008'),(70,'core','0040_contract','2026-03-14 08:26:15.515092'),(71,'core','0041_contracttype','2026-03-16 05:30:29.318364'),(72,'core','0042_seed_contract_types','2026-03-16 05:30:47.997350'),(73,'core','0043_contract_extras','2026-03-16 05:56:15.917040'),(74,'core','0044_project','2026-03-16 07:20:43.637200'),(75,'core','0045_project_mentor','2026-03-16 07:39:33.056005'),(76,'core','0046_activitylog','2026-03-17 10:06:59.431211'),(77,'core','0047_add_activity_log_table','2026-03-17 10:06:59.485931'),(78,'core','0048_proposal_address_fields','2026-03-18 06:45:22.869798'),(79,'core','0049_proposal_activity_fields','2026-03-18 07:29:12.033279');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('04s85cfr6u7tyqhon63dg4qm9ymdihtt','.eJxVjEEOwiAQRe_C2hCgQAeX7j0Dmc5MpWpoUtqV8e7apAvd_vfef6mM21ry1mTJE6uzsur0uw1ID6k74DvW26xprusyDXpX9EGbvs4sz8vh_h0UbOVbiw8d9sABSMYELIKRLfhoTPTGIHMfWbpkCYJhRyEROnZxDCGBM0m9P-13N7U:1vy0xf:9dxBwg3yDcThZ7CCiDlGngLkWDVOTWUtwnMwqxjC-6A','2026-03-19 05:09:23.291883'),('njrwjvmkj95k6ux8gjl3fao0lilbqs4l','.eJxVjEEOwiAQRe_C2hCgQAeX7j0Dmc5MpWpoUtqV8e7apAvd_vfef6mM21ry1mTJE6uzsur0uw1ID6k74DvW26xprusyDXpX9EGbvs4sz8vh_h0UbOVbiw8d9sABSMYELIKRLfhoTPTGIHMfWbpkCYJhRyEROnZxDCGBM0m9P-13N7U:1vnWDM:IqaNNY80aj4BJQgob7RxqJGiY0fTWu8nzOMcKVlD1wA','2026-02-18 06:18:12.557028'),('uh6cz46l4tb174vikodom7t0nii39hzc','.eJxVjEEOwiAQRe_C2hCgQAeX7j0Dmc5MpWpoUtqV8e7apAvd_vfef6mM21ry1mTJE6uzsur0uw1ID6k74DvW26xprusyDXpX9EGbvs4sz8vh_h0UbOVbiw8d9sABSMYELIKRLfhoTPTGIHMfWbpkCYJhRyEROnZxDCGBM0m9P-13N7U:1vsdVX:JdpkZ6f1tNYtmPE7_SjFoZDzobc_QIoiRU8hSP2uOvo','2026-03-04 09:06:07.243728');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_activity_log`
--

DROP TABLE IF EXISTS `ms_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_activity_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `date` datetime NOT NULL,
  `staffid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_activity_log`
--

LOCK TABLES `ms_activity_log` WRITE;
/*!40000 ALTER TABLE `ms_activity_log` DISABLE KEYS */;
INSERT INTO `ms_activity_log` VALUES (1,'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.177.17]','2019-07-10 16:31:01',NULL),(2,'Non Existing User Tried to Login [Email: admin@foogleteh.com, Is Staff Member: No, IP: 103.116.177.17]','2019-07-10 16:34:41',NULL),(3,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.177.17]','2019-07-10 16:36:11',NULL),(4,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.177.17]','2019-07-10 16:38:57',NULL),(5,'New Client Created [ID: 1, From Staff: 1]','2019-07-10 16:43:46',NULL),(6,'New Invoice Item Added [ID:1, Item1]','2019-07-10 16:44:21',NULL),(7,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.177.17]','2019-07-10 16:46:47',NULL),(8,'Invoice Item Deleted [ID: 1]','2019-07-10 16:48:54',NULL),(9,'Invoice Deleted [INV-000001]','2019-07-10 16:50:55',NULL),(10,'Client Deleted [ID: 1]','2019-07-10 16:51:29',NULL),(11,'Staff Member Updated [ID: 1, Super Admin]','2019-07-10 16:54:54',NULL),(12,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 43.248.37.34]','2019-07-10 17:24:54',NULL),(13,'New Staff Member Added [ID: 2, Jay Patel]','2019-07-10 17:29:18',NULL),(14,'Staff Member Updated [ID: 2, Jay Patel]','2019-07-10 17:30:11',NULL),(15,'Staff Member Updated [ID: 2, Jay Patel]','2019-07-10 17:31:46',NULL),(16,'Staff Member Updated [ID: 2, Jay Patel]','2019-07-10 17:31:57',NULL),(17,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.178.131]','2019-07-11 11:01:50',NULL),(18,'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]','2019-07-11 11:02:00',NULL),(19,'New Currency Added [ID: INR]','2019-07-11 11:49:36',NULL),(20,'New Announcement Added [Leave tomorrow ]','2019-07-11 11:53:58',NULL),(21,'Failed Login Attempt [Email: jay.patel@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]','2019-07-11 11:54:29',NULL),(22,'Staff Member Updated [ID: 2, Rahul Patel]','2019-07-11 14:10:54',NULL),(23,'Staff Member Updated [ID: 2, Rahul Patel]','2019-07-11 14:11:36',NULL),(24,'New Staff Member Added [ID: 3, Krishna  Patni]','2019-07-11 14:17:36',NULL),(25,'Staff Member Updated [ID: 3, Krishna  Patni]','2019-07-11 14:18:30',NULL),(26,'Staff Member Updated [ID: 3, Krishna  Patni]','2019-07-11 14:19:13',NULL),(27,'Staff Password Changed [2]','2019-07-11 14:30:59',NULL),(28,'Announcement Deleted [1]','2019-07-11 15:59:00',NULL),(29,'New Role Added [ID: 2.CEO]','2019-07-11 16:47:52',NULL),(30,'New Staff Member Added [ID: 4, Sandip Patel]','2019-07-11 16:49:25',NULL),(31,'Staff Member Updated [ID: 3, Krishna  Patni]','2019-07-11 16:50:23',NULL),(32,'Staff Member Updated [ID: 2, Rahul Patel]','2019-07-11 16:51:33',NULL),(33,'Tried to access page where don\'t have permission [settings]','2019-07-11 16:52:38',NULL),(34,'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]','2019-07-11 16:53:54',NULL),(35,'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]','2019-07-11 16:54:10',NULL),(36,'New Leads Source Added [SourceID: 3, Name: Website]','2019-07-11 16:54:47',NULL),(37,'New Leads Source Added [SourceID: 4, Name: Instagram]','2019-07-11 16:55:01',NULL),(38,'New Leads Source Added [SourceID: 5, Name: Direct Call]','2019-07-11 16:55:17',NULL),(39,'New Leads Source Added [SourceID: 6, Name: Direct Message]','2019-07-11 16:55:31',NULL),(40,'New Leads Source Added [SourceID: 7, Name: Other]','2019-07-11 16:55:41',NULL),(41,'New Leads Status Added [StatusID: 2, Name: New]','2019-07-11 17:03:33',NULL),(42,'New Leads Status Added [StatusID: 3, Name: Contacted]','2019-07-11 17:03:44',NULL),(43,'New Leads Status Added [StatusID: 4, Name: On Hold]','2019-07-11 17:04:06',NULL),(44,'New Leads Status Added [StatusID: 5, Name: Not Interested]','2019-07-11 17:04:17',NULL),(45,'New Leads Status Added [StatusID: 6, Name: Follow up in a Day]','2019-07-11 17:06:14',NULL),(46,'New Leads Status Added [StatusID: 7, Name: Follow up in 2 days]','2019-07-11 17:06:27',NULL),(47,'New Leads Status Added [StatusID: 8, Name: Unqualified]','2019-07-11 17:06:49',NULL),(48,'New Leads Source Added [SourceID: 8, Name: Software application form]','2019-07-11 17:07:30',NULL),(49,'New Web to Lead Form Added [EGGManiac application form]','2019-07-11 17:09:00',NULL),(50,'Failed Login Attempt [Email: krishna@eggmaniac.com, Is Staff Member: Yes, IP: 103.116.178.131]','2019-07-11 17:58:58',NULL),(51,'Failed Login Attempt [Email: krishna@eggmaniac.com, Is Staff Member: Yes, IP: 103.116.178.131]','2019-07-11 17:59:23',NULL),(52,'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]','2019-07-11 18:32:29',NULL),(53,'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.177.8]','2019-07-12 11:39:51',NULL),(54,'New Announcement Added [Leave Tomorrow]','2019-07-12 16:39:04',NULL),(55,'New Invoice Item Added [ID:2, caramel con]','2019-07-12 16:40:18',NULL),(56,'New Client Created [ID: 2, From Staff: 1]','2019-07-12 16:40:31',NULL),(57,'New Lead Added [ID: 1]','2019-07-12 16:43:33',NULL),(58,'New Lead Added [ID: 2]','2019-07-12 16:47:54',NULL),(59,'New Survey Added [ID: 1, Subject: Feedback]','2019-07-12 16:56:30',NULL),(60,'New Survey Question Added [SurveyID: 1]','2019-07-12 16:56:35',NULL),(61,'Survey Question Updated [QuestionID: 1]','2019-07-12 16:56:45',NULL),(62,'Survey Question Updated [QuestionID: 1]','2019-07-12 16:56:51',NULL),(63,'Survey Question Updated [QuestionID: 1]','2019-07-12 16:57:17',NULL),(64,'New Goal Added [ID:1]','2019-07-12 17:01:07',NULL),(65,'Estimates Deleted [Number: EST-000001]','2019-07-12 18:00:47',NULL),(66,'Lead Deleted [Deleted by: Super Admin, ID: 2]','2019-07-12 18:22:48',NULL),(67,'Client Deleted [ID: 2]','2019-07-12 18:23:10',NULL),(68,'Lead Deleted [Deleted by: Super Admin, ID: 1]','2019-07-12 18:51:35',NULL),(69,'Announcement Deleted [2]','2019-07-12 18:52:18',NULL),(70,'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.110]','2019-07-13 09:45:05',NULL),(71,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]','2019-07-18 16:43:40',NULL),(72,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]','2019-07-18 16:44:06',NULL),(73,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]','2019-07-18 16:44:28',NULL),(74,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]','2019-07-18 16:44:41',NULL),(75,'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]','2019-07-18 16:44:59',NULL),(76,'Staff Status Changed [StaffID: 2 - Status(Active/Inactive): 0]','2019-07-18 16:47:36',NULL),(77,'Staff Member Deleted [Name: Rahul Patel, Data Transferred To: Super Admin]','2019-07-18 16:50:01',NULL),(78,'Staff Member Deleted [Name: Krishna  Patni, Data Transferred To: Super Admin]','2019-07-18 16:55:37',NULL),(79,'Staff Member Deleted [Name: Sandip Patel, Data Transferred To: Super Admin]','2019-07-18 16:55:44',NULL);
/*!40000 ALTER TABLE `ms_activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_announcements`
--

DROP TABLE IF EXISTS `ms_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_announcements` (
  `announcementid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `message` text,
  `showtousers` int NOT NULL DEFAULT '0',
  `showtostaff` int NOT NULL DEFAULT '0',
  `showname` int NOT NULL DEFAULT '1',
  `dateadded` datetime NOT NULL,
  `userid` varchar(100) NOT NULL,
  PRIMARY KEY (`announcementid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_announcements`
--

LOCK TABLES `ms_announcements` WRITE;
/*!40000 ALTER TABLE `ms_announcements` DISABLE KEYS */;
INSERT INTO `ms_announcements` VALUES (1,'Today\'s Meeting','Today\'s discussion about how the CRM works with our daily e-commerce work, It\'s important to everyone for attending the meeting.\nThank you.',1,1,1,'2026-03-17 06:29:39','krishna01@gmail.com');
/*!40000 ALTER TABLE `ms_announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_goals`
--

DROP TABLE IF EXISTS `ms_goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_goals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subject` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `goal_type` int NOT NULL DEFAULT '0',
  `contract_type` int NOT NULL DEFAULT '0',
  `achievement` int NOT NULL DEFAULT '0',
  `notify_when_fail` int NOT NULL DEFAULT '0',
  `notify_when_achieve` int NOT NULL DEFAULT '0',
  `notified` int NOT NULL DEFAULT '0',
  `staff_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_goals`
--

LOCK TABLES `ms_goals` WRITE;
/*!40000 ALTER TABLE `ms_goals` DISABLE KEYS */;
INSERT INTO `ms_goals` VALUES (1,'SmartTech','Done the management properly.','2026-03-17','2026-06-16',0,0,57,0,0,0,2);
/*!40000 ALTER TABLE `ms_goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_knowledge_base`
--

DROP TABLE IF EXISTS `ms_knowledge_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_knowledge_base` (
  `articleid` int NOT NULL AUTO_INCREMENT,
  `articlegroup` int NOT NULL,
  `subject` mediumtext NOT NULL,
  `description` text NOT NULL,
  `slug` mediumtext NOT NULL,
  `active` tinyint NOT NULL,
  `datecreated` datetime NOT NULL,
  `article_order` int NOT NULL DEFAULT '0',
  `staff_article` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`articleid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_knowledge_base`
--

LOCK TABLES `ms_knowledge_base` WRITE;
/*!40000 ALTER TABLE `ms_knowledge_base` DISABLE KEYS */;
INSERT INTO `ms_knowledge_base` VALUES (1,1,'Getting Started','Welcome to the Knowledge Base. Add your first article to help your team.','getting-started',1,'2026-03-16 18:17:44',0,0),(2,1,'CRM management','Management about e-commerce website using CRM system for better productivity and easily access to people through online stores.','crm-management',1,'2026-03-16 12:58:54',0,0);
/*!40000 ALTER TABLE `ms_knowledge_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_knowledge_base_groups`
--

DROP TABLE IF EXISTS `ms_knowledge_base_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_knowledge_base_groups` (
  `groupid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `group_slug` text,
  `description` mediumtext,
  `active` tinyint NOT NULL,
  `color` varchar(10) DEFAULT '#28B8DA',
  `group_order` int DEFAULT '0',
  PRIMARY KEY (`groupid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_knowledge_base_groups`
--

LOCK TABLES `ms_knowledge_base_groups` WRITE;
/*!40000 ALTER TABLE `ms_knowledge_base_groups` DISABLE KEYS */;
INSERT INTO `ms_knowledge_base_groups` VALUES (1,'General','general','General knowledge base articles',1,'#28B8DA',0),(2,'CRM','crm','Management the e-commerce website  ',1,'#28B8DA',0);
/*!40000 ALTER TABLE `ms_knowledge_base_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_roles`
--

DROP TABLE IF EXISTS `ms_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_roles` (
  `roleid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `permissions` text,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_roles`
--

LOCK TABLES `ms_roles` WRITE;
/*!40000 ALTER TABLE `ms_roles` DISABLE KEYS */;
INSERT INTO `ms_roles` VALUES (1,'User','Not Accessible '),(2,'User','Not Accessible '),(3,'User','Not Accessible '),(4,'User','Not Accessible '),(5,'User','Not Accessible '),(6,'User','Not Accessible '),(7,'User','Not Accessible '),(8,'User','Not Accessible '),(9,'User','Not Accessible '),(10,'User','Not Accessible '),(11,'User','Not Accessible '),(12,'User','Not Accessible '),(13,'User','Not Accessible '),(14,'User','Not Accessible ');
/*!40000 ALTER TABLE `ms_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_staff`
--

DROP TABLE IF EXISTS `ms_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_staff` (
  `staffid` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `facebook` mediumtext,
  `linkedin` mediumtext,
  `phonenumber` varchar(30) DEFAULT NULL,
  `skype` varchar(50) DEFAULT NULL,
  `password` varchar(250) NOT NULL,
  `datecreated` datetime NOT NULL,
  `profile_image` varchar(191) DEFAULT NULL,
  `last_ip` varchar(40) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `last_password_change` datetime DEFAULT NULL,
  `new_pass_key` varchar(32) DEFAULT NULL,
  `new_pass_key_requested` datetime DEFAULT NULL,
  `admin` int NOT NULL DEFAULT '0',
  `role` int DEFAULT NULL,
  `active` int NOT NULL DEFAULT '1',
  `default_language` varchar(40) DEFAULT NULL,
  `direction` varchar(3) DEFAULT NULL,
  `media_path_slug` varchar(191) DEFAULT NULL,
  `is_not_staff` int NOT NULL DEFAULT '0',
  `hourly_rate` decimal(15,2) NOT NULL DEFAULT '0.00',
  `two_factor_auth_enabled` tinyint(1) DEFAULT '0',
  `two_factor_auth_code` varchar(100) DEFAULT NULL,
  `two_factor_auth_code_requested` datetime DEFAULT NULL,
  `email_signature` text,
  PRIMARY KEY (`staffid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_staff`
--

LOCK TABLES `ms_staff` WRITE;
/*!40000 ALTER TABLE `ms_staff` DISABLE KEYS */;
INSERT INTO `ms_staff` VALUES (1,'admin@example.com','Admin','User',NULL,NULL,NULL,NULL,'','2026-03-16 16:21:25',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1,NULL,NULL,NULL,0,0.00,0,NULL,NULL,NULL),(2,'ts0279190@gmail.com','Sahil','Date','http://facebook.com/','http://linkdin.com/','09512839679','','pbkdf2_sha256$1200000$aiXkwW5BjbTmFkZ5skIBL8$3psWEl4CURYY3cnLErU9PZqrtp7yuNALX9q4H5c+SHk=','2026-03-16 10:59:25','',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,1,'english','ltr','',0,250.00,0,NULL,NULL,'sahil'),(3,'ts0279190@gmail.com','Sahil','Date','http://facebook.com/','http://linkdin.com/','09512839679','','pbkdf2_sha256$1200000$fs7I5PecSRqt9kb3p4MzKP$vMYtbPYUUXrTMjkDItPE26KE53wOgi+WC84S3jXkt+o=','2026-03-16 11:05:16','',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,1,'english','ltr','',0,250.00,0,NULL,NULL,'sahil');
/*!40000 ALTER TABLE `ms_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_surveys`
--

DROP TABLE IF EXISTS `ms_surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_surveys` (
  `surveyid` int NOT NULL AUTO_INCREMENT,
  `subject` mediumtext NOT NULL,
  `slug` mediumtext NOT NULL,
  `description` text NOT NULL,
  `viewdescription` text,
  `datecreated` datetime NOT NULL,
  `redirect_url` varchar(100) DEFAULT NULL,
  `send` tinyint(1) NOT NULL DEFAULT '0',
  `onlyforloggedin` int DEFAULT '0',
  `fromname` varchar(100) DEFAULT NULL,
  `iprestrict` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `hash` varchar(32) NOT NULL,
  PRIMARY KEY (`surveyid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_surveys`
--

LOCK TABLES `ms_surveys` WRITE;
/*!40000 ALTER TABLE `ms_surveys` DISABLE KEYS */;
INSERT INTO `ms_surveys` VALUES (1,'Feedback','feedback','asd','asdsad','2019-07-12 16:56:30','',0,0,'',0,1,'2ff812ef6da62c0866c90045f6b0dea1');
/*!40000 ALTER TABLE `ms_surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_tickets_pipe_log`
--

DROP TABLE IF EXISTS `ms_tickets_pipe_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_tickets_pipe_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `email_to` varchar(100) NOT NULL,
  `name` varchar(191) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `message` mediumtext NOT NULL,
  `email` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_tickets_pipe_log`
--

LOCK TABLES `ms_tickets_pipe_log` WRITE;
/*!40000 ALTER TABLE `ms_tickets_pipe_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ms_tickets_pipe_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_user_profiles`
--

DROP TABLE IF EXISTS `ms_user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_user_profiles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_type` int DEFAULT NULL,
  `business_name` varchar(100) NOT NULL,
  `user_email` varchar(254) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` longtext NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `created_datetime` datetime(6) DEFAULT NULL,
  `updated_datetime` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email` (`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_user_profiles`
--

LOCK TABLES `ms_user_profiles` WRITE;
/*!40000 ALTER TABLE `ms_user_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `ms_user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ms_user_token`
--

DROP TABLE IF EXISTS `ms_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_user_token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `access_token` longtext NOT NULL,
  `refresh_token` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ms_user_token_user_id_e6163f22_fk_ms_user_profiles_id` (`user_id`),
  CONSTRAINT `ms_user_token_user_id_e6163f22_fk_ms_user_profiles_id` FOREIGN KEY (`user_id`) REFERENCES `ms_user_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_user_token`
--

LOCK TABLES `ms_user_token` WRITE;
/*!40000 ALTER TABLE `ms_user_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `ms_user_token` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-18 16:56:42
