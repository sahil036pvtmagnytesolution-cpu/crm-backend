-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 12, 2025 at 12:31 PM
-- Server version: 10.6.21-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `my_crm`
--

-- --------------------------------------------------------

--
-- Table structure for table `ms_activity_log`
--

CREATE TABLE `ms_activity_log` (
  `id` int(11) NOT NULL,
  `description` mediumtext NOT NULL,
  `date` datetime NOT NULL,
  `staffid` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_activity_log`
--

INSERT INTO `ms_activity_log` (`id`, `description`, `date`, `staffid`) VALUES
(1, 'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.177.17]', '2019-07-10 16:31:01', NULL),
(2, 'Non Existing User Tried to Login [Email: admin@foogleteh.com, Is Staff Member: No, IP: 103.116.177.17]', '2019-07-10 16:34:41', NULL),
(3, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.177.17]', '2019-07-10 16:36:11', NULL),
(4, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.177.17]', '2019-07-10 16:38:57', NULL),
(5, 'New Client Created [ID: 1, From Staff: 1]', '2019-07-10 16:43:46', 'Hemangi Patel'),
(6, 'New Invoice Item Added [ID:1, Item1]', '2019-07-10 16:44:21', 'Hemangi Patel'),
(7, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.177.17]', '2019-07-10 16:46:47', 'Hemangi Patel'),
(8, 'Invoice Item Deleted [ID: 1]', '2019-07-10 16:48:54', 'Hemangi Patel'),
(9, 'Invoice Deleted [INV-000001]', '2019-07-10 16:50:55', 'Hemangi Patel'),
(10, 'Client Deleted [ID: 1]', '2019-07-10 16:51:29', 'Hemangi Patel'),
(11, 'Staff Member Updated [ID: 1, Super Admin]', '2019-07-10 16:54:54', 'Hemangi Patel'),
(12, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 43.248.37.34]', '2019-07-10 17:24:54', NULL),
(13, 'New Staff Member Added [ID: 2, Jay Patel]', '2019-07-10 17:29:18', 'Super Admin'),
(14, 'Staff Member Updated [ID: 2, Jay Patel]', '2019-07-10 17:30:11', 'Super Admin'),
(15, 'Staff Member Updated [ID: 2, Jay Patel]', '2019-07-10 17:31:46', 'Super Admin'),
(16, 'Staff Member Updated [ID: 2, Jay Patel]', '2019-07-10 17:31:57', 'Super Admin'),
(17, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.178.131]', '2019-07-11 11:01:50', NULL),
(18, 'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]', '2019-07-11 11:02:00', NULL),
(19, 'New Currency Added [ID: INR]', '2019-07-11 11:49:36', 'Super Admin'),
(20, 'New Announcement Added [Leave tomorrow ]', '2019-07-11 11:53:58', 'Super Admin'),
(21, 'Failed Login Attempt [Email: jay.patel@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]', '2019-07-11 11:54:29', NULL),
(22, 'Staff Member Updated [ID: 2, Rahul Patel]', '2019-07-11 14:10:54', 'Super Admin'),
(23, 'Staff Member Updated [ID: 2, Rahul Patel]', '2019-07-11 14:11:36', 'Super Admin'),
(24, 'New Staff Member Added [ID: 3, Krishna  Patni]', '2019-07-11 14:17:36', 'Super Admin'),
(25, 'Staff Member Updated [ID: 3, Krishna  Patni]', '2019-07-11 14:18:30', 'Super Admin'),
(26, 'Staff Member Updated [ID: 3, Krishna  Patni]', '2019-07-11 14:19:13', 'Super Admin'),
(27, 'Staff Password Changed [2]', '2019-07-11 14:30:59', 'Rahul Patel'),
(28, 'Announcement Deleted [1]', '2019-07-11 15:59:00', 'Super Admin'),
(29, 'New Role Added [ID: 2.CEO]', '2019-07-11 16:47:52', 'Super Admin'),
(30, 'New Staff Member Added [ID: 4, Sandip Patel]', '2019-07-11 16:49:25', 'Super Admin'),
(31, 'Staff Member Updated [ID: 3, Krishna  Patni]', '2019-07-11 16:50:23', 'Super Admin'),
(32, 'Staff Member Updated [ID: 2, Rahul Patel]', '2019-07-11 16:51:33', 'Super Admin'),
(33, 'Tried to access page where don\'t have permission [settings]', '2019-07-11 16:52:38', 'Rahul Patel'),
(34, 'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]', '2019-07-11 16:53:54', NULL),
(35, 'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]', '2019-07-11 16:54:10', NULL),
(36, 'New Leads Source Added [SourceID: 3, Name: Website]', '2019-07-11 16:54:47', 'Super Admin'),
(37, 'New Leads Source Added [SourceID: 4, Name: Instagram]', '2019-07-11 16:55:01', 'Super Admin'),
(38, 'New Leads Source Added [SourceID: 5, Name: Direct Call]', '2019-07-11 16:55:17', 'Super Admin'),
(39, 'New Leads Source Added [SourceID: 6, Name: Direct Message]', '2019-07-11 16:55:31', 'Super Admin'),
(40, 'New Leads Source Added [SourceID: 7, Name: Other]', '2019-07-11 16:55:41', 'Super Admin'),
(41, 'New Leads Status Added [StatusID: 2, Name: New]', '2019-07-11 17:03:33', 'Super Admin'),
(42, 'New Leads Status Added [StatusID: 3, Name: Contacted]', '2019-07-11 17:03:44', 'Super Admin'),
(43, 'New Leads Status Added [StatusID: 4, Name: On Hold]', '2019-07-11 17:04:06', 'Super Admin'),
(44, 'New Leads Status Added [StatusID: 5, Name: Not Interested]', '2019-07-11 17:04:17', 'Super Admin'),
(45, 'New Leads Status Added [StatusID: 6, Name: Follow up in a Day]', '2019-07-11 17:06:14', 'Super Admin'),
(46, 'New Leads Status Added [StatusID: 7, Name: Follow up in 2 days]', '2019-07-11 17:06:27', 'Super Admin'),
(47, 'New Leads Status Added [StatusID: 8, Name: Unqualified]', '2019-07-11 17:06:49', 'Super Admin'),
(48, 'New Leads Source Added [SourceID: 8, Name: Software application form]', '2019-07-11 17:07:30', 'Super Admin'),
(49, 'New Web to Lead Form Added [EGGManiac application form]', '2019-07-11 17:09:00', 'Super Admin'),
(50, 'Failed Login Attempt [Email: krishna@eggmaniac.com, Is Staff Member: Yes, IP: 103.116.178.131]', '2019-07-11 17:58:58', NULL),
(51, 'Failed Login Attempt [Email: krishna@eggmaniac.com, Is Staff Member: Yes, IP: 103.116.178.131]', '2019-07-11 17:59:23', NULL),
(52, 'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.131]', '2019-07-11 18:32:29', NULL),
(53, 'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.177.8]', '2019-07-12 11:39:51', NULL),
(54, 'New Announcement Added [Leave Tomorrow]', '2019-07-12 16:39:04', 'Super Admin'),
(55, 'New Invoice Item Added [ID:2, caramel con]', '2019-07-12 16:40:18', 'Super Admin'),
(56, 'New Client Created [ID: 2, From Staff: 1]', '2019-07-12 16:40:31', 'Super Admin'),
(57, 'New Lead Added [ID: 1]', '2019-07-12 16:43:33', 'Super Admin'),
(58, 'New Lead Added [ID: 2]', '2019-07-12 16:47:54', 'Rahul Patel'),
(59, 'New Survey Added [ID: 1, Subject: Feedback]', '2019-07-12 16:56:30', 'Super Admin'),
(60, 'New Survey Question Added [SurveyID: 1]', '2019-07-12 16:56:35', 'Super Admin'),
(61, 'Survey Question Updated [QuestionID: 1]', '2019-07-12 16:56:45', 'Super Admin'),
(62, 'Survey Question Updated [QuestionID: 1]', '2019-07-12 16:56:51', 'Super Admin'),
(63, 'Survey Question Updated [QuestionID: 1]', '2019-07-12 16:57:17', 'Super Admin'),
(64, 'New Goal Added [ID:1]', '2019-07-12 17:01:07', 'Super Admin'),
(65, 'Estimates Deleted [Number: EST-000001]', '2019-07-12 18:00:47', 'Super Admin'),
(66, 'Lead Deleted [Deleted by: Super Admin, ID: 2]', '2019-07-12 18:22:48', 'Super Admin'),
(67, 'Client Deleted [ID: 2]', '2019-07-12 18:23:10', 'Super Admin'),
(68, 'Lead Deleted [Deleted by: Super Admin, ID: 1]', '2019-07-12 18:51:35', 'Super Admin'),
(69, 'Announcement Deleted [2]', '2019-07-12 18:52:18', 'Super Admin'),
(70, 'Failed Login Attempt [Email: admin@foogletech.com, Is Staff Member: Yes, IP: 103.116.178.110]', '2019-07-13 09:45:05', NULL),
(71, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]', '2019-07-18 16:43:40', NULL),
(72, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]', '2019-07-18 16:44:06', NULL),
(73, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]', '2019-07-18 16:44:28', NULL),
(74, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]', '2019-07-18 16:44:41', NULL),
(75, 'Non Existing User Tried to Login [Email: admin@foogletech.com, Is Staff Member: No, IP: 103.116.179.40]', '2019-07-18 16:44:59', NULL),
(76, 'Staff Status Changed [StaffID: 2 - Status(Active/Inactive): 0]', '2019-07-18 16:47:36', 'Super Admin'),
(77, 'Staff Member Deleted [Name: Rahul Patel, Data Transferred To: Super Admin]', '2019-07-18 16:50:01', 'Super Admin'),
(78, 'Staff Member Deleted [Name: Krishna  Patni, Data Transferred To: Super Admin]', '2019-07-18 16:55:37', 'Super Admin'),
(79, 'Staff Member Deleted [Name: Sandip Patel, Data Transferred To: Super Admin]', '2019-07-18 16:55:44', 'Super Admin');

-- --------------------------------------------------------

--
-- Table structure for table `ms_announcements`
--

CREATE TABLE `ms_announcements` (
  `announcementid` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `message` text DEFAULT NULL,
  `showtousers` int(11) NOT NULL,
  `showtostaff` int(11) NOT NULL,
  `showname` int(11) NOT NULL,
  `dateadded` datetime NOT NULL,
  `userid` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_clients`
--

CREATE TABLE `ms_clients` (
  `userid` int(11) NOT NULL,
  `company` varchar(191) DEFAULT NULL,
  `vat` varchar(50) DEFAULT NULL,
  `phonenumber` varchar(30) DEFAULT NULL,
  `country` int(11) NOT NULL DEFAULT 0,
  `city` varchar(100) DEFAULT NULL,
  `zip` varchar(15) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `website` varchar(150) DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `active` int(11) NOT NULL DEFAULT 1,
  `leadid` int(11) DEFAULT NULL,
  `billing_street` varchar(200) DEFAULT NULL,
  `billing_city` varchar(100) DEFAULT NULL,
  `billing_state` varchar(100) DEFAULT NULL,
  `billing_zip` varchar(100) DEFAULT NULL,
  `billing_country` int(11) DEFAULT 0,
  `shipping_street` varchar(200) DEFAULT NULL,
  `shipping_city` varchar(100) DEFAULT NULL,
  `shipping_state` varchar(100) DEFAULT NULL,
  `shipping_zip` varchar(100) DEFAULT NULL,
  `shipping_country` int(11) DEFAULT 0,
  `longitude` varchar(191) DEFAULT NULL,
  `latitude` varchar(191) DEFAULT NULL,
  `default_language` varchar(40) DEFAULT NULL,
  `default_currency` int(11) NOT NULL DEFAULT 0,
  `show_primary_contact` int(11) NOT NULL DEFAULT 0,
  `stripe_id` varchar(40) DEFAULT NULL,
  `registration_confirmed` int(11) NOT NULL DEFAULT 1,
  `addedfrom` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_consents`
--

CREATE TABLE `ms_consents` (
  `id` int(11) NOT NULL,
  `action` varchar(10) NOT NULL,
  `date` datetime NOT NULL,
  `ip` varchar(40) NOT NULL,
  `contact_id` int(11) NOT NULL DEFAULT 0,
  `lead_id` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `opt_in_purpose_description` text DEFAULT NULL,
  `purpose_id` int(11) NOT NULL,
  `staff_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_consent_purposes`
--

CREATE TABLE `ms_consent_purposes` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_contacts`
--

CREATE TABLE `ms_contacts` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `is_primary` int(11) NOT NULL DEFAULT 1,
  `firstname` varchar(191) NOT NULL,
  `lastname` varchar(191) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phonenumber` varchar(100) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `new_pass_key` varchar(32) DEFAULT NULL,
  `new_pass_key_requested` datetime DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `email_verification_key` varchar(32) DEFAULT NULL,
  `email_verification_sent_at` datetime DEFAULT NULL,
  `last_ip` varchar(40) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_password_change` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `profile_image` varchar(191) DEFAULT NULL,
  `direction` varchar(3) DEFAULT NULL,
  `invoice_emails` tinyint(1) NOT NULL DEFAULT 1,
  `estimate_emails` tinyint(1) NOT NULL DEFAULT 1,
  `credit_note_emails` tinyint(1) NOT NULL DEFAULT 1,
  `contract_emails` tinyint(1) NOT NULL DEFAULT 1,
  `task_emails` tinyint(1) NOT NULL DEFAULT 1,
  `project_emails` tinyint(1) NOT NULL DEFAULT 1,
  `ticket_emails` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_contact_permissions`
--

CREATE TABLE `ms_contact_permissions` (
  `id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_contracts`
--

CREATE TABLE `ms_contracts` (
  `id` int(11) NOT NULL,
  `content` longtext DEFAULT NULL,
  `description` text DEFAULT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `client` int(11) NOT NULL,
  `datestart` date DEFAULT NULL,
  `dateend` date DEFAULT NULL,
  `contract_type` int(11) DEFAULT NULL,
  `addedfrom` int(11) NOT NULL,
  `dateadded` datetime NOT NULL,
  `isexpirynotified` int(11) NOT NULL DEFAULT 0,
  `contract_value` decimal(15,2) DEFAULT NULL,
  `trash` tinyint(1) DEFAULT 0,
  `not_visible_to_client` tinyint(1) NOT NULL DEFAULT 0,
  `hash` varchar(32) DEFAULT NULL,
  `signed` tinyint(1) NOT NULL DEFAULT 0,
  `signature` varchar(40) DEFAULT NULL,
  `acceptance_firstname` varchar(50) DEFAULT NULL,
  `acceptance_lastname` varchar(50) DEFAULT NULL,
  `acceptance_email` varchar(100) DEFAULT NULL,
  `acceptance_date` datetime DEFAULT NULL,
  `acceptance_ip` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_contracts_types`
--

CREATE TABLE `ms_contracts_types` (
  `id` int(11) NOT NULL,
  `name` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_contract_comments`
--

CREATE TABLE `ms_contract_comments` (
  `id` int(11) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `contract_id` int(11) NOT NULL,
  `staffid` int(11) NOT NULL,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_contract_renewals`
--

CREATE TABLE `ms_contract_renewals` (
  `id` int(11) NOT NULL,
  `contractid` int(11) NOT NULL,
  `old_start_date` date NOT NULL,
  `new_start_date` date NOT NULL,
  `old_end_date` date DEFAULT NULL,
  `new_end_date` date DEFAULT NULL,
  `old_value` decimal(15,2) DEFAULT NULL,
  `new_value` decimal(15,2) DEFAULT NULL,
  `date_renewed` datetime NOT NULL,
  `renewed_by` varchar(100) NOT NULL,
  `renewed_by_staff_id` int(11) NOT NULL DEFAULT 0,
  `is_on_old_expiry_notified` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_countries`
--

CREATE TABLE `ms_countries` (
  `country_id` int(5) NOT NULL,
  `iso2` char(2) DEFAULT NULL,
  `short_name` varchar(80) NOT NULL DEFAULT '',
  `long_name` varchar(80) NOT NULL DEFAULT '',
  `iso3` char(3) DEFAULT NULL,
  `numcode` varchar(6) DEFAULT NULL,
  `un_member` varchar(12) DEFAULT NULL,
  `calling_code` varchar(8) DEFAULT NULL,
  `cctld` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_countries`
--

INSERT INTO `ms_countries` (`country_id`, `iso2`, `short_name`, `long_name`, `iso3`, `numcode`, `un_member`, `calling_code`, `cctld`) VALUES
(1, 'AF', 'Afghanistan', 'Islamic Republic of Afghanistan', 'AFG', '004', 'yes', '93', '.af'),
(2, 'AX', 'Aland Islands', '&Aring;land Islands', 'ALA', '248', 'no', '358', '.ax'),
(3, 'AL', 'Albania', 'Republic of Albania', 'ALB', '008', 'yes', '355', '.al'),
(4, 'DZ', 'Algeria', 'People\'s Democratic Republic of Algeria', 'DZA', '012', 'yes', '213', '.dz'),
(5, 'AS', 'American Samoa', 'American Samoa', 'ASM', '016', 'no', '1+684', '.as'),
(6, 'AD', 'Andorra', 'Principality of Andorra', 'AND', '020', 'yes', '376', '.ad'),
(7, 'AO', 'Angola', 'Republic of Angola', 'AGO', '024', 'yes', '244', '.ao'),
(8, 'AI', 'Anguilla', 'Anguilla', 'AIA', '660', 'no', '1+264', '.ai'),
(9, 'AQ', 'Antarctica', 'Antarctica', 'ATA', '010', 'no', '672', '.aq'),
(10, 'AG', 'Antigua and Barbuda', 'Antigua and Barbuda', 'ATG', '028', 'yes', '1+268', '.ag'),
(11, 'AR', 'Argentina', 'Argentine Republic', 'ARG', '032', 'yes', '54', '.ar'),
(12, 'AM', 'Armenia', 'Republic of Armenia', 'ARM', '051', 'yes', '374', '.am'),
(13, 'AW', 'Aruba', 'Aruba', 'ABW', '533', 'no', '297', '.aw'),
(14, 'AU', 'Australia', 'Commonwealth of Australia', 'AUS', '036', 'yes', '61', '.au'),
(15, 'AT', 'Austria', 'Republic of Austria', 'AUT', '040', 'yes', '43', '.at'),
(16, 'AZ', 'Azerbaijan', 'Republic of Azerbaijan', 'AZE', '031', 'yes', '994', '.az'),
(17, 'BS', 'Bahamas', 'Commonwealth of The Bahamas', 'BHS', '044', 'yes', '1+242', '.bs'),
(18, 'BH', 'Bahrain', 'Kingdom of Bahrain', 'BHR', '048', 'yes', '973', '.bh'),
(19, 'BD', 'Bangladesh', 'People\'s Republic of Bangladesh', 'BGD', '050', 'yes', '880', '.bd'),
(20, 'BB', 'Barbados', 'Barbados', 'BRB', '052', 'yes', '1+246', '.bb'),
(21, 'BY', 'Belarus', 'Republic of Belarus', 'BLR', '112', 'yes', '375', '.by'),
(22, 'BE', 'Belgium', 'Kingdom of Belgium', 'BEL', '056', 'yes', '32', '.be'),
(23, 'BZ', 'Belize', 'Belize', 'BLZ', '084', 'yes', '501', '.bz'),
(24, 'BJ', 'Benin', 'Republic of Benin', 'BEN', '204', 'yes', '229', '.bj'),
(25, 'BM', 'Bermuda', 'Bermuda Islands', 'BMU', '060', 'no', '1+441', '.bm'),
(26, 'BT', 'Bhutan', 'Kingdom of Bhutan', 'BTN', '064', 'yes', '975', '.bt'),
(27, 'BO', 'Bolivia', 'Plurinational State of Bolivia', 'BOL', '068', 'yes', '591', '.bo'),
(28, 'BQ', 'Bonaire, Sint Eustatius and Saba', 'Bonaire, Sint Eustatius and Saba', 'BES', '535', 'no', '599', '.bq'),
(29, 'BA', 'Bosnia and Herzegovina', 'Bosnia and Herzegovina', 'BIH', '070', 'yes', '387', '.ba'),
(30, 'BW', 'Botswana', 'Republic of Botswana', 'BWA', '072', 'yes', '267', '.bw'),
(31, 'BV', 'Bouvet Island', 'Bouvet Island', 'BVT', '074', 'no', 'NONE', '.bv'),
(32, 'BR', 'Brazil', 'Federative Republic of Brazil', 'BRA', '076', 'yes', '55', '.br'),
(33, 'IO', 'British Indian Ocean Territory', 'British Indian Ocean Territory', 'IOT', '086', 'no', '246', '.io'),
(34, 'BN', 'Brunei', 'Brunei Darussalam', 'BRN', '096', 'yes', '673', '.bn'),
(35, 'BG', 'Bulgaria', 'Republic of Bulgaria', 'BGR', '100', 'yes', '359', '.bg'),
(36, 'BF', 'Burkina Faso', 'Burkina Faso', 'BFA', '854', 'yes', '226', '.bf'),
(37, 'BI', 'Burundi', 'Republic of Burundi', 'BDI', '108', 'yes', '257', '.bi'),
(38, 'KH', 'Cambodia', 'Kingdom of Cambodia', 'KHM', '116', 'yes', '855', '.kh'),
(39, 'CM', 'Cameroon', 'Republic of Cameroon', 'CMR', '120', 'yes', '237', '.cm'),
(40, 'CA', 'Canada', 'Canada', 'CAN', '124', 'yes', '1', '.ca'),
(41, 'CV', 'Cape Verde', 'Republic of Cape Verde', 'CPV', '132', 'yes', '238', '.cv'),
(42, 'KY', 'Cayman Islands', 'The Cayman Islands', 'CYM', '136', 'no', '1+345', '.ky'),
(43, 'CF', 'Central African Republic', 'Central African Republic', 'CAF', '140', 'yes', '236', '.cf'),
(44, 'TD', 'Chad', 'Republic of Chad', 'TCD', '148', 'yes', '235', '.td'),
(45, 'CL', 'Chile', 'Republic of Chile', 'CHL', '152', 'yes', '56', '.cl'),
(46, 'CN', 'China', 'People\'s Republic of China', 'CHN', '156', 'yes', '86', '.cn'),
(47, 'CX', 'Christmas Island', 'Christmas Island', 'CXR', '162', 'no', '61', '.cx'),
(48, 'CC', 'Cocos (Keeling) Islands', 'Cocos (Keeling) Islands', 'CCK', '166', 'no', '61', '.cc'),
(49, 'CO', 'Colombia', 'Republic of Colombia', 'COL', '170', 'yes', '57', '.co'),
(50, 'KM', 'Comoros', 'Union of the Comoros', 'COM', '174', 'yes', '269', '.km'),
(51, 'CG', 'Congo', 'Republic of the Congo', 'COG', '178', 'yes', '242', '.cg'),
(52, 'CK', 'Cook Islands', 'Cook Islands', 'COK', '184', 'some', '682', '.ck'),
(53, 'CR', 'Costa Rica', 'Republic of Costa Rica', 'CRI', '188', 'yes', '506', '.cr'),
(54, 'CI', 'Cote d\'ivoire (Ivory Coast)', 'Republic of C&ocirc;te D\'Ivoire (Ivory Coast)', 'CIV', '384', 'yes', '225', '.ci'),
(55, 'HR', 'Croatia', 'Republic of Croatia', 'HRV', '191', 'yes', '385', '.hr'),
(56, 'CU', 'Cuba', 'Republic of Cuba', 'CUB', '192', 'yes', '53', '.cu'),
(57, 'CW', 'Curacao', 'Cura&ccedil;ao', 'CUW', '531', 'no', '599', '.cw'),
(58, 'CY', 'Cyprus', 'Republic of Cyprus', 'CYP', '196', 'yes', '357', '.cy'),
(59, 'CZ', 'Czech Republic', 'Czech Republic', 'CZE', '203', 'yes', '420', '.cz'),
(60, 'CD', 'Democratic Republic of the Congo', 'Democratic Republic of the Congo', 'COD', '180', 'yes', '243', '.cd'),
(61, 'DK', 'Denmark', 'Kingdom of Denmark', 'DNK', '208', 'yes', '45', '.dk'),
(62, 'DJ', 'Djibouti', 'Republic of Djibouti', 'DJI', '262', 'yes', '253', '.dj'),
(63, 'DM', 'Dominica', 'Commonwealth of Dominica', 'DMA', '212', 'yes', '1+767', '.dm'),
(64, 'DO', 'Dominican Republic', 'Dominican Republic', 'DOM', '214', 'yes', '1+809, 8', '.do'),
(65, 'EC', 'Ecuador', 'Republic of Ecuador', 'ECU', '218', 'yes', '593', '.ec'),
(66, 'EG', 'Egypt', 'Arab Republic of Egypt', 'EGY', '818', 'yes', '20', '.eg'),
(67, 'SV', 'El Salvador', 'Republic of El Salvador', 'SLV', '222', 'yes', '503', '.sv'),
(68, 'GQ', 'Equatorial Guinea', 'Republic of Equatorial Guinea', 'GNQ', '226', 'yes', '240', '.gq'),
(69, 'ER', 'Eritrea', 'State of Eritrea', 'ERI', '232', 'yes', '291', '.er'),
(70, 'EE', 'Estonia', 'Republic of Estonia', 'EST', '233', 'yes', '372', '.ee'),
(71, 'ET', 'Ethiopia', 'Federal Democratic Republic of Ethiopia', 'ETH', '231', 'yes', '251', '.et'),
(72, 'FK', 'Falkland Islands (Malvinas)', 'The Falkland Islands (Malvinas)', 'FLK', '238', 'no', '500', '.fk'),
(73, 'FO', 'Faroe Islands', 'The Faroe Islands', 'FRO', '234', 'no', '298', '.fo'),
(74, 'FJ', 'Fiji', 'Republic of Fiji', 'FJI', '242', 'yes', '679', '.fj'),
(75, 'FI', 'Finland', 'Republic of Finland', 'FIN', '246', 'yes', '358', '.fi'),
(76, 'FR', 'France', 'French Republic', 'FRA', '250', 'yes', '33', '.fr'),
(77, 'GF', 'French Guiana', 'French Guiana', 'GUF', '254', 'no', '594', '.gf'),
(78, 'PF', 'French Polynesia', 'French Polynesia', 'PYF', '258', 'no', '689', '.pf'),
(79, 'TF', 'French Southern Territories', 'French Southern Territories', 'ATF', '260', 'no', NULL, '.tf'),
(80, 'GA', 'Gabon', 'Gabonese Republic', 'GAB', '266', 'yes', '241', '.ga'),
(81, 'GM', 'Gambia', 'Republic of The Gambia', 'GMB', '270', 'yes', '220', '.gm'),
(82, 'GE', 'Georgia', 'Georgia', 'GEO', '268', 'yes', '995', '.ge'),
(83, 'DE', 'Germany', 'Federal Republic of Germany', 'DEU', '276', 'yes', '49', '.de'),
(84, 'GH', 'Ghana', 'Republic of Ghana', 'GHA', '288', 'yes', '233', '.gh'),
(85, 'GI', 'Gibraltar', 'Gibraltar', 'GIB', '292', 'no', '350', '.gi'),
(86, 'GR', 'Greece', 'Hellenic Republic', 'GRC', '300', 'yes', '30', '.gr'),
(87, 'GL', 'Greenland', 'Greenland', 'GRL', '304', 'no', '299', '.gl'),
(88, 'GD', 'Grenada', 'Grenada', 'GRD', '308', 'yes', '1+473', '.gd'),
(89, 'GP', 'Guadaloupe', 'Guadeloupe', 'GLP', '312', 'no', '590', '.gp'),
(90, 'GU', 'Guam', 'Guam', 'GUM', '316', 'no', '1+671', '.gu'),
(91, 'GT', 'Guatemala', 'Republic of Guatemala', 'GTM', '320', 'yes', '502', '.gt'),
(92, 'GG', 'Guernsey', 'Guernsey', 'GGY', '831', 'no', '44', '.gg'),
(93, 'GN', 'Guinea', 'Republic of Guinea', 'GIN', '324', 'yes', '224', '.gn'),
(94, 'GW', 'Guinea-Bissau', 'Republic of Guinea-Bissau', 'GNB', '624', 'yes', '245', '.gw'),
(95, 'GY', 'Guyana', 'Co-operative Republic of Guyana', 'GUY', '328', 'yes', '592', '.gy'),
(96, 'HT', 'Haiti', 'Republic of Haiti', 'HTI', '332', 'yes', '509', '.ht'),
(97, 'HM', 'Heard Island and McDonald Islands', 'Heard Island and McDonald Islands', 'HMD', '334', 'no', 'NONE', '.hm'),
(98, 'HN', 'Honduras', 'Republic of Honduras', 'HND', '340', 'yes', '504', '.hn'),
(99, 'HK', 'Hong Kong', 'Hong Kong', 'HKG', '344', 'no', '852', '.hk'),
(100, 'HU', 'Hungary', 'Hungary', 'HUN', '348', 'yes', '36', '.hu'),
(101, 'IS', 'Iceland', 'Republic of Iceland', 'ISL', '352', 'yes', '354', '.is'),
(102, 'IN', 'India', 'Republic of India', 'IND', '356', 'yes', '91', '.in'),
(103, 'ID', 'Indonesia', 'Republic of Indonesia', 'IDN', '360', 'yes', '62', '.id'),
(104, 'IR', 'Iran', 'Islamic Republic of Iran', 'IRN', '364', 'yes', '98', '.ir'),
(105, 'IQ', 'Iraq', 'Republic of Iraq', 'IRQ', '368', 'yes', '964', '.iq'),
(106, 'IE', 'Ireland', 'Ireland', 'IRL', '372', 'yes', '353', '.ie'),
(107, 'IM', 'Isle of Man', 'Isle of Man', 'IMN', '833', 'no', '44', '.im'),
(108, 'IL', 'Israel', 'State of Israel', 'ISR', '376', 'yes', '972', '.il'),
(109, 'IT', 'Italy', 'Italian Republic', 'ITA', '380', 'yes', '39', '.jm'),
(110, 'JM', 'Jamaica', 'Jamaica', 'JAM', '388', 'yes', '1+876', '.jm'),
(111, 'JP', 'Japan', 'Japan', 'JPN', '392', 'yes', '81', '.jp'),
(112, 'JE', 'Jersey', 'The Bailiwick of Jersey', 'JEY', '832', 'no', '44', '.je'),
(113, 'JO', 'Jordan', 'Hashemite Kingdom of Jordan', 'JOR', '400', 'yes', '962', '.jo'),
(114, 'KZ', 'Kazakhstan', 'Republic of Kazakhstan', 'KAZ', '398', 'yes', '7', '.kz'),
(115, 'KE', 'Kenya', 'Republic of Kenya', 'KEN', '404', 'yes', '254', '.ke'),
(116, 'KI', 'Kiribati', 'Republic of Kiribati', 'KIR', '296', 'yes', '686', '.ki'),
(117, 'XK', 'Kosovo', 'Republic of Kosovo', '---', '---', 'some', '381', ''),
(118, 'KW', 'Kuwait', 'State of Kuwait', 'KWT', '414', 'yes', '965', '.kw'),
(119, 'KG', 'Kyrgyzstan', 'Kyrgyz Republic', 'KGZ', '417', 'yes', '996', '.kg'),
(120, 'LA', 'Laos', 'Lao People\'s Democratic Republic', 'LAO', '418', 'yes', '856', '.la'),
(121, 'LV', 'Latvia', 'Republic of Latvia', 'LVA', '428', 'yes', '371', '.lv'),
(122, 'LB', 'Lebanon', 'Republic of Lebanon', 'LBN', '422', 'yes', '961', '.lb'),
(123, 'LS', 'Lesotho', 'Kingdom of Lesotho', 'LSO', '426', 'yes', '266', '.ls'),
(124, 'LR', 'Liberia', 'Republic of Liberia', 'LBR', '430', 'yes', '231', '.lr'),
(125, 'LY', 'Libya', 'Libya', 'LBY', '434', 'yes', '218', '.ly'),
(126, 'LI', 'Liechtenstein', 'Principality of Liechtenstein', 'LIE', '438', 'yes', '423', '.li'),
(127, 'LT', 'Lithuania', 'Republic of Lithuania', 'LTU', '440', 'yes', '370', '.lt'),
(128, 'LU', 'Luxembourg', 'Grand Duchy of Luxembourg', 'LUX', '442', 'yes', '352', '.lu'),
(129, 'MO', 'Macao', 'The Macao Special Administrative Region', 'MAC', '446', 'no', '853', '.mo'),
(130, 'MK', 'North Macedonia', 'Republic of North Macedonia', 'MKD', '807', 'yes', '389', '.mk'),
(131, 'MG', 'Madagascar', 'Republic of Madagascar', 'MDG', '450', 'yes', '261', '.mg'),
(132, 'MW', 'Malawi', 'Republic of Malawi', 'MWI', '454', 'yes', '265', '.mw'),
(133, 'MY', 'Malaysia', 'Malaysia', 'MYS', '458', 'yes', '60', '.my'),
(134, 'MV', 'Maldives', 'Republic of Maldives', 'MDV', '462', 'yes', '960', '.mv'),
(135, 'ML', 'Mali', 'Republic of Mali', 'MLI', '466', 'yes', '223', '.ml'),
(136, 'MT', 'Malta', 'Republic of Malta', 'MLT', '470', 'yes', '356', '.mt'),
(137, 'MH', 'Marshall Islands', 'Republic of the Marshall Islands', 'MHL', '584', 'yes', '692', '.mh'),
(138, 'MQ', 'Martinique', 'Martinique', 'MTQ', '474', 'no', '596', '.mq'),
(139, 'MR', 'Mauritania', 'Islamic Republic of Mauritania', 'MRT', '478', 'yes', '222', '.mr'),
(140, 'MU', 'Mauritius', 'Republic of Mauritius', 'MUS', '480', 'yes', '230', '.mu'),
(141, 'YT', 'Mayotte', 'Mayotte', 'MYT', '175', 'no', '262', '.yt'),
(142, 'MX', 'Mexico', 'United Mexican States', 'MEX', '484', 'yes', '52', '.mx'),
(143, 'FM', 'Micronesia', 'Federated States of Micronesia', 'FSM', '583', 'yes', '691', '.fm'),
(144, 'MD', 'Moldava', 'Republic of Moldova', 'MDA', '498', 'yes', '373', '.md'),
(145, 'MC', 'Monaco', 'Principality of Monaco', 'MCO', '492', 'yes', '377', '.mc'),
(146, 'MN', 'Mongolia', 'Mongolia', 'MNG', '496', 'yes', '976', '.mn'),
(147, 'ME', 'Montenegro', 'Montenegro', 'MNE', '499', 'yes', '382', '.me'),
(148, 'MS', 'Montserrat', 'Montserrat', 'MSR', '500', 'no', '1+664', '.ms'),
(149, 'MA', 'Morocco', 'Kingdom of Morocco', 'MAR', '504', 'yes', '212', '.ma'),
(150, 'MZ', 'Mozambique', 'Republic of Mozambique', 'MOZ', '508', 'yes', '258', '.mz'),
(151, 'MM', 'Myanmar (Burma)', 'Republic of the Union of Myanmar', 'MMR', '104', 'yes', '95', '.mm'),
(152, 'NA', 'Namibia', 'Republic of Namibia', 'NAM', '516', 'yes', '264', '.na'),
(153, 'NR', 'Nauru', 'Republic of Nauru', 'NRU', '520', 'yes', '674', '.nr'),
(154, 'NP', 'Nepal', 'Federal Democratic Republic of Nepal', 'NPL', '524', 'yes', '977', '.np'),
(155, 'NL', 'Netherlands', 'Kingdom of the Netherlands', 'NLD', '528', 'yes', '31', '.nl'),
(156, 'NC', 'New Caledonia', 'New Caledonia', 'NCL', '540', 'no', '687', '.nc'),
(157, 'NZ', 'New Zealand', 'New Zealand', 'NZL', '554', 'yes', '64', '.nz'),
(158, 'NI', 'Nicaragua', 'Republic of Nicaragua', 'NIC', '558', 'yes', '505', '.ni'),
(159, 'NE', 'Niger', 'Republic of Niger', 'NER', '562', 'yes', '227', '.ne'),
(160, 'NG', 'Nigeria', 'Federal Republic of Nigeria', 'NGA', '566', 'yes', '234', '.ng'),
(161, 'NU', 'Niue', 'Niue', 'NIU', '570', 'some', '683', '.nu'),
(162, 'NF', 'Norfolk Island', 'Norfolk Island', 'NFK', '574', 'no', '672', '.nf'),
(163, 'KP', 'North Korea', 'Democratic People\'s Republic of Korea', 'PRK', '408', 'yes', '850', '.kp'),
(164, 'MP', 'Northern Mariana Islands', 'Northern Mariana Islands', 'MNP', '580', 'no', '1+670', '.mp'),
(165, 'NO', 'Norway', 'Kingdom of Norway', 'NOR', '578', 'yes', '47', '.no'),
(166, 'OM', 'Oman', 'Sultanate of Oman', 'OMN', '512', 'yes', '968', '.om'),
(167, 'PK', 'Pakistan', 'Islamic Republic of Pakistan', 'PAK', '586', 'yes', '92', '.pk'),
(168, 'PW', 'Palau', 'Republic of Palau', 'PLW', '585', 'yes', '680', '.pw'),
(169, 'PS', 'Palestine', 'State of Palestine (or Occupied Palestinian Territory)', 'PSE', '275', 'some', '970', '.ps'),
(170, 'PA', 'Panama', 'Republic of Panama', 'PAN', '591', 'yes', '507', '.pa'),
(171, 'PG', 'Papua New Guinea', 'Independent State of Papua New Guinea', 'PNG', '598', 'yes', '675', '.pg'),
(172, 'PY', 'Paraguay', 'Republic of Paraguay', 'PRY', '600', 'yes', '595', '.py'),
(173, 'PE', 'Peru', 'Republic of Peru', 'PER', '604', 'yes', '51', '.pe'),
(174, 'PH', 'Phillipines', 'Republic of the Philippines', 'PHL', '608', 'yes', '63', '.ph'),
(175, 'PN', 'Pitcairn', 'Pitcairn', 'PCN', '612', 'no', 'NONE', '.pn'),
(176, 'PL', 'Poland', 'Republic of Poland', 'POL', '616', 'yes', '48', '.pl'),
(177, 'PT', 'Portugal', 'Portuguese Republic', 'PRT', '620', 'yes', '351', '.pt'),
(178, 'PR', 'Puerto Rico', 'Commonwealth of Puerto Rico', 'PRI', '630', 'no', '1+939', '.pr'),
(179, 'QA', 'Qatar', 'State of Qatar', 'QAT', '634', 'yes', '974', '.qa'),
(180, 'RE', 'Reunion', 'R&eacute;union', 'REU', '638', 'no', '262', '.re'),
(181, 'RO', 'Romania', 'Romania', 'ROU', '642', 'yes', '40', '.ro'),
(182, 'RU', 'Russia', 'Russian Federation', 'RUS', '643', 'yes', '7', '.ru'),
(183, 'RW', 'Rwanda', 'Republic of Rwanda', 'RWA', '646', 'yes', '250', '.rw'),
(184, 'BL', 'Saint Barthelemy', 'Saint Barth&eacute;lemy', 'BLM', '652', 'no', '590', '.bl'),
(185, 'SH', 'Saint Helena', 'Saint Helena, Ascension and Tristan da Cunha', 'SHN', '654', 'no', '290', '.sh'),
(186, 'KN', 'Saint Kitts and Nevis', 'Federation of Saint Christopher and Nevis', 'KNA', '659', 'yes', '1+869', '.kn'),
(187, 'LC', 'Saint Lucia', 'Saint Lucia', 'LCA', '662', 'yes', '1+758', '.lc'),
(188, 'MF', 'Saint Martin', 'Saint Martin', 'MAF', '663', 'no', '590', '.mf'),
(189, 'PM', 'Saint Pierre and Miquelon', 'Saint Pierre and Miquelon', 'SPM', '666', 'no', '508', '.pm'),
(190, 'VC', 'Saint Vincent and the Grenadines', 'Saint Vincent and the Grenadines', 'VCT', '670', 'yes', '1+784', '.vc'),
(191, 'WS', 'Samoa', 'Independent State of Samoa', 'WSM', '882', 'yes', '685', '.ws'),
(192, 'SM', 'San Marino', 'Republic of San Marino', 'SMR', '674', 'yes', '378', '.sm'),
(193, 'ST', 'Sao Tome and Principe', 'Democratic Republic of S&atilde;o Tom&eacute; and Pr&iacute;ncipe', 'STP', '678', 'yes', '239', '.st'),
(194, 'SA', 'Saudi Arabia', 'Kingdom of Saudi Arabia', 'SAU', '682', 'yes', '966', '.sa'),
(195, 'SN', 'Senegal', 'Republic of Senegal', 'SEN', '686', 'yes', '221', '.sn'),
(196, 'RS', 'Serbia', 'Republic of Serbia', 'SRB', '688', 'yes', '381', '.rs'),
(197, 'SC', 'Seychelles', 'Republic of Seychelles', 'SYC', '690', 'yes', '248', '.sc'),
(198, 'SL', 'Sierra Leone', 'Republic of Sierra Leone', 'SLE', '694', 'yes', '232', '.sl'),
(199, 'SG', 'Singapore', 'Republic of Singapore', 'SGP', '702', 'yes', '65', '.sg'),
(200, 'SX', 'Sint Maarten', 'Sint Maarten', 'SXM', '534', 'no', '1+721', '.sx'),
(201, 'SK', 'Slovakia', 'Slovak Republic', 'SVK', '703', 'yes', '421', '.sk'),
(202, 'SI', 'Slovenia', 'Republic of Slovenia', 'SVN', '705', 'yes', '386', '.si'),
(203, 'SB', 'Solomon Islands', 'Solomon Islands', 'SLB', '090', 'yes', '677', '.sb'),
(204, 'SO', 'Somalia', 'Somali Republic', 'SOM', '706', 'yes', '252', '.so'),
(205, 'ZA', 'South Africa', 'Republic of South Africa', 'ZAF', '710', 'yes', '27', '.za'),
(206, 'GS', 'South Georgia and the South Sandwich Islands', 'South Georgia and the South Sandwich Islands', 'SGS', '239', 'no', '500', '.gs'),
(207, 'KR', 'South Korea', 'Republic of Korea', 'KOR', '410', 'yes', '82', '.kr'),
(208, 'SS', 'South Sudan', 'Republic of South Sudan', 'SSD', '728', 'yes', '211', '.ss'),
(209, 'ES', 'Spain', 'Kingdom of Spain', 'ESP', '724', 'yes', '34', '.es'),
(210, 'LK', 'Sri Lanka', 'Democratic Socialist Republic of Sri Lanka', 'LKA', '144', 'yes', '94', '.lk'),
(211, 'SD', 'Sudan', 'Republic of the Sudan', 'SDN', '729', 'yes', '249', '.sd'),
(212, 'SR', 'Suriname', 'Republic of Suriname', 'SUR', '740', 'yes', '597', '.sr'),
(213, 'SJ', 'Svalbard and Jan Mayen', 'Svalbard and Jan Mayen', 'SJM', '744', 'no', '47', '.sj'),
(214, 'SZ', 'Swaziland', 'Kingdom of Swaziland', 'SWZ', '748', 'yes', '268', '.sz'),
(215, 'SE', 'Sweden', 'Kingdom of Sweden', 'SWE', '752', 'yes', '46', '.se'),
(216, 'CH', 'Switzerland', 'Swiss Confederation', 'CHE', '756', 'yes', '41', '.ch'),
(217, 'SY', 'Syria', 'Syrian Arab Republic', 'SYR', '760', 'yes', '963', '.sy'),
(218, 'TW', 'Taiwan', 'Republic of China (Taiwan)', 'TWN', '158', 'former', '886', '.tw'),
(219, 'TJ', 'Tajikistan', 'Republic of Tajikistan', 'TJK', '762', 'yes', '992', '.tj'),
(220, 'TZ', 'Tanzania', 'United Republic of Tanzania', 'TZA', '834', 'yes', '255', '.tz'),
(221, 'TH', 'Thailand', 'Kingdom of Thailand', 'THA', '764', 'yes', '66', '.th'),
(222, 'TL', 'Timor-Leste (East Timor)', 'Democratic Republic of Timor-Leste', 'TLS', '626', 'yes', '670', '.tl'),
(223, 'TG', 'Togo', 'Togolese Republic', 'TGO', '768', 'yes', '228', '.tg'),
(224, 'TK', 'Tokelau', 'Tokelau', 'TKL', '772', 'no', '690', '.tk'),
(225, 'TO', 'Tonga', 'Kingdom of Tonga', 'TON', '776', 'yes', '676', '.to'),
(226, 'TT', 'Trinidad and Tobago', 'Republic of Trinidad and Tobago', 'TTO', '780', 'yes', '1+868', '.tt'),
(227, 'TN', 'Tunisia', 'Republic of Tunisia', 'TUN', '788', 'yes', '216', '.tn'),
(228, 'TR', 'Turkey', 'Republic of Turkey', 'TUR', '792', 'yes', '90', '.tr'),
(229, 'TM', 'Turkmenistan', 'Turkmenistan', 'TKM', '795', 'yes', '993', '.tm'),
(230, 'TC', 'Turks and Caicos Islands', 'Turks and Caicos Islands', 'TCA', '796', 'no', '1+649', '.tc'),
(231, 'TV', 'Tuvalu', 'Tuvalu', 'TUV', '798', 'yes', '688', '.tv'),
(232, 'UG', 'Uganda', 'Republic of Uganda', 'UGA', '800', 'yes', '256', '.ug'),
(233, 'UA', 'Ukraine', 'Ukraine', 'UKR', '804', 'yes', '380', '.ua'),
(234, 'AE', 'United Arab Emirates', 'United Arab Emirates', 'ARE', '784', 'yes', '971', '.ae'),
(235, 'GB', 'United Kingdom', 'United Kingdom of Great Britain and Nothern Ireland', 'GBR', '826', 'yes', '44', '.uk'),
(236, 'US', 'United States', 'United States of America', 'USA', '840', 'yes', '1', '.us'),
(237, 'UM', 'United States Minor Outlying Islands', 'United States Minor Outlying Islands', 'UMI', '581', 'no', 'NONE', 'NONE'),
(238, 'UY', 'Uruguay', 'Eastern Republic of Uruguay', 'URY', '858', 'yes', '598', '.uy'),
(239, 'UZ', 'Uzbekistan', 'Republic of Uzbekistan', 'UZB', '860', 'yes', '998', '.uz'),
(240, 'VU', 'Vanuatu', 'Republic of Vanuatu', 'VUT', '548', 'yes', '678', '.vu'),
(241, 'VA', 'Vatican City', 'State of the Vatican City', 'VAT', '336', 'no', '39', '.va'),
(242, 'VE', 'Venezuela', 'Bolivarian Republic of Venezuela', 'VEN', '862', 'yes', '58', '.ve'),
(243, 'VN', 'Vietnam', 'Socialist Republic of Vietnam', 'VNM', '704', 'yes', '84', '.vn'),
(244, 'VG', 'Virgin Islands, British', 'British Virgin Islands', 'VGB', '092', 'no', '1+284', '.vg'),
(245, 'VI', 'Virgin Islands, US', 'Virgin Islands of the United States', 'VIR', '850', 'no', '1+340', '.vi'),
(246, 'WF', 'Wallis and Futuna', 'Wallis and Futuna', 'WLF', '876', 'no', '681', '.wf'),
(247, 'EH', 'Western Sahara', 'Western Sahara', 'ESH', '732', 'no', '212', '.eh'),
(248, 'YE', 'Yemen', 'Republic of Yemen', 'YEM', '887', 'yes', '967', '.ye'),
(249, 'ZM', 'Zambia', 'Republic of Zambia', 'ZMB', '894', 'yes', '260', '.zm'),
(250, 'ZW', 'Zimbabwe', 'Republic of Zimbabwe', 'ZWE', '716', 'yes', '263', '.zw');

-- --------------------------------------------------------

--
-- Table structure for table `ms_creditnotes`
--

CREATE TABLE `ms_creditnotes` (
  `id` int(11) NOT NULL,
  `clientid` int(11) NOT NULL,
  `deleted_customer_name` varchar(100) DEFAULT NULL,
  `number` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `number_format` int(11) NOT NULL DEFAULT 1,
  `datecreated` datetime NOT NULL,
  `date` date NOT NULL,
  `adminnote` text DEFAULT NULL,
  `terms` text DEFAULT NULL,
  `clientnote` text DEFAULT NULL,
  `currency` int(11) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `total_tax` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total` decimal(15,2) NOT NULL,
  `adjustment` decimal(15,2) DEFAULT NULL,
  `addedfrom` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `discount_percent` decimal(15,2) DEFAULT 0.00,
  `discount_total` decimal(15,2) DEFAULT 0.00,
  `discount_type` varchar(30) NOT NULL,
  `billing_street` varchar(200) DEFAULT NULL,
  `billing_city` varchar(100) DEFAULT NULL,
  `billing_state` varchar(100) DEFAULT NULL,
  `billing_zip` varchar(100) DEFAULT NULL,
  `billing_country` int(11) DEFAULT NULL,
  `shipping_street` varchar(200) DEFAULT NULL,
  `shipping_city` varchar(100) DEFAULT NULL,
  `shipping_state` varchar(100) DEFAULT NULL,
  `shipping_zip` varchar(100) DEFAULT NULL,
  `shipping_country` int(11) DEFAULT NULL,
  `include_shipping` tinyint(1) NOT NULL,
  `show_shipping_on_credit_note` tinyint(1) NOT NULL DEFAULT 1,
  `show_quantity_as` int(11) NOT NULL DEFAULT 1,
  `reference_no` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_creditnote_refunds`
--

CREATE TABLE `ms_creditnote_refunds` (
  `id` int(11) NOT NULL,
  `credit_note_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `refunded_on` date NOT NULL,
  `payment_mode` varchar(40) NOT NULL,
  `note` text DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_credits`
--

CREATE TABLE `ms_credits` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `credit_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `date_applied` datetime NOT NULL,
  `amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_currencies`
--

CREATE TABLE `ms_currencies` (
  `id` int(11) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `decimal_separator` varchar(5) DEFAULT NULL,
  `thousand_separator` varchar(5) DEFAULT NULL,
  `placement` varchar(10) DEFAULT NULL,
  `isdefault` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_currencies`
--

INSERT INTO `ms_currencies` (`id`, `symbol`, `name`, `decimal_separator`, `thousand_separator`, `placement`, `isdefault`) VALUES
(1, '$', 'USD', '.', ',', 'before', 0),
(2, 'â‚¬', 'EUR', ',', '.', 'before', 0),
(3, '₹', 'INR', '.', ',', 'before', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_customers_groups`
--

CREATE TABLE `ms_customers_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_customer_admins`
--

CREATE TABLE `ms_customer_admins` (
  `staff_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `date_assigned` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_customer_groups`
--

CREATE TABLE `ms_customer_groups` (
  `id` int(11) NOT NULL,
  `groupid` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_customfields`
--

CREATE TABLE `ms_customfields` (
  `id` int(11) NOT NULL,
  `fieldto` varchar(15) NOT NULL,
  `name` varchar(150) NOT NULL,
  `slug` varchar(150) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(20) NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `display_inline` tinyint(1) NOT NULL DEFAULT 0,
  `field_order` int(11) DEFAULT 0,
  `active` int(11) NOT NULL DEFAULT 1,
  `show_on_pdf` int(11) NOT NULL DEFAULT 0,
  `show_on_ticket_form` tinyint(1) NOT NULL DEFAULT 0,
  `only_admin` tinyint(1) NOT NULL DEFAULT 0,
  `show_on_table` tinyint(1) NOT NULL DEFAULT 0,
  `show_on_client_portal` int(11) NOT NULL DEFAULT 0,
  `disalow_client_to_edit` int(11) NOT NULL DEFAULT 0,
  `bs_column` int(11) NOT NULL DEFAULT 12
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_customfieldsvalues`
--

CREATE TABLE `ms_customfieldsvalues` (
  `id` int(11) NOT NULL,
  `relid` int(11) NOT NULL,
  `fieldid` int(11) NOT NULL,
  `fieldto` varchar(15) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_departments`
--

CREATE TABLE `ms_departments` (
  `departmentid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `imap_username` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `email_from_header` tinyint(1) NOT NULL DEFAULT 0,
  `host` varchar(150) DEFAULT NULL,
  `password` mediumtext DEFAULT NULL,
  `encryption` varchar(3) DEFAULT NULL,
  `delete_after_import` int(11) NOT NULL DEFAULT 0,
  `calendar_id` mediumtext DEFAULT NULL,
  `hidefromclient` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_dismissed_announcements`
--

CREATE TABLE `ms_dismissed_announcements` (
  `dismissedannouncementid` int(11) NOT NULL,
  `announcementid` int(11) NOT NULL,
  `staff` int(11) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_emaillists`
--

CREATE TABLE `ms_emaillists` (
  `listid` int(11) NOT NULL,
  `name` mediumtext NOT NULL,
  `creator` varchar(100) NOT NULL,
  `datecreated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_emailtemplates`
--

CREATE TABLE `ms_emailtemplates` (
  `emailtemplateid` int(11) NOT NULL,
  `type` mediumtext NOT NULL,
  `slug` varchar(100) NOT NULL,
  `language` varchar(40) DEFAULT NULL,
  `name` mediumtext NOT NULL,
  `subject` mediumtext NOT NULL,
  `message` text NOT NULL,
  `fromname` mediumtext NOT NULL,
  `fromemail` varchar(100) DEFAULT NULL,
  `plaintext` int(11) NOT NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_emailtemplates`
--

INSERT INTO `ms_emailtemplates` (`emailtemplateid`, `type`, `slug`, `language`, `name`, `subject`, `message`, `fromname`, `fromemail`, `plaintext`, `active`, `order`) VALUES
(1, 'client', 'new-client-created', 'english', 'New Contact Added/Registered (Welcome Email)', 'Welcome aboard', 'Dear {contact_firstname} {contact_lastname}<br /><br />Thank you for registering on the <strong>{companyname}</strong> CRM System.<br /><br />We just wanted to say welcome.<br /><br />Please contact us if you need any help.<br /><br />Click here to view your profile: <a href=\"{crm_url}\">{crm_url}</a><br /><br />Kind Regards, <br />{email_signature}<br /><br />(This is an automated email, so please don\'t reply to this email address)', '{companyname} | CRM', '', 0, 1, 0),
(2, 'invoice', 'invoice-send-to-client', 'english', 'Send Invoice to Customer', 'Invoice with number {invoice_number} created', '<span style=\"font-size: 12pt;\">Dear {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">We have prepared the following invoice for you: <strong># {invoice_number}</strong></span><br /><br /><span style=\"font-size: 12pt;\"><strong>Invoice status</strong>: {invoice_status}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the invoice on the following link: <a href=\"{invoice_link}\">{invoice_number}</a></span><br /><br /><span style=\"font-size: 12pt;\">Please contact us for more information.</span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(3, 'ticket', 'new-ticket-opened-admin', 'english', 'New Ticket Opened (Opened by Staff, Sent to Customer)', 'New Support Ticket Opened', '<span style=\"font-size: 12pt;\">Hi {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">New support ticket has been opened.</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Subject:</strong> {ticket_subject}</span><br /><span style=\"font-size: 12pt;\"><strong>Department:</strong> {ticket_department}</span><br /><span style=\"font-size: 12pt;\"><strong>Priority:</strong> {ticket_priority}</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Ticket message:</strong></span><br /><span style=\"font-size: 12pt;\">{ticket_message}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the ticket on the following link: <a href=\"{ticket_url}\">#{ticket_id}<br /><br /></a>Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(4, 'ticket', 'ticket-reply', 'english', 'Ticket Reply (Sent to Customer)', 'New Ticket Reply', '<span style=\"font-size: 12pt;\">Hi {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">You have a new ticket reply to ticket <a href=\"{ticket_url}\">#{ticket_id}</a></span><br /><br /><span style=\"font-size: 12pt;\"><strong>Ticket Subject:</strong> {ticket_subject}<br /></span><br /><span style=\"font-size: 12pt;\"><strong>Ticket message:</strong></span><br /><span style=\"font-size: 12pt;\">{ticket_message}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the ticket on the following link: <a href=\"{ticket_url}\">#{ticket_id}</a></span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(5, 'ticket', 'ticket-autoresponse', 'english', 'New Ticket Opened - Autoresponse', 'New Support Ticket Opened', '<span style=\"font-size: 12pt;\">Hi {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">Thank you for contacting our support team. A support ticket has now been opened for your request. You will be notified when a response is made by email.</span><br /> <br /><span style=\"font-size: 12pt;\"><strong>Subject:</strong> {ticket_subject}</span><br /><span style=\"font-size: 12pt;\"><strong>Department</strong>: {ticket_department}</span><br /><span style=\"font-size: 12pt;\"><strong>Priority:</strong> {ticket_priority}</span><br /> <br /><span style=\"font-size: 12pt;\"><strong>Ticket message:</strong></span><br /><span style=\"font-size: 12pt;\">{ticket_message}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the ticket on the following link: <a href=\"{ticket_url}\">#{ticket_id}</a></span><br /> <br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(6, 'invoice', 'invoice-payment-recorded', 'english', 'Invoice Payment Recorded (Sent to Customer)', 'Invoice Payment Recorded', '<span style=\"font-size: 12pt;\">Hello {contact_firstname}&nbsp;{contact_lastname}<br /><br /></span>Thank you for the payment. Find the payment details below:<br /><br />-------------------------------------------------<br /><br />Amount:&nbsp;<strong>{payment_total}<br /></strong>Date:&nbsp;<strong>{payment_date}</strong><br />Invoice number:&nbsp;<span style=\"font-size: 12pt;\"><strong># {invoice_number}<br /><br /></strong></span>-------------------------------------------------<br /><br />You can always view the invoice for this payment at the following link:&nbsp;<a href=\"{invoice_link}\"><span style=\"font-size: 12pt;\">{invoice_number}</span></a><br /><br />We are looking forward working with you.<br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(7, 'invoice', 'invoice-overdue-notice', 'english', 'Invoice Overdue Notice', 'Invoice Overdue Notice - {invoice_number}', '<span style=\"font-size: 12pt;\">Hi {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">This is an overdue notice for invoice <strong># {invoice_number}</strong></span><br /><br /><span style=\"font-size: 12pt;\">This invoice was due: {invoice_duedate}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the invoice on the following link: <a href=\"{invoice_link}\">{invoice_number}</a></span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(8, 'invoice', 'invoice-already-send', 'english', 'Invoice Already Sent to Customer', 'Invoice # {invoice_number} ', '<span style=\"font-size: 12pt;\">Hi {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">At your request, here is the invoice with number <strong># {invoice_number}</strong></span><br /><br /><span style=\"font-size: 12pt;\">You can view the invoice on the following link: <a href=\"{invoice_link}\">{invoice_number}</a></span><br /><br /><span style=\"font-size: 12pt;\">Please contact us for more information.</span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(9, 'ticket', 'new-ticket-created-staff', 'english', 'New Ticket Created (Opened by Customer, Sent to Staff Members)', 'New Ticket Created', '<span style=\"font-size: 12pt;\">A new support ticket has been opened.</span><br /> <br /><span style=\"font-size: 12pt;\"><strong>Subject</strong>: {ticket_subject}</span><br /><span style=\"font-size: 12pt;\"><strong>Department</strong>: {ticket_department}</span><br /><span style=\"font-size: 12pt;\"><strong>Priority</strong>: {ticket_priority}</span><br /> <br /><span style=\"font-size: 12pt;\"><strong>Ticket message:</strong></span><br /><span style=\"font-size: 12pt;\">{ticket_message}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the ticket on the following link: <a href=\"{ticket_url}\">#{ticket_id}<br /></a></span><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(10, 'estimate', 'estimate-send-to-client', 'english', 'Send Estimate to Customer', 'Estimate # {estimate_number} created', '<span style=\"font-size: 12pt;\">Dear {contact_firstname} {contact_lastname}</span><br /> <br /><span style=\"font-size: 12pt;\">Please find the attached estimate <strong># {estimate_number}</strong></span><br /> <br /><span style=\"font-size: 12pt;\"><strong>Estimate status:</strong> {estimate_status}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the estimate on the following link: <a href=\"{estimate_link}\">{estimate_number}</a></span><br /> <br /><span style=\"font-size: 12pt;\">We look forward to your communication.</span><br /> <br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}<br /></span>', '{companyname} | CRM', '', 0, 1, 0),
(11, 'ticket', 'ticket-reply-to-admin', 'english', 'Ticket Reply (Sent to Staff)', 'New Support Ticket Reply', '<span style=\"font-size: 12pt;\">A new support ticket reply from {contact_firstname} {contact_lastname}</span><br /> <br /><span style=\"font-size: 12pt;\"><strong>Subject</strong>: {ticket_subject}</span><br /><span style=\"font-size: 12pt;\"><strong>Department</strong>: {ticket_department}</span><br /><span style=\"font-size: 12pt;\"><strong>Priority</strong>: {ticket_priority}</span><br /> <br /><span style=\"font-size: 12pt;\"><strong>Ticket message:</strong></span><br /><span style=\"font-size: 12pt;\">{ticket_message}</span><br /> <br /><span style=\"font-size: 12pt;\">You can view the ticket on the following link: <a href=\"{ticket_url}\">#{ticket_id}</a></span><br /> <br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(12, 'estimate', 'estimate-already-send', 'english', 'Estimate Already Sent to Customer', 'Estimate # {estimate_number} ', '<span style=\"font-size: 12pt;\">Dear {contact_firstname} {contact_lastname}</span><br /> <br /><span style=\"font-size: 12pt;\">Thank you for your estimate request.</span><br /> <br /><span style=\"font-size: 12pt;\">You can view the estimate on the following link: <a href=\"{estimate_link}\">{estimate_number}</a></span><br /> <br /><span style=\"font-size: 12pt;\">Please contact us for more information.</span><br /> <br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(13, 'contract', 'contract-expiration', 'english', 'Contract Expiration Reminder (Sent to Customer Contacts)', 'Contract Expiration Reminder', '<span style=\"font-size: 12pt;\">Dear {client_company}</span><br /><br /><span style=\"font-size: 12pt;\">This is a reminder that the following contract will expire soon:</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Subject:</strong> {contract_subject}</span><br /><span style=\"font-size: 12pt;\"><strong>Description:</strong> {contract_description}</span><br /><span style=\"font-size: 12pt;\"><strong>Date Start:</strong> {contract_datestart}</span><br /><span style=\"font-size: 12pt;\"><strong>Date End:</strong> {contract_dateend}</span><br /><br /><span style=\"font-size: 12pt;\">Please contact us for more information.</span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(14, 'tasks', 'task-assigned', 'english', 'New Task Assigned (Sent to Staff)', 'New Task Assigned to You - {task_name}', '<span style=\"font-size: 12pt;\">Dear {staff_firstname}</span><br /><br /><span style=\"font-size: 12pt;\">You have been assigned to a new task:</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Name:</strong> {task_name}<br /></span><strong>Start Date:</strong> {task_startdate}<br /><span style=\"font-size: 12pt;\"><strong>Due date:</strong> {task_duedate}</span><br /><span style=\"font-size: 12pt;\"><strong>Priority:</strong> {task_priority}<br /><br /></span><span style=\"font-size: 12pt;\"><span>You can view the task on the following link</span>: <a href=\"{task_link}\">{task_name}</a></span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(15, 'tasks', 'task-added-as-follower', 'english', 'Staff Member Added as Follower on Task (Sent to Staff)', 'You are added as follower on task - {task_name}', '<span style=\"font-size: 12pt;\">Hi {staff_firstname}<br /></span><br /><span style=\"font-size: 12pt;\">You have been added as follower on the following task:</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Name:</strong> {task_name}</span><br /><span style=\"font-size: 12pt;\"><strong>Start date:</strong> {task_startdate}</span><br /><br /><span>You can view the task on the following link</span><span>: </span><a href=\"{task_link}\">{task_name}</a><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(16, 'tasks', 'task-commented', 'english', 'New Comment on Task (Sent to Staff)', 'New Comment on Task - {task_name}', 'Dear {staff_firstname}<br /><br />A comment has been made on the following task:<br /><br /><strong>Name:</strong> {task_name}<br /><strong>Comment:</strong> {task_comment}<br /><br />You can view the task on the following link: <a href=\"{task_link}\">{task_name}</a><br /><br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(17, 'tasks', 'task-added-attachment', 'english', 'New Attachment(s) on Task (Sent to Staff)', 'New Attachment on Task - {task_name}', 'Hi {staff_firstname}<br /><br /><strong>{task_user_take_action}</strong> added an attachment on the following task:<br /><br /><strong>Name:</strong> {task_name}<br /><br />You can view the task on the following link: <a href=\"{task_link}\">{task_name}</a><br /><br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(18, 'estimate', 'estimate-declined-to-staff', 'english', 'Estimate Declined (Sent to Staff)', 'Customer Declined Estimate', '<span style=\"font-size: 12pt;\">Hi</span><br /> <br /><span style=\"font-size: 12pt;\">Customer ({client_company}) declined estimate with number <strong># {estimate_number}</strong></span><br /> <br /><span style=\"font-size: 12pt;\">You can view the estimate on the following link: <a href=\"{estimate_link}\">{estimate_number}</a></span><br /> <br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(19, 'estimate', 'estimate-accepted-to-staff', 'english', 'Estimate Accepted (Sent to Staff)', 'Customer Accepted Estimate', '<span style=\"font-size: 12pt;\">Hi</span><br /> <br /><span style=\"font-size: 12pt;\">Customer ({client_company}) accepted estimate with number <strong># {estimate_number}</strong></span><br /> <br /><span style=\"font-size: 12pt;\">You can view the estimate on the following link: <a href=\"{estimate_link}\">{estimate_number}</a></span><br /> <br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(20, 'proposals', 'proposal-client-accepted', 'english', 'Customer Action - Accepted (Sent to Staff)', 'Customer Accepted Proposal', '<div>Hi<br /> <br />Client <strong>{proposal_proposal_to}</strong> accepted the following proposal:<br /> <br /><strong>Number:</strong> {proposal_number}<br /><strong>Subject</strong>: {proposal_subject}<br /><strong>Total</strong>: {proposal_total}<br /> <br />View the proposal on the following link: <a href=\"{proposal_link}\">{proposal_number}</a><br /> <br />Kind Regards,<br />{email_signature}</div>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>\r\n<div>&nbsp;</div>', '{companyname} | CRM', '', 0, 1, 0),
(21, 'proposals', 'proposal-send-to-customer', 'english', 'Send Proposal to Customer', 'Proposal With Number {proposal_number} Created', 'Dear {proposal_proposal_to}<br /><br />Please find our attached proposal.<br /><br />This proposal is valid until: {proposal_open_till}<br />You can view the proposal on the following link: <a href=\"{proposal_link}\">{proposal_number}</a><br /><br />Please don\'t hesitate to comment online if you have any questions.<br /><br />We look forward to your communication.<br /><br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(22, 'proposals', 'proposal-client-declined', 'english', 'Customer Action - Declined (Sent to Staff)', 'Client Declined Proposal', 'Hi<br /> <br />Customer <strong>{proposal_proposal_to}</strong> declined the proposal <strong>{proposal_subject}</strong><br /> <br />View the proposal on the following link <a href=\"{proposal_link}\">{proposal_number}</a>&nbsp;or from the admin area.<br /> <br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(23, 'proposals', 'proposal-client-thank-you', 'english', 'Thank You Email (Sent to Customer After Accept)', 'Thank for you accepting proposal', 'Dear {proposal_proposal_to}<br /> <br />Thank for for accepting the proposal.<br /> <br />We look forward to doing business with you.<br /> <br />We will contact you as soon as possible<br /> <br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(24, 'proposals', 'proposal-comment-to-client', 'english', 'New Comment Â (Sent to Customer/Lead)', 'New Proposal Comment', 'Dear {proposal_proposal_to}<br /> <br />A new comment has been made on the following proposal: <strong>{proposal_number}</strong><br /> <br />You can view and reply to the comment on the following link: <a href=\"{proposal_link}\">{proposal_number}</a><br /> <br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(25, 'proposals', 'proposal-comment-to-admin', 'english', 'New Comment (Sent to Staff) ', 'New Proposal Comment', 'Hi<br /> <br />A new comment has been made to the proposal <strong>{proposal_subject}</strong><br /> <br />You can view and reply to the comment on the following link: <a href=\"{proposal_link}\">{proposal_number}</a>&nbsp;or from the admin area.<br /> <br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(26, 'estimate', 'estimate-thank-you-to-customer', 'english', 'Thank You Email (Sent to Customer After Accept)', 'Thank for you accepting estimate', '<span style=\"font-size: 12pt;\">Dear {contact_firstname} {contact_lastname}</span><br /> <br /><span style=\"font-size: 12pt;\">Thank for for accepting the estimate.</span><br /> <br /><span style=\"font-size: 12pt;\">We look forward to doing business with you.</span><br /> <br /><span style=\"font-size: 12pt;\">We will contact you as soon as possible.</span><br /> <br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(27, 'tasks', 'task-deadline-notification', 'english', 'Task Deadline Reminder - Sent to Assigned Members', 'Task Deadline Reminder', 'Hi {staff_firstname}&nbsp;{staff_lastname}<br /><br />This is an automated email from {companyname}.<br /><br />The task <strong>{task_name}</strong> deadline is on <strong>{task_duedate}</strong>. <br />This task is still not finished.<br /><br />You can view the task on the following link: <a href=\"{task_link}\">{task_name}</a><br /><br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(28, 'contract', 'send-contract', 'english', 'Send Contract to Customer', 'Contract - {contract_subject}', '<p><span style=\"font-size: 12pt;\">Hi&nbsp;{contact_firstname}&nbsp;{contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">Please find the {contract_subject} attached.<br /><br /></span><span style=\"font-size: 12pt;\">Looking forward to hear from you.</span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span></p>', '{companyname} | CRM', '', 0, 1, 0),
(29, 'invoice', 'invoice-payment-recorded-to-staff', 'english', 'Invoice Payment Recorded (Sent to Staff)', 'New Invoice Payment', '<span style=\"font-size: 12pt;\">Hi</span><br /><br /><span style=\"font-size: 12pt;\">Customer recorded payment for invoice <strong># {invoice_number}</strong></span><br /> <br /><span style=\"font-size: 12pt;\">You can view the invoice on the following link: <a href=\"{invoice_link}\">{invoice_number}</a></span><br /> <br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(30, 'ticket', 'auto-close-ticket', 'english', 'Auto Close Ticket', 'Ticket Auto Closed', '<p><span style=\"font-size: 12pt;\">Hi {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">Ticket {ticket_subject} has been auto close due to inactivity.</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Ticket #</strong>: <a href=\"{ticket_url}\">{ticket_id}</a></span><br /><span style=\"font-size: 12pt;\"><strong>Department</strong>: {ticket_department}</span><br /><span style=\"font-size: 12pt;\"><strong>Priority:</strong> {ticket_priority}</span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span></p>', '{companyname} | CRM', '', 0, 1, 0),
(31, 'project', 'new-project-discussion-created-to-staff', 'english', 'New Project Discussion (Sent to Project Members)', 'New Project Discussion Created - {project_name}', '<p>Hi {staff_firstname}<br /><br />New project discussion created from <strong>{discussion_creator}</strong><br /><br /><strong>Subject:</strong> {discussion_subject}<br /><strong>Description:</strong> {discussion_description}<br /><br />You can view the discussion on the following link: <a href=\"{discussion_link}\">{discussion_subject}</a><br /><br />Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(32, 'project', 'new-project-discussion-created-to-customer', 'english', 'New Project Discussion (Sent to Customer Contacts)', 'New Project Discussion Created - {project_name}', '<p>Hello {contact_firstname} {contact_lastname}<br /><br />New project discussion created from <strong>{discussion_creator}</strong><br /><br /><strong>Subject:</strong> {discussion_subject}<br /><strong>Description:</strong> {discussion_description}<br /><br />You can view the discussion on the following link: <a href=\"{discussion_link}\">{discussion_subject}</a><br /><br />Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(33, 'project', 'new-project-file-uploaded-to-customer', 'english', 'New Project File(s) Uploaded (Sent to Customer Contacts)', 'New Project File(s) Uploaded - {project_name}', '<p>Hello {contact_firstname} {contact_lastname}<br /><br />New project file is uploaded on <strong>{project_name}</strong> from <strong>{file_creator}</strong><br /><br />You can view the project on the following link: <a href=\"{project_link}\">{project_name}</a><br /><br />To view the file in our CRM you can click on the following link: <a href=\"{discussion_link}\">{discussion_subject}</a><br /><br />Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(34, 'project', 'new-project-file-uploaded-to-staff', 'english', 'New Project File(s) Uploaded (Sent to Project Members)', 'New Project File(s) Uploaded - {project_name}', '<p>Hello&nbsp;{staff_firstname}</p>\r\n<p>New project&nbsp;file is uploaded on&nbsp;<strong>{project_name}</strong> from&nbsp;<strong>{file_creator}</strong></p>\r\n<p>You can view the project on the following link: <a href=\"{project_link}\">{project_name}<br /></a><br />To view&nbsp;the file you can click on the following link: <a href=\"{discussion_link}\">{discussion_subject}</a></p>\r\n<p>Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(35, 'project', 'new-project-discussion-comment-to-customer', 'english', 'New Discussion Comment  (Sent to Customer Contacts)', 'New Discussion Comment', '<p><span style=\"font-size: 12pt;\">Hello {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">New discussion comment has been made on <strong>{discussion_subject}</strong> from <strong>{comment_creator}</strong></span><br /><br /><span style=\"font-size: 12pt;\"><strong>Discussion subject:</strong> {discussion_subject}</span><br /><span style=\"font-size: 12pt;\"><strong>Comment</strong>: {discussion_comment}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the discussion on the following link: <a href=\"{discussion_link}\">{discussion_subject}</a></span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span></p>', '{companyname} | CRM', '', 0, 1, 0),
(36, 'project', 'new-project-discussion-comment-to-staff', 'english', 'New Discussion Comment (Sent to Project Members)', 'New Discussion Comment', '<p>Hi {staff_firstname}<br /><br />New discussion comment has been made on <strong>{discussion_subject}</strong> from <strong>{comment_creator}</strong><br /><br /><strong>Discussion subject:</strong> {discussion_subject}<br /><strong>Comment:</strong> {discussion_comment}<br /><br />You can view the discussion on the following link: <a href=\"{discussion_link}\">{discussion_subject}</a><br /><br />Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(37, 'project', 'staff-added-as-project-member', 'english', 'Staff Added as Project Member', 'New project assigned to you', '<p>Hi {staff_firstname}<br /><br />New project has been assigned to you.<br /><br />You can view the project on the following link <a href=\"{project_link}\">{project_name}</a><br /><br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(38, 'estimate', 'estimate-expiry-reminder', 'english', 'Estimate Expiration Reminder', 'Estimate Expiration Reminder', '<p><span style=\"font-size: 12pt;\">Hello {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\">The estimate with <strong># {estimate_number}</strong> will expire on <strong>{estimate_expirydate}</strong></span><br /><br /><span style=\"font-size: 12pt;\">You can view the estimate on the following link: <a href=\"{estimate_link}\">{estimate_number}</a></span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span></p>', '{companyname} | CRM', '', 0, 1, 0),
(39, 'proposals', 'proposal-expiry-reminder', 'english', 'Proposal Expiration Reminder', 'Proposal Expiration Reminder', '<p>Hello {proposal_proposal_to}<br /><br />The proposal {proposal_number}&nbsp;will expire on <strong>{proposal_open_till}</strong><br /><br />You can view the proposal on the following link: <a href=\"{proposal_link}\">{proposal_number}</a><br /><br />Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(40, 'staff', 'new-staff-created', 'english', 'New Staff Created (Welcome Email)', 'You are added as staff member', 'Hi {staff_firstname}<br /><br />You are added as member on our CRM.<br /><br />Please use the following logic credentials:<br /><br /><strong>Email:</strong> {staff_email}<br /><strong>Password:</strong> {password}<br /><br />Click <a href=\"{admin_url}\">here </a>to login in the dashboard.<br /><br />Best Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(41, 'client', 'contact-forgot-password', 'english', 'Forgot Password', 'Create New Password', '<h2>Create a new password</h2>\r\nForgot your password?<br /> To create a new password, just follow this link:<br /> <br /><a href=\"{reset_password_url}\">Reset Password</a><br /> <br /> You received this email, because it was requested by a {companyname}&nbsp;user. This is part of the procedure to create a new password on the system. If you DID NOT request a new password then please ignore this email and your password will remain the same. <br /><br /> {email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(42, 'client', 'contact-password-reseted', 'english', 'Password Reset - Confirmation', 'Your password has been changed', '<strong><span style=\"font-size: 14pt;\">You have changed your password.</span><br /></strong><br /> Please, keep it in your records so you don\'t forget it.<br /> <br /> Your email address for login is: {contact_email}<br /><br />If this wasnt you, please contact us.<br /><br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(43, 'client', 'contact-set-password', 'english', 'Set New Password', 'Set new password on {companyname} ', '<h2><span style=\"font-size: 14pt;\">Setup your new password on {companyname}</span></h2>\r\nPlease use the following link to set up your new password:<br /><br /><a href=\"{set_password_url}\">Set new password</a><br /><br />Keep it in your records so you don\'t forget it.<br /><br />Please set your new password in <strong>48 hours</strong>. After that, you won\'t be able to set your password because this link will expire.<br /><br />You can login at: <a href=\"{crm_url}\">{crm_url}</a><br />Your email address for login: {contact_email}<br /><br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(44, 'staff', 'staff-forgot-password', 'english', 'Forgot Password', 'Create New Password', '<h2><span style=\"font-size: 14pt;\">Create a new password</span></h2>\r\nForgot your password?<br /> To create a new password, just follow this link:<br /> <br /><a href=\"{reset_password_url}\">Reset Password</a><br /> <br /> You received this email, because it was requested by a <strong>{companyname}</strong>&nbsp;user. This is part of the procedure to create a new password on the system. If you DID NOT request a new password then please ignore this email and your password will remain the same. <br /><br /> {email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(45, 'staff', 'staff-password-reseted', 'english', 'Password Reset - Confirmation', 'Your password has been changed', '<span style=\"font-size: 14pt;\"><strong>You have changed your password.<br /></strong></span><br /> Please, keep it in your records so you don\'t forget it.<br /> <br /> Your email address for login is: {staff_email}<br /><br /> If this wasnt you, please contact us.<br /><br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(46, 'project', 'assigned-to-project', 'english', 'New Project Created (Sent to Customer Contacts)', 'New Project Created', '<p>Hello&nbsp;{contact_firstname}&nbsp;{contact_lastname}</p>\r\n<p>New project is assigned to your company.<br /><br /><strong>Project Name:</strong>&nbsp;{project_name}<br /><strong>Project Start Date:</strong>&nbsp;{project_start_date}</p>\r\n<p>You can view the project on the following link:&nbsp;<a href=\"{project_link}\">{project_name}</a></p>\r\n<p>We are looking forward hearing from you.<br /><br />Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(47, 'tasks', 'task-added-attachment-to-contacts', 'english', 'New Attachment(s) on Task (Sent to Customer Contacts)', 'New Attachment on Task - {task_name}', '<span>Hi {contact_firstname} {contact_lastname}</span><br /><br /><strong>{task_user_take_action}</strong><span> added an attachment on the following task:</span><br /><br /><strong>Name:</strong><span> {task_name}</span><br /><br /><span>You can view the task on the following link: </span><a href=\"{task_link}\">{task_name}</a><br /><br /><span>Kind Regards,</span><br /><span>{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(48, 'tasks', 'task-commented-to-contacts', 'english', 'New Comment on Task (Sent to Customer Contacts)', 'New Comment on Task - {task_name}', '<span>Dear {contact_firstname} {contact_lastname}</span><br /><br /><span>A comment has been made on the following task:</span><br /><br /><strong>Name:</strong><span> {task_name}</span><br /><strong>Comment:</strong><span> {task_comment}</span><br /><br /><span>You can view the task on the following link: </span><a href=\"{task_link}\">{task_name}</a><br /><br /><span>Kind Regards,</span><br /><span>{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(49, 'leads', 'new-lead-assigned', 'english', 'New Lead Assigned to Staff Member', 'New lead assigned to you', '<p>Hello {lead_assigned}<br /><br />New lead is assigned to you.<br /><br /><strong>Lead Name:</strong>&nbsp;{lead_name}<br /><strong>Lead Email:</strong>&nbsp;{lead_email}<br /><br />You can view the lead on the following link: <a href=\"{lead_link}\">{lead_name}</a><br /><br />Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(50, 'client', 'client-statement', 'english', 'Statement - Account Summary', 'Account Statement from {statement_from} to {statement_to}', 'Dear {contact_firstname} {contact_lastname}, <br /><br />Its been a great experience working with you.<br /><br />Attached with this email is a list of all transactions for the period between {statement_from} to {statement_to}<br /><br />For your information your account balance due is total:&nbsp;{statement_balance_due}<br /><br />Please contact us if you need more information.<br /> <br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(51, 'ticket', 'ticket-assigned-to-admin', 'english', 'New Ticket Assigned (Sent to Staff)', 'New support ticket has been assigned to you', '<p><span style=\"font-size: 12pt;\">Hi</span></p>\r\n<p><span style=\"font-size: 12pt;\">A new support ticket&nbsp;has been assigned to you.</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Subject</strong>: {ticket_subject}</span><br /><span style=\"font-size: 12pt;\"><strong>Department</strong>: {ticket_department}</span><br /><span style=\"font-size: 12pt;\"><strong>Priority</strong>: {ticket_priority}</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Ticket message:</strong></span><br /><span style=\"font-size: 12pt;\">{ticket_message}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the ticket on the following link: <a href=\"{ticket_url}\">#{ticket_id}</a></span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span></p>', '{companyname} | CRM', '', 0, 1, 0),
(52, 'client', 'new-client-registered-to-admin', 'english', 'New Customer Registration (Sent to admins)', 'New Customer Registration', 'Hello.<br /><br />New customer registration on your customer portal:<br /><br /><strong>Firstname:</strong>&nbsp;{contact_firstname}<br /><strong>Lastname:</strong>&nbsp;{contact_lastname}<br /><strong>Company:</strong>&nbsp;{client_company}<br /><strong>Email:</strong>&nbsp;{contact_email}<br /><br />Best Regards', '{companyname} | CRM', '', 0, 1, 0),
(53, 'leads', 'new-web-to-lead-form-submitted', 'english', 'Web to lead form submitted - Sent to lead', '{lead_name} - We Received Your Request', 'Hello {lead_name}.<br /><br /><strong>Your request has been received.</strong><br /><br />This email is to let you know that we received your request and we will get back to you as soon as possible with more information.<br /><br />Best Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 0, 0),
(54, 'staff', 'two-factor-authentication', 'english', 'Two Factor Authentication', 'Confirm Your Login', '<p>Hi {staff_firstname}</p>\r\n<p style=\"text-align: left;\">You received this email because you have enabled two factor authentication in your account.<br />Use the following code to confirm your login:</p>\r\n<p style=\"text-align: left;\"><span style=\"font-size: 18pt;\"><strong>{two_factor_auth_code}<br /><br /></strong><span style=\"font-size: 12pt;\">{email_signature}</span><strong><br /><br /><br /><br /></strong></span></p>', '{companyname} | CRM', '', 0, 1, 0),
(55, 'project', 'project-finished-to-customer', 'english', 'Project Marked as Finished (Sent to Customer Contacts)', 'Project Marked as Finished', '<p>Hello&nbsp;{contact_firstname}&nbsp;{contact_lastname}</p>\r\n<p>You are receiving this email because project&nbsp;<strong>{project_name}</strong> has been marked as finished. This project is assigned under your company and we just wanted to keep you up to date.<br /><br />You can view the project on the following link:&nbsp;<a href=\"{project_link}\">{project_name}</a></p>\r\n<p>If you have any questions don\'t hesitate to contact us.<br /><br />Kind Regards,<br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(56, 'credit_note', 'credit-note-send-to-client', 'english', 'Send Credit Note To Email', 'Credit Note With Number #{credit_note_number} Created', 'Dear&nbsp;{contact_firstname}&nbsp;{contact_lastname}<br /><br />We have attached the credit note with number <strong>#{credit_note_number} </strong>for your reference.<br /><br /><strong>Date:</strong>&nbsp;{credit_note_date}<br /><strong>Total Amount:</strong>&nbsp;{credit_note_total}<br /><br /><span style=\"font-size: 12pt;\">Please contact us for more information.</span><br /> <br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(57, 'tasks', 'task-status-change-to-staff', 'english', 'Task Status Changed (Sent to Staff)', 'Task Status Changed', '<span style=\"font-size: 12pt;\">Hi {staff_firstname}</span><br /><br /><span style=\"font-size: 12pt;\"><strong>{task_user_take_action}</strong> marked task as <strong>{task_status}</strong></span><br /><br /><span style=\"font-size: 12pt;\"><strong>Name:</strong> {task_name}</span><br /><span style=\"font-size: 12pt;\"><strong>Due date:</strong> {task_duedate}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the task on the following link: <a href=\"{task_link}\">{task_name}</a></span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(58, 'tasks', 'task-status-change-to-contacts', 'english', 'Task Status Changed (Sent to Customer Contacts)', 'Task Status Changed', '<span style=\"font-size: 12pt;\">Hi {contact_firstname} {contact_lastname}</span><br /><br /><span style=\"font-size: 12pt;\"><strong>{task_user_take_action}</strong> marked task as <strong>{task_status}</strong></span><br /><br /><span style=\"font-size: 12pt;\"><strong>Name:</strong> {task_name}</span><br /><span style=\"font-size: 12pt;\"><strong>Due date:</strong> {task_duedate}</span><br /><br /><span style=\"font-size: 12pt;\">You can view the task on the following link: <a href=\"{task_link}\">{task_name}</a></span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(59, 'staff', 'reminder-email-staff', 'english', 'Staff Reminder Email', 'You Have a New Reminder!', '<p>Hello&nbsp;{staff_firstname}<br /><br /><strong>You have a new reminder&nbsp;linked to&nbsp;{staff_reminder_relation_name}!<br /><br />Reminder description:</strong><br />{staff_reminder_description}<br /><br />Click <a href=\"{staff_reminder_relation_link}\">here</a> to view&nbsp;<a href=\"{staff_reminder_relation_link}\">{staff_reminder_relation_name}</a><br /><br />Best Regards<br /><br /></p>', '{companyname} | CRM', '', 0, 1, 0),
(60, 'contract', 'contract-comment-to-client', 'english', 'New Comment Â (Sent to Customer Contacts)', 'New Contract Comment', 'Dear {contact_firstname} {contact_lastname}<br /> <br />A new comment has been made on the following contract: <strong>{contract_subject}</strong><br /> <br />You can view and reply to the comment on the following link: <a href=\"{contract_link}\">{contract_subject}</a><br /> <br />Kind Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(61, 'contract', 'contract-comment-to-admin', 'english', 'New Comment (Sent to Staff) ', 'New Contract Comment', 'Hi {staff_firstname}<br /><br />A new comment has been made to the contract&nbsp;<strong>{contract_subject}</strong><br /><br />You can view and reply to the comment on the following link: <a href=\"{contract_link}\">{contract_subject}</a>&nbsp;or from the admin area.<br /><br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(62, 'subscriptions', 'send-subscription', 'english', 'Send Subscription to Customer', 'Subscription Created', 'Hello&nbsp;{contact_firstname}&nbsp;{contact_lastname}<br /><br />We have prepared the subscription&nbsp;<strong>{subscription_name}</strong> for your company.<br /><br />Click <a href=\"{subscription_link}\">here</a> to review the subscription and subscribe.<br /><br />Best Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(63, 'subscriptions', 'subscription-payment-failed', 'english', 'Subscription Payment Failed', 'Your most recent invoice payment failed', 'Hello&nbsp;{contact_firstname}&nbsp;{contact_lastname}<br /><br br=\"\" />Unfortunately, your most recent invoice payment for&nbsp;<strong>{subscription_name}</strong> was declined.<br /><br /> This could be due to a change in your card number, your card expiring,<br /> cancellation of your credit card, or the card issuer not recognizing the<br /> payment and therefore taking action to prevent it.<br /><br /> Please update your payment information as soon as possible by logging in here:<br /><a href=\"{crm_url}\">{crm_url}</a><br /><br />Best Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(64, 'subscriptions', 'subscription-canceled', 'english', 'Subscription Canceled (Sent to customer primary contact)', 'Your subscription has been canceled', 'Hello&nbsp;{contact_firstname}&nbsp;{contact_lastname}<br /><br />Your subscription&nbsp;<strong>{subscription_name} </strong>has been canceled, if you have any questions don\'t hesitate to contact us.<br /><br />It was a pleasure doing business with you.<br /><br />Best Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(65, 'subscriptions', 'subscription-payment-succeeded', 'english', 'Subscription Payment Succeeded (Sent to customer primary contact)', 'Subscription  Payment Receipt - {subscription_name}', 'Hello&nbsp;{contact_firstname}&nbsp;{contact_lastname}<br /><br />This email is to let you know that we received your payment for subscription&nbsp;<strong>{subscription_name}&nbsp;</strong>of&nbsp;<strong><span>{payment_total}<br /><br /></span></strong>The invoice associated with it is now with status&nbsp;<strong>{invoice_status}<br /></strong><br />Thank you for your confidence.<br /><br />Best Regards,<br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(66, 'contract', 'contract-expiration-to-staff', 'english', 'Contract Expiration Reminder (Sent to Staff)', 'Contract Expiration Reminder', 'Hi {staff_firstname}<br /><br /><span style=\"font-size: 12pt;\">This is a reminder that the following contract will expire soon:</span><br /><br /><span style=\"font-size: 12pt;\"><strong>Subject:</strong> {contract_subject}</span><br /><span style=\"font-size: 12pt;\"><strong>Description:</strong> {contract_description}</span><br /><span style=\"font-size: 12pt;\"><strong>Date Start:</strong> {contract_datestart}</span><br /><span style=\"font-size: 12pt;\"><strong>Date End:</strong> {contract_dateend}</span><br /><br /><span style=\"font-size: 12pt;\">Kind Regards,</span><br /><span style=\"font-size: 12pt;\">{email_signature}</span>', '{companyname} | CRM', '', 0, 1, 0),
(67, 'gdpr', 'gdpr-removal-request', 'english', 'Removal Request From Contact (Sent to administrators)', 'Data Removal Request Received', 'Hello&nbsp;{staff_firstname}&nbsp;{staff_lastname}<br /><br />Data removal has been requested by&nbsp;{contact_firstname} {contact_lastname}<br /><br />You can review this request and take proper actions directly from the admin area.', '{companyname} | CRM', '', 0, 1, 0),
(68, 'gdpr', 'gdpr-removal-request-lead', 'english', 'Removal Request From Lead (Sent to administrators)', 'Data Removal Request Received', 'Hello&nbsp;{staff_firstname}&nbsp;{staff_lastname}<br /><br />Data removal has been requested by {lead_name}<br /><br />You can review this request and take proper actions directly from the admin area.<br /><br />To view the lead inside the admin area click here:&nbsp;<a href=\"{lead_link}\">{lead_link}</a>', '{companyname} | CRM', '', 0, 1, 0),
(69, 'client', 'client-registration-confirmed', 'english', 'Customer Registration Confirmed', 'Your registration is confirmed', '<p>Dear {contact_firstname} {contact_lastname}<br /><br />We just wanted to let you know that your registration at&nbsp;{companyname} is successfully confirmed and your account is now active.<br /><br />You can login at&nbsp;<a href=\"{crm_url}\">{crm_url}</a> with the email and password you provided during registration.<br /><br />Please contact us if you need any help.<br /><br />Kind Regards, <br />{email_signature}</p>\r\n<p><br />(This is an automated email, so please don\'t reply to this email address)</p>', '{companyname} | CRM', '', 0, 1, 0),
(70, 'contract', 'contract-signed-to-staff', 'english', 'Contract Signed (Sent to Staff)', 'Customer Signed a Contract', 'Hi {staff_firstname}<br /><br />A contract with subject&nbsp;<strong>{contract_subject} </strong>has been successfully signed by the customer.<br /><br />You can view the contract at the following link: <a href=\"{contract_link}\">{contract_subject}</a>&nbsp;or from the admin area.<br /><br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(71, 'subscriptions', 'customer-subscribed-to-staff', 'english', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator)', 'Customer Subscribed to a Subscription', 'The customer <strong>{client_company}</strong> subscribed to a subscription with name&nbsp;<strong>{subscription_name}</strong><br /><br /><strong>ID</strong>:&nbsp;{subscription_id}<br /><strong>Subscription name</strong>:&nbsp;{subscription_name}<br /><strong>Subscription description</strong>:&nbsp;{subscription_description}<br /><br />You can view the subscription by clicking <a href=\"{subscription_link}\">here</a><br />\r\n<div style=\"text-align: center;\"><span style=\"font-size: 10pt;\">&nbsp;</span></div>\r\nBest Regards,<br />{email_signature}<br /><br /><span style=\"font-size: 10pt;\"><span style=\"color: #999999;\">You are receiving this email because you are either administrator or you are creator of the subscription.</span></span>', '{companyname} | CRM', '', 0, 1, 0),
(72, 'client', 'contact-verification-email', 'english', 'Email Verification (Sent to Contact After Registration)', 'Verify Email Address', '<p>Hello&nbsp;{contact_firstname}<br /><br />Please click the button below to verify your email address.<br /><br /><a href=\"{email_verification_url}\">Verify Email Address</a><br /><br />If you did not create an account, no further action is required</p>\r\n<p><br />{email_signature}</p>', '{companyname} | CRM', '', 0, 1, 0),
(73, 'client', 'new-customer-profile-file-uploaded-to-staff', 'english', 'New Customer Profile File(s) Uploaded (Sent to Staff)', 'Customer Uploaded New File(s) in Profile', 'Hi!<br /><br />New file(s) is uploaded into the customer ({client_company}) profile by&nbsp;{contact_firstname}<br /><br />You can check the uploaded files into the admin area by clicking <a href=\"{customer_profile_files_admin_link}\">here</a> or at the following link:&nbsp;{customer_profile_files_admin_link}<br /><br />{email_signature}', '{companyname} | CRM', '', 0, 1, 0),
(74, 'staff', 'event-notification-to-staff', 'english', 'Event Notification (Calendar)', 'Upcoming Event - {event_title}', 'Hi {staff_firstname}! <br /><br />This is a reminder for event <a href=\\\"{event_link}\\\">{event_title}</a> scheduled at {event_start_date}. <br /><br />Regards.', '', '', 0, 1, 0),
(75, 'client', 'new-client-created', 'swedish', 'New Contact Added/Registered (Welcome Email) [swedish]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(76, 'invoice', 'invoice-send-to-client', 'swedish', 'Send Invoice to Customer [swedish]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(77, 'ticket', 'new-ticket-opened-admin', 'swedish', 'New Ticket Opened (Opened by Staff, Sent to Customer) [swedish]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(78, 'ticket', 'ticket-reply', 'swedish', 'Ticket Reply (Sent to Customer) [swedish]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(79, 'ticket', 'ticket-autoresponse', 'swedish', 'New Ticket Opened - Autoresponse [swedish]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(80, 'invoice', 'invoice-payment-recorded', 'swedish', 'Invoice Payment Recorded (Sent to Customer) [swedish]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(81, 'invoice', 'invoice-overdue-notice', 'swedish', 'Invoice Overdue Notice [swedish]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(82, 'invoice', 'invoice-already-send', 'swedish', 'Invoice Already Sent to Customer [swedish]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(83, 'ticket', 'new-ticket-created-staff', 'swedish', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [swedish]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(84, 'estimate', 'estimate-send-to-client', 'swedish', 'Send Estimate to Customer [swedish]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(85, 'ticket', 'ticket-reply-to-admin', 'swedish', 'Ticket Reply (Sent to Staff) [swedish]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0);
INSERT INTO `ms_emailtemplates` (`emailtemplateid`, `type`, `slug`, `language`, `name`, `subject`, `message`, `fromname`, `fromemail`, `plaintext`, `active`, `order`) VALUES
(86, 'estimate', 'estimate-already-send', 'swedish', 'Estimate Already Sent to Customer [swedish]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(87, 'contract', 'contract-expiration', 'swedish', 'Contract Expiration Reminder (Sent to Customer Contacts) [swedish]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(88, 'tasks', 'task-assigned', 'swedish', 'New Task Assigned (Sent to Staff) [swedish]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(89, 'tasks', 'task-added-as-follower', 'swedish', 'Staff Member Added as Follower on Task (Sent to Staff) [swedish]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(90, 'tasks', 'task-commented', 'swedish', 'New Comment on Task (Sent to Staff) [swedish]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(91, 'tasks', 'task-added-attachment', 'swedish', 'New Attachment(s) on Task (Sent to Staff) [swedish]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(92, 'estimate', 'estimate-declined-to-staff', 'swedish', 'Estimate Declined (Sent to Staff) [swedish]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(93, 'estimate', 'estimate-accepted-to-staff', 'swedish', 'Estimate Accepted (Sent to Staff) [swedish]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(94, 'proposals', 'proposal-client-accepted', 'swedish', 'Customer Action - Accepted (Sent to Staff) [swedish]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(95, 'proposals', 'proposal-send-to-customer', 'swedish', 'Send Proposal to Customer [swedish]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(96, 'proposals', 'proposal-client-declined', 'swedish', 'Customer Action - Declined (Sent to Staff) [swedish]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(97, 'proposals', 'proposal-client-thank-you', 'swedish', 'Thank You Email (Sent to Customer After Accept) [swedish]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(98, 'proposals', 'proposal-comment-to-client', 'swedish', 'New Comment Â (Sent to Customer/Lead) [swedish]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(99, 'proposals', 'proposal-comment-to-admin', 'swedish', 'New Comment (Sent to Staff)  [swedish]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(100, 'estimate', 'estimate-thank-you-to-customer', 'swedish', 'Thank You Email (Sent to Customer After Accept) [swedish]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(101, 'tasks', 'task-deadline-notification', 'swedish', 'Task Deadline Reminder - Sent to Assigned Members [swedish]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(102, 'contract', 'send-contract', 'swedish', 'Send Contract to Customer [swedish]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(103, 'invoice', 'invoice-payment-recorded-to-staff', 'swedish', 'Invoice Payment Recorded (Sent to Staff) [swedish]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(104, 'ticket', 'auto-close-ticket', 'swedish', 'Auto Close Ticket [swedish]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(105, 'project', 'new-project-discussion-created-to-staff', 'swedish', 'New Project Discussion (Sent to Project Members) [swedish]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(106, 'project', 'new-project-discussion-created-to-customer', 'swedish', 'New Project Discussion (Sent to Customer Contacts) [swedish]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(107, 'project', 'new-project-file-uploaded-to-customer', 'swedish', 'New Project File(s) Uploaded (Sent to Customer Contacts) [swedish]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(108, 'project', 'new-project-file-uploaded-to-staff', 'swedish', 'New Project File(s) Uploaded (Sent to Project Members) [swedish]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(109, 'project', 'new-project-discussion-comment-to-customer', 'swedish', 'New Discussion Comment  (Sent to Customer Contacts) [swedish]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(110, 'project', 'new-project-discussion-comment-to-staff', 'swedish', 'New Discussion Comment (Sent to Project Members) [swedish]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(111, 'project', 'staff-added-as-project-member', 'swedish', 'Staff Added as Project Member [swedish]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(112, 'estimate', 'estimate-expiry-reminder', 'swedish', 'Estimate Expiration Reminder [swedish]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(113, 'proposals', 'proposal-expiry-reminder', 'swedish', 'Proposal Expiration Reminder [swedish]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(114, 'staff', 'new-staff-created', 'swedish', 'New Staff Created (Welcome Email) [swedish]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(115, 'client', 'contact-forgot-password', 'swedish', 'Forgot Password [swedish]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(116, 'client', 'contact-password-reseted', 'swedish', 'Password Reset - Confirmation [swedish]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(117, 'client', 'contact-set-password', 'swedish', 'Set New Password [swedish]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(118, 'staff', 'staff-forgot-password', 'swedish', 'Forgot Password [swedish]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(119, 'staff', 'staff-password-reseted', 'swedish', 'Password Reset - Confirmation [swedish]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(120, 'project', 'assigned-to-project', 'swedish', 'New Project Created (Sent to Customer Contacts) [swedish]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(121, 'tasks', 'task-added-attachment-to-contacts', 'swedish', 'New Attachment(s) on Task (Sent to Customer Contacts) [swedish]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(122, 'tasks', 'task-commented-to-contacts', 'swedish', 'New Comment on Task (Sent to Customer Contacts) [swedish]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(123, 'leads', 'new-lead-assigned', 'swedish', 'New Lead Assigned to Staff Member [swedish]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(124, 'client', 'client-statement', 'swedish', 'Statement - Account Summary [swedish]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(125, 'ticket', 'ticket-assigned-to-admin', 'swedish', 'New Ticket Assigned (Sent to Staff) [swedish]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(126, 'client', 'new-client-registered-to-admin', 'swedish', 'New Customer Registration (Sent to admins) [swedish]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(127, 'leads', 'new-web-to-lead-form-submitted', 'swedish', 'Web to lead form submitted - Sent to lead [swedish]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(128, 'staff', 'two-factor-authentication', 'swedish', 'Two Factor Authentication [swedish]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(129, 'project', 'project-finished-to-customer', 'swedish', 'Project Marked as Finished (Sent to Customer Contacts) [swedish]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(130, 'credit_note', 'credit-note-send-to-client', 'swedish', 'Send Credit Note To Email [swedish]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(131, 'tasks', 'task-status-change-to-staff', 'swedish', 'Task Status Changed (Sent to Staff) [swedish]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(132, 'tasks', 'task-status-change-to-contacts', 'swedish', 'Task Status Changed (Sent to Customer Contacts) [swedish]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(133, 'staff', 'reminder-email-staff', 'swedish', 'Staff Reminder Email [swedish]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(134, 'contract', 'contract-comment-to-client', 'swedish', 'New Comment Â (Sent to Customer Contacts) [swedish]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(135, 'contract', 'contract-comment-to-admin', 'swedish', 'New Comment (Sent to Staff)  [swedish]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(136, 'subscriptions', 'send-subscription', 'swedish', 'Send Subscription to Customer [swedish]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(137, 'subscriptions', 'subscription-payment-failed', 'swedish', 'Subscription Payment Failed [swedish]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(138, 'subscriptions', 'subscription-canceled', 'swedish', 'Subscription Canceled (Sent to customer primary contact) [swedish]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(139, 'subscriptions', 'subscription-payment-succeeded', 'swedish', 'Subscription Payment Succeeded (Sent to customer primary contact) [swedish]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(140, 'contract', 'contract-expiration-to-staff', 'swedish', 'Contract Expiration Reminder (Sent to Staff) [swedish]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(141, 'gdpr', 'gdpr-removal-request', 'swedish', 'Removal Request From Contact (Sent to administrators) [swedish]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(142, 'gdpr', 'gdpr-removal-request-lead', 'swedish', 'Removal Request From Lead (Sent to administrators) [swedish]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(143, 'client', 'client-registration-confirmed', 'swedish', 'Customer Registration Confirmed [swedish]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(144, 'contract', 'contract-signed-to-staff', 'swedish', 'Contract Signed (Sent to Staff) [swedish]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(145, 'subscriptions', 'customer-subscribed-to-staff', 'swedish', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [swedish]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(146, 'client', 'contact-verification-email', 'swedish', 'Email Verification (Sent to Contact After Registration) [swedish]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(147, 'client', 'new-customer-profile-file-uploaded-to-staff', 'swedish', 'New Customer Profile File(s) Uploaded (Sent to Staff) [swedish]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(148, 'staff', 'event-notification-to-staff', 'swedish', 'Event Notification (Calendar) [swedish]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(149, 'client', 'new-client-created', 'czech', 'New Contact Added/Registered (Welcome Email) [czech]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(150, 'invoice', 'invoice-send-to-client', 'czech', 'Send Invoice to Customer [czech]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(151, 'ticket', 'new-ticket-opened-admin', 'czech', 'New Ticket Opened (Opened by Staff, Sent to Customer) [czech]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(152, 'ticket', 'ticket-reply', 'czech', 'Ticket Reply (Sent to Customer) [czech]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(153, 'ticket', 'ticket-autoresponse', 'czech', 'New Ticket Opened - Autoresponse [czech]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(154, 'invoice', 'invoice-payment-recorded', 'czech', 'Invoice Payment Recorded (Sent to Customer) [czech]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(155, 'invoice', 'invoice-overdue-notice', 'czech', 'Invoice Overdue Notice [czech]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(156, 'invoice', 'invoice-already-send', 'czech', 'Invoice Already Sent to Customer [czech]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(157, 'ticket', 'new-ticket-created-staff', 'czech', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [czech]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(158, 'estimate', 'estimate-send-to-client', 'czech', 'Send Estimate to Customer [czech]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(159, 'ticket', 'ticket-reply-to-admin', 'czech', 'Ticket Reply (Sent to Staff) [czech]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(160, 'estimate', 'estimate-already-send', 'czech', 'Estimate Already Sent to Customer [czech]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(161, 'contract', 'contract-expiration', 'czech', 'Contract Expiration Reminder (Sent to Customer Contacts) [czech]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(162, 'tasks', 'task-assigned', 'czech', 'New Task Assigned (Sent to Staff) [czech]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(163, 'tasks', 'task-added-as-follower', 'czech', 'Staff Member Added as Follower on Task (Sent to Staff) [czech]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(164, 'tasks', 'task-commented', 'czech', 'New Comment on Task (Sent to Staff) [czech]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(165, 'tasks', 'task-added-attachment', 'czech', 'New Attachment(s) on Task (Sent to Staff) [czech]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(166, 'estimate', 'estimate-declined-to-staff', 'czech', 'Estimate Declined (Sent to Staff) [czech]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(167, 'estimate', 'estimate-accepted-to-staff', 'czech', 'Estimate Accepted (Sent to Staff) [czech]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(168, 'proposals', 'proposal-client-accepted', 'czech', 'Customer Action - Accepted (Sent to Staff) [czech]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(169, 'proposals', 'proposal-send-to-customer', 'czech', 'Send Proposal to Customer [czech]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(170, 'proposals', 'proposal-client-declined', 'czech', 'Customer Action - Declined (Sent to Staff) [czech]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(171, 'proposals', 'proposal-client-thank-you', 'czech', 'Thank You Email (Sent to Customer After Accept) [czech]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(172, 'proposals', 'proposal-comment-to-client', 'czech', 'New Comment Â (Sent to Customer/Lead) [czech]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(173, 'proposals', 'proposal-comment-to-admin', 'czech', 'New Comment (Sent to Staff)  [czech]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(174, 'estimate', 'estimate-thank-you-to-customer', 'czech', 'Thank You Email (Sent to Customer After Accept) [czech]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(175, 'tasks', 'task-deadline-notification', 'czech', 'Task Deadline Reminder - Sent to Assigned Members [czech]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(176, 'contract', 'send-contract', 'czech', 'Send Contract to Customer [czech]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(177, 'invoice', 'invoice-payment-recorded-to-staff', 'czech', 'Invoice Payment Recorded (Sent to Staff) [czech]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(178, 'ticket', 'auto-close-ticket', 'czech', 'Auto Close Ticket [czech]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(179, 'project', 'new-project-discussion-created-to-staff', 'czech', 'New Project Discussion (Sent to Project Members) [czech]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(180, 'project', 'new-project-discussion-created-to-customer', 'czech', 'New Project Discussion (Sent to Customer Contacts) [czech]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(181, 'project', 'new-project-file-uploaded-to-customer', 'czech', 'New Project File(s) Uploaded (Sent to Customer Contacts) [czech]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(182, 'project', 'new-project-file-uploaded-to-staff', 'czech', 'New Project File(s) Uploaded (Sent to Project Members) [czech]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(183, 'project', 'new-project-discussion-comment-to-customer', 'czech', 'New Discussion Comment  (Sent to Customer Contacts) [czech]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(184, 'project', 'new-project-discussion-comment-to-staff', 'czech', 'New Discussion Comment (Sent to Project Members) [czech]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(185, 'project', 'staff-added-as-project-member', 'czech', 'Staff Added as Project Member [czech]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(186, 'estimate', 'estimate-expiry-reminder', 'czech', 'Estimate Expiration Reminder [czech]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(187, 'proposals', 'proposal-expiry-reminder', 'czech', 'Proposal Expiration Reminder [czech]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(188, 'staff', 'new-staff-created', 'czech', 'New Staff Created (Welcome Email) [czech]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(189, 'client', 'contact-forgot-password', 'czech', 'Forgot Password [czech]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(190, 'client', 'contact-password-reseted', 'czech', 'Password Reset - Confirmation [czech]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(191, 'client', 'contact-set-password', 'czech', 'Set New Password [czech]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(192, 'staff', 'staff-forgot-password', 'czech', 'Forgot Password [czech]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(193, 'staff', 'staff-password-reseted', 'czech', 'Password Reset - Confirmation [czech]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(194, 'project', 'assigned-to-project', 'czech', 'New Project Created (Sent to Customer Contacts) [czech]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(195, 'tasks', 'task-added-attachment-to-contacts', 'czech', 'New Attachment(s) on Task (Sent to Customer Contacts) [czech]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(196, 'tasks', 'task-commented-to-contacts', 'czech', 'New Comment on Task (Sent to Customer Contacts) [czech]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(197, 'leads', 'new-lead-assigned', 'czech', 'New Lead Assigned to Staff Member [czech]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(198, 'client', 'client-statement', 'czech', 'Statement - Account Summary [czech]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(199, 'ticket', 'ticket-assigned-to-admin', 'czech', 'New Ticket Assigned (Sent to Staff) [czech]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(200, 'client', 'new-client-registered-to-admin', 'czech', 'New Customer Registration (Sent to admins) [czech]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(201, 'leads', 'new-web-to-lead-form-submitted', 'czech', 'Web to lead form submitted - Sent to lead [czech]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(202, 'staff', 'two-factor-authentication', 'czech', 'Two Factor Authentication [czech]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(203, 'project', 'project-finished-to-customer', 'czech', 'Project Marked as Finished (Sent to Customer Contacts) [czech]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(204, 'credit_note', 'credit-note-send-to-client', 'czech', 'Send Credit Note To Email [czech]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(205, 'tasks', 'task-status-change-to-staff', 'czech', 'Task Status Changed (Sent to Staff) [czech]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(206, 'tasks', 'task-status-change-to-contacts', 'czech', 'Task Status Changed (Sent to Customer Contacts) [czech]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(207, 'staff', 'reminder-email-staff', 'czech', 'Staff Reminder Email [czech]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(208, 'contract', 'contract-comment-to-client', 'czech', 'New Comment Â (Sent to Customer Contacts) [czech]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(209, 'contract', 'contract-comment-to-admin', 'czech', 'New Comment (Sent to Staff)  [czech]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(210, 'subscriptions', 'send-subscription', 'czech', 'Send Subscription to Customer [czech]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(211, 'subscriptions', 'subscription-payment-failed', 'czech', 'Subscription Payment Failed [czech]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(212, 'subscriptions', 'subscription-canceled', 'czech', 'Subscription Canceled (Sent to customer primary contact) [czech]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(213, 'subscriptions', 'subscription-payment-succeeded', 'czech', 'Subscription Payment Succeeded (Sent to customer primary contact) [czech]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(214, 'contract', 'contract-expiration-to-staff', 'czech', 'Contract Expiration Reminder (Sent to Staff) [czech]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(215, 'gdpr', 'gdpr-removal-request', 'czech', 'Removal Request From Contact (Sent to administrators) [czech]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(216, 'gdpr', 'gdpr-removal-request-lead', 'czech', 'Removal Request From Lead (Sent to administrators) [czech]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(217, 'client', 'client-registration-confirmed', 'czech', 'Customer Registration Confirmed [czech]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(218, 'contract', 'contract-signed-to-staff', 'czech', 'Contract Signed (Sent to Staff) [czech]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(219, 'subscriptions', 'customer-subscribed-to-staff', 'czech', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [czech]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(220, 'client', 'contact-verification-email', 'czech', 'Email Verification (Sent to Contact After Registration) [czech]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(221, 'client', 'new-customer-profile-file-uploaded-to-staff', 'czech', 'New Customer Profile File(s) Uploaded (Sent to Staff) [czech]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(222, 'staff', 'event-notification-to-staff', 'czech', 'Event Notification (Calendar) [czech]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(223, 'client', 'new-client-created', 'portuguese_br', 'New Contact Added/Registered (Welcome Email) [portuguese_br]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(224, 'invoice', 'invoice-send-to-client', 'portuguese_br', 'Send Invoice to Customer [portuguese_br]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(225, 'ticket', 'new-ticket-opened-admin', 'portuguese_br', 'New Ticket Opened (Opened by Staff, Sent to Customer) [portuguese_br]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(226, 'ticket', 'ticket-reply', 'portuguese_br', 'Ticket Reply (Sent to Customer) [portuguese_br]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(227, 'ticket', 'ticket-autoresponse', 'portuguese_br', 'New Ticket Opened - Autoresponse [portuguese_br]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(228, 'invoice', 'invoice-payment-recorded', 'portuguese_br', 'Invoice Payment Recorded (Sent to Customer) [portuguese_br]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(229, 'invoice', 'invoice-overdue-notice', 'portuguese_br', 'Invoice Overdue Notice [portuguese_br]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(230, 'invoice', 'invoice-already-send', 'portuguese_br', 'Invoice Already Sent to Customer [portuguese_br]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(231, 'ticket', 'new-ticket-created-staff', 'portuguese_br', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [portuguese_br]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(232, 'estimate', 'estimate-send-to-client', 'portuguese_br', 'Send Estimate to Customer [portuguese_br]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(233, 'ticket', 'ticket-reply-to-admin', 'portuguese_br', 'Ticket Reply (Sent to Staff) [portuguese_br]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(234, 'estimate', 'estimate-already-send', 'portuguese_br', 'Estimate Already Sent to Customer [portuguese_br]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(235, 'contract', 'contract-expiration', 'portuguese_br', 'Contract Expiration Reminder (Sent to Customer Contacts) [portuguese_br]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(236, 'tasks', 'task-assigned', 'portuguese_br', 'New Task Assigned (Sent to Staff) [portuguese_br]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(237, 'tasks', 'task-added-as-follower', 'portuguese_br', 'Staff Member Added as Follower on Task (Sent to Staff) [portuguese_br]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(238, 'tasks', 'task-commented', 'portuguese_br', 'New Comment on Task (Sent to Staff) [portuguese_br]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(239, 'tasks', 'task-added-attachment', 'portuguese_br', 'New Attachment(s) on Task (Sent to Staff) [portuguese_br]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(240, 'estimate', 'estimate-declined-to-staff', 'portuguese_br', 'Estimate Declined (Sent to Staff) [portuguese_br]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(241, 'estimate', 'estimate-accepted-to-staff', 'portuguese_br', 'Estimate Accepted (Sent to Staff) [portuguese_br]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(242, 'proposals', 'proposal-client-accepted', 'portuguese_br', 'Customer Action - Accepted (Sent to Staff) [portuguese_br]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(243, 'proposals', 'proposal-send-to-customer', 'portuguese_br', 'Send Proposal to Customer [portuguese_br]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(244, 'proposals', 'proposal-client-declined', 'portuguese_br', 'Customer Action - Declined (Sent to Staff) [portuguese_br]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(245, 'proposals', 'proposal-client-thank-you', 'portuguese_br', 'Thank You Email (Sent to Customer After Accept) [portuguese_br]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(246, 'proposals', 'proposal-comment-to-client', 'portuguese_br', 'New Comment Â (Sent to Customer/Lead) [portuguese_br]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(247, 'proposals', 'proposal-comment-to-admin', 'portuguese_br', 'New Comment (Sent to Staff)  [portuguese_br]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(248, 'estimate', 'estimate-thank-you-to-customer', 'portuguese_br', 'Thank You Email (Sent to Customer After Accept) [portuguese_br]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(249, 'tasks', 'task-deadline-notification', 'portuguese_br', 'Task Deadline Reminder - Sent to Assigned Members [portuguese_br]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(250, 'contract', 'send-contract', 'portuguese_br', 'Send Contract to Customer [portuguese_br]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(251, 'invoice', 'invoice-payment-recorded-to-staff', 'portuguese_br', 'Invoice Payment Recorded (Sent to Staff) [portuguese_br]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(252, 'ticket', 'auto-close-ticket', 'portuguese_br', 'Auto Close Ticket [portuguese_br]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(253, 'project', 'new-project-discussion-created-to-staff', 'portuguese_br', 'New Project Discussion (Sent to Project Members) [portuguese_br]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(254, 'project', 'new-project-discussion-created-to-customer', 'portuguese_br', 'New Project Discussion (Sent to Customer Contacts) [portuguese_br]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(255, 'project', 'new-project-file-uploaded-to-customer', 'portuguese_br', 'New Project File(s) Uploaded (Sent to Customer Contacts) [portuguese_br]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(256, 'project', 'new-project-file-uploaded-to-staff', 'portuguese_br', 'New Project File(s) Uploaded (Sent to Project Members) [portuguese_br]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(257, 'project', 'new-project-discussion-comment-to-customer', 'portuguese_br', 'New Discussion Comment  (Sent to Customer Contacts) [portuguese_br]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(258, 'project', 'new-project-discussion-comment-to-staff', 'portuguese_br', 'New Discussion Comment (Sent to Project Members) [portuguese_br]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(259, 'project', 'staff-added-as-project-member', 'portuguese_br', 'Staff Added as Project Member [portuguese_br]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(260, 'estimate', 'estimate-expiry-reminder', 'portuguese_br', 'Estimate Expiration Reminder [portuguese_br]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(261, 'proposals', 'proposal-expiry-reminder', 'portuguese_br', 'Proposal Expiration Reminder [portuguese_br]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(262, 'staff', 'new-staff-created', 'portuguese_br', 'New Staff Created (Welcome Email) [portuguese_br]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(263, 'client', 'contact-forgot-password', 'portuguese_br', 'Forgot Password [portuguese_br]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(264, 'client', 'contact-password-reseted', 'portuguese_br', 'Password Reset - Confirmation [portuguese_br]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(265, 'client', 'contact-set-password', 'portuguese_br', 'Set New Password [portuguese_br]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(266, 'staff', 'staff-forgot-password', 'portuguese_br', 'Forgot Password [portuguese_br]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(267, 'staff', 'staff-password-reseted', 'portuguese_br', 'Password Reset - Confirmation [portuguese_br]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(268, 'project', 'assigned-to-project', 'portuguese_br', 'New Project Created (Sent to Customer Contacts) [portuguese_br]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(269, 'tasks', 'task-added-attachment-to-contacts', 'portuguese_br', 'New Attachment(s) on Task (Sent to Customer Contacts) [portuguese_br]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(270, 'tasks', 'task-commented-to-contacts', 'portuguese_br', 'New Comment on Task (Sent to Customer Contacts) [portuguese_br]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(271, 'leads', 'new-lead-assigned', 'portuguese_br', 'New Lead Assigned to Staff Member [portuguese_br]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(272, 'client', 'client-statement', 'portuguese_br', 'Statement - Account Summary [portuguese_br]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(273, 'ticket', 'ticket-assigned-to-admin', 'portuguese_br', 'New Ticket Assigned (Sent to Staff) [portuguese_br]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(274, 'client', 'new-client-registered-to-admin', 'portuguese_br', 'New Customer Registration (Sent to admins) [portuguese_br]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(275, 'leads', 'new-web-to-lead-form-submitted', 'portuguese_br', 'Web to lead form submitted - Sent to lead [portuguese_br]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(276, 'staff', 'two-factor-authentication', 'portuguese_br', 'Two Factor Authentication [portuguese_br]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(277, 'project', 'project-finished-to-customer', 'portuguese_br', 'Project Marked as Finished (Sent to Customer Contacts) [portuguese_br]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(278, 'credit_note', 'credit-note-send-to-client', 'portuguese_br', 'Send Credit Note To Email [portuguese_br]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(279, 'tasks', 'task-status-change-to-staff', 'portuguese_br', 'Task Status Changed (Sent to Staff) [portuguese_br]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(280, 'tasks', 'task-status-change-to-contacts', 'portuguese_br', 'Task Status Changed (Sent to Customer Contacts) [portuguese_br]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(281, 'staff', 'reminder-email-staff', 'portuguese_br', 'Staff Reminder Email [portuguese_br]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(282, 'contract', 'contract-comment-to-client', 'portuguese_br', 'New Comment Â (Sent to Customer Contacts) [portuguese_br]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(283, 'contract', 'contract-comment-to-admin', 'portuguese_br', 'New Comment (Sent to Staff)  [portuguese_br]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(284, 'subscriptions', 'send-subscription', 'portuguese_br', 'Send Subscription to Customer [portuguese_br]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(285, 'subscriptions', 'subscription-payment-failed', 'portuguese_br', 'Subscription Payment Failed [portuguese_br]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(286, 'subscriptions', 'subscription-canceled', 'portuguese_br', 'Subscription Canceled (Sent to customer primary contact) [portuguese_br]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(287, 'subscriptions', 'subscription-payment-succeeded', 'portuguese_br', 'Subscription Payment Succeeded (Sent to customer primary contact) [portuguese_br]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(288, 'contract', 'contract-expiration-to-staff', 'portuguese_br', 'Contract Expiration Reminder (Sent to Staff) [portuguese_br]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(289, 'gdpr', 'gdpr-removal-request', 'portuguese_br', 'Removal Request From Contact (Sent to administrators) [portuguese_br]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(290, 'gdpr', 'gdpr-removal-request-lead', 'portuguese_br', 'Removal Request From Lead (Sent to administrators) [portuguese_br]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(291, 'client', 'client-registration-confirmed', 'portuguese_br', 'Customer Registration Confirmed [portuguese_br]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(292, 'contract', 'contract-signed-to-staff', 'portuguese_br', 'Contract Signed (Sent to Staff) [portuguese_br]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(293, 'subscriptions', 'customer-subscribed-to-staff', 'portuguese_br', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [portuguese_br]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(294, 'client', 'contact-verification-email', 'portuguese_br', 'Email Verification (Sent to Contact After Registration) [portuguese_br]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(295, 'client', 'new-customer-profile-file-uploaded-to-staff', 'portuguese_br', 'New Customer Profile File(s) Uploaded (Sent to Staff) [portuguese_br]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(296, 'staff', 'event-notification-to-staff', 'portuguese_br', 'Event Notification (Calendar) [portuguese_br]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(297, 'client', 'new-client-created', 'german', 'New Contact Added/Registered (Welcome Email) [german]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(298, 'invoice', 'invoice-send-to-client', 'german', 'Send Invoice to Customer [german]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(299, 'ticket', 'new-ticket-opened-admin', 'german', 'New Ticket Opened (Opened by Staff, Sent to Customer) [german]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(300, 'ticket', 'ticket-reply', 'german', 'Ticket Reply (Sent to Customer) [german]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(301, 'ticket', 'ticket-autoresponse', 'german', 'New Ticket Opened - Autoresponse [german]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(302, 'invoice', 'invoice-payment-recorded', 'german', 'Invoice Payment Recorded (Sent to Customer) [german]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(303, 'invoice', 'invoice-overdue-notice', 'german', 'Invoice Overdue Notice [german]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(304, 'invoice', 'invoice-already-send', 'german', 'Invoice Already Sent to Customer [german]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(305, 'ticket', 'new-ticket-created-staff', 'german', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [german]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(306, 'estimate', 'estimate-send-to-client', 'german', 'Send Estimate to Customer [german]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(307, 'ticket', 'ticket-reply-to-admin', 'german', 'Ticket Reply (Sent to Staff) [german]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(308, 'estimate', 'estimate-already-send', 'german', 'Estimate Already Sent to Customer [german]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(309, 'contract', 'contract-expiration', 'german', 'Contract Expiration Reminder (Sent to Customer Contacts) [german]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(310, 'tasks', 'task-assigned', 'german', 'New Task Assigned (Sent to Staff) [german]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(311, 'tasks', 'task-added-as-follower', 'german', 'Staff Member Added as Follower on Task (Sent to Staff) [german]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(312, 'tasks', 'task-commented', 'german', 'New Comment on Task (Sent to Staff) [german]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(313, 'tasks', 'task-added-attachment', 'german', 'New Attachment(s) on Task (Sent to Staff) [german]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(314, 'estimate', 'estimate-declined-to-staff', 'german', 'Estimate Declined (Sent to Staff) [german]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(315, 'estimate', 'estimate-accepted-to-staff', 'german', 'Estimate Accepted (Sent to Staff) [german]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(316, 'proposals', 'proposal-client-accepted', 'german', 'Customer Action - Accepted (Sent to Staff) [german]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(317, 'proposals', 'proposal-send-to-customer', 'german', 'Send Proposal to Customer [german]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(318, 'proposals', 'proposal-client-declined', 'german', 'Customer Action - Declined (Sent to Staff) [german]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(319, 'proposals', 'proposal-client-thank-you', 'german', 'Thank You Email (Sent to Customer After Accept) [german]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(320, 'proposals', 'proposal-comment-to-client', 'german', 'New Comment Â (Sent to Customer/Lead) [german]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(321, 'proposals', 'proposal-comment-to-admin', 'german', 'New Comment (Sent to Staff)  [german]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(322, 'estimate', 'estimate-thank-you-to-customer', 'german', 'Thank You Email (Sent to Customer After Accept) [german]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(323, 'tasks', 'task-deadline-notification', 'german', 'Task Deadline Reminder - Sent to Assigned Members [german]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(324, 'contract', 'send-contract', 'german', 'Send Contract to Customer [german]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(325, 'invoice', 'invoice-payment-recorded-to-staff', 'german', 'Invoice Payment Recorded (Sent to Staff) [german]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(326, 'ticket', 'auto-close-ticket', 'german', 'Auto Close Ticket [german]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(327, 'project', 'new-project-discussion-created-to-staff', 'german', 'New Project Discussion (Sent to Project Members) [german]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(328, 'project', 'new-project-discussion-created-to-customer', 'german', 'New Project Discussion (Sent to Customer Contacts) [german]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(329, 'project', 'new-project-file-uploaded-to-customer', 'german', 'New Project File(s) Uploaded (Sent to Customer Contacts) [german]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(330, 'project', 'new-project-file-uploaded-to-staff', 'german', 'New Project File(s) Uploaded (Sent to Project Members) [german]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(331, 'project', 'new-project-discussion-comment-to-customer', 'german', 'New Discussion Comment  (Sent to Customer Contacts) [german]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(332, 'project', 'new-project-discussion-comment-to-staff', 'german', 'New Discussion Comment (Sent to Project Members) [german]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(333, 'project', 'staff-added-as-project-member', 'german', 'Staff Added as Project Member [german]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(334, 'estimate', 'estimate-expiry-reminder', 'german', 'Estimate Expiration Reminder [german]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(335, 'proposals', 'proposal-expiry-reminder', 'german', 'Proposal Expiration Reminder [german]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(336, 'staff', 'new-staff-created', 'german', 'New Staff Created (Welcome Email) [german]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(337, 'client', 'contact-forgot-password', 'german', 'Forgot Password [german]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(338, 'client', 'contact-password-reseted', 'german', 'Password Reset - Confirmation [german]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(339, 'client', 'contact-set-password', 'german', 'Set New Password [german]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(340, 'staff', 'staff-forgot-password', 'german', 'Forgot Password [german]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(341, 'staff', 'staff-password-reseted', 'german', 'Password Reset - Confirmation [german]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(342, 'project', 'assigned-to-project', 'german', 'New Project Created (Sent to Customer Contacts) [german]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(343, 'tasks', 'task-added-attachment-to-contacts', 'german', 'New Attachment(s) on Task (Sent to Customer Contacts) [german]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(344, 'tasks', 'task-commented-to-contacts', 'german', 'New Comment on Task (Sent to Customer Contacts) [german]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(345, 'leads', 'new-lead-assigned', 'german', 'New Lead Assigned to Staff Member [german]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(346, 'client', 'client-statement', 'german', 'Statement - Account Summary [german]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(347, 'ticket', 'ticket-assigned-to-admin', 'german', 'New Ticket Assigned (Sent to Staff) [german]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(348, 'client', 'new-client-registered-to-admin', 'german', 'New Customer Registration (Sent to admins) [german]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(349, 'leads', 'new-web-to-lead-form-submitted', 'german', 'Web to lead form submitted - Sent to lead [german]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(350, 'staff', 'two-factor-authentication', 'german', 'Two Factor Authentication [german]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(351, 'project', 'project-finished-to-customer', 'german', 'Project Marked as Finished (Sent to Customer Contacts) [german]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(352, 'credit_note', 'credit-note-send-to-client', 'german', 'Send Credit Note To Email [german]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(353, 'tasks', 'task-status-change-to-staff', 'german', 'Task Status Changed (Sent to Staff) [german]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0);
INSERT INTO `ms_emailtemplates` (`emailtemplateid`, `type`, `slug`, `language`, `name`, `subject`, `message`, `fromname`, `fromemail`, `plaintext`, `active`, `order`) VALUES
(354, 'tasks', 'task-status-change-to-contacts', 'german', 'Task Status Changed (Sent to Customer Contacts) [german]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(355, 'staff', 'reminder-email-staff', 'german', 'Staff Reminder Email [german]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(356, 'contract', 'contract-comment-to-client', 'german', 'New Comment Â (Sent to Customer Contacts) [german]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(357, 'contract', 'contract-comment-to-admin', 'german', 'New Comment (Sent to Staff)  [german]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(358, 'subscriptions', 'send-subscription', 'german', 'Send Subscription to Customer [german]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(359, 'subscriptions', 'subscription-payment-failed', 'german', 'Subscription Payment Failed [german]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(360, 'subscriptions', 'subscription-canceled', 'german', 'Subscription Canceled (Sent to customer primary contact) [german]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(361, 'subscriptions', 'subscription-payment-succeeded', 'german', 'Subscription Payment Succeeded (Sent to customer primary contact) [german]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(362, 'contract', 'contract-expiration-to-staff', 'german', 'Contract Expiration Reminder (Sent to Staff) [german]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(363, 'gdpr', 'gdpr-removal-request', 'german', 'Removal Request From Contact (Sent to administrators) [german]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(364, 'gdpr', 'gdpr-removal-request-lead', 'german', 'Removal Request From Lead (Sent to administrators) [german]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(365, 'client', 'client-registration-confirmed', 'german', 'Customer Registration Confirmed [german]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(366, 'contract', 'contract-signed-to-staff', 'german', 'Contract Signed (Sent to Staff) [german]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(367, 'subscriptions', 'customer-subscribed-to-staff', 'german', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [german]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(368, 'client', 'contact-verification-email', 'german', 'Email Verification (Sent to Contact After Registration) [german]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(369, 'client', 'new-customer-profile-file-uploaded-to-staff', 'german', 'New Customer Profile File(s) Uploaded (Sent to Staff) [german]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(370, 'staff', 'event-notification-to-staff', 'german', 'Event Notification (Calendar) [german]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(371, 'client', 'new-client-created', 'portuguese', 'New Contact Added/Registered (Welcome Email) [portuguese]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(372, 'invoice', 'invoice-send-to-client', 'portuguese', 'Send Invoice to Customer [portuguese]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(373, 'ticket', 'new-ticket-opened-admin', 'portuguese', 'New Ticket Opened (Opened by Staff, Sent to Customer) [portuguese]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(374, 'ticket', 'ticket-reply', 'portuguese', 'Ticket Reply (Sent to Customer) [portuguese]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(375, 'ticket', 'ticket-autoresponse', 'portuguese', 'New Ticket Opened - Autoresponse [portuguese]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(376, 'invoice', 'invoice-payment-recorded', 'portuguese', 'Invoice Payment Recorded (Sent to Customer) [portuguese]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(377, 'invoice', 'invoice-overdue-notice', 'portuguese', 'Invoice Overdue Notice [portuguese]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(378, 'invoice', 'invoice-already-send', 'portuguese', 'Invoice Already Sent to Customer [portuguese]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(379, 'ticket', 'new-ticket-created-staff', 'portuguese', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [portuguese]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(380, 'estimate', 'estimate-send-to-client', 'portuguese', 'Send Estimate to Customer [portuguese]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(381, 'ticket', 'ticket-reply-to-admin', 'portuguese', 'Ticket Reply (Sent to Staff) [portuguese]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(382, 'estimate', 'estimate-already-send', 'portuguese', 'Estimate Already Sent to Customer [portuguese]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(383, 'contract', 'contract-expiration', 'portuguese', 'Contract Expiration Reminder (Sent to Customer Contacts) [portuguese]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(384, 'tasks', 'task-assigned', 'portuguese', 'New Task Assigned (Sent to Staff) [portuguese]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(385, 'tasks', 'task-added-as-follower', 'portuguese', 'Staff Member Added as Follower on Task (Sent to Staff) [portuguese]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(386, 'tasks', 'task-commented', 'portuguese', 'New Comment on Task (Sent to Staff) [portuguese]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(387, 'tasks', 'task-added-attachment', 'portuguese', 'New Attachment(s) on Task (Sent to Staff) [portuguese]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(388, 'estimate', 'estimate-declined-to-staff', 'portuguese', 'Estimate Declined (Sent to Staff) [portuguese]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(389, 'estimate', 'estimate-accepted-to-staff', 'portuguese', 'Estimate Accepted (Sent to Staff) [portuguese]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(390, 'proposals', 'proposal-client-accepted', 'portuguese', 'Customer Action - Accepted (Sent to Staff) [portuguese]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(391, 'proposals', 'proposal-send-to-customer', 'portuguese', 'Send Proposal to Customer [portuguese]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(392, 'proposals', 'proposal-client-declined', 'portuguese', 'Customer Action - Declined (Sent to Staff) [portuguese]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(393, 'proposals', 'proposal-client-thank-you', 'portuguese', 'Thank You Email (Sent to Customer After Accept) [portuguese]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(394, 'proposals', 'proposal-comment-to-client', 'portuguese', 'New Comment Â (Sent to Customer/Lead) [portuguese]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(395, 'proposals', 'proposal-comment-to-admin', 'portuguese', 'New Comment (Sent to Staff)  [portuguese]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(396, 'estimate', 'estimate-thank-you-to-customer', 'portuguese', 'Thank You Email (Sent to Customer After Accept) [portuguese]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(397, 'tasks', 'task-deadline-notification', 'portuguese', 'Task Deadline Reminder - Sent to Assigned Members [portuguese]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(398, 'contract', 'send-contract', 'portuguese', 'Send Contract to Customer [portuguese]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(399, 'invoice', 'invoice-payment-recorded-to-staff', 'portuguese', 'Invoice Payment Recorded (Sent to Staff) [portuguese]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(400, 'ticket', 'auto-close-ticket', 'portuguese', 'Auto Close Ticket [portuguese]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(401, 'project', 'new-project-discussion-created-to-staff', 'portuguese', 'New Project Discussion (Sent to Project Members) [portuguese]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(402, 'project', 'new-project-discussion-created-to-customer', 'portuguese', 'New Project Discussion (Sent to Customer Contacts) [portuguese]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(403, 'project', 'new-project-file-uploaded-to-customer', 'portuguese', 'New Project File(s) Uploaded (Sent to Customer Contacts) [portuguese]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(404, 'project', 'new-project-file-uploaded-to-staff', 'portuguese', 'New Project File(s) Uploaded (Sent to Project Members) [portuguese]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(405, 'project', 'new-project-discussion-comment-to-customer', 'portuguese', 'New Discussion Comment  (Sent to Customer Contacts) [portuguese]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(406, 'project', 'new-project-discussion-comment-to-staff', 'portuguese', 'New Discussion Comment (Sent to Project Members) [portuguese]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(407, 'project', 'staff-added-as-project-member', 'portuguese', 'Staff Added as Project Member [portuguese]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(408, 'estimate', 'estimate-expiry-reminder', 'portuguese', 'Estimate Expiration Reminder [portuguese]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(409, 'proposals', 'proposal-expiry-reminder', 'portuguese', 'Proposal Expiration Reminder [portuguese]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(410, 'staff', 'new-staff-created', 'portuguese', 'New Staff Created (Welcome Email) [portuguese]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(411, 'client', 'contact-forgot-password', 'portuguese', 'Forgot Password [portuguese]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(412, 'client', 'contact-password-reseted', 'portuguese', 'Password Reset - Confirmation [portuguese]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(413, 'client', 'contact-set-password', 'portuguese', 'Set New Password [portuguese]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(414, 'staff', 'staff-forgot-password', 'portuguese', 'Forgot Password [portuguese]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(415, 'staff', 'staff-password-reseted', 'portuguese', 'Password Reset - Confirmation [portuguese]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(416, 'project', 'assigned-to-project', 'portuguese', 'New Project Created (Sent to Customer Contacts) [portuguese]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(417, 'tasks', 'task-added-attachment-to-contacts', 'portuguese', 'New Attachment(s) on Task (Sent to Customer Contacts) [portuguese]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(418, 'tasks', 'task-commented-to-contacts', 'portuguese', 'New Comment on Task (Sent to Customer Contacts) [portuguese]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(419, 'leads', 'new-lead-assigned', 'portuguese', 'New Lead Assigned to Staff Member [portuguese]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(420, 'client', 'client-statement', 'portuguese', 'Statement - Account Summary [portuguese]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(421, 'ticket', 'ticket-assigned-to-admin', 'portuguese', 'New Ticket Assigned (Sent to Staff) [portuguese]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(422, 'client', 'new-client-registered-to-admin', 'portuguese', 'New Customer Registration (Sent to admins) [portuguese]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(423, 'leads', 'new-web-to-lead-form-submitted', 'portuguese', 'Web to lead form submitted - Sent to lead [portuguese]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(424, 'staff', 'two-factor-authentication', 'portuguese', 'Two Factor Authentication [portuguese]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(425, 'project', 'project-finished-to-customer', 'portuguese', 'Project Marked as Finished (Sent to Customer Contacts) [portuguese]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(426, 'credit_note', 'credit-note-send-to-client', 'portuguese', 'Send Credit Note To Email [portuguese]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(427, 'tasks', 'task-status-change-to-staff', 'portuguese', 'Task Status Changed (Sent to Staff) [portuguese]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(428, 'tasks', 'task-status-change-to-contacts', 'portuguese', 'Task Status Changed (Sent to Customer Contacts) [portuguese]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(429, 'staff', 'reminder-email-staff', 'portuguese', 'Staff Reminder Email [portuguese]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(430, 'contract', 'contract-comment-to-client', 'portuguese', 'New Comment Â (Sent to Customer Contacts) [portuguese]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(431, 'contract', 'contract-comment-to-admin', 'portuguese', 'New Comment (Sent to Staff)  [portuguese]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(432, 'subscriptions', 'send-subscription', 'portuguese', 'Send Subscription to Customer [portuguese]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(433, 'subscriptions', 'subscription-payment-failed', 'portuguese', 'Subscription Payment Failed [portuguese]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(434, 'subscriptions', 'subscription-canceled', 'portuguese', 'Subscription Canceled (Sent to customer primary contact) [portuguese]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(435, 'subscriptions', 'subscription-payment-succeeded', 'portuguese', 'Subscription Payment Succeeded (Sent to customer primary contact) [portuguese]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(436, 'contract', 'contract-expiration-to-staff', 'portuguese', 'Contract Expiration Reminder (Sent to Staff) [portuguese]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(437, 'gdpr', 'gdpr-removal-request', 'portuguese', 'Removal Request From Contact (Sent to administrators) [portuguese]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(438, 'gdpr', 'gdpr-removal-request-lead', 'portuguese', 'Removal Request From Lead (Sent to administrators) [portuguese]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(439, 'client', 'client-registration-confirmed', 'portuguese', 'Customer Registration Confirmed [portuguese]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(440, 'contract', 'contract-signed-to-staff', 'portuguese', 'Contract Signed (Sent to Staff) [portuguese]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(441, 'subscriptions', 'customer-subscribed-to-staff', 'portuguese', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [portuguese]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(442, 'client', 'contact-verification-email', 'portuguese', 'Email Verification (Sent to Contact After Registration) [portuguese]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(443, 'client', 'new-customer-profile-file-uploaded-to-staff', 'portuguese', 'New Customer Profile File(s) Uploaded (Sent to Staff) [portuguese]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(444, 'staff', 'event-notification-to-staff', 'portuguese', 'Event Notification (Calendar) [portuguese]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(445, 'client', 'new-client-created', 'vietnamese', 'New Contact Added/Registered (Welcome Email) [vietnamese]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(446, 'invoice', 'invoice-send-to-client', 'vietnamese', 'Send Invoice to Customer [vietnamese]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(447, 'ticket', 'new-ticket-opened-admin', 'vietnamese', 'New Ticket Opened (Opened by Staff, Sent to Customer) [vietnamese]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(448, 'ticket', 'ticket-reply', 'vietnamese', 'Ticket Reply (Sent to Customer) [vietnamese]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(449, 'ticket', 'ticket-autoresponse', 'vietnamese', 'New Ticket Opened - Autoresponse [vietnamese]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(450, 'invoice', 'invoice-payment-recorded', 'vietnamese', 'Invoice Payment Recorded (Sent to Customer) [vietnamese]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(451, 'invoice', 'invoice-overdue-notice', 'vietnamese', 'Invoice Overdue Notice [vietnamese]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(452, 'invoice', 'invoice-already-send', 'vietnamese', 'Invoice Already Sent to Customer [vietnamese]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(453, 'ticket', 'new-ticket-created-staff', 'vietnamese', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [vietnamese]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(454, 'estimate', 'estimate-send-to-client', 'vietnamese', 'Send Estimate to Customer [vietnamese]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(455, 'ticket', 'ticket-reply-to-admin', 'vietnamese', 'Ticket Reply (Sent to Staff) [vietnamese]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(456, 'estimate', 'estimate-already-send', 'vietnamese', 'Estimate Already Sent to Customer [vietnamese]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(457, 'contract', 'contract-expiration', 'vietnamese', 'Contract Expiration Reminder (Sent to Customer Contacts) [vietnamese]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(458, 'tasks', 'task-assigned', 'vietnamese', 'New Task Assigned (Sent to Staff) [vietnamese]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(459, 'tasks', 'task-added-as-follower', 'vietnamese', 'Staff Member Added as Follower on Task (Sent to Staff) [vietnamese]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(460, 'tasks', 'task-commented', 'vietnamese', 'New Comment on Task (Sent to Staff) [vietnamese]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(461, 'tasks', 'task-added-attachment', 'vietnamese', 'New Attachment(s) on Task (Sent to Staff) [vietnamese]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(462, 'estimate', 'estimate-declined-to-staff', 'vietnamese', 'Estimate Declined (Sent to Staff) [vietnamese]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(463, 'estimate', 'estimate-accepted-to-staff', 'vietnamese', 'Estimate Accepted (Sent to Staff) [vietnamese]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(464, 'proposals', 'proposal-client-accepted', 'vietnamese', 'Customer Action - Accepted (Sent to Staff) [vietnamese]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(465, 'proposals', 'proposal-send-to-customer', 'vietnamese', 'Send Proposal to Customer [vietnamese]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(466, 'proposals', 'proposal-client-declined', 'vietnamese', 'Customer Action - Declined (Sent to Staff) [vietnamese]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(467, 'proposals', 'proposal-client-thank-you', 'vietnamese', 'Thank You Email (Sent to Customer After Accept) [vietnamese]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(468, 'proposals', 'proposal-comment-to-client', 'vietnamese', 'New Comment Â (Sent to Customer/Lead) [vietnamese]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(469, 'proposals', 'proposal-comment-to-admin', 'vietnamese', 'New Comment (Sent to Staff)  [vietnamese]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(470, 'estimate', 'estimate-thank-you-to-customer', 'vietnamese', 'Thank You Email (Sent to Customer After Accept) [vietnamese]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(471, 'tasks', 'task-deadline-notification', 'vietnamese', 'Task Deadline Reminder - Sent to Assigned Members [vietnamese]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(472, 'contract', 'send-contract', 'vietnamese', 'Send Contract to Customer [vietnamese]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(473, 'invoice', 'invoice-payment-recorded-to-staff', 'vietnamese', 'Invoice Payment Recorded (Sent to Staff) [vietnamese]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(474, 'ticket', 'auto-close-ticket', 'vietnamese', 'Auto Close Ticket [vietnamese]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(475, 'project', 'new-project-discussion-created-to-staff', 'vietnamese', 'New Project Discussion (Sent to Project Members) [vietnamese]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(476, 'project', 'new-project-discussion-created-to-customer', 'vietnamese', 'New Project Discussion (Sent to Customer Contacts) [vietnamese]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(477, 'project', 'new-project-file-uploaded-to-customer', 'vietnamese', 'New Project File(s) Uploaded (Sent to Customer Contacts) [vietnamese]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(478, 'project', 'new-project-file-uploaded-to-staff', 'vietnamese', 'New Project File(s) Uploaded (Sent to Project Members) [vietnamese]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(479, 'project', 'new-project-discussion-comment-to-customer', 'vietnamese', 'New Discussion Comment  (Sent to Customer Contacts) [vietnamese]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(480, 'project', 'new-project-discussion-comment-to-staff', 'vietnamese', 'New Discussion Comment (Sent to Project Members) [vietnamese]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(481, 'project', 'staff-added-as-project-member', 'vietnamese', 'Staff Added as Project Member [vietnamese]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(482, 'estimate', 'estimate-expiry-reminder', 'vietnamese', 'Estimate Expiration Reminder [vietnamese]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(483, 'proposals', 'proposal-expiry-reminder', 'vietnamese', 'Proposal Expiration Reminder [vietnamese]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(484, 'staff', 'new-staff-created', 'vietnamese', 'New Staff Created (Welcome Email) [vietnamese]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(485, 'client', 'contact-forgot-password', 'vietnamese', 'Forgot Password [vietnamese]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(486, 'client', 'contact-password-reseted', 'vietnamese', 'Password Reset - Confirmation [vietnamese]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(487, 'client', 'contact-set-password', 'vietnamese', 'Set New Password [vietnamese]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(488, 'staff', 'staff-forgot-password', 'vietnamese', 'Forgot Password [vietnamese]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(489, 'staff', 'staff-password-reseted', 'vietnamese', 'Password Reset - Confirmation [vietnamese]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(490, 'project', 'assigned-to-project', 'vietnamese', 'New Project Created (Sent to Customer Contacts) [vietnamese]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(491, 'tasks', 'task-added-attachment-to-contacts', 'vietnamese', 'New Attachment(s) on Task (Sent to Customer Contacts) [vietnamese]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(492, 'tasks', 'task-commented-to-contacts', 'vietnamese', 'New Comment on Task (Sent to Customer Contacts) [vietnamese]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(493, 'leads', 'new-lead-assigned', 'vietnamese', 'New Lead Assigned to Staff Member [vietnamese]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(494, 'client', 'client-statement', 'vietnamese', 'Statement - Account Summary [vietnamese]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(495, 'ticket', 'ticket-assigned-to-admin', 'vietnamese', 'New Ticket Assigned (Sent to Staff) [vietnamese]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(496, 'client', 'new-client-registered-to-admin', 'vietnamese', 'New Customer Registration (Sent to admins) [vietnamese]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(497, 'leads', 'new-web-to-lead-form-submitted', 'vietnamese', 'Web to lead form submitted - Sent to lead [vietnamese]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(498, 'staff', 'two-factor-authentication', 'vietnamese', 'Two Factor Authentication [vietnamese]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(499, 'project', 'project-finished-to-customer', 'vietnamese', 'Project Marked as Finished (Sent to Customer Contacts) [vietnamese]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(500, 'credit_note', 'credit-note-send-to-client', 'vietnamese', 'Send Credit Note To Email [vietnamese]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(501, 'tasks', 'task-status-change-to-staff', 'vietnamese', 'Task Status Changed (Sent to Staff) [vietnamese]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(502, 'tasks', 'task-status-change-to-contacts', 'vietnamese', 'Task Status Changed (Sent to Customer Contacts) [vietnamese]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(503, 'staff', 'reminder-email-staff', 'vietnamese', 'Staff Reminder Email [vietnamese]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(504, 'contract', 'contract-comment-to-client', 'vietnamese', 'New Comment Â (Sent to Customer Contacts) [vietnamese]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(505, 'contract', 'contract-comment-to-admin', 'vietnamese', 'New Comment (Sent to Staff)  [vietnamese]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(506, 'subscriptions', 'send-subscription', 'vietnamese', 'Send Subscription to Customer [vietnamese]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(507, 'subscriptions', 'subscription-payment-failed', 'vietnamese', 'Subscription Payment Failed [vietnamese]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(508, 'subscriptions', 'subscription-canceled', 'vietnamese', 'Subscription Canceled (Sent to customer primary contact) [vietnamese]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(509, 'subscriptions', 'subscription-payment-succeeded', 'vietnamese', 'Subscription Payment Succeeded (Sent to customer primary contact) [vietnamese]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(510, 'contract', 'contract-expiration-to-staff', 'vietnamese', 'Contract Expiration Reminder (Sent to Staff) [vietnamese]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(511, 'gdpr', 'gdpr-removal-request', 'vietnamese', 'Removal Request From Contact (Sent to administrators) [vietnamese]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(512, 'gdpr', 'gdpr-removal-request-lead', 'vietnamese', 'Removal Request From Lead (Sent to administrators) [vietnamese]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(513, 'client', 'client-registration-confirmed', 'vietnamese', 'Customer Registration Confirmed [vietnamese]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(514, 'contract', 'contract-signed-to-staff', 'vietnamese', 'Contract Signed (Sent to Staff) [vietnamese]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(515, 'subscriptions', 'customer-subscribed-to-staff', 'vietnamese', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [vietnamese]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(516, 'client', 'contact-verification-email', 'vietnamese', 'Email Verification (Sent to Contact After Registration) [vietnamese]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(517, 'client', 'new-customer-profile-file-uploaded-to-staff', 'vietnamese', 'New Customer Profile File(s) Uploaded (Sent to Staff) [vietnamese]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(518, 'staff', 'event-notification-to-staff', 'vietnamese', 'Event Notification (Calendar) [vietnamese]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(519, 'client', 'new-client-created', 'persian', 'New Contact Added/Registered (Welcome Email) [persian]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(520, 'invoice', 'invoice-send-to-client', 'persian', 'Send Invoice to Customer [persian]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(521, 'ticket', 'new-ticket-opened-admin', 'persian', 'New Ticket Opened (Opened by Staff, Sent to Customer) [persian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(522, 'ticket', 'ticket-reply', 'persian', 'Ticket Reply (Sent to Customer) [persian]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(523, 'ticket', 'ticket-autoresponse', 'persian', 'New Ticket Opened - Autoresponse [persian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(524, 'invoice', 'invoice-payment-recorded', 'persian', 'Invoice Payment Recorded (Sent to Customer) [persian]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(525, 'invoice', 'invoice-overdue-notice', 'persian', 'Invoice Overdue Notice [persian]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(526, 'invoice', 'invoice-already-send', 'persian', 'Invoice Already Sent to Customer [persian]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(527, 'ticket', 'new-ticket-created-staff', 'persian', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [persian]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(528, 'estimate', 'estimate-send-to-client', 'persian', 'Send Estimate to Customer [persian]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(529, 'ticket', 'ticket-reply-to-admin', 'persian', 'Ticket Reply (Sent to Staff) [persian]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(530, 'estimate', 'estimate-already-send', 'persian', 'Estimate Already Sent to Customer [persian]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(531, 'contract', 'contract-expiration', 'persian', 'Contract Expiration Reminder (Sent to Customer Contacts) [persian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(532, 'tasks', 'task-assigned', 'persian', 'New Task Assigned (Sent to Staff) [persian]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(533, 'tasks', 'task-added-as-follower', 'persian', 'Staff Member Added as Follower on Task (Sent to Staff) [persian]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(534, 'tasks', 'task-commented', 'persian', 'New Comment on Task (Sent to Staff) [persian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(535, 'tasks', 'task-added-attachment', 'persian', 'New Attachment(s) on Task (Sent to Staff) [persian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(536, 'estimate', 'estimate-declined-to-staff', 'persian', 'Estimate Declined (Sent to Staff) [persian]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(537, 'estimate', 'estimate-accepted-to-staff', 'persian', 'Estimate Accepted (Sent to Staff) [persian]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(538, 'proposals', 'proposal-client-accepted', 'persian', 'Customer Action - Accepted (Sent to Staff) [persian]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(539, 'proposals', 'proposal-send-to-customer', 'persian', 'Send Proposal to Customer [persian]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(540, 'proposals', 'proposal-client-declined', 'persian', 'Customer Action - Declined (Sent to Staff) [persian]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(541, 'proposals', 'proposal-client-thank-you', 'persian', 'Thank You Email (Sent to Customer After Accept) [persian]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(542, 'proposals', 'proposal-comment-to-client', 'persian', 'New Comment Â (Sent to Customer/Lead) [persian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(543, 'proposals', 'proposal-comment-to-admin', 'persian', 'New Comment (Sent to Staff)  [persian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(544, 'estimate', 'estimate-thank-you-to-customer', 'persian', 'Thank You Email (Sent to Customer After Accept) [persian]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(545, 'tasks', 'task-deadline-notification', 'persian', 'Task Deadline Reminder - Sent to Assigned Members [persian]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(546, 'contract', 'send-contract', 'persian', 'Send Contract to Customer [persian]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(547, 'invoice', 'invoice-payment-recorded-to-staff', 'persian', 'Invoice Payment Recorded (Sent to Staff) [persian]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(548, 'ticket', 'auto-close-ticket', 'persian', 'Auto Close Ticket [persian]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(549, 'project', 'new-project-discussion-created-to-staff', 'persian', 'New Project Discussion (Sent to Project Members) [persian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(550, 'project', 'new-project-discussion-created-to-customer', 'persian', 'New Project Discussion (Sent to Customer Contacts) [persian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(551, 'project', 'new-project-file-uploaded-to-customer', 'persian', 'New Project File(s) Uploaded (Sent to Customer Contacts) [persian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(552, 'project', 'new-project-file-uploaded-to-staff', 'persian', 'New Project File(s) Uploaded (Sent to Project Members) [persian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(553, 'project', 'new-project-discussion-comment-to-customer', 'persian', 'New Discussion Comment  (Sent to Customer Contacts) [persian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(554, 'project', 'new-project-discussion-comment-to-staff', 'persian', 'New Discussion Comment (Sent to Project Members) [persian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(555, 'project', 'staff-added-as-project-member', 'persian', 'Staff Added as Project Member [persian]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(556, 'estimate', 'estimate-expiry-reminder', 'persian', 'Estimate Expiration Reminder [persian]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(557, 'proposals', 'proposal-expiry-reminder', 'persian', 'Proposal Expiration Reminder [persian]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(558, 'staff', 'new-staff-created', 'persian', 'New Staff Created (Welcome Email) [persian]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(559, 'client', 'contact-forgot-password', 'persian', 'Forgot Password [persian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(560, 'client', 'contact-password-reseted', 'persian', 'Password Reset - Confirmation [persian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(561, 'client', 'contact-set-password', 'persian', 'Set New Password [persian]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(562, 'staff', 'staff-forgot-password', 'persian', 'Forgot Password [persian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(563, 'staff', 'staff-password-reseted', 'persian', 'Password Reset - Confirmation [persian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(564, 'project', 'assigned-to-project', 'persian', 'New Project Created (Sent to Customer Contacts) [persian]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(565, 'tasks', 'task-added-attachment-to-contacts', 'persian', 'New Attachment(s) on Task (Sent to Customer Contacts) [persian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(566, 'tasks', 'task-commented-to-contacts', 'persian', 'New Comment on Task (Sent to Customer Contacts) [persian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(567, 'leads', 'new-lead-assigned', 'persian', 'New Lead Assigned to Staff Member [persian]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(568, 'client', 'client-statement', 'persian', 'Statement - Account Summary [persian]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(569, 'ticket', 'ticket-assigned-to-admin', 'persian', 'New Ticket Assigned (Sent to Staff) [persian]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(570, 'client', 'new-client-registered-to-admin', 'persian', 'New Customer Registration (Sent to admins) [persian]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(571, 'leads', 'new-web-to-lead-form-submitted', 'persian', 'Web to lead form submitted - Sent to lead [persian]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(572, 'staff', 'two-factor-authentication', 'persian', 'Two Factor Authentication [persian]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(573, 'project', 'project-finished-to-customer', 'persian', 'Project Marked as Finished (Sent to Customer Contacts) [persian]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(574, 'credit_note', 'credit-note-send-to-client', 'persian', 'Send Credit Note To Email [persian]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(575, 'tasks', 'task-status-change-to-staff', 'persian', 'Task Status Changed (Sent to Staff) [persian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(576, 'tasks', 'task-status-change-to-contacts', 'persian', 'Task Status Changed (Sent to Customer Contacts) [persian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(577, 'staff', 'reminder-email-staff', 'persian', 'Staff Reminder Email [persian]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(578, 'contract', 'contract-comment-to-client', 'persian', 'New Comment Â (Sent to Customer Contacts) [persian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(579, 'contract', 'contract-comment-to-admin', 'persian', 'New Comment (Sent to Staff)  [persian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(580, 'subscriptions', 'send-subscription', 'persian', 'Send Subscription to Customer [persian]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(581, 'subscriptions', 'subscription-payment-failed', 'persian', 'Subscription Payment Failed [persian]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(582, 'subscriptions', 'subscription-canceled', 'persian', 'Subscription Canceled (Sent to customer primary contact) [persian]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(583, 'subscriptions', 'subscription-payment-succeeded', 'persian', 'Subscription Payment Succeeded (Sent to customer primary contact) [persian]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(584, 'contract', 'contract-expiration-to-staff', 'persian', 'Contract Expiration Reminder (Sent to Staff) [persian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(585, 'gdpr', 'gdpr-removal-request', 'persian', 'Removal Request From Contact (Sent to administrators) [persian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(586, 'gdpr', 'gdpr-removal-request-lead', 'persian', 'Removal Request From Lead (Sent to administrators) [persian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(587, 'client', 'client-registration-confirmed', 'persian', 'Customer Registration Confirmed [persian]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(588, 'contract', 'contract-signed-to-staff', 'persian', 'Contract Signed (Sent to Staff) [persian]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(589, 'subscriptions', 'customer-subscribed-to-staff', 'persian', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [persian]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(590, 'client', 'contact-verification-email', 'persian', 'Email Verification (Sent to Contact After Registration) [persian]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(591, 'client', 'new-customer-profile-file-uploaded-to-staff', 'persian', 'New Customer Profile File(s) Uploaded (Sent to Staff) [persian]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(592, 'staff', 'event-notification-to-staff', 'persian', 'Event Notification (Calendar) [persian]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(593, 'client', 'new-client-created', 'spanish', 'New Contact Added/Registered (Welcome Email) [spanish]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(594, 'invoice', 'invoice-send-to-client', 'spanish', 'Send Invoice to Customer [spanish]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(595, 'ticket', 'new-ticket-opened-admin', 'spanish', 'New Ticket Opened (Opened by Staff, Sent to Customer) [spanish]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(596, 'ticket', 'ticket-reply', 'spanish', 'Ticket Reply (Sent to Customer) [spanish]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(597, 'ticket', 'ticket-autoresponse', 'spanish', 'New Ticket Opened - Autoresponse [spanish]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(598, 'invoice', 'invoice-payment-recorded', 'spanish', 'Invoice Payment Recorded (Sent to Customer) [spanish]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(599, 'invoice', 'invoice-overdue-notice', 'spanish', 'Invoice Overdue Notice [spanish]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(600, 'invoice', 'invoice-already-send', 'spanish', 'Invoice Already Sent to Customer [spanish]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(601, 'ticket', 'new-ticket-created-staff', 'spanish', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [spanish]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(602, 'estimate', 'estimate-send-to-client', 'spanish', 'Send Estimate to Customer [spanish]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(603, 'ticket', 'ticket-reply-to-admin', 'spanish', 'Ticket Reply (Sent to Staff) [spanish]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(604, 'estimate', 'estimate-already-send', 'spanish', 'Estimate Already Sent to Customer [spanish]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(605, 'contract', 'contract-expiration', 'spanish', 'Contract Expiration Reminder (Sent to Customer Contacts) [spanish]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(606, 'tasks', 'task-assigned', 'spanish', 'New Task Assigned (Sent to Staff) [spanish]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(607, 'tasks', 'task-added-as-follower', 'spanish', 'Staff Member Added as Follower on Task (Sent to Staff) [spanish]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(608, 'tasks', 'task-commented', 'spanish', 'New Comment on Task (Sent to Staff) [spanish]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(609, 'tasks', 'task-added-attachment', 'spanish', 'New Attachment(s) on Task (Sent to Staff) [spanish]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(610, 'estimate', 'estimate-declined-to-staff', 'spanish', 'Estimate Declined (Sent to Staff) [spanish]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(611, 'estimate', 'estimate-accepted-to-staff', 'spanish', 'Estimate Accepted (Sent to Staff) [spanish]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(612, 'proposals', 'proposal-client-accepted', 'spanish', 'Customer Action - Accepted (Sent to Staff) [spanish]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(613, 'proposals', 'proposal-send-to-customer', 'spanish', 'Send Proposal to Customer [spanish]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(614, 'proposals', 'proposal-client-declined', 'spanish', 'Customer Action - Declined (Sent to Staff) [spanish]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(615, 'proposals', 'proposal-client-thank-you', 'spanish', 'Thank You Email (Sent to Customer After Accept) [spanish]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(616, 'proposals', 'proposal-comment-to-client', 'spanish', 'New Comment Â (Sent to Customer/Lead) [spanish]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(617, 'proposals', 'proposal-comment-to-admin', 'spanish', 'New Comment (Sent to Staff)  [spanish]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(618, 'estimate', 'estimate-thank-you-to-customer', 'spanish', 'Thank You Email (Sent to Customer After Accept) [spanish]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(619, 'tasks', 'task-deadline-notification', 'spanish', 'Task Deadline Reminder - Sent to Assigned Members [spanish]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0);
INSERT INTO `ms_emailtemplates` (`emailtemplateid`, `type`, `slug`, `language`, `name`, `subject`, `message`, `fromname`, `fromemail`, `plaintext`, `active`, `order`) VALUES
(620, 'contract', 'send-contract', 'spanish', 'Send Contract to Customer [spanish]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(621, 'invoice', 'invoice-payment-recorded-to-staff', 'spanish', 'Invoice Payment Recorded (Sent to Staff) [spanish]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(622, 'ticket', 'auto-close-ticket', 'spanish', 'Auto Close Ticket [spanish]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(623, 'project', 'new-project-discussion-created-to-staff', 'spanish', 'New Project Discussion (Sent to Project Members) [spanish]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(624, 'project', 'new-project-discussion-created-to-customer', 'spanish', 'New Project Discussion (Sent to Customer Contacts) [spanish]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(625, 'project', 'new-project-file-uploaded-to-customer', 'spanish', 'New Project File(s) Uploaded (Sent to Customer Contacts) [spanish]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(626, 'project', 'new-project-file-uploaded-to-staff', 'spanish', 'New Project File(s) Uploaded (Sent to Project Members) [spanish]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(627, 'project', 'new-project-discussion-comment-to-customer', 'spanish', 'New Discussion Comment  (Sent to Customer Contacts) [spanish]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(628, 'project', 'new-project-discussion-comment-to-staff', 'spanish', 'New Discussion Comment (Sent to Project Members) [spanish]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(629, 'project', 'staff-added-as-project-member', 'spanish', 'Staff Added as Project Member [spanish]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(630, 'estimate', 'estimate-expiry-reminder', 'spanish', 'Estimate Expiration Reminder [spanish]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(631, 'proposals', 'proposal-expiry-reminder', 'spanish', 'Proposal Expiration Reminder [spanish]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(632, 'staff', 'new-staff-created', 'spanish', 'New Staff Created (Welcome Email) [spanish]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(633, 'client', 'contact-forgot-password', 'spanish', 'Forgot Password [spanish]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(634, 'client', 'contact-password-reseted', 'spanish', 'Password Reset - Confirmation [spanish]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(635, 'client', 'contact-set-password', 'spanish', 'Set New Password [spanish]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(636, 'staff', 'staff-forgot-password', 'spanish', 'Forgot Password [spanish]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(637, 'staff', 'staff-password-reseted', 'spanish', 'Password Reset - Confirmation [spanish]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(638, 'project', 'assigned-to-project', 'spanish', 'New Project Created (Sent to Customer Contacts) [spanish]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(639, 'tasks', 'task-added-attachment-to-contacts', 'spanish', 'New Attachment(s) on Task (Sent to Customer Contacts) [spanish]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(640, 'tasks', 'task-commented-to-contacts', 'spanish', 'New Comment on Task (Sent to Customer Contacts) [spanish]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(641, 'leads', 'new-lead-assigned', 'spanish', 'New Lead Assigned to Staff Member [spanish]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(642, 'client', 'client-statement', 'spanish', 'Statement - Account Summary [spanish]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(643, 'ticket', 'ticket-assigned-to-admin', 'spanish', 'New Ticket Assigned (Sent to Staff) [spanish]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(644, 'client', 'new-client-registered-to-admin', 'spanish', 'New Customer Registration (Sent to admins) [spanish]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(645, 'leads', 'new-web-to-lead-form-submitted', 'spanish', 'Web to lead form submitted - Sent to lead [spanish]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(646, 'staff', 'two-factor-authentication', 'spanish', 'Two Factor Authentication [spanish]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(647, 'project', 'project-finished-to-customer', 'spanish', 'Project Marked as Finished (Sent to Customer Contacts) [spanish]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(648, 'credit_note', 'credit-note-send-to-client', 'spanish', 'Send Credit Note To Email [spanish]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(649, 'tasks', 'task-status-change-to-staff', 'spanish', 'Task Status Changed (Sent to Staff) [spanish]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(650, 'tasks', 'task-status-change-to-contacts', 'spanish', 'Task Status Changed (Sent to Customer Contacts) [spanish]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(651, 'staff', 'reminder-email-staff', 'spanish', 'Staff Reminder Email [spanish]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(652, 'contract', 'contract-comment-to-client', 'spanish', 'New Comment Â (Sent to Customer Contacts) [spanish]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(653, 'contract', 'contract-comment-to-admin', 'spanish', 'New Comment (Sent to Staff)  [spanish]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(654, 'subscriptions', 'send-subscription', 'spanish', 'Send Subscription to Customer [spanish]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(655, 'subscriptions', 'subscription-payment-failed', 'spanish', 'Subscription Payment Failed [spanish]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(656, 'subscriptions', 'subscription-canceled', 'spanish', 'Subscription Canceled (Sent to customer primary contact) [spanish]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(657, 'subscriptions', 'subscription-payment-succeeded', 'spanish', 'Subscription Payment Succeeded (Sent to customer primary contact) [spanish]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(658, 'contract', 'contract-expiration-to-staff', 'spanish', 'Contract Expiration Reminder (Sent to Staff) [spanish]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(659, 'gdpr', 'gdpr-removal-request', 'spanish', 'Removal Request From Contact (Sent to administrators) [spanish]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(660, 'gdpr', 'gdpr-removal-request-lead', 'spanish', 'Removal Request From Lead (Sent to administrators) [spanish]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(661, 'client', 'client-registration-confirmed', 'spanish', 'Customer Registration Confirmed [spanish]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(662, 'contract', 'contract-signed-to-staff', 'spanish', 'Contract Signed (Sent to Staff) [spanish]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(663, 'subscriptions', 'customer-subscribed-to-staff', 'spanish', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [spanish]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(664, 'client', 'contact-verification-email', 'spanish', 'Email Verification (Sent to Contact After Registration) [spanish]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(665, 'client', 'new-customer-profile-file-uploaded-to-staff', 'spanish', 'New Customer Profile File(s) Uploaded (Sent to Staff) [spanish]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(666, 'staff', 'event-notification-to-staff', 'spanish', 'Event Notification (Calendar) [spanish]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(667, 'client', 'new-client-created', 'japanese', 'New Contact Added/Registered (Welcome Email) [japanese]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(668, 'invoice', 'invoice-send-to-client', 'japanese', 'Send Invoice to Customer [japanese]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(669, 'ticket', 'new-ticket-opened-admin', 'japanese', 'New Ticket Opened (Opened by Staff, Sent to Customer) [japanese]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(670, 'ticket', 'ticket-reply', 'japanese', 'Ticket Reply (Sent to Customer) [japanese]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(671, 'ticket', 'ticket-autoresponse', 'japanese', 'New Ticket Opened - Autoresponse [japanese]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(672, 'invoice', 'invoice-payment-recorded', 'japanese', 'Invoice Payment Recorded (Sent to Customer) [japanese]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(673, 'invoice', 'invoice-overdue-notice', 'japanese', 'Invoice Overdue Notice [japanese]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(674, 'invoice', 'invoice-already-send', 'japanese', 'Invoice Already Sent to Customer [japanese]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(675, 'ticket', 'new-ticket-created-staff', 'japanese', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [japanese]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(676, 'estimate', 'estimate-send-to-client', 'japanese', 'Send Estimate to Customer [japanese]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(677, 'ticket', 'ticket-reply-to-admin', 'japanese', 'Ticket Reply (Sent to Staff) [japanese]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(678, 'estimate', 'estimate-already-send', 'japanese', 'Estimate Already Sent to Customer [japanese]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(679, 'contract', 'contract-expiration', 'japanese', 'Contract Expiration Reminder (Sent to Customer Contacts) [japanese]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(680, 'tasks', 'task-assigned', 'japanese', 'New Task Assigned (Sent to Staff) [japanese]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(681, 'tasks', 'task-added-as-follower', 'japanese', 'Staff Member Added as Follower on Task (Sent to Staff) [japanese]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(682, 'tasks', 'task-commented', 'japanese', 'New Comment on Task (Sent to Staff) [japanese]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(683, 'tasks', 'task-added-attachment', 'japanese', 'New Attachment(s) on Task (Sent to Staff) [japanese]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(684, 'estimate', 'estimate-declined-to-staff', 'japanese', 'Estimate Declined (Sent to Staff) [japanese]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(685, 'estimate', 'estimate-accepted-to-staff', 'japanese', 'Estimate Accepted (Sent to Staff) [japanese]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(686, 'proposals', 'proposal-client-accepted', 'japanese', 'Customer Action - Accepted (Sent to Staff) [japanese]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(687, 'proposals', 'proposal-send-to-customer', 'japanese', 'Send Proposal to Customer [japanese]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(688, 'proposals', 'proposal-client-declined', 'japanese', 'Customer Action - Declined (Sent to Staff) [japanese]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(689, 'proposals', 'proposal-client-thank-you', 'japanese', 'Thank You Email (Sent to Customer After Accept) [japanese]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(690, 'proposals', 'proposal-comment-to-client', 'japanese', 'New Comment Â (Sent to Customer/Lead) [japanese]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(691, 'proposals', 'proposal-comment-to-admin', 'japanese', 'New Comment (Sent to Staff)  [japanese]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(692, 'estimate', 'estimate-thank-you-to-customer', 'japanese', 'Thank You Email (Sent to Customer After Accept) [japanese]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(693, 'tasks', 'task-deadline-notification', 'japanese', 'Task Deadline Reminder - Sent to Assigned Members [japanese]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(694, 'contract', 'send-contract', 'japanese', 'Send Contract to Customer [japanese]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(695, 'invoice', 'invoice-payment-recorded-to-staff', 'japanese', 'Invoice Payment Recorded (Sent to Staff) [japanese]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(696, 'ticket', 'auto-close-ticket', 'japanese', 'Auto Close Ticket [japanese]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(697, 'project', 'new-project-discussion-created-to-staff', 'japanese', 'New Project Discussion (Sent to Project Members) [japanese]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(698, 'project', 'new-project-discussion-created-to-customer', 'japanese', 'New Project Discussion (Sent to Customer Contacts) [japanese]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(699, 'project', 'new-project-file-uploaded-to-customer', 'japanese', 'New Project File(s) Uploaded (Sent to Customer Contacts) [japanese]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(700, 'project', 'new-project-file-uploaded-to-staff', 'japanese', 'New Project File(s) Uploaded (Sent to Project Members) [japanese]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(701, 'project', 'new-project-discussion-comment-to-customer', 'japanese', 'New Discussion Comment  (Sent to Customer Contacts) [japanese]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(702, 'project', 'new-project-discussion-comment-to-staff', 'japanese', 'New Discussion Comment (Sent to Project Members) [japanese]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(703, 'project', 'staff-added-as-project-member', 'japanese', 'Staff Added as Project Member [japanese]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(704, 'estimate', 'estimate-expiry-reminder', 'japanese', 'Estimate Expiration Reminder [japanese]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(705, 'proposals', 'proposal-expiry-reminder', 'japanese', 'Proposal Expiration Reminder [japanese]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(706, 'staff', 'new-staff-created', 'japanese', 'New Staff Created (Welcome Email) [japanese]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(707, 'client', 'contact-forgot-password', 'japanese', 'Forgot Password [japanese]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(708, 'client', 'contact-password-reseted', 'japanese', 'Password Reset - Confirmation [japanese]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(709, 'client', 'contact-set-password', 'japanese', 'Set New Password [japanese]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(710, 'staff', 'staff-forgot-password', 'japanese', 'Forgot Password [japanese]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(711, 'staff', 'staff-password-reseted', 'japanese', 'Password Reset - Confirmation [japanese]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(712, 'project', 'assigned-to-project', 'japanese', 'New Project Created (Sent to Customer Contacts) [japanese]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(713, 'tasks', 'task-added-attachment-to-contacts', 'japanese', 'New Attachment(s) on Task (Sent to Customer Contacts) [japanese]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(714, 'tasks', 'task-commented-to-contacts', 'japanese', 'New Comment on Task (Sent to Customer Contacts) [japanese]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(715, 'leads', 'new-lead-assigned', 'japanese', 'New Lead Assigned to Staff Member [japanese]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(716, 'client', 'client-statement', 'japanese', 'Statement - Account Summary [japanese]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(717, 'ticket', 'ticket-assigned-to-admin', 'japanese', 'New Ticket Assigned (Sent to Staff) [japanese]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(718, 'client', 'new-client-registered-to-admin', 'japanese', 'New Customer Registration (Sent to admins) [japanese]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(719, 'leads', 'new-web-to-lead-form-submitted', 'japanese', 'Web to lead form submitted - Sent to lead [japanese]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(720, 'staff', 'two-factor-authentication', 'japanese', 'Two Factor Authentication [japanese]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(721, 'project', 'project-finished-to-customer', 'japanese', 'Project Marked as Finished (Sent to Customer Contacts) [japanese]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(722, 'credit_note', 'credit-note-send-to-client', 'japanese', 'Send Credit Note To Email [japanese]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(723, 'tasks', 'task-status-change-to-staff', 'japanese', 'Task Status Changed (Sent to Staff) [japanese]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(724, 'tasks', 'task-status-change-to-contacts', 'japanese', 'Task Status Changed (Sent to Customer Contacts) [japanese]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(725, 'staff', 'reminder-email-staff', 'japanese', 'Staff Reminder Email [japanese]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(726, 'contract', 'contract-comment-to-client', 'japanese', 'New Comment Â (Sent to Customer Contacts) [japanese]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(727, 'contract', 'contract-comment-to-admin', 'japanese', 'New Comment (Sent to Staff)  [japanese]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(728, 'subscriptions', 'send-subscription', 'japanese', 'Send Subscription to Customer [japanese]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(729, 'subscriptions', 'subscription-payment-failed', 'japanese', 'Subscription Payment Failed [japanese]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(730, 'subscriptions', 'subscription-canceled', 'japanese', 'Subscription Canceled (Sent to customer primary contact) [japanese]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(731, 'subscriptions', 'subscription-payment-succeeded', 'japanese', 'Subscription Payment Succeeded (Sent to customer primary contact) [japanese]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(732, 'contract', 'contract-expiration-to-staff', 'japanese', 'Contract Expiration Reminder (Sent to Staff) [japanese]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(733, 'gdpr', 'gdpr-removal-request', 'japanese', 'Removal Request From Contact (Sent to administrators) [japanese]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(734, 'gdpr', 'gdpr-removal-request-lead', 'japanese', 'Removal Request From Lead (Sent to administrators) [japanese]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(735, 'client', 'client-registration-confirmed', 'japanese', 'Customer Registration Confirmed [japanese]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(736, 'contract', 'contract-signed-to-staff', 'japanese', 'Contract Signed (Sent to Staff) [japanese]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(737, 'subscriptions', 'customer-subscribed-to-staff', 'japanese', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [japanese]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(738, 'client', 'contact-verification-email', 'japanese', 'Email Verification (Sent to Contact After Registration) [japanese]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(739, 'client', 'new-customer-profile-file-uploaded-to-staff', 'japanese', 'New Customer Profile File(s) Uploaded (Sent to Staff) [japanese]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(740, 'staff', 'event-notification-to-staff', 'japanese', 'Event Notification (Calendar) [japanese]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(741, 'client', 'new-client-created', 'bulgarian', 'New Contact Added/Registered (Welcome Email) [bulgarian]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(742, 'invoice', 'invoice-send-to-client', 'bulgarian', 'Send Invoice to Customer [bulgarian]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(743, 'ticket', 'new-ticket-opened-admin', 'bulgarian', 'New Ticket Opened (Opened by Staff, Sent to Customer) [bulgarian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(744, 'ticket', 'ticket-reply', 'bulgarian', 'Ticket Reply (Sent to Customer) [bulgarian]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(745, 'ticket', 'ticket-autoresponse', 'bulgarian', 'New Ticket Opened - Autoresponse [bulgarian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(746, 'invoice', 'invoice-payment-recorded', 'bulgarian', 'Invoice Payment Recorded (Sent to Customer) [bulgarian]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(747, 'invoice', 'invoice-overdue-notice', 'bulgarian', 'Invoice Overdue Notice [bulgarian]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(748, 'invoice', 'invoice-already-send', 'bulgarian', 'Invoice Already Sent to Customer [bulgarian]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(749, 'ticket', 'new-ticket-created-staff', 'bulgarian', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [bulgarian]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(750, 'estimate', 'estimate-send-to-client', 'bulgarian', 'Send Estimate to Customer [bulgarian]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(751, 'ticket', 'ticket-reply-to-admin', 'bulgarian', 'Ticket Reply (Sent to Staff) [bulgarian]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(752, 'estimate', 'estimate-already-send', 'bulgarian', 'Estimate Already Sent to Customer [bulgarian]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(753, 'contract', 'contract-expiration', 'bulgarian', 'Contract Expiration Reminder (Sent to Customer Contacts) [bulgarian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(754, 'tasks', 'task-assigned', 'bulgarian', 'New Task Assigned (Sent to Staff) [bulgarian]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(755, 'tasks', 'task-added-as-follower', 'bulgarian', 'Staff Member Added as Follower on Task (Sent to Staff) [bulgarian]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(756, 'tasks', 'task-commented', 'bulgarian', 'New Comment on Task (Sent to Staff) [bulgarian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(757, 'tasks', 'task-added-attachment', 'bulgarian', 'New Attachment(s) on Task (Sent to Staff) [bulgarian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(758, 'estimate', 'estimate-declined-to-staff', 'bulgarian', 'Estimate Declined (Sent to Staff) [bulgarian]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(759, 'estimate', 'estimate-accepted-to-staff', 'bulgarian', 'Estimate Accepted (Sent to Staff) [bulgarian]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(760, 'proposals', 'proposal-client-accepted', 'bulgarian', 'Customer Action - Accepted (Sent to Staff) [bulgarian]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(761, 'proposals', 'proposal-send-to-customer', 'bulgarian', 'Send Proposal to Customer [bulgarian]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(762, 'proposals', 'proposal-client-declined', 'bulgarian', 'Customer Action - Declined (Sent to Staff) [bulgarian]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(763, 'proposals', 'proposal-client-thank-you', 'bulgarian', 'Thank You Email (Sent to Customer After Accept) [bulgarian]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(764, 'proposals', 'proposal-comment-to-client', 'bulgarian', 'New Comment Â (Sent to Customer/Lead) [bulgarian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(765, 'proposals', 'proposal-comment-to-admin', 'bulgarian', 'New Comment (Sent to Staff)  [bulgarian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(766, 'estimate', 'estimate-thank-you-to-customer', 'bulgarian', 'Thank You Email (Sent to Customer After Accept) [bulgarian]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(767, 'tasks', 'task-deadline-notification', 'bulgarian', 'Task Deadline Reminder - Sent to Assigned Members [bulgarian]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(768, 'contract', 'send-contract', 'bulgarian', 'Send Contract to Customer [bulgarian]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(769, 'invoice', 'invoice-payment-recorded-to-staff', 'bulgarian', 'Invoice Payment Recorded (Sent to Staff) [bulgarian]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(770, 'ticket', 'auto-close-ticket', 'bulgarian', 'Auto Close Ticket [bulgarian]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(771, 'project', 'new-project-discussion-created-to-staff', 'bulgarian', 'New Project Discussion (Sent to Project Members) [bulgarian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(772, 'project', 'new-project-discussion-created-to-customer', 'bulgarian', 'New Project Discussion (Sent to Customer Contacts) [bulgarian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(773, 'project', 'new-project-file-uploaded-to-customer', 'bulgarian', 'New Project File(s) Uploaded (Sent to Customer Contacts) [bulgarian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(774, 'project', 'new-project-file-uploaded-to-staff', 'bulgarian', 'New Project File(s) Uploaded (Sent to Project Members) [bulgarian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(775, 'project', 'new-project-discussion-comment-to-customer', 'bulgarian', 'New Discussion Comment  (Sent to Customer Contacts) [bulgarian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(776, 'project', 'new-project-discussion-comment-to-staff', 'bulgarian', 'New Discussion Comment (Sent to Project Members) [bulgarian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(777, 'project', 'staff-added-as-project-member', 'bulgarian', 'Staff Added as Project Member [bulgarian]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(778, 'estimate', 'estimate-expiry-reminder', 'bulgarian', 'Estimate Expiration Reminder [bulgarian]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(779, 'proposals', 'proposal-expiry-reminder', 'bulgarian', 'Proposal Expiration Reminder [bulgarian]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(780, 'staff', 'new-staff-created', 'bulgarian', 'New Staff Created (Welcome Email) [bulgarian]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(781, 'client', 'contact-forgot-password', 'bulgarian', 'Forgot Password [bulgarian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(782, 'client', 'contact-password-reseted', 'bulgarian', 'Password Reset - Confirmation [bulgarian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(783, 'client', 'contact-set-password', 'bulgarian', 'Set New Password [bulgarian]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(784, 'staff', 'staff-forgot-password', 'bulgarian', 'Forgot Password [bulgarian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(785, 'staff', 'staff-password-reseted', 'bulgarian', 'Password Reset - Confirmation [bulgarian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(786, 'project', 'assigned-to-project', 'bulgarian', 'New Project Created (Sent to Customer Contacts) [bulgarian]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(787, 'tasks', 'task-added-attachment-to-contacts', 'bulgarian', 'New Attachment(s) on Task (Sent to Customer Contacts) [bulgarian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(788, 'tasks', 'task-commented-to-contacts', 'bulgarian', 'New Comment on Task (Sent to Customer Contacts) [bulgarian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(789, 'leads', 'new-lead-assigned', 'bulgarian', 'New Lead Assigned to Staff Member [bulgarian]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(790, 'client', 'client-statement', 'bulgarian', 'Statement - Account Summary [bulgarian]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(791, 'ticket', 'ticket-assigned-to-admin', 'bulgarian', 'New Ticket Assigned (Sent to Staff) [bulgarian]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(792, 'client', 'new-client-registered-to-admin', 'bulgarian', 'New Customer Registration (Sent to admins) [bulgarian]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(793, 'leads', 'new-web-to-lead-form-submitted', 'bulgarian', 'Web to lead form submitted - Sent to lead [bulgarian]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(794, 'staff', 'two-factor-authentication', 'bulgarian', 'Two Factor Authentication [bulgarian]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(795, 'project', 'project-finished-to-customer', 'bulgarian', 'Project Marked as Finished (Sent to Customer Contacts) [bulgarian]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(796, 'credit_note', 'credit-note-send-to-client', 'bulgarian', 'Send Credit Note To Email [bulgarian]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(797, 'tasks', 'task-status-change-to-staff', 'bulgarian', 'Task Status Changed (Sent to Staff) [bulgarian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(798, 'tasks', 'task-status-change-to-contacts', 'bulgarian', 'Task Status Changed (Sent to Customer Contacts) [bulgarian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(799, 'staff', 'reminder-email-staff', 'bulgarian', 'Staff Reminder Email [bulgarian]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(800, 'contract', 'contract-comment-to-client', 'bulgarian', 'New Comment Â (Sent to Customer Contacts) [bulgarian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(801, 'contract', 'contract-comment-to-admin', 'bulgarian', 'New Comment (Sent to Staff)  [bulgarian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(802, 'subscriptions', 'send-subscription', 'bulgarian', 'Send Subscription to Customer [bulgarian]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(803, 'subscriptions', 'subscription-payment-failed', 'bulgarian', 'Subscription Payment Failed [bulgarian]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(804, 'subscriptions', 'subscription-canceled', 'bulgarian', 'Subscription Canceled (Sent to customer primary contact) [bulgarian]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(805, 'subscriptions', 'subscription-payment-succeeded', 'bulgarian', 'Subscription Payment Succeeded (Sent to customer primary contact) [bulgarian]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(806, 'contract', 'contract-expiration-to-staff', 'bulgarian', 'Contract Expiration Reminder (Sent to Staff) [bulgarian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(807, 'gdpr', 'gdpr-removal-request', 'bulgarian', 'Removal Request From Contact (Sent to administrators) [bulgarian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(808, 'gdpr', 'gdpr-removal-request-lead', 'bulgarian', 'Removal Request From Lead (Sent to administrators) [bulgarian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(809, 'client', 'client-registration-confirmed', 'bulgarian', 'Customer Registration Confirmed [bulgarian]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(810, 'contract', 'contract-signed-to-staff', 'bulgarian', 'Contract Signed (Sent to Staff) [bulgarian]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(811, 'subscriptions', 'customer-subscribed-to-staff', 'bulgarian', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [bulgarian]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(812, 'client', 'contact-verification-email', 'bulgarian', 'Email Verification (Sent to Contact After Registration) [bulgarian]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(813, 'client', 'new-customer-profile-file-uploaded-to-staff', 'bulgarian', 'New Customer Profile File(s) Uploaded (Sent to Staff) [bulgarian]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(814, 'staff', 'event-notification-to-staff', 'bulgarian', 'Event Notification (Calendar) [bulgarian]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(815, 'client', 'new-client-created', 'slovak', 'New Contact Added/Registered (Welcome Email) [slovak]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(816, 'invoice', 'invoice-send-to-client', 'slovak', 'Send Invoice to Customer [slovak]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(817, 'ticket', 'new-ticket-opened-admin', 'slovak', 'New Ticket Opened (Opened by Staff, Sent to Customer) [slovak]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(818, 'ticket', 'ticket-reply', 'slovak', 'Ticket Reply (Sent to Customer) [slovak]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(819, 'ticket', 'ticket-autoresponse', 'slovak', 'New Ticket Opened - Autoresponse [slovak]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(820, 'invoice', 'invoice-payment-recorded', 'slovak', 'Invoice Payment Recorded (Sent to Customer) [slovak]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(821, 'invoice', 'invoice-overdue-notice', 'slovak', 'Invoice Overdue Notice [slovak]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(822, 'invoice', 'invoice-already-send', 'slovak', 'Invoice Already Sent to Customer [slovak]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(823, 'ticket', 'new-ticket-created-staff', 'slovak', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [slovak]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(824, 'estimate', 'estimate-send-to-client', 'slovak', 'Send Estimate to Customer [slovak]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(825, 'ticket', 'ticket-reply-to-admin', 'slovak', 'Ticket Reply (Sent to Staff) [slovak]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(826, 'estimate', 'estimate-already-send', 'slovak', 'Estimate Already Sent to Customer [slovak]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(827, 'contract', 'contract-expiration', 'slovak', 'Contract Expiration Reminder (Sent to Customer Contacts) [slovak]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(828, 'tasks', 'task-assigned', 'slovak', 'New Task Assigned (Sent to Staff) [slovak]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(829, 'tasks', 'task-added-as-follower', 'slovak', 'Staff Member Added as Follower on Task (Sent to Staff) [slovak]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(830, 'tasks', 'task-commented', 'slovak', 'New Comment on Task (Sent to Staff) [slovak]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(831, 'tasks', 'task-added-attachment', 'slovak', 'New Attachment(s) on Task (Sent to Staff) [slovak]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(832, 'estimate', 'estimate-declined-to-staff', 'slovak', 'Estimate Declined (Sent to Staff) [slovak]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(833, 'estimate', 'estimate-accepted-to-staff', 'slovak', 'Estimate Accepted (Sent to Staff) [slovak]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(834, 'proposals', 'proposal-client-accepted', 'slovak', 'Customer Action - Accepted (Sent to Staff) [slovak]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(835, 'proposals', 'proposal-send-to-customer', 'slovak', 'Send Proposal to Customer [slovak]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(836, 'proposals', 'proposal-client-declined', 'slovak', 'Customer Action - Declined (Sent to Staff) [slovak]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(837, 'proposals', 'proposal-client-thank-you', 'slovak', 'Thank You Email (Sent to Customer After Accept) [slovak]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(838, 'proposals', 'proposal-comment-to-client', 'slovak', 'New Comment Â (Sent to Customer/Lead) [slovak]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(839, 'proposals', 'proposal-comment-to-admin', 'slovak', 'New Comment (Sent to Staff)  [slovak]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(840, 'estimate', 'estimate-thank-you-to-customer', 'slovak', 'Thank You Email (Sent to Customer After Accept) [slovak]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(841, 'tasks', 'task-deadline-notification', 'slovak', 'Task Deadline Reminder - Sent to Assigned Members [slovak]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(842, 'contract', 'send-contract', 'slovak', 'Send Contract to Customer [slovak]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(843, 'invoice', 'invoice-payment-recorded-to-staff', 'slovak', 'Invoice Payment Recorded (Sent to Staff) [slovak]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(844, 'ticket', 'auto-close-ticket', 'slovak', 'Auto Close Ticket [slovak]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(845, 'project', 'new-project-discussion-created-to-staff', 'slovak', 'New Project Discussion (Sent to Project Members) [slovak]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(846, 'project', 'new-project-discussion-created-to-customer', 'slovak', 'New Project Discussion (Sent to Customer Contacts) [slovak]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(847, 'project', 'new-project-file-uploaded-to-customer', 'slovak', 'New Project File(s) Uploaded (Sent to Customer Contacts) [slovak]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(848, 'project', 'new-project-file-uploaded-to-staff', 'slovak', 'New Project File(s) Uploaded (Sent to Project Members) [slovak]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(849, 'project', 'new-project-discussion-comment-to-customer', 'slovak', 'New Discussion Comment  (Sent to Customer Contacts) [slovak]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(850, 'project', 'new-project-discussion-comment-to-staff', 'slovak', 'New Discussion Comment (Sent to Project Members) [slovak]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(851, 'project', 'staff-added-as-project-member', 'slovak', 'Staff Added as Project Member [slovak]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(852, 'estimate', 'estimate-expiry-reminder', 'slovak', 'Estimate Expiration Reminder [slovak]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(853, 'proposals', 'proposal-expiry-reminder', 'slovak', 'Proposal Expiration Reminder [slovak]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(854, 'staff', 'new-staff-created', 'slovak', 'New Staff Created (Welcome Email) [slovak]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(855, 'client', 'contact-forgot-password', 'slovak', 'Forgot Password [slovak]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(856, 'client', 'contact-password-reseted', 'slovak', 'Password Reset - Confirmation [slovak]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(857, 'client', 'contact-set-password', 'slovak', 'Set New Password [slovak]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(858, 'staff', 'staff-forgot-password', 'slovak', 'Forgot Password [slovak]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(859, 'staff', 'staff-password-reseted', 'slovak', 'Password Reset - Confirmation [slovak]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(860, 'project', 'assigned-to-project', 'slovak', 'New Project Created (Sent to Customer Contacts) [slovak]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(861, 'tasks', 'task-added-attachment-to-contacts', 'slovak', 'New Attachment(s) on Task (Sent to Customer Contacts) [slovak]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(862, 'tasks', 'task-commented-to-contacts', 'slovak', 'New Comment on Task (Sent to Customer Contacts) [slovak]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(863, 'leads', 'new-lead-assigned', 'slovak', 'New Lead Assigned to Staff Member [slovak]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(864, 'client', 'client-statement', 'slovak', 'Statement - Account Summary [slovak]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(865, 'ticket', 'ticket-assigned-to-admin', 'slovak', 'New Ticket Assigned (Sent to Staff) [slovak]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(866, 'client', 'new-client-registered-to-admin', 'slovak', 'New Customer Registration (Sent to admins) [slovak]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(867, 'leads', 'new-web-to-lead-form-submitted', 'slovak', 'Web to lead form submitted - Sent to lead [slovak]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(868, 'staff', 'two-factor-authentication', 'slovak', 'Two Factor Authentication [slovak]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(869, 'project', 'project-finished-to-customer', 'slovak', 'Project Marked as Finished (Sent to Customer Contacts) [slovak]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(870, 'credit_note', 'credit-note-send-to-client', 'slovak', 'Send Credit Note To Email [slovak]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(871, 'tasks', 'task-status-change-to-staff', 'slovak', 'Task Status Changed (Sent to Staff) [slovak]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(872, 'tasks', 'task-status-change-to-contacts', 'slovak', 'Task Status Changed (Sent to Customer Contacts) [slovak]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(873, 'staff', 'reminder-email-staff', 'slovak', 'Staff Reminder Email [slovak]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(874, 'contract', 'contract-comment-to-client', 'slovak', 'New Comment Â (Sent to Customer Contacts) [slovak]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(875, 'contract', 'contract-comment-to-admin', 'slovak', 'New Comment (Sent to Staff)  [slovak]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(876, 'subscriptions', 'send-subscription', 'slovak', 'Send Subscription to Customer [slovak]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(877, 'subscriptions', 'subscription-payment-failed', 'slovak', 'Subscription Payment Failed [slovak]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(878, 'subscriptions', 'subscription-canceled', 'slovak', 'Subscription Canceled (Sent to customer primary contact) [slovak]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(879, 'subscriptions', 'subscription-payment-succeeded', 'slovak', 'Subscription Payment Succeeded (Sent to customer primary contact) [slovak]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(880, 'contract', 'contract-expiration-to-staff', 'slovak', 'Contract Expiration Reminder (Sent to Staff) [slovak]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(881, 'gdpr', 'gdpr-removal-request', 'slovak', 'Removal Request From Contact (Sent to administrators) [slovak]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(882, 'gdpr', 'gdpr-removal-request-lead', 'slovak', 'Removal Request From Lead (Sent to administrators) [slovak]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(883, 'client', 'client-registration-confirmed', 'slovak', 'Customer Registration Confirmed [slovak]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(884, 'contract', 'contract-signed-to-staff', 'slovak', 'Contract Signed (Sent to Staff) [slovak]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(885, 'subscriptions', 'customer-subscribed-to-staff', 'slovak', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [slovak]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(886, 'client', 'contact-verification-email', 'slovak', 'Email Verification (Sent to Contact After Registration) [slovak]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(887, 'client', 'new-customer-profile-file-uploaded-to-staff', 'slovak', 'New Customer Profile File(s) Uploaded (Sent to Staff) [slovak]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0);
INSERT INTO `ms_emailtemplates` (`emailtemplateid`, `type`, `slug`, `language`, `name`, `subject`, `message`, `fromname`, `fromemail`, `plaintext`, `active`, `order`) VALUES
(888, 'staff', 'event-notification-to-staff', 'slovak', 'Event Notification (Calendar) [slovak]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(889, 'client', 'new-client-created', 'russian', 'New Contact Added/Registered (Welcome Email) [russian]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(890, 'invoice', 'invoice-send-to-client', 'russian', 'Send Invoice to Customer [russian]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(891, 'ticket', 'new-ticket-opened-admin', 'russian', 'New Ticket Opened (Opened by Staff, Sent to Customer) [russian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(892, 'ticket', 'ticket-reply', 'russian', 'Ticket Reply (Sent to Customer) [russian]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(893, 'ticket', 'ticket-autoresponse', 'russian', 'New Ticket Opened - Autoresponse [russian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(894, 'invoice', 'invoice-payment-recorded', 'russian', 'Invoice Payment Recorded (Sent to Customer) [russian]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(895, 'invoice', 'invoice-overdue-notice', 'russian', 'Invoice Overdue Notice [russian]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(896, 'invoice', 'invoice-already-send', 'russian', 'Invoice Already Sent to Customer [russian]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(897, 'ticket', 'new-ticket-created-staff', 'russian', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [russian]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(898, 'estimate', 'estimate-send-to-client', 'russian', 'Send Estimate to Customer [russian]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(899, 'ticket', 'ticket-reply-to-admin', 'russian', 'Ticket Reply (Sent to Staff) [russian]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(900, 'estimate', 'estimate-already-send', 'russian', 'Estimate Already Sent to Customer [russian]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(901, 'contract', 'contract-expiration', 'russian', 'Contract Expiration Reminder (Sent to Customer Contacts) [russian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(902, 'tasks', 'task-assigned', 'russian', 'New Task Assigned (Sent to Staff) [russian]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(903, 'tasks', 'task-added-as-follower', 'russian', 'Staff Member Added as Follower on Task (Sent to Staff) [russian]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(904, 'tasks', 'task-commented', 'russian', 'New Comment on Task (Sent to Staff) [russian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(905, 'tasks', 'task-added-attachment', 'russian', 'New Attachment(s) on Task (Sent to Staff) [russian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(906, 'estimate', 'estimate-declined-to-staff', 'russian', 'Estimate Declined (Sent to Staff) [russian]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(907, 'estimate', 'estimate-accepted-to-staff', 'russian', 'Estimate Accepted (Sent to Staff) [russian]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(908, 'proposals', 'proposal-client-accepted', 'russian', 'Customer Action - Accepted (Sent to Staff) [russian]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(909, 'proposals', 'proposal-send-to-customer', 'russian', 'Send Proposal to Customer [russian]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(910, 'proposals', 'proposal-client-declined', 'russian', 'Customer Action - Declined (Sent to Staff) [russian]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(911, 'proposals', 'proposal-client-thank-you', 'russian', 'Thank You Email (Sent to Customer After Accept) [russian]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(912, 'proposals', 'proposal-comment-to-client', 'russian', 'New Comment Â (Sent to Customer/Lead) [russian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(913, 'proposals', 'proposal-comment-to-admin', 'russian', 'New Comment (Sent to Staff)  [russian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(914, 'estimate', 'estimate-thank-you-to-customer', 'russian', 'Thank You Email (Sent to Customer After Accept) [russian]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(915, 'tasks', 'task-deadline-notification', 'russian', 'Task Deadline Reminder - Sent to Assigned Members [russian]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(916, 'contract', 'send-contract', 'russian', 'Send Contract to Customer [russian]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(917, 'invoice', 'invoice-payment-recorded-to-staff', 'russian', 'Invoice Payment Recorded (Sent to Staff) [russian]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(918, 'ticket', 'auto-close-ticket', 'russian', 'Auto Close Ticket [russian]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(919, 'project', 'new-project-discussion-created-to-staff', 'russian', 'New Project Discussion (Sent to Project Members) [russian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(920, 'project', 'new-project-discussion-created-to-customer', 'russian', 'New Project Discussion (Sent to Customer Contacts) [russian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(921, 'project', 'new-project-file-uploaded-to-customer', 'russian', 'New Project File(s) Uploaded (Sent to Customer Contacts) [russian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(922, 'project', 'new-project-file-uploaded-to-staff', 'russian', 'New Project File(s) Uploaded (Sent to Project Members) [russian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(923, 'project', 'new-project-discussion-comment-to-customer', 'russian', 'New Discussion Comment  (Sent to Customer Contacts) [russian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(924, 'project', 'new-project-discussion-comment-to-staff', 'russian', 'New Discussion Comment (Sent to Project Members) [russian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(925, 'project', 'staff-added-as-project-member', 'russian', 'Staff Added as Project Member [russian]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(926, 'estimate', 'estimate-expiry-reminder', 'russian', 'Estimate Expiration Reminder [russian]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(927, 'proposals', 'proposal-expiry-reminder', 'russian', 'Proposal Expiration Reminder [russian]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(928, 'staff', 'new-staff-created', 'russian', 'New Staff Created (Welcome Email) [russian]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(929, 'client', 'contact-forgot-password', 'russian', 'Forgot Password [russian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(930, 'client', 'contact-password-reseted', 'russian', 'Password Reset - Confirmation [russian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(931, 'client', 'contact-set-password', 'russian', 'Set New Password [russian]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(932, 'staff', 'staff-forgot-password', 'russian', 'Forgot Password [russian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(933, 'staff', 'staff-password-reseted', 'russian', 'Password Reset - Confirmation [russian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(934, 'project', 'assigned-to-project', 'russian', 'New Project Created (Sent to Customer Contacts) [russian]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(935, 'tasks', 'task-added-attachment-to-contacts', 'russian', 'New Attachment(s) on Task (Sent to Customer Contacts) [russian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(936, 'tasks', 'task-commented-to-contacts', 'russian', 'New Comment on Task (Sent to Customer Contacts) [russian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(937, 'leads', 'new-lead-assigned', 'russian', 'New Lead Assigned to Staff Member [russian]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(938, 'client', 'client-statement', 'russian', 'Statement - Account Summary [russian]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(939, 'ticket', 'ticket-assigned-to-admin', 'russian', 'New Ticket Assigned (Sent to Staff) [russian]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(940, 'client', 'new-client-registered-to-admin', 'russian', 'New Customer Registration (Sent to admins) [russian]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(941, 'leads', 'new-web-to-lead-form-submitted', 'russian', 'Web to lead form submitted - Sent to lead [russian]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(942, 'staff', 'two-factor-authentication', 'russian', 'Two Factor Authentication [russian]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(943, 'project', 'project-finished-to-customer', 'russian', 'Project Marked as Finished (Sent to Customer Contacts) [russian]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(944, 'credit_note', 'credit-note-send-to-client', 'russian', 'Send Credit Note To Email [russian]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(945, 'tasks', 'task-status-change-to-staff', 'russian', 'Task Status Changed (Sent to Staff) [russian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(946, 'tasks', 'task-status-change-to-contacts', 'russian', 'Task Status Changed (Sent to Customer Contacts) [russian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(947, 'staff', 'reminder-email-staff', 'russian', 'Staff Reminder Email [russian]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(948, 'contract', 'contract-comment-to-client', 'russian', 'New Comment Â (Sent to Customer Contacts) [russian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(949, 'contract', 'contract-comment-to-admin', 'russian', 'New Comment (Sent to Staff)  [russian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(950, 'subscriptions', 'send-subscription', 'russian', 'Send Subscription to Customer [russian]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(951, 'subscriptions', 'subscription-payment-failed', 'russian', 'Subscription Payment Failed [russian]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(952, 'subscriptions', 'subscription-canceled', 'russian', 'Subscription Canceled (Sent to customer primary contact) [russian]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(953, 'subscriptions', 'subscription-payment-succeeded', 'russian', 'Subscription Payment Succeeded (Sent to customer primary contact) [russian]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(954, 'contract', 'contract-expiration-to-staff', 'russian', 'Contract Expiration Reminder (Sent to Staff) [russian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(955, 'gdpr', 'gdpr-removal-request', 'russian', 'Removal Request From Contact (Sent to administrators) [russian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(956, 'gdpr', 'gdpr-removal-request-lead', 'russian', 'Removal Request From Lead (Sent to administrators) [russian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(957, 'client', 'client-registration-confirmed', 'russian', 'Customer Registration Confirmed [russian]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(958, 'contract', 'contract-signed-to-staff', 'russian', 'Contract Signed (Sent to Staff) [russian]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(959, 'subscriptions', 'customer-subscribed-to-staff', 'russian', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [russian]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(960, 'client', 'contact-verification-email', 'russian', 'Email Verification (Sent to Contact After Registration) [russian]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(961, 'client', 'new-customer-profile-file-uploaded-to-staff', 'russian', 'New Customer Profile File(s) Uploaded (Sent to Staff) [russian]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(962, 'staff', 'event-notification-to-staff', 'russian', 'Event Notification (Calendar) [russian]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(963, 'client', 'new-client-created', 'chinese', 'New Contact Added/Registered (Welcome Email) [chinese]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(964, 'invoice', 'invoice-send-to-client', 'chinese', 'Send Invoice to Customer [chinese]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(965, 'ticket', 'new-ticket-opened-admin', 'chinese', 'New Ticket Opened (Opened by Staff, Sent to Customer) [chinese]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(966, 'ticket', 'ticket-reply', 'chinese', 'Ticket Reply (Sent to Customer) [chinese]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(967, 'ticket', 'ticket-autoresponse', 'chinese', 'New Ticket Opened - Autoresponse [chinese]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(968, 'invoice', 'invoice-payment-recorded', 'chinese', 'Invoice Payment Recorded (Sent to Customer) [chinese]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(969, 'invoice', 'invoice-overdue-notice', 'chinese', 'Invoice Overdue Notice [chinese]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(970, 'invoice', 'invoice-already-send', 'chinese', 'Invoice Already Sent to Customer [chinese]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(971, 'ticket', 'new-ticket-created-staff', 'chinese', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [chinese]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(972, 'estimate', 'estimate-send-to-client', 'chinese', 'Send Estimate to Customer [chinese]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(973, 'ticket', 'ticket-reply-to-admin', 'chinese', 'Ticket Reply (Sent to Staff) [chinese]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(974, 'estimate', 'estimate-already-send', 'chinese', 'Estimate Already Sent to Customer [chinese]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(975, 'contract', 'contract-expiration', 'chinese', 'Contract Expiration Reminder (Sent to Customer Contacts) [chinese]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(976, 'tasks', 'task-assigned', 'chinese', 'New Task Assigned (Sent to Staff) [chinese]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(977, 'tasks', 'task-added-as-follower', 'chinese', 'Staff Member Added as Follower on Task (Sent to Staff) [chinese]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(978, 'tasks', 'task-commented', 'chinese', 'New Comment on Task (Sent to Staff) [chinese]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(979, 'tasks', 'task-added-attachment', 'chinese', 'New Attachment(s) on Task (Sent to Staff) [chinese]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(980, 'estimate', 'estimate-declined-to-staff', 'chinese', 'Estimate Declined (Sent to Staff) [chinese]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(981, 'estimate', 'estimate-accepted-to-staff', 'chinese', 'Estimate Accepted (Sent to Staff) [chinese]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(982, 'proposals', 'proposal-client-accepted', 'chinese', 'Customer Action - Accepted (Sent to Staff) [chinese]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(983, 'proposals', 'proposal-send-to-customer', 'chinese', 'Send Proposal to Customer [chinese]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(984, 'proposals', 'proposal-client-declined', 'chinese', 'Customer Action - Declined (Sent to Staff) [chinese]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(985, 'proposals', 'proposal-client-thank-you', 'chinese', 'Thank You Email (Sent to Customer After Accept) [chinese]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(986, 'proposals', 'proposal-comment-to-client', 'chinese', 'New Comment Â (Sent to Customer/Lead) [chinese]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(987, 'proposals', 'proposal-comment-to-admin', 'chinese', 'New Comment (Sent to Staff)  [chinese]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(988, 'estimate', 'estimate-thank-you-to-customer', 'chinese', 'Thank You Email (Sent to Customer After Accept) [chinese]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(989, 'tasks', 'task-deadline-notification', 'chinese', 'Task Deadline Reminder - Sent to Assigned Members [chinese]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(990, 'contract', 'send-contract', 'chinese', 'Send Contract to Customer [chinese]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(991, 'invoice', 'invoice-payment-recorded-to-staff', 'chinese', 'Invoice Payment Recorded (Sent to Staff) [chinese]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(992, 'ticket', 'auto-close-ticket', 'chinese', 'Auto Close Ticket [chinese]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(993, 'project', 'new-project-discussion-created-to-staff', 'chinese', 'New Project Discussion (Sent to Project Members) [chinese]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(994, 'project', 'new-project-discussion-created-to-customer', 'chinese', 'New Project Discussion (Sent to Customer Contacts) [chinese]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(995, 'project', 'new-project-file-uploaded-to-customer', 'chinese', 'New Project File(s) Uploaded (Sent to Customer Contacts) [chinese]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(996, 'project', 'new-project-file-uploaded-to-staff', 'chinese', 'New Project File(s) Uploaded (Sent to Project Members) [chinese]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(997, 'project', 'new-project-discussion-comment-to-customer', 'chinese', 'New Discussion Comment  (Sent to Customer Contacts) [chinese]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(998, 'project', 'new-project-discussion-comment-to-staff', 'chinese', 'New Discussion Comment (Sent to Project Members) [chinese]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(999, 'project', 'staff-added-as-project-member', 'chinese', 'Staff Added as Project Member [chinese]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1000, 'estimate', 'estimate-expiry-reminder', 'chinese', 'Estimate Expiration Reminder [chinese]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1001, 'proposals', 'proposal-expiry-reminder', 'chinese', 'Proposal Expiration Reminder [chinese]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1002, 'staff', 'new-staff-created', 'chinese', 'New Staff Created (Welcome Email) [chinese]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1003, 'client', 'contact-forgot-password', 'chinese', 'Forgot Password [chinese]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1004, 'client', 'contact-password-reseted', 'chinese', 'Password Reset - Confirmation [chinese]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1005, 'client', 'contact-set-password', 'chinese', 'Set New Password [chinese]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1006, 'staff', 'staff-forgot-password', 'chinese', 'Forgot Password [chinese]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1007, 'staff', 'staff-password-reseted', 'chinese', 'Password Reset - Confirmation [chinese]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1008, 'project', 'assigned-to-project', 'chinese', 'New Project Created (Sent to Customer Contacts) [chinese]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1009, 'tasks', 'task-added-attachment-to-contacts', 'chinese', 'New Attachment(s) on Task (Sent to Customer Contacts) [chinese]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1010, 'tasks', 'task-commented-to-contacts', 'chinese', 'New Comment on Task (Sent to Customer Contacts) [chinese]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1011, 'leads', 'new-lead-assigned', 'chinese', 'New Lead Assigned to Staff Member [chinese]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1012, 'client', 'client-statement', 'chinese', 'Statement - Account Summary [chinese]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1013, 'ticket', 'ticket-assigned-to-admin', 'chinese', 'New Ticket Assigned (Sent to Staff) [chinese]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1014, 'client', 'new-client-registered-to-admin', 'chinese', 'New Customer Registration (Sent to admins) [chinese]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1015, 'leads', 'new-web-to-lead-form-submitted', 'chinese', 'Web to lead form submitted - Sent to lead [chinese]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1016, 'staff', 'two-factor-authentication', 'chinese', 'Two Factor Authentication [chinese]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1017, 'project', 'project-finished-to-customer', 'chinese', 'Project Marked as Finished (Sent to Customer Contacts) [chinese]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1018, 'credit_note', 'credit-note-send-to-client', 'chinese', 'Send Credit Note To Email [chinese]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1019, 'tasks', 'task-status-change-to-staff', 'chinese', 'Task Status Changed (Sent to Staff) [chinese]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1020, 'tasks', 'task-status-change-to-contacts', 'chinese', 'Task Status Changed (Sent to Customer Contacts) [chinese]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1021, 'staff', 'reminder-email-staff', 'chinese', 'Staff Reminder Email [chinese]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1022, 'contract', 'contract-comment-to-client', 'chinese', 'New Comment Â (Sent to Customer Contacts) [chinese]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1023, 'contract', 'contract-comment-to-admin', 'chinese', 'New Comment (Sent to Staff)  [chinese]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1024, 'subscriptions', 'send-subscription', 'chinese', 'Send Subscription to Customer [chinese]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1025, 'subscriptions', 'subscription-payment-failed', 'chinese', 'Subscription Payment Failed [chinese]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1026, 'subscriptions', 'subscription-canceled', 'chinese', 'Subscription Canceled (Sent to customer primary contact) [chinese]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1027, 'subscriptions', 'subscription-payment-succeeded', 'chinese', 'Subscription Payment Succeeded (Sent to customer primary contact) [chinese]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1028, 'contract', 'contract-expiration-to-staff', 'chinese', 'Contract Expiration Reminder (Sent to Staff) [chinese]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1029, 'gdpr', 'gdpr-removal-request', 'chinese', 'Removal Request From Contact (Sent to administrators) [chinese]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1030, 'gdpr', 'gdpr-removal-request-lead', 'chinese', 'Removal Request From Lead (Sent to administrators) [chinese]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1031, 'client', 'client-registration-confirmed', 'chinese', 'Customer Registration Confirmed [chinese]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1032, 'contract', 'contract-signed-to-staff', 'chinese', 'Contract Signed (Sent to Staff) [chinese]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1033, 'subscriptions', 'customer-subscribed-to-staff', 'chinese', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [chinese]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1034, 'client', 'contact-verification-email', 'chinese', 'Email Verification (Sent to Contact After Registration) [chinese]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1035, 'client', 'new-customer-profile-file-uploaded-to-staff', 'chinese', 'New Customer Profile File(s) Uploaded (Sent to Staff) [chinese]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1036, 'staff', 'event-notification-to-staff', 'chinese', 'Event Notification (Calendar) [chinese]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(1037, 'client', 'new-client-created', 'dutch', 'New Contact Added/Registered (Welcome Email) [dutch]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1038, 'invoice', 'invoice-send-to-client', 'dutch', 'Send Invoice to Customer [dutch]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1039, 'ticket', 'new-ticket-opened-admin', 'dutch', 'New Ticket Opened (Opened by Staff, Sent to Customer) [dutch]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1040, 'ticket', 'ticket-reply', 'dutch', 'Ticket Reply (Sent to Customer) [dutch]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1041, 'ticket', 'ticket-autoresponse', 'dutch', 'New Ticket Opened - Autoresponse [dutch]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1042, 'invoice', 'invoice-payment-recorded', 'dutch', 'Invoice Payment Recorded (Sent to Customer) [dutch]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1043, 'invoice', 'invoice-overdue-notice', 'dutch', 'Invoice Overdue Notice [dutch]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1044, 'invoice', 'invoice-already-send', 'dutch', 'Invoice Already Sent to Customer [dutch]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1045, 'ticket', 'new-ticket-created-staff', 'dutch', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [dutch]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1046, 'estimate', 'estimate-send-to-client', 'dutch', 'Send Estimate to Customer [dutch]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1047, 'ticket', 'ticket-reply-to-admin', 'dutch', 'Ticket Reply (Sent to Staff) [dutch]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1048, 'estimate', 'estimate-already-send', 'dutch', 'Estimate Already Sent to Customer [dutch]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1049, 'contract', 'contract-expiration', 'dutch', 'Contract Expiration Reminder (Sent to Customer Contacts) [dutch]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1050, 'tasks', 'task-assigned', 'dutch', 'New Task Assigned (Sent to Staff) [dutch]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1051, 'tasks', 'task-added-as-follower', 'dutch', 'Staff Member Added as Follower on Task (Sent to Staff) [dutch]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1052, 'tasks', 'task-commented', 'dutch', 'New Comment on Task (Sent to Staff) [dutch]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1053, 'tasks', 'task-added-attachment', 'dutch', 'New Attachment(s) on Task (Sent to Staff) [dutch]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1054, 'estimate', 'estimate-declined-to-staff', 'dutch', 'Estimate Declined (Sent to Staff) [dutch]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1055, 'estimate', 'estimate-accepted-to-staff', 'dutch', 'Estimate Accepted (Sent to Staff) [dutch]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1056, 'proposals', 'proposal-client-accepted', 'dutch', 'Customer Action - Accepted (Sent to Staff) [dutch]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1057, 'proposals', 'proposal-send-to-customer', 'dutch', 'Send Proposal to Customer [dutch]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1058, 'proposals', 'proposal-client-declined', 'dutch', 'Customer Action - Declined (Sent to Staff) [dutch]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1059, 'proposals', 'proposal-client-thank-you', 'dutch', 'Thank You Email (Sent to Customer After Accept) [dutch]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1060, 'proposals', 'proposal-comment-to-client', 'dutch', 'New Comment Â (Sent to Customer/Lead) [dutch]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1061, 'proposals', 'proposal-comment-to-admin', 'dutch', 'New Comment (Sent to Staff)  [dutch]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1062, 'estimate', 'estimate-thank-you-to-customer', 'dutch', 'Thank You Email (Sent to Customer After Accept) [dutch]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1063, 'tasks', 'task-deadline-notification', 'dutch', 'Task Deadline Reminder - Sent to Assigned Members [dutch]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1064, 'contract', 'send-contract', 'dutch', 'Send Contract to Customer [dutch]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1065, 'invoice', 'invoice-payment-recorded-to-staff', 'dutch', 'Invoice Payment Recorded (Sent to Staff) [dutch]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1066, 'ticket', 'auto-close-ticket', 'dutch', 'Auto Close Ticket [dutch]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1067, 'project', 'new-project-discussion-created-to-staff', 'dutch', 'New Project Discussion (Sent to Project Members) [dutch]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1068, 'project', 'new-project-discussion-created-to-customer', 'dutch', 'New Project Discussion (Sent to Customer Contacts) [dutch]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1069, 'project', 'new-project-file-uploaded-to-customer', 'dutch', 'New Project File(s) Uploaded (Sent to Customer Contacts) [dutch]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1070, 'project', 'new-project-file-uploaded-to-staff', 'dutch', 'New Project File(s) Uploaded (Sent to Project Members) [dutch]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1071, 'project', 'new-project-discussion-comment-to-customer', 'dutch', 'New Discussion Comment  (Sent to Customer Contacts) [dutch]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1072, 'project', 'new-project-discussion-comment-to-staff', 'dutch', 'New Discussion Comment (Sent to Project Members) [dutch]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1073, 'project', 'staff-added-as-project-member', 'dutch', 'Staff Added as Project Member [dutch]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1074, 'estimate', 'estimate-expiry-reminder', 'dutch', 'Estimate Expiration Reminder [dutch]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1075, 'proposals', 'proposal-expiry-reminder', 'dutch', 'Proposal Expiration Reminder [dutch]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1076, 'staff', 'new-staff-created', 'dutch', 'New Staff Created (Welcome Email) [dutch]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1077, 'client', 'contact-forgot-password', 'dutch', 'Forgot Password [dutch]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1078, 'client', 'contact-password-reseted', 'dutch', 'Password Reset - Confirmation [dutch]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1079, 'client', 'contact-set-password', 'dutch', 'Set New Password [dutch]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1080, 'staff', 'staff-forgot-password', 'dutch', 'Forgot Password [dutch]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1081, 'staff', 'staff-password-reseted', 'dutch', 'Password Reset - Confirmation [dutch]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1082, 'project', 'assigned-to-project', 'dutch', 'New Project Created (Sent to Customer Contacts) [dutch]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1083, 'tasks', 'task-added-attachment-to-contacts', 'dutch', 'New Attachment(s) on Task (Sent to Customer Contacts) [dutch]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1084, 'tasks', 'task-commented-to-contacts', 'dutch', 'New Comment on Task (Sent to Customer Contacts) [dutch]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1085, 'leads', 'new-lead-assigned', 'dutch', 'New Lead Assigned to Staff Member [dutch]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1086, 'client', 'client-statement', 'dutch', 'Statement - Account Summary [dutch]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1087, 'ticket', 'ticket-assigned-to-admin', 'dutch', 'New Ticket Assigned (Sent to Staff) [dutch]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1088, 'client', 'new-client-registered-to-admin', 'dutch', 'New Customer Registration (Sent to admins) [dutch]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1089, 'leads', 'new-web-to-lead-form-submitted', 'dutch', 'Web to lead form submitted - Sent to lead [dutch]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1090, 'staff', 'two-factor-authentication', 'dutch', 'Two Factor Authentication [dutch]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1091, 'project', 'project-finished-to-customer', 'dutch', 'Project Marked as Finished (Sent to Customer Contacts) [dutch]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1092, 'credit_note', 'credit-note-send-to-client', 'dutch', 'Send Credit Note To Email [dutch]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1093, 'tasks', 'task-status-change-to-staff', 'dutch', 'Task Status Changed (Sent to Staff) [dutch]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1094, 'tasks', 'task-status-change-to-contacts', 'dutch', 'Task Status Changed (Sent to Customer Contacts) [dutch]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1095, 'staff', 'reminder-email-staff', 'dutch', 'Staff Reminder Email [dutch]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1096, 'contract', 'contract-comment-to-client', 'dutch', 'New Comment Â (Sent to Customer Contacts) [dutch]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1097, 'contract', 'contract-comment-to-admin', 'dutch', 'New Comment (Sent to Staff)  [dutch]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1098, 'subscriptions', 'send-subscription', 'dutch', 'Send Subscription to Customer [dutch]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1099, 'subscriptions', 'subscription-payment-failed', 'dutch', 'Subscription Payment Failed [dutch]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1100, 'subscriptions', 'subscription-canceled', 'dutch', 'Subscription Canceled (Sent to customer primary contact) [dutch]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1101, 'subscriptions', 'subscription-payment-succeeded', 'dutch', 'Subscription Payment Succeeded (Sent to customer primary contact) [dutch]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1102, 'contract', 'contract-expiration-to-staff', 'dutch', 'Contract Expiration Reminder (Sent to Staff) [dutch]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1103, 'gdpr', 'gdpr-removal-request', 'dutch', 'Removal Request From Contact (Sent to administrators) [dutch]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1104, 'gdpr', 'gdpr-removal-request-lead', 'dutch', 'Removal Request From Lead (Sent to administrators) [dutch]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1105, 'client', 'client-registration-confirmed', 'dutch', 'Customer Registration Confirmed [dutch]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1106, 'contract', 'contract-signed-to-staff', 'dutch', 'Contract Signed (Sent to Staff) [dutch]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1107, 'subscriptions', 'customer-subscribed-to-staff', 'dutch', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [dutch]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1108, 'client', 'contact-verification-email', 'dutch', 'Email Verification (Sent to Contact After Registration) [dutch]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1109, 'client', 'new-customer-profile-file-uploaded-to-staff', 'dutch', 'New Customer Profile File(s) Uploaded (Sent to Staff) [dutch]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1110, 'staff', 'event-notification-to-staff', 'dutch', 'Event Notification (Calendar) [dutch]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(1111, 'client', 'new-client-created', 'catalan', 'New Contact Added/Registered (Welcome Email) [catalan]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1112, 'invoice', 'invoice-send-to-client', 'catalan', 'Send Invoice to Customer [catalan]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1113, 'ticket', 'new-ticket-opened-admin', 'catalan', 'New Ticket Opened (Opened by Staff, Sent to Customer) [catalan]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1114, 'ticket', 'ticket-reply', 'catalan', 'Ticket Reply (Sent to Customer) [catalan]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1115, 'ticket', 'ticket-autoresponse', 'catalan', 'New Ticket Opened - Autoresponse [catalan]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1116, 'invoice', 'invoice-payment-recorded', 'catalan', 'Invoice Payment Recorded (Sent to Customer) [catalan]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1117, 'invoice', 'invoice-overdue-notice', 'catalan', 'Invoice Overdue Notice [catalan]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1118, 'invoice', 'invoice-already-send', 'catalan', 'Invoice Already Sent to Customer [catalan]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1119, 'ticket', 'new-ticket-created-staff', 'catalan', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [catalan]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1120, 'estimate', 'estimate-send-to-client', 'catalan', 'Send Estimate to Customer [catalan]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1121, 'ticket', 'ticket-reply-to-admin', 'catalan', 'Ticket Reply (Sent to Staff) [catalan]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1122, 'estimate', 'estimate-already-send', 'catalan', 'Estimate Already Sent to Customer [catalan]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1123, 'contract', 'contract-expiration', 'catalan', 'Contract Expiration Reminder (Sent to Customer Contacts) [catalan]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1124, 'tasks', 'task-assigned', 'catalan', 'New Task Assigned (Sent to Staff) [catalan]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1125, 'tasks', 'task-added-as-follower', 'catalan', 'Staff Member Added as Follower on Task (Sent to Staff) [catalan]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1126, 'tasks', 'task-commented', 'catalan', 'New Comment on Task (Sent to Staff) [catalan]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1127, 'tasks', 'task-added-attachment', 'catalan', 'New Attachment(s) on Task (Sent to Staff) [catalan]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1128, 'estimate', 'estimate-declined-to-staff', 'catalan', 'Estimate Declined (Sent to Staff) [catalan]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1129, 'estimate', 'estimate-accepted-to-staff', 'catalan', 'Estimate Accepted (Sent to Staff) [catalan]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1130, 'proposals', 'proposal-client-accepted', 'catalan', 'Customer Action - Accepted (Sent to Staff) [catalan]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1131, 'proposals', 'proposal-send-to-customer', 'catalan', 'Send Proposal to Customer [catalan]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1132, 'proposals', 'proposal-client-declined', 'catalan', 'Customer Action - Declined (Sent to Staff) [catalan]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1133, 'proposals', 'proposal-client-thank-you', 'catalan', 'Thank You Email (Sent to Customer After Accept) [catalan]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1134, 'proposals', 'proposal-comment-to-client', 'catalan', 'New Comment Â (Sent to Customer/Lead) [catalan]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1135, 'proposals', 'proposal-comment-to-admin', 'catalan', 'New Comment (Sent to Staff)  [catalan]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1136, 'estimate', 'estimate-thank-you-to-customer', 'catalan', 'Thank You Email (Sent to Customer After Accept) [catalan]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1137, 'tasks', 'task-deadline-notification', 'catalan', 'Task Deadline Reminder - Sent to Assigned Members [catalan]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1138, 'contract', 'send-contract', 'catalan', 'Send Contract to Customer [catalan]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1139, 'invoice', 'invoice-payment-recorded-to-staff', 'catalan', 'Invoice Payment Recorded (Sent to Staff) [catalan]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1140, 'ticket', 'auto-close-ticket', 'catalan', 'Auto Close Ticket [catalan]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1141, 'project', 'new-project-discussion-created-to-staff', 'catalan', 'New Project Discussion (Sent to Project Members) [catalan]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1142, 'project', 'new-project-discussion-created-to-customer', 'catalan', 'New Project Discussion (Sent to Customer Contacts) [catalan]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1143, 'project', 'new-project-file-uploaded-to-customer', 'catalan', 'New Project File(s) Uploaded (Sent to Customer Contacts) [catalan]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1144, 'project', 'new-project-file-uploaded-to-staff', 'catalan', 'New Project File(s) Uploaded (Sent to Project Members) [catalan]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1145, 'project', 'new-project-discussion-comment-to-customer', 'catalan', 'New Discussion Comment  (Sent to Customer Contacts) [catalan]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1146, 'project', 'new-project-discussion-comment-to-staff', 'catalan', 'New Discussion Comment (Sent to Project Members) [catalan]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1147, 'project', 'staff-added-as-project-member', 'catalan', 'Staff Added as Project Member [catalan]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1148, 'estimate', 'estimate-expiry-reminder', 'catalan', 'Estimate Expiration Reminder [catalan]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1149, 'proposals', 'proposal-expiry-reminder', 'catalan', 'Proposal Expiration Reminder [catalan]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1150, 'staff', 'new-staff-created', 'catalan', 'New Staff Created (Welcome Email) [catalan]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1151, 'client', 'contact-forgot-password', 'catalan', 'Forgot Password [catalan]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1152, 'client', 'contact-password-reseted', 'catalan', 'Password Reset - Confirmation [catalan]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1153, 'client', 'contact-set-password', 'catalan', 'Set New Password [catalan]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1154, 'staff', 'staff-forgot-password', 'catalan', 'Forgot Password [catalan]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1155, 'staff', 'staff-password-reseted', 'catalan', 'Password Reset - Confirmation [catalan]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1156, 'project', 'assigned-to-project', 'catalan', 'New Project Created (Sent to Customer Contacts) [catalan]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1157, 'tasks', 'task-added-attachment-to-contacts', 'catalan', 'New Attachment(s) on Task (Sent to Customer Contacts) [catalan]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1158, 'tasks', 'task-commented-to-contacts', 'catalan', 'New Comment on Task (Sent to Customer Contacts) [catalan]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1159, 'leads', 'new-lead-assigned', 'catalan', 'New Lead Assigned to Staff Member [catalan]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0);
INSERT INTO `ms_emailtemplates` (`emailtemplateid`, `type`, `slug`, `language`, `name`, `subject`, `message`, `fromname`, `fromemail`, `plaintext`, `active`, `order`) VALUES
(1160, 'client', 'client-statement', 'catalan', 'Statement - Account Summary [catalan]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1161, 'ticket', 'ticket-assigned-to-admin', 'catalan', 'New Ticket Assigned (Sent to Staff) [catalan]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1162, 'client', 'new-client-registered-to-admin', 'catalan', 'New Customer Registration (Sent to admins) [catalan]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1163, 'leads', 'new-web-to-lead-form-submitted', 'catalan', 'Web to lead form submitted - Sent to lead [catalan]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1164, 'staff', 'two-factor-authentication', 'catalan', 'Two Factor Authentication [catalan]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1165, 'project', 'project-finished-to-customer', 'catalan', 'Project Marked as Finished (Sent to Customer Contacts) [catalan]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1166, 'credit_note', 'credit-note-send-to-client', 'catalan', 'Send Credit Note To Email [catalan]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1167, 'tasks', 'task-status-change-to-staff', 'catalan', 'Task Status Changed (Sent to Staff) [catalan]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1168, 'tasks', 'task-status-change-to-contacts', 'catalan', 'Task Status Changed (Sent to Customer Contacts) [catalan]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1169, 'staff', 'reminder-email-staff', 'catalan', 'Staff Reminder Email [catalan]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1170, 'contract', 'contract-comment-to-client', 'catalan', 'New Comment Â (Sent to Customer Contacts) [catalan]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1171, 'contract', 'contract-comment-to-admin', 'catalan', 'New Comment (Sent to Staff)  [catalan]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1172, 'subscriptions', 'send-subscription', 'catalan', 'Send Subscription to Customer [catalan]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1173, 'subscriptions', 'subscription-payment-failed', 'catalan', 'Subscription Payment Failed [catalan]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1174, 'subscriptions', 'subscription-canceled', 'catalan', 'Subscription Canceled (Sent to customer primary contact) [catalan]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1175, 'subscriptions', 'subscription-payment-succeeded', 'catalan', 'Subscription Payment Succeeded (Sent to customer primary contact) [catalan]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1176, 'contract', 'contract-expiration-to-staff', 'catalan', 'Contract Expiration Reminder (Sent to Staff) [catalan]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1177, 'gdpr', 'gdpr-removal-request', 'catalan', 'Removal Request From Contact (Sent to administrators) [catalan]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1178, 'gdpr', 'gdpr-removal-request-lead', 'catalan', 'Removal Request From Lead (Sent to administrators) [catalan]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1179, 'client', 'client-registration-confirmed', 'catalan', 'Customer Registration Confirmed [catalan]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1180, 'contract', 'contract-signed-to-staff', 'catalan', 'Contract Signed (Sent to Staff) [catalan]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1181, 'subscriptions', 'customer-subscribed-to-staff', 'catalan', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [catalan]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1182, 'client', 'contact-verification-email', 'catalan', 'Email Verification (Sent to Contact After Registration) [catalan]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1183, 'client', 'new-customer-profile-file-uploaded-to-staff', 'catalan', 'New Customer Profile File(s) Uploaded (Sent to Staff) [catalan]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1184, 'staff', 'event-notification-to-staff', 'catalan', 'Event Notification (Calendar) [catalan]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(1185, 'client', 'new-client-created', 'polish', 'New Contact Added/Registered (Welcome Email) [polish]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1186, 'invoice', 'invoice-send-to-client', 'polish', 'Send Invoice to Customer [polish]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1187, 'ticket', 'new-ticket-opened-admin', 'polish', 'New Ticket Opened (Opened by Staff, Sent to Customer) [polish]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1188, 'ticket', 'ticket-reply', 'polish', 'Ticket Reply (Sent to Customer) [polish]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1189, 'ticket', 'ticket-autoresponse', 'polish', 'New Ticket Opened - Autoresponse [polish]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1190, 'invoice', 'invoice-payment-recorded', 'polish', 'Invoice Payment Recorded (Sent to Customer) [polish]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1191, 'invoice', 'invoice-overdue-notice', 'polish', 'Invoice Overdue Notice [polish]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1192, 'invoice', 'invoice-already-send', 'polish', 'Invoice Already Sent to Customer [polish]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1193, 'ticket', 'new-ticket-created-staff', 'polish', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [polish]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1194, 'estimate', 'estimate-send-to-client', 'polish', 'Send Estimate to Customer [polish]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1195, 'ticket', 'ticket-reply-to-admin', 'polish', 'Ticket Reply (Sent to Staff) [polish]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1196, 'estimate', 'estimate-already-send', 'polish', 'Estimate Already Sent to Customer [polish]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1197, 'contract', 'contract-expiration', 'polish', 'Contract Expiration Reminder (Sent to Customer Contacts) [polish]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1198, 'tasks', 'task-assigned', 'polish', 'New Task Assigned (Sent to Staff) [polish]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1199, 'tasks', 'task-added-as-follower', 'polish', 'Staff Member Added as Follower on Task (Sent to Staff) [polish]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1200, 'tasks', 'task-commented', 'polish', 'New Comment on Task (Sent to Staff) [polish]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1201, 'tasks', 'task-added-attachment', 'polish', 'New Attachment(s) on Task (Sent to Staff) [polish]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1202, 'estimate', 'estimate-declined-to-staff', 'polish', 'Estimate Declined (Sent to Staff) [polish]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1203, 'estimate', 'estimate-accepted-to-staff', 'polish', 'Estimate Accepted (Sent to Staff) [polish]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1204, 'proposals', 'proposal-client-accepted', 'polish', 'Customer Action - Accepted (Sent to Staff) [polish]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1205, 'proposals', 'proposal-send-to-customer', 'polish', 'Send Proposal to Customer [polish]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1206, 'proposals', 'proposal-client-declined', 'polish', 'Customer Action - Declined (Sent to Staff) [polish]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1207, 'proposals', 'proposal-client-thank-you', 'polish', 'Thank You Email (Sent to Customer After Accept) [polish]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1208, 'proposals', 'proposal-comment-to-client', 'polish', 'New Comment Â (Sent to Customer/Lead) [polish]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1209, 'proposals', 'proposal-comment-to-admin', 'polish', 'New Comment (Sent to Staff)  [polish]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1210, 'estimate', 'estimate-thank-you-to-customer', 'polish', 'Thank You Email (Sent to Customer After Accept) [polish]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1211, 'tasks', 'task-deadline-notification', 'polish', 'Task Deadline Reminder - Sent to Assigned Members [polish]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1212, 'contract', 'send-contract', 'polish', 'Send Contract to Customer [polish]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1213, 'invoice', 'invoice-payment-recorded-to-staff', 'polish', 'Invoice Payment Recorded (Sent to Staff) [polish]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1214, 'ticket', 'auto-close-ticket', 'polish', 'Auto Close Ticket [polish]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1215, 'project', 'new-project-discussion-created-to-staff', 'polish', 'New Project Discussion (Sent to Project Members) [polish]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1216, 'project', 'new-project-discussion-created-to-customer', 'polish', 'New Project Discussion (Sent to Customer Contacts) [polish]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1217, 'project', 'new-project-file-uploaded-to-customer', 'polish', 'New Project File(s) Uploaded (Sent to Customer Contacts) [polish]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1218, 'project', 'new-project-file-uploaded-to-staff', 'polish', 'New Project File(s) Uploaded (Sent to Project Members) [polish]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1219, 'project', 'new-project-discussion-comment-to-customer', 'polish', 'New Discussion Comment  (Sent to Customer Contacts) [polish]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1220, 'project', 'new-project-discussion-comment-to-staff', 'polish', 'New Discussion Comment (Sent to Project Members) [polish]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1221, 'project', 'staff-added-as-project-member', 'polish', 'Staff Added as Project Member [polish]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1222, 'estimate', 'estimate-expiry-reminder', 'polish', 'Estimate Expiration Reminder [polish]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1223, 'proposals', 'proposal-expiry-reminder', 'polish', 'Proposal Expiration Reminder [polish]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1224, 'staff', 'new-staff-created', 'polish', 'New Staff Created (Welcome Email) [polish]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1225, 'client', 'contact-forgot-password', 'polish', 'Forgot Password [polish]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1226, 'client', 'contact-password-reseted', 'polish', 'Password Reset - Confirmation [polish]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1227, 'client', 'contact-set-password', 'polish', 'Set New Password [polish]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1228, 'staff', 'staff-forgot-password', 'polish', 'Forgot Password [polish]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1229, 'staff', 'staff-password-reseted', 'polish', 'Password Reset - Confirmation [polish]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1230, 'project', 'assigned-to-project', 'polish', 'New Project Created (Sent to Customer Contacts) [polish]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1231, 'tasks', 'task-added-attachment-to-contacts', 'polish', 'New Attachment(s) on Task (Sent to Customer Contacts) [polish]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1232, 'tasks', 'task-commented-to-contacts', 'polish', 'New Comment on Task (Sent to Customer Contacts) [polish]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1233, 'leads', 'new-lead-assigned', 'polish', 'New Lead Assigned to Staff Member [polish]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1234, 'client', 'client-statement', 'polish', 'Statement - Account Summary [polish]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1235, 'ticket', 'ticket-assigned-to-admin', 'polish', 'New Ticket Assigned (Sent to Staff) [polish]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1236, 'client', 'new-client-registered-to-admin', 'polish', 'New Customer Registration (Sent to admins) [polish]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1237, 'leads', 'new-web-to-lead-form-submitted', 'polish', 'Web to lead form submitted - Sent to lead [polish]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1238, 'staff', 'two-factor-authentication', 'polish', 'Two Factor Authentication [polish]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1239, 'project', 'project-finished-to-customer', 'polish', 'Project Marked as Finished (Sent to Customer Contacts) [polish]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1240, 'credit_note', 'credit-note-send-to-client', 'polish', 'Send Credit Note To Email [polish]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1241, 'tasks', 'task-status-change-to-staff', 'polish', 'Task Status Changed (Sent to Staff) [polish]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1242, 'tasks', 'task-status-change-to-contacts', 'polish', 'Task Status Changed (Sent to Customer Contacts) [polish]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1243, 'staff', 'reminder-email-staff', 'polish', 'Staff Reminder Email [polish]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1244, 'contract', 'contract-comment-to-client', 'polish', 'New Comment Â (Sent to Customer Contacts) [polish]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1245, 'contract', 'contract-comment-to-admin', 'polish', 'New Comment (Sent to Staff)  [polish]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1246, 'subscriptions', 'send-subscription', 'polish', 'Send Subscription to Customer [polish]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1247, 'subscriptions', 'subscription-payment-failed', 'polish', 'Subscription Payment Failed [polish]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1248, 'subscriptions', 'subscription-canceled', 'polish', 'Subscription Canceled (Sent to customer primary contact) [polish]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1249, 'subscriptions', 'subscription-payment-succeeded', 'polish', 'Subscription Payment Succeeded (Sent to customer primary contact) [polish]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1250, 'contract', 'contract-expiration-to-staff', 'polish', 'Contract Expiration Reminder (Sent to Staff) [polish]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1251, 'gdpr', 'gdpr-removal-request', 'polish', 'Removal Request From Contact (Sent to administrators) [polish]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1252, 'gdpr', 'gdpr-removal-request-lead', 'polish', 'Removal Request From Lead (Sent to administrators) [polish]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1253, 'client', 'client-registration-confirmed', 'polish', 'Customer Registration Confirmed [polish]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1254, 'contract', 'contract-signed-to-staff', 'polish', 'Contract Signed (Sent to Staff) [polish]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1255, 'subscriptions', 'customer-subscribed-to-staff', 'polish', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [polish]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1256, 'client', 'contact-verification-email', 'polish', 'Email Verification (Sent to Contact After Registration) [polish]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1257, 'client', 'new-customer-profile-file-uploaded-to-staff', 'polish', 'New Customer Profile File(s) Uploaded (Sent to Staff) [polish]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1258, 'staff', 'event-notification-to-staff', 'polish', 'Event Notification (Calendar) [polish]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(1259, 'client', 'new-client-created', 'romanian', 'New Contact Added/Registered (Welcome Email) [romanian]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1260, 'invoice', 'invoice-send-to-client', 'romanian', 'Send Invoice to Customer [romanian]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1261, 'ticket', 'new-ticket-opened-admin', 'romanian', 'New Ticket Opened (Opened by Staff, Sent to Customer) [romanian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1262, 'ticket', 'ticket-reply', 'romanian', 'Ticket Reply (Sent to Customer) [romanian]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1263, 'ticket', 'ticket-autoresponse', 'romanian', 'New Ticket Opened - Autoresponse [romanian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1264, 'invoice', 'invoice-payment-recorded', 'romanian', 'Invoice Payment Recorded (Sent to Customer) [romanian]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1265, 'invoice', 'invoice-overdue-notice', 'romanian', 'Invoice Overdue Notice [romanian]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1266, 'invoice', 'invoice-already-send', 'romanian', 'Invoice Already Sent to Customer [romanian]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1267, 'ticket', 'new-ticket-created-staff', 'romanian', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [romanian]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1268, 'estimate', 'estimate-send-to-client', 'romanian', 'Send Estimate to Customer [romanian]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1269, 'ticket', 'ticket-reply-to-admin', 'romanian', 'Ticket Reply (Sent to Staff) [romanian]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1270, 'estimate', 'estimate-already-send', 'romanian', 'Estimate Already Sent to Customer [romanian]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1271, 'contract', 'contract-expiration', 'romanian', 'Contract Expiration Reminder (Sent to Customer Contacts) [romanian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1272, 'tasks', 'task-assigned', 'romanian', 'New Task Assigned (Sent to Staff) [romanian]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1273, 'tasks', 'task-added-as-follower', 'romanian', 'Staff Member Added as Follower on Task (Sent to Staff) [romanian]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1274, 'tasks', 'task-commented', 'romanian', 'New Comment on Task (Sent to Staff) [romanian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1275, 'tasks', 'task-added-attachment', 'romanian', 'New Attachment(s) on Task (Sent to Staff) [romanian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1276, 'estimate', 'estimate-declined-to-staff', 'romanian', 'Estimate Declined (Sent to Staff) [romanian]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1277, 'estimate', 'estimate-accepted-to-staff', 'romanian', 'Estimate Accepted (Sent to Staff) [romanian]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1278, 'proposals', 'proposal-client-accepted', 'romanian', 'Customer Action - Accepted (Sent to Staff) [romanian]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1279, 'proposals', 'proposal-send-to-customer', 'romanian', 'Send Proposal to Customer [romanian]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1280, 'proposals', 'proposal-client-declined', 'romanian', 'Customer Action - Declined (Sent to Staff) [romanian]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1281, 'proposals', 'proposal-client-thank-you', 'romanian', 'Thank You Email (Sent to Customer After Accept) [romanian]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1282, 'proposals', 'proposal-comment-to-client', 'romanian', 'New Comment Â (Sent to Customer/Lead) [romanian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1283, 'proposals', 'proposal-comment-to-admin', 'romanian', 'New Comment (Sent to Staff)  [romanian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1284, 'estimate', 'estimate-thank-you-to-customer', 'romanian', 'Thank You Email (Sent to Customer After Accept) [romanian]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1285, 'tasks', 'task-deadline-notification', 'romanian', 'Task Deadline Reminder - Sent to Assigned Members [romanian]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1286, 'contract', 'send-contract', 'romanian', 'Send Contract to Customer [romanian]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1287, 'invoice', 'invoice-payment-recorded-to-staff', 'romanian', 'Invoice Payment Recorded (Sent to Staff) [romanian]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1288, 'ticket', 'auto-close-ticket', 'romanian', 'Auto Close Ticket [romanian]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1289, 'project', 'new-project-discussion-created-to-staff', 'romanian', 'New Project Discussion (Sent to Project Members) [romanian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1290, 'project', 'new-project-discussion-created-to-customer', 'romanian', 'New Project Discussion (Sent to Customer Contacts) [romanian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1291, 'project', 'new-project-file-uploaded-to-customer', 'romanian', 'New Project File(s) Uploaded (Sent to Customer Contacts) [romanian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1292, 'project', 'new-project-file-uploaded-to-staff', 'romanian', 'New Project File(s) Uploaded (Sent to Project Members) [romanian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1293, 'project', 'new-project-discussion-comment-to-customer', 'romanian', 'New Discussion Comment  (Sent to Customer Contacts) [romanian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1294, 'project', 'new-project-discussion-comment-to-staff', 'romanian', 'New Discussion Comment (Sent to Project Members) [romanian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1295, 'project', 'staff-added-as-project-member', 'romanian', 'Staff Added as Project Member [romanian]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1296, 'estimate', 'estimate-expiry-reminder', 'romanian', 'Estimate Expiration Reminder [romanian]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1297, 'proposals', 'proposal-expiry-reminder', 'romanian', 'Proposal Expiration Reminder [romanian]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1298, 'staff', 'new-staff-created', 'romanian', 'New Staff Created (Welcome Email) [romanian]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1299, 'client', 'contact-forgot-password', 'romanian', 'Forgot Password [romanian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1300, 'client', 'contact-password-reseted', 'romanian', 'Password Reset - Confirmation [romanian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1301, 'client', 'contact-set-password', 'romanian', 'Set New Password [romanian]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1302, 'staff', 'staff-forgot-password', 'romanian', 'Forgot Password [romanian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1303, 'staff', 'staff-password-reseted', 'romanian', 'Password Reset - Confirmation [romanian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1304, 'project', 'assigned-to-project', 'romanian', 'New Project Created (Sent to Customer Contacts) [romanian]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1305, 'tasks', 'task-added-attachment-to-contacts', 'romanian', 'New Attachment(s) on Task (Sent to Customer Contacts) [romanian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1306, 'tasks', 'task-commented-to-contacts', 'romanian', 'New Comment on Task (Sent to Customer Contacts) [romanian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1307, 'leads', 'new-lead-assigned', 'romanian', 'New Lead Assigned to Staff Member [romanian]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1308, 'client', 'client-statement', 'romanian', 'Statement - Account Summary [romanian]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1309, 'ticket', 'ticket-assigned-to-admin', 'romanian', 'New Ticket Assigned (Sent to Staff) [romanian]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1310, 'client', 'new-client-registered-to-admin', 'romanian', 'New Customer Registration (Sent to admins) [romanian]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1311, 'leads', 'new-web-to-lead-form-submitted', 'romanian', 'Web to lead form submitted - Sent to lead [romanian]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1312, 'staff', 'two-factor-authentication', 'romanian', 'Two Factor Authentication [romanian]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1313, 'project', 'project-finished-to-customer', 'romanian', 'Project Marked as Finished (Sent to Customer Contacts) [romanian]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1314, 'credit_note', 'credit-note-send-to-client', 'romanian', 'Send Credit Note To Email [romanian]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1315, 'tasks', 'task-status-change-to-staff', 'romanian', 'Task Status Changed (Sent to Staff) [romanian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1316, 'tasks', 'task-status-change-to-contacts', 'romanian', 'Task Status Changed (Sent to Customer Contacts) [romanian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1317, 'staff', 'reminder-email-staff', 'romanian', 'Staff Reminder Email [romanian]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1318, 'contract', 'contract-comment-to-client', 'romanian', 'New Comment Â (Sent to Customer Contacts) [romanian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1319, 'contract', 'contract-comment-to-admin', 'romanian', 'New Comment (Sent to Staff)  [romanian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1320, 'subscriptions', 'send-subscription', 'romanian', 'Send Subscription to Customer [romanian]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1321, 'subscriptions', 'subscription-payment-failed', 'romanian', 'Subscription Payment Failed [romanian]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1322, 'subscriptions', 'subscription-canceled', 'romanian', 'Subscription Canceled (Sent to customer primary contact) [romanian]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1323, 'subscriptions', 'subscription-payment-succeeded', 'romanian', 'Subscription Payment Succeeded (Sent to customer primary contact) [romanian]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1324, 'contract', 'contract-expiration-to-staff', 'romanian', 'Contract Expiration Reminder (Sent to Staff) [romanian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1325, 'gdpr', 'gdpr-removal-request', 'romanian', 'Removal Request From Contact (Sent to administrators) [romanian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1326, 'gdpr', 'gdpr-removal-request-lead', 'romanian', 'Removal Request From Lead (Sent to administrators) [romanian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1327, 'client', 'client-registration-confirmed', 'romanian', 'Customer Registration Confirmed [romanian]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1328, 'contract', 'contract-signed-to-staff', 'romanian', 'Contract Signed (Sent to Staff) [romanian]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1329, 'subscriptions', 'customer-subscribed-to-staff', 'romanian', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [romanian]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1330, 'client', 'contact-verification-email', 'romanian', 'Email Verification (Sent to Contact After Registration) [romanian]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1331, 'client', 'new-customer-profile-file-uploaded-to-staff', 'romanian', 'New Customer Profile File(s) Uploaded (Sent to Staff) [romanian]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1332, 'staff', 'event-notification-to-staff', 'romanian', 'Event Notification (Calendar) [romanian]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(1333, 'client', 'new-client-created', 'indonesia', 'New Contact Added/Registered (Welcome Email) [indonesia]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1334, 'invoice', 'invoice-send-to-client', 'indonesia', 'Send Invoice to Customer [indonesia]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1335, 'ticket', 'new-ticket-opened-admin', 'indonesia', 'New Ticket Opened (Opened by Staff, Sent to Customer) [indonesia]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1336, 'ticket', 'ticket-reply', 'indonesia', 'Ticket Reply (Sent to Customer) [indonesia]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1337, 'ticket', 'ticket-autoresponse', 'indonesia', 'New Ticket Opened - Autoresponse [indonesia]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1338, 'invoice', 'invoice-payment-recorded', 'indonesia', 'Invoice Payment Recorded (Sent to Customer) [indonesia]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1339, 'invoice', 'invoice-overdue-notice', 'indonesia', 'Invoice Overdue Notice [indonesia]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1340, 'invoice', 'invoice-already-send', 'indonesia', 'Invoice Already Sent to Customer [indonesia]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1341, 'ticket', 'new-ticket-created-staff', 'indonesia', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [indonesia]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1342, 'estimate', 'estimate-send-to-client', 'indonesia', 'Send Estimate to Customer [indonesia]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1343, 'ticket', 'ticket-reply-to-admin', 'indonesia', 'Ticket Reply (Sent to Staff) [indonesia]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1344, 'estimate', 'estimate-already-send', 'indonesia', 'Estimate Already Sent to Customer [indonesia]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1345, 'contract', 'contract-expiration', 'indonesia', 'Contract Expiration Reminder (Sent to Customer Contacts) [indonesia]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1346, 'tasks', 'task-assigned', 'indonesia', 'New Task Assigned (Sent to Staff) [indonesia]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1347, 'tasks', 'task-added-as-follower', 'indonesia', 'Staff Member Added as Follower on Task (Sent to Staff) [indonesia]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1348, 'tasks', 'task-commented', 'indonesia', 'New Comment on Task (Sent to Staff) [indonesia]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1349, 'tasks', 'task-added-attachment', 'indonesia', 'New Attachment(s) on Task (Sent to Staff) [indonesia]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1350, 'estimate', 'estimate-declined-to-staff', 'indonesia', 'Estimate Declined (Sent to Staff) [indonesia]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1351, 'estimate', 'estimate-accepted-to-staff', 'indonesia', 'Estimate Accepted (Sent to Staff) [indonesia]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1352, 'proposals', 'proposal-client-accepted', 'indonesia', 'Customer Action - Accepted (Sent to Staff) [indonesia]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1353, 'proposals', 'proposal-send-to-customer', 'indonesia', 'Send Proposal to Customer [indonesia]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1354, 'proposals', 'proposal-client-declined', 'indonesia', 'Customer Action - Declined (Sent to Staff) [indonesia]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1355, 'proposals', 'proposal-client-thank-you', 'indonesia', 'Thank You Email (Sent to Customer After Accept) [indonesia]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1356, 'proposals', 'proposal-comment-to-client', 'indonesia', 'New Comment Â (Sent to Customer/Lead) [indonesia]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1357, 'proposals', 'proposal-comment-to-admin', 'indonesia', 'New Comment (Sent to Staff)  [indonesia]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1358, 'estimate', 'estimate-thank-you-to-customer', 'indonesia', 'Thank You Email (Sent to Customer After Accept) [indonesia]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1359, 'tasks', 'task-deadline-notification', 'indonesia', 'Task Deadline Reminder - Sent to Assigned Members [indonesia]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1360, 'contract', 'send-contract', 'indonesia', 'Send Contract to Customer [indonesia]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1361, 'invoice', 'invoice-payment-recorded-to-staff', 'indonesia', 'Invoice Payment Recorded (Sent to Staff) [indonesia]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1362, 'ticket', 'auto-close-ticket', 'indonesia', 'Auto Close Ticket [indonesia]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1363, 'project', 'new-project-discussion-created-to-staff', 'indonesia', 'New Project Discussion (Sent to Project Members) [indonesia]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1364, 'project', 'new-project-discussion-created-to-customer', 'indonesia', 'New Project Discussion (Sent to Customer Contacts) [indonesia]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1365, 'project', 'new-project-file-uploaded-to-customer', 'indonesia', 'New Project File(s) Uploaded (Sent to Customer Contacts) [indonesia]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1366, 'project', 'new-project-file-uploaded-to-staff', 'indonesia', 'New Project File(s) Uploaded (Sent to Project Members) [indonesia]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1367, 'project', 'new-project-discussion-comment-to-customer', 'indonesia', 'New Discussion Comment  (Sent to Customer Contacts) [indonesia]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1368, 'project', 'new-project-discussion-comment-to-staff', 'indonesia', 'New Discussion Comment (Sent to Project Members) [indonesia]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1369, 'project', 'staff-added-as-project-member', 'indonesia', 'Staff Added as Project Member [indonesia]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1370, 'estimate', 'estimate-expiry-reminder', 'indonesia', 'Estimate Expiration Reminder [indonesia]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1371, 'proposals', 'proposal-expiry-reminder', 'indonesia', 'Proposal Expiration Reminder [indonesia]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1372, 'staff', 'new-staff-created', 'indonesia', 'New Staff Created (Welcome Email) [indonesia]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1373, 'client', 'contact-forgot-password', 'indonesia', 'Forgot Password [indonesia]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1374, 'client', 'contact-password-reseted', 'indonesia', 'Password Reset - Confirmation [indonesia]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1375, 'client', 'contact-set-password', 'indonesia', 'Set New Password [indonesia]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1376, 'staff', 'staff-forgot-password', 'indonesia', 'Forgot Password [indonesia]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1377, 'staff', 'staff-password-reseted', 'indonesia', 'Password Reset - Confirmation [indonesia]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1378, 'project', 'assigned-to-project', 'indonesia', 'New Project Created (Sent to Customer Contacts) [indonesia]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1379, 'tasks', 'task-added-attachment-to-contacts', 'indonesia', 'New Attachment(s) on Task (Sent to Customer Contacts) [indonesia]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1380, 'tasks', 'task-commented-to-contacts', 'indonesia', 'New Comment on Task (Sent to Customer Contacts) [indonesia]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1381, 'leads', 'new-lead-assigned', 'indonesia', 'New Lead Assigned to Staff Member [indonesia]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1382, 'client', 'client-statement', 'indonesia', 'Statement - Account Summary [indonesia]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1383, 'ticket', 'ticket-assigned-to-admin', 'indonesia', 'New Ticket Assigned (Sent to Staff) [indonesia]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1384, 'client', 'new-client-registered-to-admin', 'indonesia', 'New Customer Registration (Sent to admins) [indonesia]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1385, 'leads', 'new-web-to-lead-form-submitted', 'indonesia', 'Web to lead form submitted - Sent to lead [indonesia]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1386, 'staff', 'two-factor-authentication', 'indonesia', 'Two Factor Authentication [indonesia]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1387, 'project', 'project-finished-to-customer', 'indonesia', 'Project Marked as Finished (Sent to Customer Contacts) [indonesia]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1388, 'credit_note', 'credit-note-send-to-client', 'indonesia', 'Send Credit Note To Email [indonesia]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1389, 'tasks', 'task-status-change-to-staff', 'indonesia', 'Task Status Changed (Sent to Staff) [indonesia]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1390, 'tasks', 'task-status-change-to-contacts', 'indonesia', 'Task Status Changed (Sent to Customer Contacts) [indonesia]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1391, 'staff', 'reminder-email-staff', 'indonesia', 'Staff Reminder Email [indonesia]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1392, 'contract', 'contract-comment-to-client', 'indonesia', 'New Comment Â (Sent to Customer Contacts) [indonesia]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1393, 'contract', 'contract-comment-to-admin', 'indonesia', 'New Comment (Sent to Staff)  [indonesia]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1394, 'subscriptions', 'send-subscription', 'indonesia', 'Send Subscription to Customer [indonesia]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1395, 'subscriptions', 'subscription-payment-failed', 'indonesia', 'Subscription Payment Failed [indonesia]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1396, 'subscriptions', 'subscription-canceled', 'indonesia', 'Subscription Canceled (Sent to customer primary contact) [indonesia]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1397, 'subscriptions', 'subscription-payment-succeeded', 'indonesia', 'Subscription Payment Succeeded (Sent to customer primary contact) [indonesia]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1398, 'contract', 'contract-expiration-to-staff', 'indonesia', 'Contract Expiration Reminder (Sent to Staff) [indonesia]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1399, 'gdpr', 'gdpr-removal-request', 'indonesia', 'Removal Request From Contact (Sent to administrators) [indonesia]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1400, 'gdpr', 'gdpr-removal-request-lead', 'indonesia', 'Removal Request From Lead (Sent to administrators) [indonesia]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1401, 'client', 'client-registration-confirmed', 'indonesia', 'Customer Registration Confirmed [indonesia]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1402, 'contract', 'contract-signed-to-staff', 'indonesia', 'Contract Signed (Sent to Staff) [indonesia]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1403, 'subscriptions', 'customer-subscribed-to-staff', 'indonesia', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [indonesia]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1404, 'client', 'contact-verification-email', 'indonesia', 'Email Verification (Sent to Contact After Registration) [indonesia]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1405, 'client', 'new-customer-profile-file-uploaded-to-staff', 'indonesia', 'New Customer Profile File(s) Uploaded (Sent to Staff) [indonesia]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1406, 'staff', 'event-notification-to-staff', 'indonesia', 'Event Notification (Calendar) [indonesia]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(1407, 'client', 'new-client-created', 'french', 'New Contact Added/Registered (Welcome Email) [french]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1408, 'invoice', 'invoice-send-to-client', 'french', 'Send Invoice to Customer [french]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1409, 'ticket', 'new-ticket-opened-admin', 'french', 'New Ticket Opened (Opened by Staff, Sent to Customer) [french]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1410, 'ticket', 'ticket-reply', 'french', 'Ticket Reply (Sent to Customer) [french]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1411, 'ticket', 'ticket-autoresponse', 'french', 'New Ticket Opened - Autoresponse [french]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1412, 'invoice', 'invoice-payment-recorded', 'french', 'Invoice Payment Recorded (Sent to Customer) [french]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1413, 'invoice', 'invoice-overdue-notice', 'french', 'Invoice Overdue Notice [french]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1414, 'invoice', 'invoice-already-send', 'french', 'Invoice Already Sent to Customer [french]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1415, 'ticket', 'new-ticket-created-staff', 'french', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [french]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1416, 'estimate', 'estimate-send-to-client', 'french', 'Send Estimate to Customer [french]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1417, 'ticket', 'ticket-reply-to-admin', 'french', 'Ticket Reply (Sent to Staff) [french]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1418, 'estimate', 'estimate-already-send', 'french', 'Estimate Already Sent to Customer [french]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1419, 'contract', 'contract-expiration', 'french', 'Contract Expiration Reminder (Sent to Customer Contacts) [french]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1420, 'tasks', 'task-assigned', 'french', 'New Task Assigned (Sent to Staff) [french]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1421, 'tasks', 'task-added-as-follower', 'french', 'Staff Member Added as Follower on Task (Sent to Staff) [french]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1422, 'tasks', 'task-commented', 'french', 'New Comment on Task (Sent to Staff) [french]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1423, 'tasks', 'task-added-attachment', 'french', 'New Attachment(s) on Task (Sent to Staff) [french]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1424, 'estimate', 'estimate-declined-to-staff', 'french', 'Estimate Declined (Sent to Staff) [french]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1425, 'estimate', 'estimate-accepted-to-staff', 'french', 'Estimate Accepted (Sent to Staff) [french]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1426, 'proposals', 'proposal-client-accepted', 'french', 'Customer Action - Accepted (Sent to Staff) [french]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0);
INSERT INTO `ms_emailtemplates` (`emailtemplateid`, `type`, `slug`, `language`, `name`, `subject`, `message`, `fromname`, `fromemail`, `plaintext`, `active`, `order`) VALUES
(1427, 'proposals', 'proposal-send-to-customer', 'french', 'Send Proposal to Customer [french]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1428, 'proposals', 'proposal-client-declined', 'french', 'Customer Action - Declined (Sent to Staff) [french]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1429, 'proposals', 'proposal-client-thank-you', 'french', 'Thank You Email (Sent to Customer After Accept) [french]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1430, 'proposals', 'proposal-comment-to-client', 'french', 'New Comment Â (Sent to Customer/Lead) [french]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1431, 'proposals', 'proposal-comment-to-admin', 'french', 'New Comment (Sent to Staff)  [french]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1432, 'estimate', 'estimate-thank-you-to-customer', 'french', 'Thank You Email (Sent to Customer After Accept) [french]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1433, 'tasks', 'task-deadline-notification', 'french', 'Task Deadline Reminder - Sent to Assigned Members [french]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1434, 'contract', 'send-contract', 'french', 'Send Contract to Customer [french]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1435, 'invoice', 'invoice-payment-recorded-to-staff', 'french', 'Invoice Payment Recorded (Sent to Staff) [french]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1436, 'ticket', 'auto-close-ticket', 'french', 'Auto Close Ticket [french]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1437, 'project', 'new-project-discussion-created-to-staff', 'french', 'New Project Discussion (Sent to Project Members) [french]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1438, 'project', 'new-project-discussion-created-to-customer', 'french', 'New Project Discussion (Sent to Customer Contacts) [french]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1439, 'project', 'new-project-file-uploaded-to-customer', 'french', 'New Project File(s) Uploaded (Sent to Customer Contacts) [french]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1440, 'project', 'new-project-file-uploaded-to-staff', 'french', 'New Project File(s) Uploaded (Sent to Project Members) [french]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1441, 'project', 'new-project-discussion-comment-to-customer', 'french', 'New Discussion Comment  (Sent to Customer Contacts) [french]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1442, 'project', 'new-project-discussion-comment-to-staff', 'french', 'New Discussion Comment (Sent to Project Members) [french]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1443, 'project', 'staff-added-as-project-member', 'french', 'Staff Added as Project Member [french]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1444, 'estimate', 'estimate-expiry-reminder', 'french', 'Estimate Expiration Reminder [french]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1445, 'proposals', 'proposal-expiry-reminder', 'french', 'Proposal Expiration Reminder [french]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1446, 'staff', 'new-staff-created', 'french', 'New Staff Created (Welcome Email) [french]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1447, 'client', 'contact-forgot-password', 'french', 'Forgot Password [french]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1448, 'client', 'contact-password-reseted', 'french', 'Password Reset - Confirmation [french]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1449, 'client', 'contact-set-password', 'french', 'Set New Password [french]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1450, 'staff', 'staff-forgot-password', 'french', 'Forgot Password [french]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1451, 'staff', 'staff-password-reseted', 'french', 'Password Reset - Confirmation [french]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1452, 'project', 'assigned-to-project', 'french', 'New Project Created (Sent to Customer Contacts) [french]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1453, 'tasks', 'task-added-attachment-to-contacts', 'french', 'New Attachment(s) on Task (Sent to Customer Contacts) [french]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1454, 'tasks', 'task-commented-to-contacts', 'french', 'New Comment on Task (Sent to Customer Contacts) [french]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1455, 'leads', 'new-lead-assigned', 'french', 'New Lead Assigned to Staff Member [french]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1456, 'client', 'client-statement', 'french', 'Statement - Account Summary [french]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1457, 'ticket', 'ticket-assigned-to-admin', 'french', 'New Ticket Assigned (Sent to Staff) [french]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1458, 'client', 'new-client-registered-to-admin', 'french', 'New Customer Registration (Sent to admins) [french]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1459, 'leads', 'new-web-to-lead-form-submitted', 'french', 'Web to lead form submitted - Sent to lead [french]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1460, 'staff', 'two-factor-authentication', 'french', 'Two Factor Authentication [french]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1461, 'project', 'project-finished-to-customer', 'french', 'Project Marked as Finished (Sent to Customer Contacts) [french]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1462, 'credit_note', 'credit-note-send-to-client', 'french', 'Send Credit Note To Email [french]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1463, 'tasks', 'task-status-change-to-staff', 'french', 'Task Status Changed (Sent to Staff) [french]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1464, 'tasks', 'task-status-change-to-contacts', 'french', 'Task Status Changed (Sent to Customer Contacts) [french]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1465, 'staff', 'reminder-email-staff', 'french', 'Staff Reminder Email [french]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1466, 'contract', 'contract-comment-to-client', 'french', 'New Comment Â (Sent to Customer Contacts) [french]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1467, 'contract', 'contract-comment-to-admin', 'french', 'New Comment (Sent to Staff)  [french]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1468, 'subscriptions', 'send-subscription', 'french', 'Send Subscription to Customer [french]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1469, 'subscriptions', 'subscription-payment-failed', 'french', 'Subscription Payment Failed [french]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1470, 'subscriptions', 'subscription-canceled', 'french', 'Subscription Canceled (Sent to customer primary contact) [french]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1471, 'subscriptions', 'subscription-payment-succeeded', 'french', 'Subscription Payment Succeeded (Sent to customer primary contact) [french]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1472, 'contract', 'contract-expiration-to-staff', 'french', 'Contract Expiration Reminder (Sent to Staff) [french]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1473, 'gdpr', 'gdpr-removal-request', 'french', 'Removal Request From Contact (Sent to administrators) [french]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1474, 'gdpr', 'gdpr-removal-request-lead', 'french', 'Removal Request From Lead (Sent to administrators) [french]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1475, 'client', 'client-registration-confirmed', 'french', 'Customer Registration Confirmed [french]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1476, 'contract', 'contract-signed-to-staff', 'french', 'Contract Signed (Sent to Staff) [french]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1477, 'subscriptions', 'customer-subscribed-to-staff', 'french', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [french]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1478, 'client', 'contact-verification-email', 'french', 'Email Verification (Sent to Contact After Registration) [french]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1479, 'client', 'new-customer-profile-file-uploaded-to-staff', 'french', 'New Customer Profile File(s) Uploaded (Sent to Staff) [french]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1480, 'staff', 'event-notification-to-staff', 'french', 'Event Notification (Calendar) [french]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(1481, 'client', 'new-client-created', 'turkish', 'New Contact Added/Registered (Welcome Email) [turkish]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1482, 'invoice', 'invoice-send-to-client', 'turkish', 'Send Invoice to Customer [turkish]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1483, 'ticket', 'new-ticket-opened-admin', 'turkish', 'New Ticket Opened (Opened by Staff, Sent to Customer) [turkish]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1484, 'ticket', 'ticket-reply', 'turkish', 'Ticket Reply (Sent to Customer) [turkish]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1485, 'ticket', 'ticket-autoresponse', 'turkish', 'New Ticket Opened - Autoresponse [turkish]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1486, 'invoice', 'invoice-payment-recorded', 'turkish', 'Invoice Payment Recorded (Sent to Customer) [turkish]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1487, 'invoice', 'invoice-overdue-notice', 'turkish', 'Invoice Overdue Notice [turkish]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1488, 'invoice', 'invoice-already-send', 'turkish', 'Invoice Already Sent to Customer [turkish]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1489, 'ticket', 'new-ticket-created-staff', 'turkish', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [turkish]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1490, 'estimate', 'estimate-send-to-client', 'turkish', 'Send Estimate to Customer [turkish]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1491, 'ticket', 'ticket-reply-to-admin', 'turkish', 'Ticket Reply (Sent to Staff) [turkish]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1492, 'estimate', 'estimate-already-send', 'turkish', 'Estimate Already Sent to Customer [turkish]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1493, 'contract', 'contract-expiration', 'turkish', 'Contract Expiration Reminder (Sent to Customer Contacts) [turkish]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1494, 'tasks', 'task-assigned', 'turkish', 'New Task Assigned (Sent to Staff) [turkish]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1495, 'tasks', 'task-added-as-follower', 'turkish', 'Staff Member Added as Follower on Task (Sent to Staff) [turkish]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1496, 'tasks', 'task-commented', 'turkish', 'New Comment on Task (Sent to Staff) [turkish]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1497, 'tasks', 'task-added-attachment', 'turkish', 'New Attachment(s) on Task (Sent to Staff) [turkish]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1498, 'estimate', 'estimate-declined-to-staff', 'turkish', 'Estimate Declined (Sent to Staff) [turkish]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1499, 'estimate', 'estimate-accepted-to-staff', 'turkish', 'Estimate Accepted (Sent to Staff) [turkish]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1500, 'proposals', 'proposal-client-accepted', 'turkish', 'Customer Action - Accepted (Sent to Staff) [turkish]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1501, 'proposals', 'proposal-send-to-customer', 'turkish', 'Send Proposal to Customer [turkish]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1502, 'proposals', 'proposal-client-declined', 'turkish', 'Customer Action - Declined (Sent to Staff) [turkish]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1503, 'proposals', 'proposal-client-thank-you', 'turkish', 'Thank You Email (Sent to Customer After Accept) [turkish]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1504, 'proposals', 'proposal-comment-to-client', 'turkish', 'New Comment Â (Sent to Customer/Lead) [turkish]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1505, 'proposals', 'proposal-comment-to-admin', 'turkish', 'New Comment (Sent to Staff)  [turkish]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1506, 'estimate', 'estimate-thank-you-to-customer', 'turkish', 'Thank You Email (Sent to Customer After Accept) [turkish]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1507, 'tasks', 'task-deadline-notification', 'turkish', 'Task Deadline Reminder - Sent to Assigned Members [turkish]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1508, 'contract', 'send-contract', 'turkish', 'Send Contract to Customer [turkish]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1509, 'invoice', 'invoice-payment-recorded-to-staff', 'turkish', 'Invoice Payment Recorded (Sent to Staff) [turkish]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1510, 'ticket', 'auto-close-ticket', 'turkish', 'Auto Close Ticket [turkish]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1511, 'project', 'new-project-discussion-created-to-staff', 'turkish', 'New Project Discussion (Sent to Project Members) [turkish]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1512, 'project', 'new-project-discussion-created-to-customer', 'turkish', 'New Project Discussion (Sent to Customer Contacts) [turkish]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1513, 'project', 'new-project-file-uploaded-to-customer', 'turkish', 'New Project File(s) Uploaded (Sent to Customer Contacts) [turkish]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1514, 'project', 'new-project-file-uploaded-to-staff', 'turkish', 'New Project File(s) Uploaded (Sent to Project Members) [turkish]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1515, 'project', 'new-project-discussion-comment-to-customer', 'turkish', 'New Discussion Comment  (Sent to Customer Contacts) [turkish]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1516, 'project', 'new-project-discussion-comment-to-staff', 'turkish', 'New Discussion Comment (Sent to Project Members) [turkish]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1517, 'project', 'staff-added-as-project-member', 'turkish', 'Staff Added as Project Member [turkish]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1518, 'estimate', 'estimate-expiry-reminder', 'turkish', 'Estimate Expiration Reminder [turkish]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1519, 'proposals', 'proposal-expiry-reminder', 'turkish', 'Proposal Expiration Reminder [turkish]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1520, 'staff', 'new-staff-created', 'turkish', 'New Staff Created (Welcome Email) [turkish]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1521, 'client', 'contact-forgot-password', 'turkish', 'Forgot Password [turkish]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1522, 'client', 'contact-password-reseted', 'turkish', 'Password Reset - Confirmation [turkish]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1523, 'client', 'contact-set-password', 'turkish', 'Set New Password [turkish]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1524, 'staff', 'staff-forgot-password', 'turkish', 'Forgot Password [turkish]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1525, 'staff', 'staff-password-reseted', 'turkish', 'Password Reset - Confirmation [turkish]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1526, 'project', 'assigned-to-project', 'turkish', 'New Project Created (Sent to Customer Contacts) [turkish]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1527, 'tasks', 'task-added-attachment-to-contacts', 'turkish', 'New Attachment(s) on Task (Sent to Customer Contacts) [turkish]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1528, 'tasks', 'task-commented-to-contacts', 'turkish', 'New Comment on Task (Sent to Customer Contacts) [turkish]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1529, 'leads', 'new-lead-assigned', 'turkish', 'New Lead Assigned to Staff Member [turkish]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1530, 'client', 'client-statement', 'turkish', 'Statement - Account Summary [turkish]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1531, 'ticket', 'ticket-assigned-to-admin', 'turkish', 'New Ticket Assigned (Sent to Staff) [turkish]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1532, 'client', 'new-client-registered-to-admin', 'turkish', 'New Customer Registration (Sent to admins) [turkish]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1533, 'leads', 'new-web-to-lead-form-submitted', 'turkish', 'Web to lead form submitted - Sent to lead [turkish]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1534, 'staff', 'two-factor-authentication', 'turkish', 'Two Factor Authentication [turkish]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1535, 'project', 'project-finished-to-customer', 'turkish', 'Project Marked as Finished (Sent to Customer Contacts) [turkish]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1536, 'credit_note', 'credit-note-send-to-client', 'turkish', 'Send Credit Note To Email [turkish]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1537, 'tasks', 'task-status-change-to-staff', 'turkish', 'Task Status Changed (Sent to Staff) [turkish]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1538, 'tasks', 'task-status-change-to-contacts', 'turkish', 'Task Status Changed (Sent to Customer Contacts) [turkish]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1539, 'staff', 'reminder-email-staff', 'turkish', 'Staff Reminder Email [turkish]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1540, 'contract', 'contract-comment-to-client', 'turkish', 'New Comment Â (Sent to Customer Contacts) [turkish]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1541, 'contract', 'contract-comment-to-admin', 'turkish', 'New Comment (Sent to Staff)  [turkish]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1542, 'subscriptions', 'send-subscription', 'turkish', 'Send Subscription to Customer [turkish]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1543, 'subscriptions', 'subscription-payment-failed', 'turkish', 'Subscription Payment Failed [turkish]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1544, 'subscriptions', 'subscription-canceled', 'turkish', 'Subscription Canceled (Sent to customer primary contact) [turkish]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1545, 'subscriptions', 'subscription-payment-succeeded', 'turkish', 'Subscription Payment Succeeded (Sent to customer primary contact) [turkish]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1546, 'contract', 'contract-expiration-to-staff', 'turkish', 'Contract Expiration Reminder (Sent to Staff) [turkish]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1547, 'gdpr', 'gdpr-removal-request', 'turkish', 'Removal Request From Contact (Sent to administrators) [turkish]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1548, 'gdpr', 'gdpr-removal-request-lead', 'turkish', 'Removal Request From Lead (Sent to administrators) [turkish]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1549, 'client', 'client-registration-confirmed', 'turkish', 'Customer Registration Confirmed [turkish]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1550, 'contract', 'contract-signed-to-staff', 'turkish', 'Contract Signed (Sent to Staff) [turkish]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1551, 'subscriptions', 'customer-subscribed-to-staff', 'turkish', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [turkish]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1552, 'client', 'contact-verification-email', 'turkish', 'Email Verification (Sent to Contact After Registration) [turkish]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1553, 'client', 'new-customer-profile-file-uploaded-to-staff', 'turkish', 'New Customer Profile File(s) Uploaded (Sent to Staff) [turkish]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1554, 'staff', 'event-notification-to-staff', 'turkish', 'Event Notification (Calendar) [turkish]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0),
(1555, 'client', 'new-client-created', 'italian', 'New Contact Added/Registered (Welcome Email) [italian]', 'Welcome aboard', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1556, 'invoice', 'invoice-send-to-client', 'italian', 'Send Invoice to Customer [italian]', 'Invoice with number {invoice_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1557, 'ticket', 'new-ticket-opened-admin', 'italian', 'New Ticket Opened (Opened by Staff, Sent to Customer) [italian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1558, 'ticket', 'ticket-reply', 'italian', 'Ticket Reply (Sent to Customer) [italian]', 'New Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1559, 'ticket', 'ticket-autoresponse', 'italian', 'New Ticket Opened - Autoresponse [italian]', 'New Support Ticket Opened', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1560, 'invoice', 'invoice-payment-recorded', 'italian', 'Invoice Payment Recorded (Sent to Customer) [italian]', 'Invoice Payment Recorded', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1561, 'invoice', 'invoice-overdue-notice', 'italian', 'Invoice Overdue Notice [italian]', 'Invoice Overdue Notice - {invoice_number}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1562, 'invoice', 'invoice-already-send', 'italian', 'Invoice Already Sent to Customer [italian]', 'Invoice # {invoice_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1563, 'ticket', 'new-ticket-created-staff', 'italian', 'New Ticket Created (Opened by Customer, Sent to Staff Members) [italian]', 'New Ticket Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1564, 'estimate', 'estimate-send-to-client', 'italian', 'Send Estimate to Customer [italian]', 'Estimate # {estimate_number} created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1565, 'ticket', 'ticket-reply-to-admin', 'italian', 'Ticket Reply (Sent to Staff) [italian]', 'New Support Ticket Reply', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1566, 'estimate', 'estimate-already-send', 'italian', 'Estimate Already Sent to Customer [italian]', 'Estimate # {estimate_number} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1567, 'contract', 'contract-expiration', 'italian', 'Contract Expiration Reminder (Sent to Customer Contacts) [italian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1568, 'tasks', 'task-assigned', 'italian', 'New Task Assigned (Sent to Staff) [italian]', 'New Task Assigned to You - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1569, 'tasks', 'task-added-as-follower', 'italian', 'Staff Member Added as Follower on Task (Sent to Staff) [italian]', 'You are added as follower on task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1570, 'tasks', 'task-commented', 'italian', 'New Comment on Task (Sent to Staff) [italian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1571, 'tasks', 'task-added-attachment', 'italian', 'New Attachment(s) on Task (Sent to Staff) [italian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1572, 'estimate', 'estimate-declined-to-staff', 'italian', 'Estimate Declined (Sent to Staff) [italian]', 'Customer Declined Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1573, 'estimate', 'estimate-accepted-to-staff', 'italian', 'Estimate Accepted (Sent to Staff) [italian]', 'Customer Accepted Estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1574, 'proposals', 'proposal-client-accepted', 'italian', 'Customer Action - Accepted (Sent to Staff) [italian]', 'Customer Accepted Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1575, 'proposals', 'proposal-send-to-customer', 'italian', 'Send Proposal to Customer [italian]', 'Proposal With Number {proposal_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1576, 'proposals', 'proposal-client-declined', 'italian', 'Customer Action - Declined (Sent to Staff) [italian]', 'Client Declined Proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1577, 'proposals', 'proposal-client-thank-you', 'italian', 'Thank You Email (Sent to Customer After Accept) [italian]', 'Thank for you accepting proposal', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1578, 'proposals', 'proposal-comment-to-client', 'italian', 'New Comment Â (Sent to Customer/Lead) [italian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1579, 'proposals', 'proposal-comment-to-admin', 'italian', 'New Comment (Sent to Staff)  [italian]', 'New Proposal Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1580, 'estimate', 'estimate-thank-you-to-customer', 'italian', 'Thank You Email (Sent to Customer After Accept) [italian]', 'Thank for you accepting estimate', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1581, 'tasks', 'task-deadline-notification', 'italian', 'Task Deadline Reminder - Sent to Assigned Members [italian]', 'Task Deadline Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1582, 'contract', 'send-contract', 'italian', 'Send Contract to Customer [italian]', 'Contract - {contract_subject}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1583, 'invoice', 'invoice-payment-recorded-to-staff', 'italian', 'Invoice Payment Recorded (Sent to Staff) [italian]', 'New Invoice Payment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1584, 'ticket', 'auto-close-ticket', 'italian', 'Auto Close Ticket [italian]', 'Ticket Auto Closed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1585, 'project', 'new-project-discussion-created-to-staff', 'italian', 'New Project Discussion (Sent to Project Members) [italian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1586, 'project', 'new-project-discussion-created-to-customer', 'italian', 'New Project Discussion (Sent to Customer Contacts) [italian]', 'New Project Discussion Created - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1587, 'project', 'new-project-file-uploaded-to-customer', 'italian', 'New Project File(s) Uploaded (Sent to Customer Contacts) [italian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1588, 'project', 'new-project-file-uploaded-to-staff', 'italian', 'New Project File(s) Uploaded (Sent to Project Members) [italian]', 'New Project File(s) Uploaded - {project_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1589, 'project', 'new-project-discussion-comment-to-customer', 'italian', 'New Discussion Comment  (Sent to Customer Contacts) [italian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1590, 'project', 'new-project-discussion-comment-to-staff', 'italian', 'New Discussion Comment (Sent to Project Members) [italian]', 'New Discussion Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1591, 'project', 'staff-added-as-project-member', 'italian', 'Staff Added as Project Member [italian]', 'New project assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1592, 'estimate', 'estimate-expiry-reminder', 'italian', 'Estimate Expiration Reminder [italian]', 'Estimate Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1593, 'proposals', 'proposal-expiry-reminder', 'italian', 'Proposal Expiration Reminder [italian]', 'Proposal Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1594, 'staff', 'new-staff-created', 'italian', 'New Staff Created (Welcome Email) [italian]', 'You are added as staff member', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1595, 'client', 'contact-forgot-password', 'italian', 'Forgot Password [italian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1596, 'client', 'contact-password-reseted', 'italian', 'Password Reset - Confirmation [italian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1597, 'client', 'contact-set-password', 'italian', 'Set New Password [italian]', 'Set new password on {companyname} ', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1598, 'staff', 'staff-forgot-password', 'italian', 'Forgot Password [italian]', 'Create New Password', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1599, 'staff', 'staff-password-reseted', 'italian', 'Password Reset - Confirmation [italian]', 'Your password has been changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1600, 'project', 'assigned-to-project', 'italian', 'New Project Created (Sent to Customer Contacts) [italian]', 'New Project Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1601, 'tasks', 'task-added-attachment-to-contacts', 'italian', 'New Attachment(s) on Task (Sent to Customer Contacts) [italian]', 'New Attachment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1602, 'tasks', 'task-commented-to-contacts', 'italian', 'New Comment on Task (Sent to Customer Contacts) [italian]', 'New Comment on Task - {task_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1603, 'leads', 'new-lead-assigned', 'italian', 'New Lead Assigned to Staff Member [italian]', 'New lead assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1604, 'client', 'client-statement', 'italian', 'Statement - Account Summary [italian]', 'Account Statement from {statement_from} to {statement_to}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1605, 'ticket', 'ticket-assigned-to-admin', 'italian', 'New Ticket Assigned (Sent to Staff) [italian]', 'New support ticket has been assigned to you', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1606, 'client', 'new-client-registered-to-admin', 'italian', 'New Customer Registration (Sent to admins) [italian]', 'New Customer Registration', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1607, 'leads', 'new-web-to-lead-form-submitted', 'italian', 'Web to lead form submitted - Sent to lead [italian]', '{lead_name} - We Received Your Request', '', '{companyname} | CRM', NULL, 0, 0, 0),
(1608, 'staff', 'two-factor-authentication', 'italian', 'Two Factor Authentication [italian]', 'Confirm Your Login', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1609, 'project', 'project-finished-to-customer', 'italian', 'Project Marked as Finished (Sent to Customer Contacts) [italian]', 'Project Marked as Finished', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1610, 'credit_note', 'credit-note-send-to-client', 'italian', 'Send Credit Note To Email [italian]', 'Credit Note With Number #{credit_note_number} Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1611, 'tasks', 'task-status-change-to-staff', 'italian', 'Task Status Changed (Sent to Staff) [italian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1612, 'tasks', 'task-status-change-to-contacts', 'italian', 'Task Status Changed (Sent to Customer Contacts) [italian]', 'Task Status Changed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1613, 'staff', 'reminder-email-staff', 'italian', 'Staff Reminder Email [italian]', 'You Have a New Reminder!', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1614, 'contract', 'contract-comment-to-client', 'italian', 'New Comment Â (Sent to Customer Contacts) [italian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1615, 'contract', 'contract-comment-to-admin', 'italian', 'New Comment (Sent to Staff)  [italian]', 'New Contract Comment', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1616, 'subscriptions', 'send-subscription', 'italian', 'Send Subscription to Customer [italian]', 'Subscription Created', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1617, 'subscriptions', 'subscription-payment-failed', 'italian', 'Subscription Payment Failed [italian]', 'Your most recent invoice payment failed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1618, 'subscriptions', 'subscription-canceled', 'italian', 'Subscription Canceled (Sent to customer primary contact) [italian]', 'Your subscription has been canceled', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1619, 'subscriptions', 'subscription-payment-succeeded', 'italian', 'Subscription Payment Succeeded (Sent to customer primary contact) [italian]', 'Subscription  Payment Receipt - {subscription_name}', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1620, 'contract', 'contract-expiration-to-staff', 'italian', 'Contract Expiration Reminder (Sent to Staff) [italian]', 'Contract Expiration Reminder', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1621, 'gdpr', 'gdpr-removal-request', 'italian', 'Removal Request From Contact (Sent to administrators) [italian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1622, 'gdpr', 'gdpr-removal-request-lead', 'italian', 'Removal Request From Lead (Sent to administrators) [italian]', 'Data Removal Request Received', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1623, 'client', 'client-registration-confirmed', 'italian', 'Customer Registration Confirmed [italian]', 'Your registration is confirmed', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1624, 'contract', 'contract-signed-to-staff', 'italian', 'Contract Signed (Sent to Staff) [italian]', 'Customer Signed a Contract', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1625, 'subscriptions', 'customer-subscribed-to-staff', 'italian', 'Customer Subscribed to a Subscription (Sent to administrators and subscription creator) [italian]', 'Customer Subscribed to a Subscription', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1626, 'client', 'contact-verification-email', 'italian', 'Email Verification (Sent to Contact After Registration) [italian]', 'Verify Email Address', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1627, 'client', 'new-customer-profile-file-uploaded-to-staff', 'italian', 'New Customer Profile File(s) Uploaded (Sent to Staff) [italian]', 'Customer Uploaded New File(s) in Profile', '', '{companyname} | CRM', NULL, 0, 1, 0),
(1628, 'staff', 'event-notification-to-staff', 'italian', 'Event Notification (Calendar) [italian]', 'Upcoming Event - {event_title}', '', '', NULL, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ms_estimates`
--

CREATE TABLE `ms_estimates` (
  `id` int(11) NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT 0,
  `datesend` datetime DEFAULT NULL,
  `clientid` int(11) NOT NULL,
  `deleted_customer_name` varchar(100) DEFAULT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `number` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `number_format` int(11) NOT NULL DEFAULT 0,
  `hash` varchar(32) DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `date` date NOT NULL,
  `expirydate` date DEFAULT NULL,
  `currency` int(11) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `total_tax` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total` decimal(15,2) NOT NULL,
  `adjustment` decimal(15,2) DEFAULT NULL,
  `addedfrom` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `clientnote` text DEFAULT NULL,
  `adminnote` text DEFAULT NULL,
  `discount_percent` decimal(15,2) DEFAULT 0.00,
  `discount_total` decimal(15,2) DEFAULT 0.00,
  `discount_type` varchar(30) DEFAULT NULL,
  `invoiceid` int(11) DEFAULT NULL,
  `invoiced_date` datetime DEFAULT NULL,
  `terms` text DEFAULT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `sale_agent` int(11) NOT NULL DEFAULT 0,
  `billing_street` varchar(200) DEFAULT NULL,
  `billing_city` varchar(100) DEFAULT NULL,
  `billing_state` varchar(100) DEFAULT NULL,
  `billing_zip` varchar(100) DEFAULT NULL,
  `billing_country` int(11) DEFAULT NULL,
  `shipping_street` varchar(200) DEFAULT NULL,
  `shipping_city` varchar(100) DEFAULT NULL,
  `shipping_state` varchar(100) DEFAULT NULL,
  `shipping_zip` varchar(100) DEFAULT NULL,
  `shipping_country` int(11) DEFAULT NULL,
  `include_shipping` tinyint(1) NOT NULL,
  `show_shipping_on_estimate` tinyint(1) NOT NULL DEFAULT 1,
  `show_quantity_as` int(11) NOT NULL DEFAULT 1,
  `pipeline_order` int(11) NOT NULL DEFAULT 0,
  `is_expiry_notified` int(11) NOT NULL DEFAULT 0,
  `acceptance_firstname` varchar(50) DEFAULT NULL,
  `acceptance_lastname` varchar(50) DEFAULT NULL,
  `acceptance_email` varchar(100) DEFAULT NULL,
  `acceptance_date` datetime DEFAULT NULL,
  `acceptance_ip` varchar(40) DEFAULT NULL,
  `signature` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_events`
--

CREATE TABLE `ms_events` (
  `eventid` int(11) NOT NULL,
  `title` mediumtext NOT NULL,
  `description` text DEFAULT NULL,
  `userid` int(11) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `public` int(11) NOT NULL DEFAULT 0,
  `color` varchar(10) DEFAULT NULL,
  `isstartnotified` tinyint(1) NOT NULL DEFAULT 0,
  `reminder_before` int(11) NOT NULL DEFAULT 0,
  `reminder_before_type` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_expenses`
--

CREATE TABLE `ms_expenses` (
  `id` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `currency` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `tax` int(11) DEFAULT NULL,
  `tax2` int(11) NOT NULL DEFAULT 0,
  `reference_no` varchar(100) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `expense_name` varchar(191) DEFAULT NULL,
  `clientid` int(11) NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `billable` int(11) DEFAULT 0,
  `invoiceid` int(11) DEFAULT NULL,
  `paymentmode` varchar(50) DEFAULT NULL,
  `date` date NOT NULL,
  `recurring_type` varchar(10) DEFAULT NULL,
  `repeat_every` int(11) DEFAULT NULL,
  `recurring` int(11) NOT NULL DEFAULT 0,
  `cycles` int(11) NOT NULL DEFAULT 0,
  `total_cycles` int(11) NOT NULL DEFAULT 0,
  `custom_recurring` int(11) NOT NULL DEFAULT 0,
  `last_recurring_date` date DEFAULT NULL,
  `create_invoice_billable` tinyint(1) DEFAULT NULL,
  `send_invoice_to_customer` tinyint(1) NOT NULL,
  `recurring_from` int(11) DEFAULT NULL,
  `dateadded` datetime NOT NULL,
  `addedfrom` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_expenses_categories`
--

CREATE TABLE `ms_expenses_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_files`
--

CREATE TABLE `ms_files` (
  `id` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(20) NOT NULL,
  `file_name` varchar(191) NOT NULL,
  `filetype` varchar(40) DEFAULT NULL,
  `visible_to_customer` int(11) NOT NULL DEFAULT 0,
  `attachment_key` varchar(32) DEFAULT NULL,
  `external` varchar(40) DEFAULT NULL,
  `external_link` text DEFAULT NULL,
  `thumbnail_link` text DEFAULT NULL COMMENT 'For external usage',
  `staffid` int(11) NOT NULL,
  `contact_id` int(11) DEFAULT 0,
  `task_comment_id` int(11) NOT NULL DEFAULT 0,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_form_questions`
--

CREATE TABLE `ms_form_questions` (
  `questionid` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(20) DEFAULT NULL,
  `question` mediumtext NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `question_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_form_questions`
--

INSERT INTO `ms_form_questions` (`questionid`, `rel_id`, `rel_type`, `question`, `required`, `question_order`) VALUES
(1, 1, 'survey', 'Do you like service?', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_form_question_box`
--

CREATE TABLE `ms_form_question_box` (
  `boxid` int(11) NOT NULL,
  `boxtype` varchar(10) NOT NULL,
  `questionid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_form_question_box`
--

INSERT INTO `ms_form_question_box` (`boxid`, `boxtype`, `questionid`) VALUES
(1, 'radio', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_form_question_box_description`
--

CREATE TABLE `ms_form_question_box_description` (
  `questionboxdescriptionid` int(11) NOT NULL,
  `description` mediumtext NOT NULL,
  `boxid` mediumtext NOT NULL,
  `questionid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_form_question_box_description`
--

INSERT INTO `ms_form_question_box_description` (`questionboxdescriptionid`, `description`, `boxid`, `questionid`) VALUES
(1, 'Yes', '1', 1),
(2, 'No', '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_form_results`
--

CREATE TABLE `ms_form_results` (
  `resultid` int(11) NOT NULL,
  `boxid` int(11) NOT NULL,
  `boxdescriptionid` int(11) DEFAULT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(20) DEFAULT NULL,
  `questionid` int(11) NOT NULL,
  `answer` text DEFAULT NULL,
  `resultsetid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_form_results`
--

INSERT INTO `ms_form_results` (`resultid`, `boxid`, `boxdescriptionid`, `rel_id`, `rel_type`, `questionid`, `answer`, `resultsetid`) VALUES
(1, 1, 1, 1, 'survey', 1, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_gdpr_requests`
--

CREATE TABLE `ms_gdpr_requests` (
  `id` int(11) NOT NULL,
  `clientid` int(11) NOT NULL DEFAULT 0,
  `contact_id` int(11) NOT NULL DEFAULT 0,
  `lead_id` int(11) NOT NULL DEFAULT 0,
  `request_type` varchar(191) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  `request_date` datetime NOT NULL,
  `request_from` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_goals`
--

CREATE TABLE `ms_goals` (
  `id` int(11) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `goal_type` int(11) NOT NULL,
  `contract_type` int(11) NOT NULL DEFAULT 0,
  `achievement` int(11) NOT NULL,
  `notify_when_fail` tinyint(1) NOT NULL DEFAULT 1,
  `notify_when_achieve` tinyint(1) NOT NULL DEFAULT 1,
  `notified` int(11) NOT NULL DEFAULT 0,
  `staff_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_goals`
--

INSERT INTO `ms_goals` (`id`, `subject`, `description`, `start_date`, `end_date`, `goal_type`, `contract_type`, `achievement`, `notify_when_fail`, `notify_when_achieve`, `notified`, `staff_id`) VALUES
(1, 'Rahul goal for lead conversion', '', '2019-07-12', '2019-07-31', 2, 0, 0, 1, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_invoicepaymentrecords`
--

CREATE TABLE `ms_invoicepaymentrecords` (
  `id` int(11) NOT NULL,
  `invoiceid` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `paymentmode` varchar(40) DEFAULT NULL,
  `paymentmethod` varchar(191) DEFAULT NULL,
  `date` date NOT NULL,
  `daterecorded` datetime NOT NULL,
  `note` text NOT NULL,
  `transactionid` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_invoices`
--

CREATE TABLE `ms_invoices` (
  `id` int(11) NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT 0,
  `datesend` datetime DEFAULT NULL,
  `clientid` int(11) NOT NULL,
  `deleted_customer_name` varchar(100) DEFAULT NULL,
  `number` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `number_format` int(11) NOT NULL DEFAULT 0,
  `datecreated` datetime NOT NULL,
  `date` date NOT NULL,
  `duedate` date DEFAULT NULL,
  `currency` int(11) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `total_tax` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total` decimal(15,2) NOT NULL,
  `adjustment` decimal(15,2) DEFAULT NULL,
  `addedfrom` int(11) DEFAULT NULL,
  `hash` varchar(32) NOT NULL,
  `status` int(11) DEFAULT 1,
  `clientnote` text DEFAULT NULL,
  `adminnote` text DEFAULT NULL,
  `last_overdue_reminder` date DEFAULT NULL,
  `cancel_overdue_reminders` int(11) NOT NULL DEFAULT 0,
  `allowed_payment_modes` mediumtext DEFAULT NULL,
  `token` mediumtext DEFAULT NULL,
  `discount_percent` decimal(15,2) DEFAULT 0.00,
  `discount_total` decimal(15,2) DEFAULT 0.00,
  `discount_type` varchar(30) NOT NULL,
  `recurring` int(11) NOT NULL DEFAULT 0,
  `recurring_type` varchar(10) DEFAULT NULL,
  `custom_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `cycles` int(11) NOT NULL DEFAULT 0,
  `total_cycles` int(11) NOT NULL DEFAULT 0,
  `is_recurring_from` int(11) DEFAULT NULL,
  `last_recurring_date` date DEFAULT NULL,
  `terms` text DEFAULT NULL,
  `sale_agent` int(11) NOT NULL DEFAULT 0,
  `billing_street` varchar(200) DEFAULT NULL,
  `billing_city` varchar(100) DEFAULT NULL,
  `billing_state` varchar(100) DEFAULT NULL,
  `billing_zip` varchar(100) DEFAULT NULL,
  `billing_country` int(11) DEFAULT NULL,
  `shipping_street` varchar(200) DEFAULT NULL,
  `shipping_city` varchar(100) DEFAULT NULL,
  `shipping_state` varchar(100) DEFAULT NULL,
  `shipping_zip` varchar(100) DEFAULT NULL,
  `shipping_country` int(11) DEFAULT NULL,
  `include_shipping` tinyint(1) NOT NULL,
  `show_shipping_on_invoice` tinyint(1) NOT NULL DEFAULT 1,
  `show_quantity_as` int(11) NOT NULL DEFAULT 1,
  `project_id` int(11) DEFAULT 0,
  `subscription_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_itemable`
--

CREATE TABLE `ms_itemable` (
  `id` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(15) NOT NULL,
  `description` mediumtext NOT NULL,
  `long_description` mediumtext DEFAULT NULL,
  `qty` decimal(15,2) NOT NULL,
  `rate` decimal(15,2) NOT NULL,
  `unit` varchar(40) DEFAULT NULL,
  `item_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_items`
--

CREATE TABLE `ms_items` (
  `id` int(11) NOT NULL,
  `description` mediumtext NOT NULL,
  `long_description` text DEFAULT NULL,
  `rate` decimal(15,2) NOT NULL,
  `tax` int(11) DEFAULT NULL,
  `tax2` int(11) DEFAULT NULL,
  `unit` varchar(40) DEFAULT NULL,
  `group_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_items`
--

INSERT INTO `ms_items` (`id`, `description`, `long_description`, `rate`, `tax`, `tax2`, `unit`, `group_id`) VALUES
(2, 'caramel con', '', 100.00, NULL, NULL, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ms_items_groups`
--

CREATE TABLE `ms_items_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_item_tax`
--

CREATE TABLE `ms_item_tax` (
  `id` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(20) NOT NULL,
  `taxrate` decimal(15,2) NOT NULL,
  `taxname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_knowedge_base_article_feedback`
--

CREATE TABLE `ms_knowedge_base_article_feedback` (
  `articleanswerid` int(11) NOT NULL,
  `articleid` int(11) NOT NULL,
  `answer` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_knowledge_base`
--

CREATE TABLE `ms_knowledge_base` (
  `articleid` int(11) NOT NULL,
  `articlegroup` int(11) NOT NULL,
  `subject` mediumtext NOT NULL,
  `description` text NOT NULL,
  `slug` mediumtext NOT NULL,
  `active` tinyint(4) NOT NULL,
  `datecreated` datetime NOT NULL,
  `article_order` int(11) NOT NULL DEFAULT 0,
  `staff_article` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_knowledge_base_groups`
--

CREATE TABLE `ms_knowledge_base_groups` (
  `groupid` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `group_slug` text DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `color` varchar(10) DEFAULT '#28B8DA',
  `group_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_leads`
--

CREATE TABLE `ms_leads` (
  `id` int(11) NOT NULL,
  `hash` varchar(65) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `company` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `country` int(11) NOT NULL DEFAULT 0,
  `zip` varchar(15) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `assigned` int(11) NOT NULL DEFAULT 0,
  `dateadded` datetime NOT NULL,
  `from_form_id` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `lastcontact` datetime DEFAULT NULL,
  `dateassigned` date DEFAULT NULL,
  `last_status_change` datetime DEFAULT NULL,
  `addedfrom` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(150) DEFAULT NULL,
  `leadorder` int(11) DEFAULT 1,
  `phonenumber` varchar(50) DEFAULT NULL,
  `date_converted` datetime DEFAULT NULL,
  `lost` tinyint(1) NOT NULL DEFAULT 0,
  `junk` int(11) NOT NULL DEFAULT 0,
  `last_lead_status` int(11) NOT NULL DEFAULT 0,
  `is_imported_from_email_integration` tinyint(1) NOT NULL DEFAULT 0,
  `email_integration_uid` varchar(30) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `default_language` varchar(40) DEFAULT NULL,
  `client_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_leads_email_integration`
--

CREATE TABLE `ms_leads_email_integration` (
  `id` int(11) NOT NULL COMMENT 'the ID always must be 1',
  `active` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `imap_server` varchar(100) NOT NULL,
  `password` mediumtext NOT NULL,
  `check_every` int(11) NOT NULL DEFAULT 5,
  `responsible` int(11) NOT NULL,
  `lead_source` int(11) NOT NULL,
  `lead_status` int(11) NOT NULL,
  `encryption` varchar(3) DEFAULT NULL,
  `folder` varchar(100) NOT NULL,
  `last_run` varchar(50) DEFAULT NULL,
  `notify_lead_imported` tinyint(1) NOT NULL DEFAULT 1,
  `notify_lead_contact_more_times` tinyint(1) NOT NULL DEFAULT 1,
  `notify_type` varchar(20) DEFAULT NULL,
  `notify_ids` mediumtext DEFAULT NULL,
  `mark_public` int(11) NOT NULL DEFAULT 0,
  `only_loop_on_unseen_emails` tinyint(1) NOT NULL DEFAULT 1,
  `delete_after_import` int(11) NOT NULL DEFAULT 0,
  `create_task_if_customer` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_leads_email_integration`
--

INSERT INTO `ms_leads_email_integration` (`id`, `active`, `email`, `imap_server`, `password`, `check_every`, `responsible`, `lead_source`, `lead_status`, `encryption`, `folder`, `last_run`, `notify_lead_imported`, `notify_lead_contact_more_times`, `notify_type`, `notify_ids`, `mark_public`, `only_loop_on_unseen_emails`, `delete_after_import`, `create_task_if_customer`) VALUES
(1, 0, '', '', '', 10, 0, 0, 0, 'tls', 'inbox', '', 1, 1, 'assigned', '', 0, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_leads_sources`
--

CREATE TABLE `ms_leads_sources` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_leads_sources`
--

INSERT INTO `ms_leads_sources` (`id`, `name`) VALUES
(5, 'Direct Call'),
(6, 'Direct Message'),
(2, 'Facebook'),
(1, 'Google'),
(4, 'Instagram'),
(7, 'Other'),
(8, 'Software application form'),
(3, 'Website');

-- --------------------------------------------------------

--
-- Table structure for table `ms_leads_status`
--

CREATE TABLE `ms_leads_status` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `statusorder` int(11) DEFAULT NULL,
  `color` varchar(10) DEFAULT '#28B8DA',
  `isdefault` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_leads_status`
--

INSERT INTO `ms_leads_status` (`id`, `name`, `statusorder`, `color`, `isdefault`) VALUES
(1, 'Customer', 1000, '#7cb342', 1),
(2, 'New', 2, '#28B8DA', 0),
(3, 'Contacted', 3, '#28B8DA', 0),
(4, 'On Hold', 4, '#28B8DA', 0),
(5, 'Not Interested', 5, '#28B8DA', 0),
(6, 'Follow up in a Day', 6, '#28B8DA', 0),
(7, 'Follow up in 2 days', 7, '#28B8DA', 0),
(8, 'Unqualified', 8, '#28B8DA', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ms_lead_activity_log`
--

CREATE TABLE `ms_lead_activity_log` (
  `id` int(11) NOT NULL,
  `leadid` int(11) NOT NULL,
  `description` mediumtext NOT NULL,
  `additional_data` text DEFAULT NULL,
  `date` datetime NOT NULL,
  `staffid` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `custom_activity` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_lead_integration_emails`
--

CREATE TABLE `ms_lead_integration_emails` (
  `id` int(11) NOT NULL,
  `subject` mediumtext DEFAULT NULL,
  `body` mediumtext DEFAULT NULL,
  `dateadded` datetime NOT NULL,
  `leadid` int(11) NOT NULL,
  `emailid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_listemails`
--

CREATE TABLE `ms_listemails` (
  `emailid` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_maillistscustomfields`
--

CREATE TABLE `ms_maillistscustomfields` (
  `customfieldid` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `fieldname` varchar(150) NOT NULL,
  `fieldslug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_maillistscustomfieldvalues`
--

CREATE TABLE `ms_maillistscustomfieldvalues` (
  `customfieldvalueid` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `customfieldid` int(11) NOT NULL,
  `emailid` int(11) NOT NULL,
  `value` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_mail_queue`
--

CREATE TABLE `ms_mail_queue` (
  `id` int(11) NOT NULL,
  `engine` varchar(40) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `cc` text DEFAULT NULL,
  `bcc` text DEFAULT NULL,
  `message` mediumtext NOT NULL,
  `alt_message` mediumtext DEFAULT NULL,
  `status` enum('pending','sending','sent','failed') DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `headers` text DEFAULT NULL,
  `attachments` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_migrations`
--

CREATE TABLE `ms_migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_migrations`
--

INSERT INTO `ms_migrations` (`version`) VALUES
(235);

-- --------------------------------------------------------

--
-- Table structure for table `ms_milestones`
--

CREATE TABLE `ms_milestones` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `description_visible_to_customer` tinyint(1) DEFAULT 0,
  `due_date` date NOT NULL,
  `project_id` int(11) NOT NULL,
  `color` varchar(10) DEFAULT NULL,
  `milestone_order` int(11) NOT NULL DEFAULT 0,
  `datecreated` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_modules`
--

CREATE TABLE `ms_modules` (
  `id` int(11) NOT NULL,
  `module_name` varchar(55) NOT NULL,
  `installed_version` varchar(11) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_modules`
--

INSERT INTO `ms_modules` (`id`, `module_name`, `installed_version`, `active`) VALUES
(1, 'backup', '2.3.0', 1),
(2, 'surveys', '2.3.0', 1),
(3, 'goals', '2.3.0', 1),
(4, 'theme_style', '2.3.0', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_newsfeed_comment_likes`
--

CREATE TABLE `ms_newsfeed_comment_likes` (
  `id` int(11) NOT NULL,
  `postid` int(11) NOT NULL,
  `commentid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `dateliked` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_newsfeed_posts`
--

CREATE TABLE `ms_newsfeed_posts` (
  `postid` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `datecreated` datetime NOT NULL,
  `visibility` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `pinned` int(11) NOT NULL,
  `datepinned` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_newsfeed_post_comments`
--

CREATE TABLE `ms_newsfeed_post_comments` (
  `id` int(11) NOT NULL,
  `content` text DEFAULT NULL,
  `userid` int(11) NOT NULL,
  `postid` int(11) NOT NULL,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_newsfeed_post_likes`
--

CREATE TABLE `ms_newsfeed_post_likes` (
  `id` int(11) NOT NULL,
  `postid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `dateliked` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_notes`
--

CREATE TABLE `ms_notes` (
  `id` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `date_contacted` datetime DEFAULT NULL,
  `addedfrom` int(11) NOT NULL,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_notifications`
--

CREATE TABLE `ms_notifications` (
  `id` int(11) NOT NULL,
  `isread` int(11) NOT NULL DEFAULT 0,
  `isread_inline` tinyint(1) NOT NULL DEFAULT 0,
  `date` datetime NOT NULL,
  `description` text NOT NULL,
  `fromuserid` int(11) NOT NULL,
  `fromclientid` int(11) NOT NULL DEFAULT 0,
  `from_fullname` varchar(100) NOT NULL,
  `touserid` int(11) NOT NULL,
  `fromcompany` int(11) DEFAULT NULL,
  `link` mediumtext DEFAULT NULL,
  `additional_data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_options`
--

CREATE TABLE `ms_options` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `value` longtext NOT NULL,
  `autoload` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_options`
--

INSERT INTO `ms_options` (`id`, `name`, `value`, `autoload`) VALUES
(1, 'dateformat', 'Y-m-d|%Y-%m-%d', 1),
(2, 'companyname', 'Foogle Tech Software', 1),
(3, 'services', '1', 1),
(4, 'maximum_allowed_ticket_attachments', '4', 1),
(5, 'ticket_attachments_file_extensions', '.jpg,.png,.pdf,.doc,.zip,.rar', 1),
(6, 'staff_access_only_assigned_departments', '1', 1),
(7, 'use_knowledge_base', '1', 1),
(8, 'smtp_email', '', 1),
(9, 'smtp_password', '', 1),
(10, 'company_info_format', '{company_name}<br />\r\n{address}<br />\r\n{city} {state}<br />\r\n{country_code} {zip_code}<br />\r\n{vat_number_with_label}', 0),
(11, 'smtp_port', '', 1),
(12, 'smtp_host', '', 1),
(13, 'smtp_email_charset', 'utf-8', 1),
(14, 'default_timezone', 'Asia/Kolkata', 1),
(15, 'clients_default_theme', 'perfex', 1),
(16, 'company_logo', 'logo.png', 1),
(17, 'tables_pagination_limit', '25', 1),
(18, 'main_domain', '', 1),
(19, 'allow_registration', '0', 1),
(20, 'knowledge_base_without_registration', '1', 1),
(21, 'email_signature', '', 1),
(22, 'default_staff_role', '1', 1),
(23, 'newsfeed_maximum_files_upload', '10', 1),
(24, 'contract_expiration_before', '4', 1),
(25, 'invoice_prefix', 'INV-', 1),
(26, 'decimal_separator', '.', 1),
(27, 'thousand_separator', ',', 1),
(28, 'invoice_company_name', 'EGGManiac', 1),
(29, 'invoice_company_address', 'Adajan', 1),
(30, 'invoice_company_city', 'Surat', 1),
(31, 'invoice_company_country_code', '91', 1),
(32, 'invoice_company_postal_code', '', 1),
(33, 'invoice_company_phonenumber', '8588811009', 1),
(34, 'view_invoice_only_logged_in', '0', 1),
(35, 'invoice_number_format', '1', 1),
(36, 'next_invoice_number', '1', 0),
(37, 'active_language', 'english', 1),
(38, 'invoice_number_decrement_on_delete', '1', 1),
(39, 'automatically_send_invoice_overdue_reminder_after', '1', 1),
(40, 'automatically_resend_invoice_overdue_reminder_after', '3', 1),
(41, 'expenses_auto_operations_hour', '21', 1),
(42, 'delete_only_on_last_invoice', '1', 1),
(43, 'delete_only_on_last_estimate', '1', 1),
(44, 'create_invoice_from_recurring_only_on_paid_invoices', '0', 1),
(45, 'allow_payment_amount_to_be_modified', '1', 1),
(46, 'rtl_support_client', '0', 1),
(47, 'limit_top_search_bar_results_to', '10', 1),
(48, 'estimate_prefix', 'EST-', 1),
(49, 'next_estimate_number', '1', 0),
(50, 'estimate_number_decrement_on_delete', '1', 1),
(51, 'estimate_number_format', '1', 1),
(52, 'estimate_auto_convert_to_invoice_on_client_accept', '1', 1),
(53, 'exclude_estimate_from_client_area_with_draft_status', '1', 1),
(54, 'rtl_support_admin', '0', 1),
(55, 'last_cron_run', '', 1),
(56, 'show_sale_agent_on_estimates', '1', 1),
(57, 'show_sale_agent_on_invoices', '1', 1),
(58, 'predefined_terms_invoice', '', 1),
(59, 'predefined_terms_estimate', '', 1),
(60, 'default_task_priority', '2', 1),
(61, 'dropbox_app_key', '', 1),
(62, 'show_expense_reminders_on_calendar', '1', 1),
(63, 'only_show_contact_tickets', '1', 1),
(64, 'predefined_clientnote_invoice', '', 1),
(65, 'predefined_clientnote_estimate', '', 1),
(66, 'custom_pdf_logo_image_url', '', 1),
(67, 'favicon', 'favicon.ico', 1),
(68, 'invoice_due_after', '30', 1),
(69, 'google_api_key', '', 1),
(70, 'google_calendar_main_calendar', '', 1),
(71, 'default_tax', 'a:0:{}', 1),
(72, 'show_invoices_on_calendar', '1', 1),
(73, 'show_estimates_on_calendar', '1', 1),
(74, 'show_contracts_on_calendar', '1', 1),
(75, 'show_tasks_on_calendar', '1', 1),
(76, 'show_customer_reminders_on_calendar', '1', 1),
(77, 'output_client_pdfs_from_admin_area_in_client_language', '0', 1),
(78, 'show_lead_reminders_on_calendar', '1', 1),
(79, 'send_estimate_expiry_reminder_before', '4', 1),
(80, 'leads_default_source', '', 1),
(81, 'leads_default_status', '', 1),
(82, 'proposal_expiry_reminder_enabled', '1', 1),
(83, 'send_proposal_expiry_reminder_before', '4', 1),
(84, 'default_contact_permissions', 'a:6:{i:0;s:1:\"1\";i:1;s:1:\"2\";i:2;s:1:\"3\";i:3;s:1:\"4\";i:4;s:1:\"5\";i:5;s:1:\"6\";}', 1),
(85, 'pdf_logo_width', '150', 1),
(86, 'access_tickets_to_none_staff_members', '0', 1),
(87, 'customer_default_country', '', 1),
(88, 'view_estimate_only_logged_in', '0', 1),
(89, 'show_status_on_pdf_ei', '1', 1),
(90, 'email_piping_only_replies', '0', 1),
(91, 'email_piping_only_registered', '0', 1),
(92, 'default_view_calendar', 'month', 1),
(93, 'email_piping_default_priority', '2', 1),
(94, 'total_to_words_lowercase', '0', 1),
(95, 'show_tax_per_item', '1', 1),
(96, 'total_to_words_enabled', '0', 1),
(97, 'receive_notification_on_new_ticket', '1', 0),
(98, 'autoclose_tickets_after', '0', 1),
(99, 'media_max_file_size_upload', '10', 1),
(100, 'client_staff_add_edit_delete_task_comments_first_hour', '0', 1),
(101, 'show_projects_on_calendar', '1', 1),
(102, 'leads_kanban_limit', '50', 1),
(103, 'tasks_reminder_notification_before', '2', 1),
(104, 'pdf_font', 'freesans', 1),
(105, 'pdf_table_heading_color', '#323a45', 1),
(106, 'pdf_table_heading_text_color', '#ffffff', 1),
(107, 'pdf_font_size', '10', 1),
(108, 'default_leads_kanban_sort', 'leadorder', 1),
(109, 'default_leads_kanban_sort_type', 'asc', 1),
(110, 'allowed_files', '.png,.jpg,.pdf,.doc,.docx,.xls,.xlsx,.zip,.rar,.txt', 1),
(111, 'show_all_tasks_for_project_member', '1', 1),
(112, 'email_protocol', 'smtp', 1),
(113, 'calendar_first_day', '0', 1),
(114, 'recaptcha_secret_key', '', 1),
(115, 'show_help_on_setup_menu', '1', 1),
(116, 'show_proposals_on_calendar', '1', 1),
(117, 'smtp_encryption', '', 1),
(118, 'recaptcha_site_key', '', 1),
(119, 'smtp_username', '', 1),
(120, 'auto_stop_tasks_timers_on_new_timer', '1', 1),
(121, 'notification_when_customer_pay_invoice', '1', 1),
(122, 'calendar_invoice_color', '#FF6F00', 1),
(123, 'calendar_estimate_color', '#FF6F00', 1),
(124, 'calendar_proposal_color', '#84c529', 1),
(125, 'new_task_auto_assign_current_member', '1', 1),
(126, 'calendar_reminder_color', '#03A9F4', 1),
(127, 'calendar_contract_color', '#B72974', 1),
(128, 'calendar_project_color', '#B72974', 1),
(129, 'update_info_message', '', 1),
(130, 'show_estimate_reminders_on_calendar', '1', 1),
(131, 'show_invoice_reminders_on_calendar', '1', 1),
(132, 'show_proposal_reminders_on_calendar', '1', 1),
(133, 'proposal_due_after', '7', 1),
(134, 'allow_customer_to_change_ticket_status', '0', 1),
(135, 'lead_lock_after_convert_to_customer', '0', 1),
(136, 'default_proposals_pipeline_sort', 'pipeline_order', 1),
(137, 'default_proposals_pipeline_sort_type', 'asc', 1),
(138, 'default_estimates_pipeline_sort', 'pipeline_order', 1),
(139, 'default_estimates_pipeline_sort_type', 'asc', 1),
(140, 'use_recaptcha_customers_area', '0', 1),
(141, 'remove_decimals_on_zero', '0', 1),
(142, 'remove_tax_name_from_item_table', '0', 1),
(143, 'pdf_format_invoice', 'A4-PORTRAIT', 1),
(144, 'pdf_format_estimate', 'A4-PORTRAIT', 1),
(145, 'pdf_format_proposal', 'A4-PORTRAIT', 1),
(146, 'pdf_format_payment', 'A4-PORTRAIT', 1),
(147, 'pdf_format_contract', 'A4-PORTRAIT', 1),
(148, 'swap_pdf_info', '0', 1),
(149, 'exclude_invoice_from_client_area_with_draft_status', '1', 1),
(150, 'cron_has_run_from_cli', '0', 1),
(151, 'hide_cron_is_required_message', '0', 0),
(152, 'auto_assign_customer_admin_after_lead_convert', '1', 1),
(153, 'show_transactions_on_invoice_pdf', '1', 1),
(154, 'show_pay_link_to_invoice_pdf', '1', 1),
(155, 'tasks_kanban_limit', '50', 1),
(156, 'purchase_key', '', 1),
(157, 'estimates_pipeline_limit', '50', 1),
(158, 'proposals_pipeline_limit', '50', 1),
(159, 'proposal_number_prefix', 'PRO-', 1),
(160, 'number_padding_prefixes', '6', 1),
(161, 'show_page_number_on_pdf', '0', 1),
(162, 'calendar_events_limit', '4', 1),
(163, 'show_setup_menu_item_only_on_hover', '0', 1),
(164, 'company_requires_vat_number_field', '1', 1),
(165, 'company_is_required', '1', 1),
(166, 'allow_contact_to_delete_files', '0', 1),
(167, 'company_vat', '', 1),
(168, 'di', '1562754991', 1),
(169, 'invoice_auto_operations_hour', '21', 1),
(170, 'use_minified_files', '1', 1),
(171, 'only_own_files_contacts', '0', 1),
(172, 'allow_primary_contact_to_view_edit_billing_and_shipping', '0', 1),
(173, 'estimate_due_after', '7', 1),
(174, 'staff_members_open_tickets_to_all_contacts', '1', 1),
(175, 'time_format', '24', 1),
(176, 'delete_activity_log_older_then', '1', 1),
(177, 'disable_language', '0', 1),
(178, 'company_state', 'Gujarat', 1),
(179, 'email_header', '<!doctype html>\n                            <html>\n                            <head>\n                              <meta name=\"viewport\" content=\"width=device-width\" />\n                              <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n                              <style>\n                                body {\n                                 background-color: #f6f6f6;\n                                 font-family: sans-serif;\n                                 -webkit-font-smoothing: antialiased;\n                                 font-size: 14px;\n                                 line-height: 1.4;\n                                 margin: 0;\n                                 padding: 0;\n                                 -ms-text-size-adjust: 100%;\n                                 -webkit-text-size-adjust: 100%;\n                               }\n                               table {\n                                 border-collapse: separate;\n                                 mso-table-lspace: 0pt;\n                                 mso-table-rspace: 0pt;\n                                 width: 100%;\n                               }\n                               table td {\n                                 font-family: sans-serif;\n                                 font-size: 14px;\n                                 vertical-align: top;\n                               }\n                                   /* -------------------------------------\n                                     BODY & CONTAINER\n                                     ------------------------------------- */\n                                     .body {\n                                       background-color: #f6f6f6;\n                                       width: 100%;\n                                     }\n                                     /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */\n\n                                     .container {\n                                       display: block;\n                                       margin: 0 auto !important;\n                                       /* makes it centered */\n                                       max-width: 680px;\n                                       padding: 10px;\n                                       width: 680px;\n                                     }\n                                     /* This should also be a block element, so that it will fill 100% of the .container */\n\n                                     .content {\n                                       box-sizing: border-box;\n                                       display: block;\n                                       margin: 0 auto;\n                                       max-width: 680px;\n                                       padding: 10px;\n                                     }\n                                   /* -------------------------------------\n                                     HEADER, FOOTER, MAIN\n                                     ------------------------------------- */\n\n                                     .main {\n                                       background: #fff;\n                                       border-radius: 3px;\n                                       width: 100%;\n                                     }\n                                     .wrapper {\n                                       box-sizing: border-box;\n                                       padding: 20px;\n                                     }\n                                     .footer {\n                                       clear: both;\n                                       padding-top: 10px;\n                                       text-align: center;\n                                       width: 100%;\n                                     }\n                                     .footer td,\n                                     .footer p,\n                                     .footer span,\n                                     .footer a {\n                                       color: #999999;\n                                       font-size: 12px;\n                                       text-align: center;\n                                     }\n                                     hr {\n                                       border: 0;\n                                       border-bottom: 1px solid #f6f6f6;\n                                       margin: 20px 0;\n                                     }\n                                   /* -------------------------------------\n                                     RESPONSIVE AND MOBILE FRIENDLY STYLES\n                                     ------------------------------------- */\n\n                                     @media only screen and (max-width: 620px) {\n                                       table[class=body] .content {\n                                         padding: 0 !important;\n                                       }\n                                       table[class=body] .container {\n                                         padding: 0 !important;\n                                         width: 100% !important;\n                                       }\n                                       table[class=body] .main {\n                                         border-left-width: 0 !important;\n                                         border-radius: 0 !important;\n                                         border-right-width: 0 !important;\n                                       }\n                                     }\n                                   </style>\n                                 </head>\n                                 <body class=\"\">\n                                  <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"body\">\n                                    <tr>\n                                     <td>&nbsp;</td>\n                                     <td class=\"container\">\n                                      <div class=\"content\">\n                                        <!-- START CENTERED WHITE CONTAINER -->\n                                        <table class=\"main\">\n                                          <!-- START MAIN CONTENT AREA -->\n                                          <tr>\n                                           <td class=\"wrapper\">\n                                            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                                              <tr>\n                                               <td>', 1),
(180, 'show_pdf_signature_invoice', '1', 0),
(181, 'show_pdf_signature_estimate', '1', 0),
(182, 'signature_image', '', 0),
(183, 'scroll_responsive_tables', '0', 1),
(184, 'email_footer', '</td>\n                             </tr>\n                           </table>\n                         </td>\n                       </tr>\n                       <!-- END MAIN CONTENT AREA -->\n                     </table>\n                     <!-- START FOOTER -->\n                     <div class=\"footer\">\n                      <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n                        <tr>\n                          <td class=\"content-block\">\n                            <span>{companyname}</span>\n                          </td>\n                        </tr>\n                      </table>\n                    </div>\n                    <!-- END FOOTER -->\n                    <!-- END CENTERED WHITE CONTAINER -->\n                  </div>\n                </td>\n                <td>&nbsp;</td>\n              </tr>\n            </table>\n            </body>\n            </html>', 1),
(185, 'exclude_proposal_from_client_area_with_draft_status', '1', 1),
(186, 'pusher_app_key', '', 1),
(187, 'pusher_app_secret', '', 1),
(188, 'pusher_app_id', '', 1),
(189, 'pusher_realtime_notifications', '0', 1),
(190, 'pdf_format_statement', 'A4-PORTRAIT', 1),
(191, 'pusher_cluster', '', 1),
(192, 'show_table_export_button', 'to_all', 1),
(193, 'allow_staff_view_proposals_assigned', '1', 1),
(194, 'show_cloudflare_notice', '1', 0),
(195, 'task_modal_class', 'modal-lg', 1),
(196, 'lead_modal_class', 'modal-lg', 1),
(197, 'show_timesheets_overview_all_members_notice_admins', '1', 0),
(198, 'desktop_notifications', '0', 1),
(199, 'hide_notified_reminders_from_calendar', '1', 0),
(200, 'customer_info_format', '{company_name}<br />\r\n{street}<br />\r\n{city} {state}<br />\r\n{country_code} {zip_code}<br />\r\n{vat_number_with_label}', 0),
(201, 'timer_started_change_status_in_progress', '1', 0),
(202, 'default_ticket_reply_status', '3', 1),
(203, 'default_task_status', 'auto', 1),
(204, 'email_queue_skip_with_attachments', '1', 1),
(205, 'email_queue_enabled', '0', 1),
(206, 'last_email_queue_retry', '', 1),
(207, 'auto_dismiss_desktop_notifications_after', '0', 1),
(208, 'proposal_info_format', '{proposal_to}<br />\r\n{address}<br />\r\n{city} {state}<br />\r\n{country_code} {zip_code}<br />\r\n{phone}<br />\r\n{email}', 0),
(209, 'ticket_replies_order', 'asc', 1),
(210, 'new_recurring_invoice_action', 'generate_and_send', 0),
(211, 'bcc_emails', '', 0);
INSERT INTO `ms_options` (`id`, `name`, `value`, `autoload`) VALUES
(212, 'email_templates_language_checks', 'a:1554:{s:26:\"new-client-created-swedish\";i:1;s:30:\"invoice-send-to-client-swedish\";i:1;s:31:\"new-ticket-opened-admin-swedish\";i:1;s:20:\"ticket-reply-swedish\";i:1;s:27:\"ticket-autoresponse-swedish\";i:1;s:32:\"invoice-payment-recorded-swedish\";i:1;s:30:\"invoice-overdue-notice-swedish\";i:1;s:28:\"invoice-already-send-swedish\";i:1;s:32:\"new-ticket-created-staff-swedish\";i:1;s:31:\"estimate-send-to-client-swedish\";i:1;s:29:\"ticket-reply-to-admin-swedish\";i:1;s:29:\"estimate-already-send-swedish\";i:1;s:27:\"contract-expiration-swedish\";i:1;s:21:\"task-assigned-swedish\";i:1;s:30:\"task-added-as-follower-swedish\";i:1;s:22:\"task-commented-swedish\";i:1;s:29:\"task-added-attachment-swedish\";i:1;s:34:\"estimate-declined-to-staff-swedish\";i:1;s:34:\"estimate-accepted-to-staff-swedish\";i:1;s:32:\"proposal-client-accepted-swedish\";i:1;s:33:\"proposal-send-to-customer-swedish\";i:1;s:32:\"proposal-client-declined-swedish\";i:1;s:33:\"proposal-client-thank-you-swedish\";i:1;s:34:\"proposal-comment-to-client-swedish\";i:1;s:33:\"proposal-comment-to-admin-swedish\";i:1;s:38:\"estimate-thank-you-to-customer-swedish\";i:1;s:34:\"task-deadline-notification-swedish\";i:1;s:21:\"send-contract-swedish\";i:1;s:41:\"invoice-payment-recorded-to-staff-swedish\";i:1;s:25:\"auto-close-ticket-swedish\";i:1;s:47:\"new-project-discussion-created-to-staff-swedish\";i:1;s:50:\"new-project-discussion-created-to-customer-swedish\";i:1;s:45:\"new-project-file-uploaded-to-customer-swedish\";i:1;s:42:\"new-project-file-uploaded-to-staff-swedish\";i:1;s:50:\"new-project-discussion-comment-to-customer-swedish\";i:1;s:47:\"new-project-discussion-comment-to-staff-swedish\";i:1;s:37:\"staff-added-as-project-member-swedish\";i:1;s:32:\"estimate-expiry-reminder-swedish\";i:1;s:32:\"proposal-expiry-reminder-swedish\";i:1;s:25:\"new-staff-created-swedish\";i:1;s:31:\"contact-forgot-password-swedish\";i:1;s:32:\"contact-password-reseted-swedish\";i:1;s:28:\"contact-set-password-swedish\";i:1;s:29:\"staff-forgot-password-swedish\";i:1;s:30:\"staff-password-reseted-swedish\";i:1;s:27:\"assigned-to-project-swedish\";i:1;s:41:\"task-added-attachment-to-contacts-swedish\";i:1;s:34:\"task-commented-to-contacts-swedish\";i:1;s:25:\"new-lead-assigned-swedish\";i:1;s:24:\"client-statement-swedish\";i:1;s:32:\"ticket-assigned-to-admin-swedish\";i:1;s:38:\"new-client-registered-to-admin-swedish\";i:1;s:38:\"new-web-to-lead-form-submitted-swedish\";i:1;s:33:\"two-factor-authentication-swedish\";i:1;s:36:\"project-finished-to-customer-swedish\";i:1;s:34:\"credit-note-send-to-client-swedish\";i:1;s:35:\"task-status-change-to-staff-swedish\";i:1;s:38:\"task-status-change-to-contacts-swedish\";i:1;s:28:\"reminder-email-staff-swedish\";i:1;s:34:\"contract-comment-to-client-swedish\";i:1;s:33:\"contract-comment-to-admin-swedish\";i:1;s:25:\"send-subscription-swedish\";i:1;s:35:\"subscription-payment-failed-swedish\";i:1;s:29:\"subscription-canceled-swedish\";i:1;s:38:\"subscription-payment-succeeded-swedish\";i:1;s:36:\"contract-expiration-to-staff-swedish\";i:1;s:28:\"gdpr-removal-request-swedish\";i:1;s:33:\"gdpr-removal-request-lead-swedish\";i:1;s:37:\"client-registration-confirmed-swedish\";i:1;s:32:\"contract-signed-to-staff-swedish\";i:1;s:36:\"customer-subscribed-to-staff-swedish\";i:1;s:34:\"contact-verification-email-swedish\";i:1;s:51:\"new-customer-profile-file-uploaded-to-staff-swedish\";i:1;s:35:\"event-notification-to-staff-swedish\";i:1;s:24:\"new-client-created-czech\";i:1;s:28:\"invoice-send-to-client-czech\";i:1;s:29:\"new-ticket-opened-admin-czech\";i:1;s:18:\"ticket-reply-czech\";i:1;s:25:\"ticket-autoresponse-czech\";i:1;s:30:\"invoice-payment-recorded-czech\";i:1;s:28:\"invoice-overdue-notice-czech\";i:1;s:26:\"invoice-already-send-czech\";i:1;s:30:\"new-ticket-created-staff-czech\";i:1;s:29:\"estimate-send-to-client-czech\";i:1;s:27:\"ticket-reply-to-admin-czech\";i:1;s:27:\"estimate-already-send-czech\";i:1;s:25:\"contract-expiration-czech\";i:1;s:19:\"task-assigned-czech\";i:1;s:28:\"task-added-as-follower-czech\";i:1;s:20:\"task-commented-czech\";i:1;s:27:\"task-added-attachment-czech\";i:1;s:32:\"estimate-declined-to-staff-czech\";i:1;s:32:\"estimate-accepted-to-staff-czech\";i:1;s:30:\"proposal-client-accepted-czech\";i:1;s:31:\"proposal-send-to-customer-czech\";i:1;s:30:\"proposal-client-declined-czech\";i:1;s:31:\"proposal-client-thank-you-czech\";i:1;s:32:\"proposal-comment-to-client-czech\";i:1;s:31:\"proposal-comment-to-admin-czech\";i:1;s:36:\"estimate-thank-you-to-customer-czech\";i:1;s:32:\"task-deadline-notification-czech\";i:1;s:19:\"send-contract-czech\";i:1;s:39:\"invoice-payment-recorded-to-staff-czech\";i:1;s:23:\"auto-close-ticket-czech\";i:1;s:45:\"new-project-discussion-created-to-staff-czech\";i:1;s:48:\"new-project-discussion-created-to-customer-czech\";i:1;s:43:\"new-project-file-uploaded-to-customer-czech\";i:1;s:40:\"new-project-file-uploaded-to-staff-czech\";i:1;s:48:\"new-project-discussion-comment-to-customer-czech\";i:1;s:45:\"new-project-discussion-comment-to-staff-czech\";i:1;s:35:\"staff-added-as-project-member-czech\";i:1;s:30:\"estimate-expiry-reminder-czech\";i:1;s:30:\"proposal-expiry-reminder-czech\";i:1;s:23:\"new-staff-created-czech\";i:1;s:29:\"contact-forgot-password-czech\";i:1;s:30:\"contact-password-reseted-czech\";i:1;s:26:\"contact-set-password-czech\";i:1;s:27:\"staff-forgot-password-czech\";i:1;s:28:\"staff-password-reseted-czech\";i:1;s:25:\"assigned-to-project-czech\";i:1;s:39:\"task-added-attachment-to-contacts-czech\";i:1;s:32:\"task-commented-to-contacts-czech\";i:1;s:23:\"new-lead-assigned-czech\";i:1;s:22:\"client-statement-czech\";i:1;s:30:\"ticket-assigned-to-admin-czech\";i:1;s:36:\"new-client-registered-to-admin-czech\";i:1;s:36:\"new-web-to-lead-form-submitted-czech\";i:1;s:31:\"two-factor-authentication-czech\";i:1;s:34:\"project-finished-to-customer-czech\";i:1;s:32:\"credit-note-send-to-client-czech\";i:1;s:33:\"task-status-change-to-staff-czech\";i:1;s:36:\"task-status-change-to-contacts-czech\";i:1;s:26:\"reminder-email-staff-czech\";i:1;s:32:\"contract-comment-to-client-czech\";i:1;s:31:\"contract-comment-to-admin-czech\";i:1;s:23:\"send-subscription-czech\";i:1;s:33:\"subscription-payment-failed-czech\";i:1;s:27:\"subscription-canceled-czech\";i:1;s:36:\"subscription-payment-succeeded-czech\";i:1;s:34:\"contract-expiration-to-staff-czech\";i:1;s:26:\"gdpr-removal-request-czech\";i:1;s:31:\"gdpr-removal-request-lead-czech\";i:1;s:35:\"client-registration-confirmed-czech\";i:1;s:30:\"contract-signed-to-staff-czech\";i:1;s:34:\"customer-subscribed-to-staff-czech\";i:1;s:32:\"contact-verification-email-czech\";i:1;s:49:\"new-customer-profile-file-uploaded-to-staff-czech\";i:1;s:33:\"event-notification-to-staff-czech\";i:1;s:32:\"new-client-created-portuguese_br\";i:1;s:36:\"invoice-send-to-client-portuguese_br\";i:1;s:37:\"new-ticket-opened-admin-portuguese_br\";i:1;s:26:\"ticket-reply-portuguese_br\";i:1;s:33:\"ticket-autoresponse-portuguese_br\";i:1;s:38:\"invoice-payment-recorded-portuguese_br\";i:1;s:36:\"invoice-overdue-notice-portuguese_br\";i:1;s:34:\"invoice-already-send-portuguese_br\";i:1;s:38:\"new-ticket-created-staff-portuguese_br\";i:1;s:37:\"estimate-send-to-client-portuguese_br\";i:1;s:35:\"ticket-reply-to-admin-portuguese_br\";i:1;s:35:\"estimate-already-send-portuguese_br\";i:1;s:33:\"contract-expiration-portuguese_br\";i:1;s:27:\"task-assigned-portuguese_br\";i:1;s:36:\"task-added-as-follower-portuguese_br\";i:1;s:28:\"task-commented-portuguese_br\";i:1;s:35:\"task-added-attachment-portuguese_br\";i:1;s:40:\"estimate-declined-to-staff-portuguese_br\";i:1;s:40:\"estimate-accepted-to-staff-portuguese_br\";i:1;s:38:\"proposal-client-accepted-portuguese_br\";i:1;s:39:\"proposal-send-to-customer-portuguese_br\";i:1;s:38:\"proposal-client-declined-portuguese_br\";i:1;s:39:\"proposal-client-thank-you-portuguese_br\";i:1;s:40:\"proposal-comment-to-client-portuguese_br\";i:1;s:39:\"proposal-comment-to-admin-portuguese_br\";i:1;s:44:\"estimate-thank-you-to-customer-portuguese_br\";i:1;s:40:\"task-deadline-notification-portuguese_br\";i:1;s:27:\"send-contract-portuguese_br\";i:1;s:47:\"invoice-payment-recorded-to-staff-portuguese_br\";i:1;s:31:\"auto-close-ticket-portuguese_br\";i:1;s:53:\"new-project-discussion-created-to-staff-portuguese_br\";i:1;s:56:\"new-project-discussion-created-to-customer-portuguese_br\";i:1;s:51:\"new-project-file-uploaded-to-customer-portuguese_br\";i:1;s:48:\"new-project-file-uploaded-to-staff-portuguese_br\";i:1;s:56:\"new-project-discussion-comment-to-customer-portuguese_br\";i:1;s:53:\"new-project-discussion-comment-to-staff-portuguese_br\";i:1;s:43:\"staff-added-as-project-member-portuguese_br\";i:1;s:38:\"estimate-expiry-reminder-portuguese_br\";i:1;s:38:\"proposal-expiry-reminder-portuguese_br\";i:1;s:31:\"new-staff-created-portuguese_br\";i:1;s:37:\"contact-forgot-password-portuguese_br\";i:1;s:38:\"contact-password-reseted-portuguese_br\";i:1;s:34:\"contact-set-password-portuguese_br\";i:1;s:35:\"staff-forgot-password-portuguese_br\";i:1;s:36:\"staff-password-reseted-portuguese_br\";i:1;s:33:\"assigned-to-project-portuguese_br\";i:1;s:47:\"task-added-attachment-to-contacts-portuguese_br\";i:1;s:40:\"task-commented-to-contacts-portuguese_br\";i:1;s:31:\"new-lead-assigned-portuguese_br\";i:1;s:30:\"client-statement-portuguese_br\";i:1;s:38:\"ticket-assigned-to-admin-portuguese_br\";i:1;s:44:\"new-client-registered-to-admin-portuguese_br\";i:1;s:44:\"new-web-to-lead-form-submitted-portuguese_br\";i:1;s:39:\"two-factor-authentication-portuguese_br\";i:1;s:42:\"project-finished-to-customer-portuguese_br\";i:1;s:40:\"credit-note-send-to-client-portuguese_br\";i:1;s:41:\"task-status-change-to-staff-portuguese_br\";i:1;s:44:\"task-status-change-to-contacts-portuguese_br\";i:1;s:34:\"reminder-email-staff-portuguese_br\";i:1;s:40:\"contract-comment-to-client-portuguese_br\";i:1;s:39:\"contract-comment-to-admin-portuguese_br\";i:1;s:31:\"send-subscription-portuguese_br\";i:1;s:41:\"subscription-payment-failed-portuguese_br\";i:1;s:35:\"subscription-canceled-portuguese_br\";i:1;s:44:\"subscription-payment-succeeded-portuguese_br\";i:1;s:42:\"contract-expiration-to-staff-portuguese_br\";i:1;s:34:\"gdpr-removal-request-portuguese_br\";i:1;s:39:\"gdpr-removal-request-lead-portuguese_br\";i:1;s:43:\"client-registration-confirmed-portuguese_br\";i:1;s:38:\"contract-signed-to-staff-portuguese_br\";i:1;s:42:\"customer-subscribed-to-staff-portuguese_br\";i:1;s:40:\"contact-verification-email-portuguese_br\";i:1;s:57:\"new-customer-profile-file-uploaded-to-staff-portuguese_br\";i:1;s:41:\"event-notification-to-staff-portuguese_br\";i:1;s:25:\"new-client-created-german\";i:1;s:29:\"invoice-send-to-client-german\";i:1;s:30:\"new-ticket-opened-admin-german\";i:1;s:19:\"ticket-reply-german\";i:1;s:26:\"ticket-autoresponse-german\";i:1;s:31:\"invoice-payment-recorded-german\";i:1;s:29:\"invoice-overdue-notice-german\";i:1;s:27:\"invoice-already-send-german\";i:1;s:31:\"new-ticket-created-staff-german\";i:1;s:30:\"estimate-send-to-client-german\";i:1;s:28:\"ticket-reply-to-admin-german\";i:1;s:28:\"estimate-already-send-german\";i:1;s:26:\"contract-expiration-german\";i:1;s:20:\"task-assigned-german\";i:1;s:29:\"task-added-as-follower-german\";i:1;s:21:\"task-commented-german\";i:1;s:28:\"task-added-attachment-german\";i:1;s:33:\"estimate-declined-to-staff-german\";i:1;s:33:\"estimate-accepted-to-staff-german\";i:1;s:31:\"proposal-client-accepted-german\";i:1;s:32:\"proposal-send-to-customer-german\";i:1;s:31:\"proposal-client-declined-german\";i:1;s:32:\"proposal-client-thank-you-german\";i:1;s:33:\"proposal-comment-to-client-german\";i:1;s:32:\"proposal-comment-to-admin-german\";i:1;s:37:\"estimate-thank-you-to-customer-german\";i:1;s:33:\"task-deadline-notification-german\";i:1;s:20:\"send-contract-german\";i:1;s:40:\"invoice-payment-recorded-to-staff-german\";i:1;s:24:\"auto-close-ticket-german\";i:1;s:46:\"new-project-discussion-created-to-staff-german\";i:1;s:49:\"new-project-discussion-created-to-customer-german\";i:1;s:44:\"new-project-file-uploaded-to-customer-german\";i:1;s:41:\"new-project-file-uploaded-to-staff-german\";i:1;s:49:\"new-project-discussion-comment-to-customer-german\";i:1;s:46:\"new-project-discussion-comment-to-staff-german\";i:1;s:36:\"staff-added-as-project-member-german\";i:1;s:31:\"estimate-expiry-reminder-german\";i:1;s:31:\"proposal-expiry-reminder-german\";i:1;s:24:\"new-staff-created-german\";i:1;s:30:\"contact-forgot-password-german\";i:1;s:31:\"contact-password-reseted-german\";i:1;s:27:\"contact-set-password-german\";i:1;s:28:\"staff-forgot-password-german\";i:1;s:29:\"staff-password-reseted-german\";i:1;s:26:\"assigned-to-project-german\";i:1;s:40:\"task-added-attachment-to-contacts-german\";i:1;s:33:\"task-commented-to-contacts-german\";i:1;s:24:\"new-lead-assigned-german\";i:1;s:23:\"client-statement-german\";i:1;s:31:\"ticket-assigned-to-admin-german\";i:1;s:37:\"new-client-registered-to-admin-german\";i:1;s:37:\"new-web-to-lead-form-submitted-german\";i:1;s:32:\"two-factor-authentication-german\";i:1;s:35:\"project-finished-to-customer-german\";i:1;s:33:\"credit-note-send-to-client-german\";i:1;s:34:\"task-status-change-to-staff-german\";i:1;s:37:\"task-status-change-to-contacts-german\";i:1;s:27:\"reminder-email-staff-german\";i:1;s:33:\"contract-comment-to-client-german\";i:1;s:32:\"contract-comment-to-admin-german\";i:1;s:24:\"send-subscription-german\";i:1;s:34:\"subscription-payment-failed-german\";i:1;s:28:\"subscription-canceled-german\";i:1;s:37:\"subscription-payment-succeeded-german\";i:1;s:35:\"contract-expiration-to-staff-german\";i:1;s:27:\"gdpr-removal-request-german\";i:1;s:32:\"gdpr-removal-request-lead-german\";i:1;s:36:\"client-registration-confirmed-german\";i:1;s:31:\"contract-signed-to-staff-german\";i:1;s:35:\"customer-subscribed-to-staff-german\";i:1;s:33:\"contact-verification-email-german\";i:1;s:50:\"new-customer-profile-file-uploaded-to-staff-german\";i:1;s:34:\"event-notification-to-staff-german\";i:1;s:29:\"new-client-created-portuguese\";i:1;s:33:\"invoice-send-to-client-portuguese\";i:1;s:34:\"new-ticket-opened-admin-portuguese\";i:1;s:23:\"ticket-reply-portuguese\";i:1;s:30:\"ticket-autoresponse-portuguese\";i:1;s:35:\"invoice-payment-recorded-portuguese\";i:1;s:33:\"invoice-overdue-notice-portuguese\";i:1;s:31:\"invoice-already-send-portuguese\";i:1;s:35:\"new-ticket-created-staff-portuguese\";i:1;s:34:\"estimate-send-to-client-portuguese\";i:1;s:32:\"ticket-reply-to-admin-portuguese\";i:1;s:32:\"estimate-already-send-portuguese\";i:1;s:30:\"contract-expiration-portuguese\";i:1;s:24:\"task-assigned-portuguese\";i:1;s:33:\"task-added-as-follower-portuguese\";i:1;s:25:\"task-commented-portuguese\";i:1;s:32:\"task-added-attachment-portuguese\";i:1;s:37:\"estimate-declined-to-staff-portuguese\";i:1;s:37:\"estimate-accepted-to-staff-portuguese\";i:1;s:35:\"proposal-client-accepted-portuguese\";i:1;s:36:\"proposal-send-to-customer-portuguese\";i:1;s:35:\"proposal-client-declined-portuguese\";i:1;s:36:\"proposal-client-thank-you-portuguese\";i:1;s:37:\"proposal-comment-to-client-portuguese\";i:1;s:36:\"proposal-comment-to-admin-portuguese\";i:1;s:41:\"estimate-thank-you-to-customer-portuguese\";i:1;s:37:\"task-deadline-notification-portuguese\";i:1;s:24:\"send-contract-portuguese\";i:1;s:44:\"invoice-payment-recorded-to-staff-portuguese\";i:1;s:28:\"auto-close-ticket-portuguese\";i:1;s:50:\"new-project-discussion-created-to-staff-portuguese\";i:1;s:53:\"new-project-discussion-created-to-customer-portuguese\";i:1;s:48:\"new-project-file-uploaded-to-customer-portuguese\";i:1;s:45:\"new-project-file-uploaded-to-staff-portuguese\";i:1;s:53:\"new-project-discussion-comment-to-customer-portuguese\";i:1;s:50:\"new-project-discussion-comment-to-staff-portuguese\";i:1;s:40:\"staff-added-as-project-member-portuguese\";i:1;s:35:\"estimate-expiry-reminder-portuguese\";i:1;s:35:\"proposal-expiry-reminder-portuguese\";i:1;s:28:\"new-staff-created-portuguese\";i:1;s:34:\"contact-forgot-password-portuguese\";i:1;s:35:\"contact-password-reseted-portuguese\";i:1;s:31:\"contact-set-password-portuguese\";i:1;s:32:\"staff-forgot-password-portuguese\";i:1;s:33:\"staff-password-reseted-portuguese\";i:1;s:30:\"assigned-to-project-portuguese\";i:1;s:44:\"task-added-attachment-to-contacts-portuguese\";i:1;s:37:\"task-commented-to-contacts-portuguese\";i:1;s:28:\"new-lead-assigned-portuguese\";i:1;s:27:\"client-statement-portuguese\";i:1;s:35:\"ticket-assigned-to-admin-portuguese\";i:1;s:41:\"new-client-registered-to-admin-portuguese\";i:1;s:41:\"new-web-to-lead-form-submitted-portuguese\";i:1;s:36:\"two-factor-authentication-portuguese\";i:1;s:39:\"project-finished-to-customer-portuguese\";i:1;s:37:\"credit-note-send-to-client-portuguese\";i:1;s:38:\"task-status-change-to-staff-portuguese\";i:1;s:41:\"task-status-change-to-contacts-portuguese\";i:1;s:31:\"reminder-email-staff-portuguese\";i:1;s:37:\"contract-comment-to-client-portuguese\";i:1;s:36:\"contract-comment-to-admin-portuguese\";i:1;s:28:\"send-subscription-portuguese\";i:1;s:38:\"subscription-payment-failed-portuguese\";i:1;s:32:\"subscription-canceled-portuguese\";i:1;s:41:\"subscription-payment-succeeded-portuguese\";i:1;s:39:\"contract-expiration-to-staff-portuguese\";i:1;s:31:\"gdpr-removal-request-portuguese\";i:1;s:36:\"gdpr-removal-request-lead-portuguese\";i:1;s:40:\"client-registration-confirmed-portuguese\";i:1;s:35:\"contract-signed-to-staff-portuguese\";i:1;s:39:\"customer-subscribed-to-staff-portuguese\";i:1;s:37:\"contact-verification-email-portuguese\";i:1;s:54:\"new-customer-profile-file-uploaded-to-staff-portuguese\";i:1;s:38:\"event-notification-to-staff-portuguese\";i:1;s:29:\"new-client-created-vietnamese\";i:1;s:33:\"invoice-send-to-client-vietnamese\";i:1;s:34:\"new-ticket-opened-admin-vietnamese\";i:1;s:23:\"ticket-reply-vietnamese\";i:1;s:30:\"ticket-autoresponse-vietnamese\";i:1;s:35:\"invoice-payment-recorded-vietnamese\";i:1;s:33:\"invoice-overdue-notice-vietnamese\";i:1;s:31:\"invoice-already-send-vietnamese\";i:1;s:35:\"new-ticket-created-staff-vietnamese\";i:1;s:34:\"estimate-send-to-client-vietnamese\";i:1;s:32:\"ticket-reply-to-admin-vietnamese\";i:1;s:32:\"estimate-already-send-vietnamese\";i:1;s:30:\"contract-expiration-vietnamese\";i:1;s:24:\"task-assigned-vietnamese\";i:1;s:33:\"task-added-as-follower-vietnamese\";i:1;s:25:\"task-commented-vietnamese\";i:1;s:32:\"task-added-attachment-vietnamese\";i:1;s:37:\"estimate-declined-to-staff-vietnamese\";i:1;s:37:\"estimate-accepted-to-staff-vietnamese\";i:1;s:35:\"proposal-client-accepted-vietnamese\";i:1;s:36:\"proposal-send-to-customer-vietnamese\";i:1;s:35:\"proposal-client-declined-vietnamese\";i:1;s:36:\"proposal-client-thank-you-vietnamese\";i:1;s:37:\"proposal-comment-to-client-vietnamese\";i:1;s:36:\"proposal-comment-to-admin-vietnamese\";i:1;s:41:\"estimate-thank-you-to-customer-vietnamese\";i:1;s:37:\"task-deadline-notification-vietnamese\";i:1;s:24:\"send-contract-vietnamese\";i:1;s:44:\"invoice-payment-recorded-to-staff-vietnamese\";i:1;s:28:\"auto-close-ticket-vietnamese\";i:1;s:50:\"new-project-discussion-created-to-staff-vietnamese\";i:1;s:53:\"new-project-discussion-created-to-customer-vietnamese\";i:1;s:48:\"new-project-file-uploaded-to-customer-vietnamese\";i:1;s:45:\"new-project-file-uploaded-to-staff-vietnamese\";i:1;s:53:\"new-project-discussion-comment-to-customer-vietnamese\";i:1;s:50:\"new-project-discussion-comment-to-staff-vietnamese\";i:1;s:40:\"staff-added-as-project-member-vietnamese\";i:1;s:35:\"estimate-expiry-reminder-vietnamese\";i:1;s:35:\"proposal-expiry-reminder-vietnamese\";i:1;s:28:\"new-staff-created-vietnamese\";i:1;s:34:\"contact-forgot-password-vietnamese\";i:1;s:35:\"contact-password-reseted-vietnamese\";i:1;s:31:\"contact-set-password-vietnamese\";i:1;s:32:\"staff-forgot-password-vietnamese\";i:1;s:33:\"staff-password-reseted-vietnamese\";i:1;s:30:\"assigned-to-project-vietnamese\";i:1;s:44:\"task-added-attachment-to-contacts-vietnamese\";i:1;s:37:\"task-commented-to-contacts-vietnamese\";i:1;s:28:\"new-lead-assigned-vietnamese\";i:1;s:27:\"client-statement-vietnamese\";i:1;s:35:\"ticket-assigned-to-admin-vietnamese\";i:1;s:41:\"new-client-registered-to-admin-vietnamese\";i:1;s:41:\"new-web-to-lead-form-submitted-vietnamese\";i:1;s:36:\"two-factor-authentication-vietnamese\";i:1;s:39:\"project-finished-to-customer-vietnamese\";i:1;s:37:\"credit-note-send-to-client-vietnamese\";i:1;s:38:\"task-status-change-to-staff-vietnamese\";i:1;s:41:\"task-status-change-to-contacts-vietnamese\";i:1;s:31:\"reminder-email-staff-vietnamese\";i:1;s:37:\"contract-comment-to-client-vietnamese\";i:1;s:36:\"contract-comment-to-admin-vietnamese\";i:1;s:28:\"send-subscription-vietnamese\";i:1;s:38:\"subscription-payment-failed-vietnamese\";i:1;s:32:\"subscription-canceled-vietnamese\";i:1;s:41:\"subscription-payment-succeeded-vietnamese\";i:1;s:39:\"contract-expiration-to-staff-vietnamese\";i:1;s:31:\"gdpr-removal-request-vietnamese\";i:1;s:36:\"gdpr-removal-request-lead-vietnamese\";i:1;s:40:\"client-registration-confirmed-vietnamese\";i:1;s:35:\"contract-signed-to-staff-vietnamese\";i:1;s:39:\"customer-subscribed-to-staff-vietnamese\";i:1;s:37:\"contact-verification-email-vietnamese\";i:1;s:54:\"new-customer-profile-file-uploaded-to-staff-vietnamese\";i:1;s:38:\"event-notification-to-staff-vietnamese\";i:1;s:26:\"new-client-created-persian\";i:1;s:30:\"invoice-send-to-client-persian\";i:1;s:31:\"new-ticket-opened-admin-persian\";i:1;s:20:\"ticket-reply-persian\";i:1;s:27:\"ticket-autoresponse-persian\";i:1;s:32:\"invoice-payment-recorded-persian\";i:1;s:30:\"invoice-overdue-notice-persian\";i:1;s:28:\"invoice-already-send-persian\";i:1;s:32:\"new-ticket-created-staff-persian\";i:1;s:31:\"estimate-send-to-client-persian\";i:1;s:29:\"ticket-reply-to-admin-persian\";i:1;s:29:\"estimate-already-send-persian\";i:1;s:27:\"contract-expiration-persian\";i:1;s:21:\"task-assigned-persian\";i:1;s:30:\"task-added-as-follower-persian\";i:1;s:22:\"task-commented-persian\";i:1;s:29:\"task-added-attachment-persian\";i:1;s:34:\"estimate-declined-to-staff-persian\";i:1;s:34:\"estimate-accepted-to-staff-persian\";i:1;s:32:\"proposal-client-accepted-persian\";i:1;s:33:\"proposal-send-to-customer-persian\";i:1;s:32:\"proposal-client-declined-persian\";i:1;s:33:\"proposal-client-thank-you-persian\";i:1;s:34:\"proposal-comment-to-client-persian\";i:1;s:33:\"proposal-comment-to-admin-persian\";i:1;s:38:\"estimate-thank-you-to-customer-persian\";i:1;s:34:\"task-deadline-notification-persian\";i:1;s:21:\"send-contract-persian\";i:1;s:41:\"invoice-payment-recorded-to-staff-persian\";i:1;s:25:\"auto-close-ticket-persian\";i:1;s:47:\"new-project-discussion-created-to-staff-persian\";i:1;s:50:\"new-project-discussion-created-to-customer-persian\";i:1;s:45:\"new-project-file-uploaded-to-customer-persian\";i:1;s:42:\"new-project-file-uploaded-to-staff-persian\";i:1;s:50:\"new-project-discussion-comment-to-customer-persian\";i:1;s:47:\"new-project-discussion-comment-to-staff-persian\";i:1;s:37:\"staff-added-as-project-member-persian\";i:1;s:32:\"estimate-expiry-reminder-persian\";i:1;s:32:\"proposal-expiry-reminder-persian\";i:1;s:25:\"new-staff-created-persian\";i:1;s:31:\"contact-forgot-password-persian\";i:1;s:32:\"contact-password-reseted-persian\";i:1;s:28:\"contact-set-password-persian\";i:1;s:29:\"staff-forgot-password-persian\";i:1;s:30:\"staff-password-reseted-persian\";i:1;s:27:\"assigned-to-project-persian\";i:1;s:41:\"task-added-attachment-to-contacts-persian\";i:1;s:34:\"task-commented-to-contacts-persian\";i:1;s:25:\"new-lead-assigned-persian\";i:1;s:24:\"client-statement-persian\";i:1;s:32:\"ticket-assigned-to-admin-persian\";i:1;s:38:\"new-client-registered-to-admin-persian\";i:1;s:38:\"new-web-to-lead-form-submitted-persian\";i:1;s:33:\"two-factor-authentication-persian\";i:1;s:36:\"project-finished-to-customer-persian\";i:1;s:34:\"credit-note-send-to-client-persian\";i:1;s:35:\"task-status-change-to-staff-persian\";i:1;s:38:\"task-status-change-to-contacts-persian\";i:1;s:28:\"reminder-email-staff-persian\";i:1;s:34:\"contract-comment-to-client-persian\";i:1;s:33:\"contract-comment-to-admin-persian\";i:1;s:25:\"send-subscription-persian\";i:1;s:35:\"subscription-payment-failed-persian\";i:1;s:29:\"subscription-canceled-persian\";i:1;s:38:\"subscription-payment-succeeded-persian\";i:1;s:36:\"contract-expiration-to-staff-persian\";i:1;s:28:\"gdpr-removal-request-persian\";i:1;s:33:\"gdpr-removal-request-lead-persian\";i:1;s:37:\"client-registration-confirmed-persian\";i:1;s:32:\"contract-signed-to-staff-persian\";i:1;s:36:\"customer-subscribed-to-staff-persian\";i:1;s:34:\"contact-verification-email-persian\";i:1;s:51:\"new-customer-profile-file-uploaded-to-staff-persian\";i:1;s:35:\"event-notification-to-staff-persian\";i:1;s:26:\"new-client-created-spanish\";i:1;s:30:\"invoice-send-to-client-spanish\";i:1;s:31:\"new-ticket-opened-admin-spanish\";i:1;s:20:\"ticket-reply-spanish\";i:1;s:27:\"ticket-autoresponse-spanish\";i:1;s:32:\"invoice-payment-recorded-spanish\";i:1;s:30:\"invoice-overdue-notice-spanish\";i:1;s:28:\"invoice-already-send-spanish\";i:1;s:32:\"new-ticket-created-staff-spanish\";i:1;s:31:\"estimate-send-to-client-spanish\";i:1;s:29:\"ticket-reply-to-admin-spanish\";i:1;s:29:\"estimate-already-send-spanish\";i:1;s:27:\"contract-expiration-spanish\";i:1;s:21:\"task-assigned-spanish\";i:1;s:30:\"task-added-as-follower-spanish\";i:1;s:22:\"task-commented-spanish\";i:1;s:29:\"task-added-attachment-spanish\";i:1;s:34:\"estimate-declined-to-staff-spanish\";i:1;s:34:\"estimate-accepted-to-staff-spanish\";i:1;s:32:\"proposal-client-accepted-spanish\";i:1;s:33:\"proposal-send-to-customer-spanish\";i:1;s:32:\"proposal-client-declined-spanish\";i:1;s:33:\"proposal-client-thank-you-spanish\";i:1;s:34:\"proposal-comment-to-client-spanish\";i:1;s:33:\"proposal-comment-to-admin-spanish\";i:1;s:38:\"estimate-thank-you-to-customer-spanish\";i:1;s:34:\"task-deadline-notification-spanish\";i:1;s:21:\"send-contract-spanish\";i:1;s:41:\"invoice-payment-recorded-to-staff-spanish\";i:1;s:25:\"auto-close-ticket-spanish\";i:1;s:47:\"new-project-discussion-created-to-staff-spanish\";i:1;s:50:\"new-project-discussion-created-to-customer-spanish\";i:1;s:45:\"new-project-file-uploaded-to-customer-spanish\";i:1;s:42:\"new-project-file-uploaded-to-staff-spanish\";i:1;s:50:\"new-project-discussion-comment-to-customer-spanish\";i:1;s:47:\"new-project-discussion-comment-to-staff-spanish\";i:1;s:37:\"staff-added-as-project-member-spanish\";i:1;s:32:\"estimate-expiry-reminder-spanish\";i:1;s:32:\"proposal-expiry-reminder-spanish\";i:1;s:25:\"new-staff-created-spanish\";i:1;s:31:\"contact-forgot-password-spanish\";i:1;s:32:\"contact-password-reseted-spanish\";i:1;s:28:\"contact-set-password-spanish\";i:1;s:29:\"staff-forgot-password-spanish\";i:1;s:30:\"staff-password-reseted-spanish\";i:1;s:27:\"assigned-to-project-spanish\";i:1;s:41:\"task-added-attachment-to-contacts-spanish\";i:1;s:34:\"task-commented-to-contacts-spanish\";i:1;s:25:\"new-lead-assigned-spanish\";i:1;s:24:\"client-statement-spanish\";i:1;s:32:\"ticket-assigned-to-admin-spanish\";i:1;s:38:\"new-client-registered-to-admin-spanish\";i:1;s:38:\"new-web-to-lead-form-submitted-spanish\";i:1;s:33:\"two-factor-authentication-spanish\";i:1;s:36:\"project-finished-to-customer-spanish\";i:1;s:34:\"credit-note-send-to-client-spanish\";i:1;s:35:\"task-status-change-to-staff-spanish\";i:1;s:38:\"task-status-change-to-contacts-spanish\";i:1;s:28:\"reminder-email-staff-spanish\";i:1;s:34:\"contract-comment-to-client-spanish\";i:1;s:33:\"contract-comment-to-admin-spanish\";i:1;s:25:\"send-subscription-spanish\";i:1;s:35:\"subscription-payment-failed-spanish\";i:1;s:29:\"subscription-canceled-spanish\";i:1;s:38:\"subscription-payment-succeeded-spanish\";i:1;s:36:\"contract-expiration-to-staff-spanish\";i:1;s:28:\"gdpr-removal-request-spanish\";i:1;s:33:\"gdpr-removal-request-lead-spanish\";i:1;s:37:\"client-registration-confirmed-spanish\";i:1;s:32:\"contract-signed-to-staff-spanish\";i:1;s:36:\"customer-subscribed-to-staff-spanish\";i:1;s:34:\"contact-verification-email-spanish\";i:1;s:51:\"new-customer-profile-file-uploaded-to-staff-spanish\";i:1;s:35:\"event-notification-to-staff-spanish\";i:1;s:27:\"new-client-created-japanese\";i:1;s:31:\"invoice-send-to-client-japanese\";i:1;s:32:\"new-ticket-opened-admin-japanese\";i:1;s:21:\"ticket-reply-japanese\";i:1;s:28:\"ticket-autoresponse-japanese\";i:1;s:33:\"invoice-payment-recorded-japanese\";i:1;s:31:\"invoice-overdue-notice-japanese\";i:1;s:29:\"invoice-already-send-japanese\";i:1;s:33:\"new-ticket-created-staff-japanese\";i:1;s:32:\"estimate-send-to-client-japanese\";i:1;s:30:\"ticket-reply-to-admin-japanese\";i:1;s:30:\"estimate-already-send-japanese\";i:1;s:28:\"contract-expiration-japanese\";i:1;s:22:\"task-assigned-japanese\";i:1;s:31:\"task-added-as-follower-japanese\";i:1;s:23:\"task-commented-japanese\";i:1;s:30:\"task-added-attachment-japanese\";i:1;s:35:\"estimate-declined-to-staff-japanese\";i:1;s:35:\"estimate-accepted-to-staff-japanese\";i:1;s:33:\"proposal-client-accepted-japanese\";i:1;s:34:\"proposal-send-to-customer-japanese\";i:1;s:33:\"proposal-client-declined-japanese\";i:1;s:34:\"proposal-client-thank-you-japanese\";i:1;s:35:\"proposal-comment-to-client-japanese\";i:1;s:34:\"proposal-comment-to-admin-japanese\";i:1;s:39:\"estimate-thank-you-to-customer-japanese\";i:1;s:35:\"task-deadline-notification-japanese\";i:1;s:22:\"send-contract-japanese\";i:1;s:42:\"invoice-payment-recorded-to-staff-japanese\";i:1;s:26:\"auto-close-ticket-japanese\";i:1;s:48:\"new-project-discussion-created-to-staff-japanese\";i:1;s:51:\"new-project-discussion-created-to-customer-japanese\";i:1;s:46:\"new-project-file-uploaded-to-customer-japanese\";i:1;s:43:\"new-project-file-uploaded-to-staff-japanese\";i:1;s:51:\"new-project-discussion-comment-to-customer-japanese\";i:1;s:48:\"new-project-discussion-comment-to-staff-japanese\";i:1;s:38:\"staff-added-as-project-member-japanese\";i:1;s:33:\"estimate-expiry-reminder-japanese\";i:1;s:33:\"proposal-expiry-reminder-japanese\";i:1;s:26:\"new-staff-created-japanese\";i:1;s:32:\"contact-forgot-password-japanese\";i:1;s:33:\"contact-password-reseted-japanese\";i:1;s:29:\"contact-set-password-japanese\";i:1;s:30:\"staff-forgot-password-japanese\";i:1;s:31:\"staff-password-reseted-japanese\";i:1;s:28:\"assigned-to-project-japanese\";i:1;s:42:\"task-added-attachment-to-contacts-japanese\";i:1;s:35:\"task-commented-to-contacts-japanese\";i:1;s:26:\"new-lead-assigned-japanese\";i:1;s:25:\"client-statement-japanese\";i:1;s:33:\"ticket-assigned-to-admin-japanese\";i:1;s:39:\"new-client-registered-to-admin-japanese\";i:1;s:39:\"new-web-to-lead-form-submitted-japanese\";i:1;s:34:\"two-factor-authentication-japanese\";i:1;s:37:\"project-finished-to-customer-japanese\";i:1;s:35:\"credit-note-send-to-client-japanese\";i:1;s:36:\"task-status-change-to-staff-japanese\";i:1;s:39:\"task-status-change-to-contacts-japanese\";i:1;s:29:\"reminder-email-staff-japanese\";i:1;s:35:\"contract-comment-to-client-japanese\";i:1;s:34:\"contract-comment-to-admin-japanese\";i:1;s:26:\"send-subscription-japanese\";i:1;s:36:\"subscription-payment-failed-japanese\";i:1;s:30:\"subscription-canceled-japanese\";i:1;s:39:\"subscription-payment-succeeded-japanese\";i:1;s:37:\"contract-expiration-to-staff-japanese\";i:1;s:29:\"gdpr-removal-request-japanese\";i:1;s:34:\"gdpr-removal-request-lead-japanese\";i:1;s:38:\"client-registration-confirmed-japanese\";i:1;s:33:\"contract-signed-to-staff-japanese\";i:1;s:37:\"customer-subscribed-to-staff-japanese\";i:1;s:35:\"contact-verification-email-japanese\";i:1;s:52:\"new-customer-profile-file-uploaded-to-staff-japanese\";i:1;s:36:\"event-notification-to-staff-japanese\";i:1;s:28:\"new-client-created-bulgarian\";i:1;s:32:\"invoice-send-to-client-bulgarian\";i:1;s:33:\"new-ticket-opened-admin-bulgarian\";i:1;s:22:\"ticket-reply-bulgarian\";i:1;s:29:\"ticket-autoresponse-bulgarian\";i:1;s:34:\"invoice-payment-recorded-bulgarian\";i:1;s:32:\"invoice-overdue-notice-bulgarian\";i:1;s:30:\"invoice-already-send-bulgarian\";i:1;s:34:\"new-ticket-created-staff-bulgarian\";i:1;s:33:\"estimate-send-to-client-bulgarian\";i:1;s:31:\"ticket-reply-to-admin-bulgarian\";i:1;s:31:\"estimate-already-send-bulgarian\";i:1;s:29:\"contract-expiration-bulgarian\";i:1;s:23:\"task-assigned-bulgarian\";i:1;s:32:\"task-added-as-follower-bulgarian\";i:1;s:24:\"task-commented-bulgarian\";i:1;s:31:\"task-added-attachment-bulgarian\";i:1;s:36:\"estimate-declined-to-staff-bulgarian\";i:1;s:36:\"estimate-accepted-to-staff-bulgarian\";i:1;s:34:\"proposal-client-accepted-bulgarian\";i:1;s:35:\"proposal-send-to-customer-bulgarian\";i:1;s:34:\"proposal-client-declined-bulgarian\";i:1;s:35:\"proposal-client-thank-you-bulgarian\";i:1;s:36:\"proposal-comment-to-client-bulgarian\";i:1;s:35:\"proposal-comment-to-admin-bulgarian\";i:1;s:40:\"estimate-thank-you-to-customer-bulgarian\";i:1;s:36:\"task-deadline-notification-bulgarian\";i:1;s:23:\"send-contract-bulgarian\";i:1;s:43:\"invoice-payment-recorded-to-staff-bulgarian\";i:1;s:27:\"auto-close-ticket-bulgarian\";i:1;s:49:\"new-project-discussion-created-to-staff-bulgarian\";i:1;s:52:\"new-project-discussion-created-to-customer-bulgarian\";i:1;s:47:\"new-project-file-uploaded-to-customer-bulgarian\";i:1;s:44:\"new-project-file-uploaded-to-staff-bulgarian\";i:1;s:52:\"new-project-discussion-comment-to-customer-bulgarian\";i:1;s:49:\"new-project-discussion-comment-to-staff-bulgarian\";i:1;s:39:\"staff-added-as-project-member-bulgarian\";i:1;s:34:\"estimate-expiry-reminder-bulgarian\";i:1;s:34:\"proposal-expiry-reminder-bulgarian\";i:1;s:27:\"new-staff-created-bulgarian\";i:1;s:33:\"contact-forgot-password-bulgarian\";i:1;s:34:\"contact-password-reseted-bulgarian\";i:1;s:30:\"contact-set-password-bulgarian\";i:1;s:31:\"staff-forgot-password-bulgarian\";i:1;s:32:\"staff-password-reseted-bulgarian\";i:1;s:29:\"assigned-to-project-bulgarian\";i:1;s:43:\"task-added-attachment-to-contacts-bulgarian\";i:1;s:36:\"task-commented-to-contacts-bulgarian\";i:1;s:27:\"new-lead-assigned-bulgarian\";i:1;s:26:\"client-statement-bulgarian\";i:1;s:34:\"ticket-assigned-to-admin-bulgarian\";i:1;s:40:\"new-client-registered-to-admin-bulgarian\";i:1;s:40:\"new-web-to-lead-form-submitted-bulgarian\";i:1;s:35:\"two-factor-authentication-bulgarian\";i:1;s:38:\"project-finished-to-customer-bulgarian\";i:1;s:36:\"credit-note-send-to-client-bulgarian\";i:1;s:37:\"task-status-change-to-staff-bulgarian\";i:1;s:40:\"task-status-change-to-contacts-bulgarian\";i:1;s:30:\"reminder-email-staff-bulgarian\";i:1;s:36:\"contract-comment-to-client-bulgarian\";i:1;s:35:\"contract-comment-to-admin-bulgarian\";i:1;s:27:\"send-subscription-bulgarian\";i:1;s:37:\"subscription-payment-failed-bulgarian\";i:1;s:31:\"subscription-canceled-bulgarian\";i:1;s:40:\"subscription-payment-succeeded-bulgarian\";i:1;s:38:\"contract-expiration-to-staff-bulgarian\";i:1;s:30:\"gdpr-removal-request-bulgarian\";i:1;s:35:\"gdpr-removal-request-lead-bulgarian\";i:1;s:39:\"client-registration-confirmed-bulgarian\";i:1;s:34:\"contract-signed-to-staff-bulgarian\";i:1;s:38:\"customer-subscribed-to-staff-bulgarian\";i:1;s:36:\"contact-verification-email-bulgarian\";i:1;s:53:\"new-customer-profile-file-uploaded-to-staff-bulgarian\";i:1;s:37:\"event-notification-to-staff-bulgarian\";i:1;s:25:\"new-client-created-slovak\";i:1;s:29:\"invoice-send-to-client-slovak\";i:1;s:30:\"new-ticket-opened-admin-slovak\";i:1;s:19:\"ticket-reply-slovak\";i:1;s:26:\"ticket-autoresponse-slovak\";i:1;s:31:\"invoice-payment-recorded-slovak\";i:1;s:29:\"invoice-overdue-notice-slovak\";i:1;s:27:\"invoice-already-send-slovak\";i:1;s:31:\"new-ticket-created-staff-slovak\";i:1;s:30:\"estimate-send-to-client-slovak\";i:1;s:28:\"ticket-reply-to-admin-slovak\";i:1;s:28:\"estimate-already-send-slovak\";i:1;s:26:\"contract-expiration-slovak\";i:1;s:20:\"task-assigned-slovak\";i:1;s:29:\"task-added-as-follower-slovak\";i:1;s:21:\"task-commented-slovak\";i:1;s:28:\"task-added-attachment-slovak\";i:1;s:33:\"estimate-declined-to-staff-slovak\";i:1;s:33:\"estimate-accepted-to-staff-slovak\";i:1;s:31:\"proposal-client-accepted-slovak\";i:1;s:32:\"proposal-send-to-customer-slovak\";i:1;s:31:\"proposal-client-declined-slovak\";i:1;s:32:\"proposal-client-thank-you-slovak\";i:1;s:33:\"proposal-comment-to-client-slovak\";i:1;s:32:\"proposal-comment-to-admin-slovak\";i:1;s:37:\"estimate-thank-you-to-customer-slovak\";i:1;s:33:\"task-deadline-notification-slovak\";i:1;s:20:\"send-contract-slovak\";i:1;s:40:\"invoice-payment-recorded-to-staff-slovak\";i:1;s:24:\"auto-close-ticket-slovak\";i:1;s:46:\"new-project-discussion-created-to-staff-slovak\";i:1;s:49:\"new-project-discussion-created-to-customer-slovak\";i:1;s:44:\"new-project-file-uploaded-to-customer-slovak\";i:1;s:41:\"new-project-file-uploaded-to-staff-slovak\";i:1;s:49:\"new-project-discussion-comment-to-customer-slovak\";i:1;s:46:\"new-project-discussion-comment-to-staff-slovak\";i:1;s:36:\"staff-added-as-project-member-slovak\";i:1;s:31:\"estimate-expiry-reminder-slovak\";i:1;s:31:\"proposal-expiry-reminder-slovak\";i:1;s:24:\"new-staff-created-slovak\";i:1;s:30:\"contact-forgot-password-slovak\";i:1;s:31:\"contact-password-reseted-slovak\";i:1;s:27:\"contact-set-password-slovak\";i:1;s:28:\"staff-forgot-password-slovak\";i:1;s:29:\"staff-password-reseted-slovak\";i:1;s:26:\"assigned-to-project-slovak\";i:1;s:40:\"task-added-attachment-to-contacts-slovak\";i:1;s:33:\"task-commented-to-contacts-slovak\";i:1;s:24:\"new-lead-assigned-slovak\";i:1;s:23:\"client-statement-slovak\";i:1;s:31:\"ticket-assigned-to-admin-slovak\";i:1;s:37:\"new-client-registered-to-admin-slovak\";i:1;s:37:\"new-web-to-lead-form-submitted-slovak\";i:1;s:32:\"two-factor-authentication-slovak\";i:1;s:35:\"project-finished-to-customer-slovak\";i:1;s:33:\"credit-note-send-to-client-slovak\";i:1;s:34:\"task-status-change-to-staff-slovak\";i:1;s:37:\"task-status-change-to-contacts-slovak\";i:1;s:27:\"reminder-email-staff-slovak\";i:1;s:33:\"contract-comment-to-client-slovak\";i:1;s:32:\"contract-comment-to-admin-slovak\";i:1;s:24:\"send-subscription-slovak\";i:1;s:34:\"subscription-payment-failed-slovak\";i:1;s:28:\"subscription-canceled-slovak\";i:1;s:37:\"subscription-payment-succeeded-slovak\";i:1;s:35:\"contract-expiration-to-staff-slovak\";i:1;s:27:\"gdpr-removal-request-slovak\";i:1;s:32:\"gdpr-removal-request-lead-slovak\";i:1;s:36:\"client-registration-confirmed-slovak\";i:1;s:31:\"contract-signed-to-staff-slovak\";i:1;s:35:\"customer-subscribed-to-staff-slovak\";i:1;s:33:\"contact-verification-email-slovak\";i:1;s:50:\"new-customer-profile-file-uploaded-to-staff-slovak\";i:1;s:34:\"event-notification-to-staff-slovak\";i:1;s:26:\"new-client-created-russian\";i:1;s:30:\"invoice-send-to-client-russian\";i:1;s:31:\"new-ticket-opened-admin-russian\";i:1;s:20:\"ticket-reply-russian\";i:1;s:27:\"ticket-autoresponse-russian\";i:1;s:32:\"invoice-payment-recorded-russian\";i:1;s:30:\"invoice-overdue-notice-russian\";i:1;s:28:\"invoice-already-send-russian\";i:1;s:32:\"new-ticket-created-staff-russian\";i:1;s:31:\"estimate-send-to-client-russian\";i:1;s:29:\"ticket-reply-to-admin-russian\";i:1;s:29:\"estimate-already-send-russian\";i:1;s:27:\"contract-expiration-russian\";i:1;s:21:\"task-assigned-russian\";i:1;s:30:\"task-added-as-follower-russian\";i:1;s:22:\"task-commented-russian\";i:1;s:29:\"task-added-attachment-russian\";i:1;s:34:\"estimate-declined-to-staff-russian\";i:1;s:34:\"estimate-accepted-to-staff-russian\";i:1;s:32:\"proposal-client-accepted-russian\";i:1;s:33:\"proposal-send-to-customer-russian\";i:1;s:32:\"proposal-client-declined-russian\";i:1;s:33:\"proposal-client-thank-you-russian\";i:1;s:34:\"proposal-comment-to-client-russian\";i:1;s:33:\"proposal-comment-to-admin-russian\";i:1;s:38:\"estimate-thank-you-to-customer-russian\";i:1;s:34:\"task-deadline-notification-russian\";i:1;s:21:\"send-contract-russian\";i:1;s:41:\"invoice-payment-recorded-to-staff-russian\";i:1;s:25:\"auto-close-ticket-russian\";i:1;s:47:\"new-project-discussion-created-to-staff-russian\";i:1;s:50:\"new-project-discussion-created-to-customer-russian\";i:1;s:45:\"new-project-file-uploaded-to-customer-russian\";i:1;s:42:\"new-project-file-uploaded-to-staff-russian\";i:1;s:50:\"new-project-discussion-comment-to-customer-russian\";i:1;s:47:\"new-project-discussion-comment-to-staff-russian\";i:1;s:37:\"staff-added-as-project-member-russian\";i:1;s:32:\"estimate-expiry-reminder-russian\";i:1;s:32:\"proposal-expiry-reminder-russian\";i:1;s:25:\"new-staff-created-russian\";i:1;s:31:\"contact-forgot-password-russian\";i:1;s:32:\"contact-password-reseted-russian\";i:1;s:28:\"contact-set-password-russian\";i:1;s:29:\"staff-forgot-password-russian\";i:1;s:30:\"staff-password-reseted-russian\";i:1;s:27:\"assigned-to-project-russian\";i:1;s:41:\"task-added-attachment-to-contacts-russian\";i:1;s:34:\"task-commented-to-contacts-russian\";i:1;s:25:\"new-lead-assigned-russian\";i:1;s:24:\"client-statement-russian\";i:1;s:32:\"ticket-assigned-to-admin-russian\";i:1;s:38:\"new-client-registered-to-admin-russian\";i:1;s:38:\"new-web-to-lead-form-submitted-russian\";i:1;s:33:\"two-factor-authentication-russian\";i:1;s:36:\"project-finished-to-customer-russian\";i:1;s:34:\"credit-note-send-to-client-russian\";i:1;s:35:\"task-status-change-to-staff-russian\";i:1;s:38:\"task-status-change-to-contacts-russian\";i:1;s:28:\"reminder-email-staff-russian\";i:1;s:34:\"contract-comment-to-client-russian\";i:1;s:33:\"contract-comment-to-admin-russian\";i:1;s:25:\"send-subscription-russian\";i:1;s:35:\"subscription-payment-failed-russian\";i:1;s:29:\"subscription-canceled-russian\";i:1;s:38:\"subscription-payment-succeeded-russian\";i:1;s:36:\"contract-expiration-to-staff-russian\";i:1;s:28:\"gdpr-removal-request-russian\";i:1;s:33:\"gdpr-removal-request-lead-russian\";i:1;s:37:\"client-registration-confirmed-russian\";i:1;s:32:\"contract-signed-to-staff-russian\";i:1;s:36:\"customer-subscribed-to-staff-russian\";i:1;s:34:\"contact-verification-email-russian\";i:1;s:51:\"new-customer-profile-file-uploaded-to-staff-russian\";i:1;s:35:\"event-notification-to-staff-russian\";i:1;s:26:\"new-client-created-chinese\";i:1;s:30:\"invoice-send-to-client-chinese\";i:1;s:31:\"new-ticket-opened-admin-chinese\";i:1;s:20:\"ticket-reply-chinese\";i:1;s:27:\"ticket-autoresponse-chinese\";i:1;s:32:\"invoice-payment-recorded-chinese\";i:1;s:30:\"invoice-overdue-notice-chinese\";i:1;s:28:\"invoice-already-send-chinese\";i:1;s:32:\"new-ticket-created-staff-chinese\";i:1;s:31:\"estimate-send-to-client-chinese\";i:1;s:29:\"ticket-reply-to-admin-chinese\";i:1;s:29:\"estimate-already-send-chinese\";i:1;s:27:\"contract-expiration-chinese\";i:1;s:21:\"task-assigned-chinese\";i:1;s:30:\"task-added-as-follower-chinese\";i:1;s:22:\"task-commented-chinese\";i:1;s:29:\"task-added-attachment-chinese\";i:1;s:34:\"estimate-declined-to-staff-chinese\";i:1;s:34:\"estimate-accepted-to-staff-chinese\";i:1;s:32:\"proposal-client-accepted-chinese\";i:1;s:33:\"proposal-send-to-customer-chinese\";i:1;s:32:\"proposal-client-declined-chinese\";i:1;s:33:\"proposal-client-thank-you-chinese\";i:1;s:34:\"proposal-comment-to-client-chinese\";i:1;s:33:\"proposal-comment-to-admin-chinese\";i:1;s:38:\"estimate-thank-you-to-customer-chinese\";i:1;s:34:\"task-deadline-notification-chinese\";i:1;s:21:\"send-contract-chinese\";i:1;s:41:\"invoice-payment-recorded-to-staff-chinese\";i:1;s:25:\"auto-close-ticket-chinese\";i:1;s:47:\"new-project-discussion-created-to-staff-chinese\";i:1;s:50:\"new-project-discussion-created-to-customer-chinese\";i:1;s:45:\"new-project-file-uploaded-to-customer-chinese\";i:1;s:42:\"new-project-file-uploaded-to-staff-chinese\";i:1;s:50:\"new-project-discussion-comment-to-customer-chinese\";i:1;s:47:\"new-project-discussion-comment-to-staff-chinese\";i:1;s:37:\"staff-added-as-project-member-chinese\";i:1;s:32:\"estimate-expiry-reminder-chinese\";i:1;s:32:\"proposal-expiry-reminder-chinese\";i:1;s:25:\"new-staff-created-chinese\";i:1;s:31:\"contact-forgot-password-chinese\";i:1;s:32:\"contact-password-reseted-chinese\";i:1;s:28:\"contact-set-password-chinese\";i:1;s:29:\"staff-forgot-password-chinese\";i:1;s:30:\"staff-password-reseted-chinese\";i:1;s:27:\"assigned-to-project-chinese\";i:1;s:41:\"task-added-attachment-to-contacts-chinese\";i:1;s:34:\"task-commented-to-contacts-chinese\";i:1;s:25:\"new-lead-assigned-chinese\";i:1;s:24:\"client-statement-chinese\";i:1;s:32:\"ticket-assigned-to-admin-chinese\";i:1;s:38:\"new-client-registered-to-admin-chinese\";i:1;s:38:\"new-web-to-lead-form-submitted-chinese\";i:1;s:33:\"two-factor-authentication-chinese\";i:1;s:36:\"project-finished-to-customer-chinese\";i:1;s:34:\"credit-note-send-to-client-chinese\";i:1;s:35:\"task-status-change-to-staff-chinese\";i:1;s:38:\"task-status-change-to-contacts-chinese\";i:1;s:28:\"reminder-email-staff-chinese\";i:1;s:34:\"contract-comment-to-client-chinese\";i:1;s:33:\"contract-comment-to-admin-chinese\";i:1;s:25:\"send-subscription-chinese\";i:1;s:35:\"subscription-payment-failed-chinese\";i:1;s:29:\"subscription-canceled-chinese\";i:1;s:38:\"subscription-payment-succeeded-chinese\";i:1;s:36:\"contract-expiration-to-staff-chinese\";i:1;s:28:\"gdpr-removal-request-chinese\";i:1;s:33:\"gdpr-removal-request-lead-chinese\";i:1;s:37:\"client-registration-confirmed-chinese\";i:1;s:32:\"contract-signed-to-staff-chinese\";i:1;s:36:\"customer-subscribed-to-staff-chinese\";i:1;s:34:\"contact-verification-email-chinese\";i:1;s:51:\"new-customer-profile-file-uploaded-to-staff-chinese\";i:1;s:35:\"event-notification-to-staff-chinese\";i:1;s:24:\"new-client-created-dutch\";i:1;s:28:\"invoice-send-to-client-dutch\";i:1;s:29:\"new-ticket-opened-admin-dutch\";i:1;s:18:\"ticket-reply-dutch\";i:1;s:25:\"ticket-autoresponse-dutch\";i:1;s:30:\"invoice-payment-recorded-dutch\";i:1;s:28:\"invoice-overdue-notice-dutch\";i:1;s:26:\"invoice-already-send-dutch\";i:1;s:30:\"new-ticket-created-staff-dutch\";i:1;s:29:\"estimate-send-to-client-dutch\";i:1;s:27:\"ticket-reply-to-admin-dutch\";i:1;s:27:\"estimate-already-send-dutch\";i:1;s:25:\"contract-expiration-dutch\";i:1;s:19:\"task-assigned-dutch\";i:1;s:28:\"task-added-as-follower-dutch\";i:1;s:20:\"task-commented-dutch\";i:1;s:27:\"task-added-attachment-dutch\";i:1;s:32:\"estimate-declined-to-staff-dutch\";i:1;s:32:\"estimate-accepted-to-staff-dutch\";i:1;s:30:\"proposal-client-accepted-dutch\";i:1;s:31:\"proposal-send-to-customer-dutch\";i:1;s:30:\"proposal-client-declined-dutch\";i:1;s:31:\"proposal-client-thank-you-dutch\";i:1;s:32:\"proposal-comment-to-client-dutch\";i:1;s:31:\"proposal-comment-to-admin-dutch\";i:1;s:36:\"estimate-thank-you-to-customer-dutch\";i:1;s:32:\"task-deadline-notification-dutch\";i:1;s:19:\"send-contract-dutch\";i:1;s:39:\"invoice-payment-recorded-to-staff-dutch\";i:1;s:23:\"auto-close-ticket-dutch\";i:1;s:45:\"new-project-discussion-created-to-staff-dutch\";i:1;s:48:\"new-project-discussion-created-to-customer-dutch\";i:1;s:43:\"new-project-file-uploaded-to-customer-dutch\";i:1;s:40:\"new-project-file-uploaded-to-staff-dutch\";i:1;s:48:\"new-project-discussion-comment-to-customer-dutch\";i:1;s:45:\"new-project-discussion-comment-to-staff-dutch\";i:1;s:35:\"staff-added-as-project-member-dutch\";i:1;s:30:\"estimate-expiry-reminder-dutch\";i:1;s:30:\"proposal-expiry-reminder-dutch\";i:1;s:23:\"new-staff-created-dutch\";i:1;s:29:\"contact-forgot-password-dutch\";i:1;s:30:\"contact-password-reseted-dutch\";i:1;s:26:\"contact-set-password-dutch\";i:1;s:27:\"staff-forgot-password-dutch\";i:1;s:28:\"staff-password-reseted-dutch\";i:1;s:25:\"assigned-to-project-dutch\";i:1;s:39:\"task-added-attachment-to-contacts-dutch\";i:1;s:32:\"task-commented-to-contacts-dutch\";i:1;s:23:\"new-lead-assigned-dutch\";i:1;s:22:\"client-statement-dutch\";i:1;s:30:\"ticket-assigned-to-admin-dutch\";i:1;s:36:\"new-client-registered-to-admin-dutch\";i:1;s:36:\"new-web-to-lead-form-submitted-dutch\";i:1;s:31:\"two-factor-authentication-dutch\";i:1;s:34:\"project-finished-to-customer-dutch\";i:1;s:32:\"credit-note-send-to-client-dutch\";i:1;s:33:\"task-status-change-to-staff-dutch\";i:1;s:36:\"task-status-change-to-contacts-dutch\";i:1;s:26:\"reminder-email-staff-dutch\";i:1;s:32:\"contract-comment-to-client-dutch\";i:1;s:31:\"contract-comment-to-admin-dutch\";i:1;s:23:\"send-subscription-dutch\";i:1;s:33:\"subscription-payment-failed-dutch\";i:1;s:27:\"subscription-canceled-dutch\";i:1;s:36:\"subscription-payment-succeeded-dutch\";i:1;s:34:\"contract-expiration-to-staff-dutch\";i:1;s:26:\"gdpr-removal-request-dutch\";i:1;s:31:\"gdpr-removal-request-lead-dutch\";i:1;s:35:\"client-registration-confirmed-dutch\";i:1;s:30:\"contract-signed-to-staff-dutch\";i:1;s:34:\"customer-subscribed-to-staff-dutch\";i:1;s:32:\"contact-verification-email-dutch\";i:1;s:49:\"new-customer-profile-file-uploaded-to-staff-dutch\";i:1;s:33:\"event-notification-to-staff-dutch\";i:1;s:26:\"new-client-created-catalan\";i:1;s:30:\"invoice-send-to-client-catalan\";i:1;s:31:\"new-ticket-opened-admin-catalan\";i:1;s:20:\"ticket-reply-catalan\";i:1;s:27:\"ticket-autoresponse-catalan\";i:1;s:32:\"invoice-payment-recorded-catalan\";i:1;s:30:\"invoice-overdue-notice-catalan\";i:1;s:28:\"invoice-already-send-catalan\";i:1;s:32:\"new-ticket-created-staff-catalan\";i:1;s:31:\"estimate-send-to-client-catalan\";i:1;s:29:\"ticket-reply-to-admin-catalan\";i:1;s:29:\"estimate-already-send-catalan\";i:1;s:27:\"contract-expiration-catalan\";i:1;s:21:\"task-assigned-catalan\";i:1;s:30:\"task-added-as-follower-catalan\";i:1;s:22:\"task-commented-catalan\";i:1;s:29:\"task-added-attachment-catalan\";i:1;s:34:\"estimate-declined-to-staff-catalan\";i:1;s:34:\"estimate-accepted-to-staff-catalan\";i:1;s:32:\"proposal-client-accepted-catalan\";i:1;s:33:\"proposal-send-to-customer-catalan\";i:1;s:32:\"proposal-client-declined-catalan\";i:1;s:33:\"proposal-client-thank-you-catalan\";i:1;s:34:\"proposal-comment-to-client-catalan\";i:1;s:33:\"proposal-comment-to-admin-catalan\";i:1;s:38:\"estimate-thank-you-to-customer-catalan\";i:1;s:34:\"task-deadline-notification-catalan\";i:1;s:21:\"send-contract-catalan\";i:1;s:41:\"invoice-payment-recorded-to-staff-catalan\";i:1;s:25:\"auto-close-ticket-catalan\";i:1;s:47:\"new-project-discussion-created-to-staff-catalan\";i:1;s:50:\"new-project-discussion-created-to-customer-catalan\";i:1;s:45:\"new-project-file-uploaded-to-customer-catalan\";i:1;s:42:\"new-project-file-uploaded-to-staff-catalan\";i:1;s:50:\"new-project-discussion-comment-to-customer-catalan\";i:1;s:47:\"new-project-discussion-comment-to-staff-catalan\";i:1;s:37:\"staff-added-as-project-member-catalan\";i:1;s:32:\"estimate-expiry-reminder-catalan\";i:1;s:32:\"proposal-expiry-reminder-catalan\";i:1;s:25:\"new-staff-created-catalan\";i:1;s:31:\"contact-forgot-password-catalan\";i:1;s:32:\"contact-password-reseted-catalan\";i:1;s:28:\"contact-set-password-catalan\";i:1;s:29:\"staff-forgot-password-catalan\";i:1;s:30:\"staff-password-reseted-catalan\";i:1;s:27:\"assigned-to-project-catalan\";i:1;s:41:\"task-added-attachment-to-contacts-catalan\";i:1;s:34:\"task-commented-to-contacts-catalan\";i:1;s:25:\"new-lead-assigned-catalan\";i:1;s:24:\"client-statement-catalan\";i:1;s:32:\"ticket-assigned-to-admin-catalan\";i:1;s:38:\"new-client-registered-to-admin-catalan\";i:1;s:38:\"new-web-to-lead-form-submitted-catalan\";i:1;s:33:\"two-factor-authentication-catalan\";i:1;s:36:\"project-finished-to-customer-catalan\";i:1;s:34:\"credit-note-send-to-client-catalan\";i:1;s:35:\"task-status-change-to-staff-catalan\";i:1;s:38:\"task-status-change-to-contacts-catalan\";i:1;s:28:\"reminder-email-staff-catalan\";i:1;s:34:\"contract-comment-to-client-catalan\";i:1;s:33:\"contract-comment-to-admin-catalan\";i:1;s:25:\"send-subscription-catalan\";i:1;s:35:\"subscription-payment-failed-catalan\";i:1;s:29:\"subscription-canceled-catalan\";i:1;s:38:\"subscription-payment-succeeded-catalan\";i:1;s:36:\"contract-expiration-to-staff-catalan\";i:1;s:28:\"gdpr-removal-request-catalan\";i:1;s:33:\"gdpr-removal-request-lead-catalan\";i:1;s:37:\"client-registration-confirmed-catalan\";i:1;s:32:\"contract-signed-to-staff-catalan\";i:1;s:36:\"customer-subscribed-to-staff-catalan\";i:1;s:34:\"contact-verification-email-catalan\";i:1;s:51:\"new-customer-profile-file-uploaded-to-staff-catalan\";i:1;s:35:\"event-notification-to-staff-catalan\";i:1;s:25:\"new-client-created-polish\";i:1;s:29:\"invoice-send-to-client-polish\";i:1;s:30:\"new-ticket-opened-admin-polish\";i:1;s:19:\"ticket-reply-polish\";i:1;s:26:\"ticket-autoresponse-polish\";i:1;s:31:\"invoice-payment-recorded-polish\";i:1;s:29:\"invoice-overdue-notice-polish\";i:1;s:27:\"invoice-already-send-polish\";i:1;s:31:\"new-ticket-created-staff-polish\";i:1;s:30:\"estimate-send-to-client-polish\";i:1;s:28:\"ticket-reply-to-admin-polish\";i:1;s:28:\"estimate-already-send-polish\";i:1;s:26:\"contract-expiration-polish\";i:1;s:20:\"task-assigned-polish\";i:1;s:29:\"task-added-as-follower-polish\";i:1;s:21:\"task-commented-polish\";i:1;s:28:\"task-added-attachment-polish\";i:1;s:33:\"estimate-declined-to-staff-polish\";i:1;s:33:\"estimate-accepted-to-staff-polish\";i:1;s:31:\"proposal-client-accepted-polish\";i:1;s:32:\"proposal-send-to-customer-polish\";i:1;s:31:\"proposal-client-declined-polish\";i:1;s:32:\"proposal-client-thank-you-polish\";i:1;s:33:\"proposal-comment-to-client-polish\";i:1;s:32:\"proposal-comment-to-admin-polish\";i:1;s:37:\"estimate-thank-you-to-customer-polish\";i:1;s:33:\"task-deadline-notification-polish\";i:1;s:20:\"send-contract-polish\";i:1;s:40:\"invoice-payment-recorded-to-staff-polish\";i:1;s:24:\"auto-close-ticket-polish\";i:1;s:46:\"new-project-discussion-created-to-staff-polish\";i:1;s:49:\"new-project-discussion-created-to-customer-polish\";i:1;s:44:\"new-project-file-uploaded-to-customer-polish\";i:1;s:41:\"new-project-file-uploaded-to-staff-polish\";i:1;s:49:\"new-project-discussion-comment-to-customer-polish\";i:1;s:46:\"new-project-discussion-comment-to-staff-polish\";i:1;s:36:\"staff-added-as-project-member-polish\";i:1;s:31:\"estimate-expiry-reminder-polish\";i:1;s:31:\"proposal-expiry-reminder-polish\";i:1;s:24:\"new-staff-created-polish\";i:1;s:30:\"contact-forgot-password-polish\";i:1;s:31:\"contact-password-reseted-polish\";i:1;s:27:\"contact-set-password-polish\";i:1;s:28:\"staff-forgot-password-polish\";i:1;s:29:\"staff-password-reseted-polish\";i:1;s:26:\"assigned-to-project-polish\";i:1;s:40:\"task-added-attachment-to-contacts-polish\";i:1;s:33:\"task-commented-to-contacts-polish\";i:1;s:24:\"new-lead-assigned-polish\";i:1;s:23:\"client-statement-polish\";i:1;s:31:\"ticket-assigned-to-admin-polish\";i:1;s:37:\"new-client-registered-to-admin-polish\";i:1;s:37:\"new-web-to-lead-form-submitted-polish\";i:1;s:32:\"two-factor-authentication-polish\";i:1;s:35:\"project-finished-to-customer-polish\";i:1;s:33:\"credit-note-send-to-client-polish\";i:1;s:34:\"task-status-change-to-staff-polish\";i:1;s:37:\"task-status-change-to-contacts-polish\";i:1;s:27:\"reminder-email-staff-polish\";i:1;s:33:\"contract-comment-to-client-polish\";i:1;s:32:\"contract-comment-to-admin-polish\";i:1;s:24:\"send-subscription-polish\";i:1;s:34:\"subscription-payment-failed-polish\";i:1;s:28:\"subscription-canceled-polish\";i:1;s:37:\"subscription-payment-succeeded-polish\";i:1;s:35:\"contract-expiration-to-staff-polish\";i:1;s:27:\"gdpr-removal-request-polish\";i:1;s:32:\"gdpr-removal-request-lead-polish\";i:1;s:36:\"client-registration-confirmed-polish\";i:1;s:31:\"contract-signed-to-staff-polish\";i:1;s:35:\"customer-subscribed-to-staff-polish\";i:1;s:33:\"contact-verification-email-polish\";i:1;s:50:\"new-customer-profile-file-uploaded-to-staff-polish\";i:1;s:34:\"event-notification-to-staff-polish\";i:1;s:27:\"new-client-created-romanian\";i:1;s:31:\"invoice-send-to-client-romanian\";i:1;s:32:\"new-ticket-opened-admin-romanian\";i:1;s:21:\"ticket-reply-romanian\";i:1;s:28:\"ticket-autoresponse-romanian\";i:1;s:33:\"invoice-payment-recorded-romanian\";i:1;s:31:\"invoice-overdue-notice-romanian\";i:1;s:29:\"invoice-already-send-romanian\";i:1;s:33:\"new-ticket-created-staff-romanian\";i:1;s:32:\"estimate-send-to-client-romanian\";i:1;s:30:\"ticket-reply-to-admin-romanian\";i:1;s:30:\"estimate-already-send-romanian\";i:1;s:28:\"contract-expiration-romanian\";i:1;s:22:\"task-assigned-romanian\";i:1;s:31:\"task-added-as-follower-romanian\";i:1;s:23:\"task-commented-romanian\";i:1;s:30:\"task-added-attachment-romanian\";i:1;s:35:\"estimate-declined-to-staff-romanian\";i:1;s:35:\"estimate-accepted-to-staff-romanian\";i:1;s:33:\"proposal-client-accepted-romanian\";i:1;s:34:\"proposal-send-to-customer-romanian\";i:1;s:33:\"proposal-client-declined-romanian\";i:1;s:34:\"proposal-client-thank-you-romanian\";i:1;s:35:\"proposal-comment-to-client-romanian\";i:1;s:34:\"proposal-comment-to-admin-romanian\";i:1;s:39:\"estimate-thank-you-to-customer-romanian\";i:1;s:35:\"task-deadline-notification-romanian\";i:1;s:22:\"send-contract-romanian\";i:1;s:42:\"invoice-payment-recorded-to-staff-romanian\";i:1;s:26:\"auto-close-ticket-romanian\";i:1;s:48:\"new-project-discussion-created-to-staff-romanian\";i:1;s:51:\"new-project-discussion-created-to-customer-romanian\";i:1;s:46:\"new-project-file-uploaded-to-customer-romanian\";i:1;s:43:\"new-project-file-uploaded-to-staff-romanian\";i:1;s:51:\"new-project-discussion-comment-to-customer-romanian\";i:1;s:48:\"new-project-discussion-comment-to-staff-romanian\";i:1;s:38:\"staff-added-as-project-member-romanian\";i:1;s:33:\"estimate-expiry-reminder-romanian\";i:1;s:33:\"proposal-expiry-reminder-romanian\";i:1;s:26:\"new-staff-created-romanian\";i:1;s:32:\"contact-forgot-password-romanian\";i:1;s:33:\"contact-password-reseted-romanian\";i:1;s:29:\"contact-set-password-romanian\";i:1;s:30:\"staff-forgot-password-romanian\";i:1;s:31:\"staff-password-reseted-romanian\";i:1;s:28:\"assigned-to-project-romanian\";i:1;s:42:\"task-added-attachment-to-contacts-romanian\";i:1;s:35:\"task-commented-to-contacts-romanian\";i:1;s:26:\"new-lead-assigned-romanian\";i:1;s:25:\"client-statement-romanian\";i:1;s:33:\"ticket-assigned-to-admin-romanian\";i:1;s:39:\"new-client-registered-to-admin-romanian\";i:1;s:39:\"new-web-to-lead-form-submitted-romanian\";i:1;s:34:\"two-factor-authentication-romanian\";i:1;s:37:\"project-finished-to-customer-romanian\";i:1;s:35:\"credit-note-send-to-client-romanian\";i:1;s:36:\"task-status-change-to-staff-romanian\";i:1;s:39:\"task-status-change-to-contacts-romanian\";i:1;s:29:\"reminder-email-staff-romanian\";i:1;s:35:\"contract-comment-to-client-romanian\";i:1;s:34:\"contract-comment-to-admin-romanian\";i:1;s:26:\"send-subscription-romanian\";i:1;s:36:\"subscription-payment-failed-romanian\";i:1;s:30:\"subscription-canceled-romanian\";i:1;s:39:\"subscription-payment-succeeded-romanian\";i:1;s:37:\"contract-expiration-to-staff-romanian\";i:1;s:29:\"gdpr-removal-request-romanian\";i:1;s:34:\"gdpr-removal-request-lead-romanian\";i:1;s:38:\"client-registration-confirmed-romanian\";i:1;s:33:\"contract-signed-to-staff-romanian\";i:1;s:37:\"customer-subscribed-to-staff-romanian\";i:1;s:35:\"contact-verification-email-romanian\";i:1;s:52:\"new-customer-profile-file-uploaded-to-staff-romanian\";i:1;s:36:\"event-notification-to-staff-romanian\";i:1;s:28:\"new-client-created-indonesia\";i:1;s:32:\"invoice-send-to-client-indonesia\";i:1;s:33:\"new-ticket-opened-admin-indonesia\";i:1;s:22:\"ticket-reply-indonesia\";i:1;s:29:\"ticket-autoresponse-indonesia\";i:1;s:34:\"invoice-payment-recorded-indonesia\";i:1;s:32:\"invoice-overdue-notice-indonesia\";i:1;s:30:\"invoice-already-send-indonesia\";i:1;s:34:\"new-ticket-created-staff-indonesia\";i:1;s:33:\"estimate-send-to-client-indonesia\";i:1;s:31:\"ticket-reply-to-admin-indonesia\";i:1;s:31:\"estimate-already-send-indonesia\";i:1;s:29:\"contract-expiration-indonesia\";i:1;s:23:\"task-assigned-indonesia\";i:1;s:32:\"task-added-as-follower-indonesia\";i:1;s:24:\"task-commented-indonesia\";i:1;s:31:\"task-added-attachment-indonesia\";i:1;s:36:\"estimate-declined-to-staff-indonesia\";i:1;s:36:\"estimate-accepted-to-staff-indonesia\";i:1;s:34:\"proposal-client-accepted-indonesia\";i:1;s:35:\"proposal-send-to-customer-indonesia\";i:1;s:34:\"proposal-client-declined-indonesia\";i:1;s:35:\"proposal-client-thank-you-indonesia\";i:1;s:36:\"proposal-comment-to-client-indonesia\";i:1;s:35:\"proposal-comment-to-admin-indonesia\";i:1;s:40:\"estimate-thank-you-to-customer-indonesia\";i:1;s:36:\"task-deadline-notification-indonesia\";i:1;s:23:\"send-contract-indonesia\";i:1;s:43:\"invoice-payment-recorded-to-staff-indonesia\";i:1;s:27:\"auto-close-ticket-indonesia\";i:1;s:49:\"new-project-discussion-created-to-staff-indonesia\";i:1;s:52:\"new-project-discussion-created-to-customer-indonesia\";i:1;s:47:\"new-project-file-uploaded-to-customer-indonesia\";i:1;s:44:\"new-project-file-uploaded-to-staff-indonesia\";i:1;s:52:\"new-project-discussion-comment-to-customer-indonesia\";i:1;s:49:\"new-project-discussion-comment-to-staff-indonesia\";i:1;s:39:\"staff-added-as-project-member-indonesia\";i:1;s:34:\"estimate-expiry-reminder-indonesia\";i:1;s:34:\"proposal-expiry-reminder-indonesia\";i:1;s:27:\"new-staff-created-indonesia\";i:1;s:33:\"contact-forgot-password-indonesia\";i:1;s:34:\"contact-password-reseted-indonesia\";i:1;s:30:\"contact-set-password-indonesia\";i:1;s:31:\"staff-forgot-password-indonesia\";i:1;s:32:\"staff-password-reseted-indonesia\";i:1;s:29:\"assigned-to-project-indonesia\";i:1;s:43:\"task-added-attachment-to-contacts-indonesia\";i:1;s:36:\"task-commented-to-contacts-indonesia\";i:1;s:27:\"new-lead-assigned-indonesia\";i:1;s:26:\"client-statement-indonesia\";i:1;s:34:\"ticket-assigned-to-admin-indonesia\";i:1;s:40:\"new-client-registered-to-admin-indonesia\";i:1;s:40:\"new-web-to-lead-form-submitted-indonesia\";i:1;s:35:\"two-factor-authentication-indonesia\";i:1;s:38:\"project-finished-to-customer-indonesia\";i:1;s:36:\"credit-note-send-to-client-indonesia\";i:1;s:37:\"task-status-change-to-staff-indonesia\";i:1;s:40:\"task-status-change-to-contacts-indonesia\";i:1;s:30:\"reminder-email-staff-indonesia\";i:1;s:36:\"contract-comment-to-client-indonesia\";i:1;s:35:\"contract-comment-to-admin-indonesia\";i:1;s:27:\"send-subscription-indonesia\";i:1;s:37:\"subscription-payment-failed-indonesia\";i:1;s:31:\"subscription-canceled-indonesia\";i:1;s:40:\"subscription-payment-succeeded-indonesia\";i:1;s:38:\"contract-expiration-to-staff-indonesia\";i:1;s:30:\"gdpr-removal-request-indonesia\";i:1;s:35:\"gdpr-removal-request-lead-indonesia\";i:1;s:39:\"client-registration-confirmed-indonesia\";i:1;s:34:\"contract-signed-to-staff-indonesia\";i:1;s:38:\"customer-subscribed-to-staff-indonesia\";i:1;s:36:\"contact-verification-email-indonesia\";i:1;s:53:\"new-customer-profile-file-uploaded-to-staff-indonesia\";i:1;s:37:\"event-notification-to-staff-indonesia\";i:1;s:25:\"new-client-created-french\";i:1;s:29:\"invoice-send-to-client-french\";i:1;s:30:\"new-ticket-opened-admin-french\";i:1;s:19:\"ticket-reply-french\";i:1;s:26:\"ticket-autoresponse-french\";i:1;s:31:\"invoice-payment-recorded-french\";i:1;s:29:\"invoice-overdue-notice-french\";i:1;s:27:\"invoice-already-send-french\";i:1;s:31:\"new-ticket-created-staff-french\";i:1;s:30:\"estimate-send-to-client-french\";i:1;s:28:\"ticket-reply-to-admin-french\";i:1;s:28:\"estimate-already-send-french\";i:1;s:26:\"contract-expiration-french\";i:1;s:20:\"task-assigned-french\";i:1;s:29:\"task-added-as-follower-french\";i:1;s:21:\"task-commented-french\";i:1;s:28:\"task-added-attachment-french\";i:1;s:33:\"estimate-declined-to-staff-french\";i:1;s:33:\"estimate-accepted-to-staff-french\";i:1;s:31:\"proposal-client-accepted-french\";i:1;s:32:\"proposal-send-to-customer-french\";i:1;s:31:\"proposal-client-declined-french\";i:1;s:32:\"proposal-client-thank-you-french\";i:1;s:33:\"proposal-comment-to-client-french\";i:1;s:32:\"proposal-comment-to-admin-french\";i:1;s:37:\"estimate-thank-you-to-customer-french\";i:1;s:33:\"task-deadline-notification-french\";i:1;s:20:\"send-contract-french\";i:1;s:40:\"invoice-payment-recorded-to-staff-french\";i:1;s:24:\"auto-close-ticket-french\";i:1;s:46:\"new-project-discussion-created-to-staff-french\";i:1;s:49:\"new-project-discussion-created-to-customer-french\";i:1;s:44:\"new-project-file-uploaded-to-customer-french\";i:1;s:41:\"new-project-file-uploaded-to-staff-french\";i:1;s:49:\"new-project-discussion-comment-to-customer-french\";i:1;s:46:\"new-project-discussion-comment-to-staff-french\";i:1;s:36:\"staff-added-as-project-member-french\";i:1;s:31:\"estimate-expiry-reminder-french\";i:1;s:31:\"proposal-expiry-reminder-french\";i:1;s:24:\"new-staff-created-french\";i:1;s:30:\"contact-forgot-password-french\";i:1;s:31:\"contact-password-reseted-french\";i:1;s:27:\"contact-set-password-french\";i:1;s:28:\"staff-forgot-password-french\";i:1;s:29:\"staff-password-reseted-french\";i:1;s:26:\"assigned-to-project-french\";i:1;s:40:\"task-added-attachment-to-contacts-french\";i:1;s:33:\"task-commented-to-contacts-french\";i:1;s:24:\"new-lead-assigned-french\";i:1;s:23:\"client-statement-french\";i:1;s:31:\"ticket-assigned-to-admin-french\";i:1;s:37:\"new-client-registered-to-admin-french\";i:1;s:37:\"new-web-to-lead-form-submitted-french\";i:1;s:32:\"two-factor-authentication-french\";i:1;s:35:\"project-finished-to-customer-french\";i:1;s:33:\"credit-note-send-to-client-french\";i:1;s:34:\"task-status-change-to-staff-french\";i:1;s:37:\"task-status-change-to-contacts-french\";i:1;s:27:\"reminder-email-staff-french\";i:1;s:33:\"contract-comment-to-client-french\";i:1;s:32:\"contract-comment-to-admin-french\";i:1;s:24:\"send-subscription-french\";i:1;s:34:\"subscription-payment-failed-french\";i:1;s:28:\"subscription-canceled-french\";i:1;s:37:\"subscription-payment-succeeded-french\";i:1;s:35:\"contract-expiration-to-staff-french\";i:1;s:27:\"gdpr-removal-request-french\";i:1;s:32:\"gdpr-removal-request-lead-french\";i:1;s:36:\"client-registration-confirmed-french\";i:1;s:31:\"contract-signed-to-staff-french\";i:1;s:35:\"customer-subscribed-to-staff-french\";i:1;s:33:\"contact-verification-email-french\";i:1;s:50:\"new-customer-profile-file-uploaded-to-staff-french\";i:1;s:34:\"event-notification-to-staff-french\";i:1;s:26:\"new-client-created-turkish\";i:1;s:30:\"invoice-send-to-client-turkish\";i:1;s:31:\"new-ticket-opened-admin-turkish\";i:1;s:20:\"ticket-reply-turkish\";i:1;s:27:\"ticket-autoresponse-turkish\";i:1;s:32:\"invoice-payment-recorded-turkish\";i:1;s:30:\"invoice-overdue-notice-turkish\";i:1;s:28:\"invoice-already-send-turkish\";i:1;s:32:\"new-ticket-created-staff-turkish\";i:1;s:31:\"estimate-send-to-client-turkish\";i:1;s:29:\"ticket-reply-to-admin-turkish\";i:1;s:29:\"estimate-already-send-turkish\";i:1;s:27:\"contract-expiration-turkish\";i:1;s:21:\"task-assigned-turkish\";i:1;s:30:\"task-added-as-follower-turkish\";i:1;s:22:\"task-commented-turkish\";i:1;s:29:\"task-added-attachment-turkish\";i:1;s:34:\"estimate-declined-to-staff-turkish\";i:1;s:34:\"estimate-accepted-to-staff-turkish\";i:1;s:32:\"proposal-client-accepted-turkish\";i:1;s:33:\"proposal-send-to-customer-turkish\";i:1;s:32:\"proposal-client-declined-turkish\";i:1;s:33:\"proposal-client-thank-you-turkish\";i:1;s:34:\"proposal-comment-to-client-turkish\";i:1;s:33:\"proposal-comment-to-admin-turkish\";i:1;s:38:\"estimate-thank-you-to-customer-turkish\";i:1;s:34:\"task-deadline-notification-turkish\";i:1;s:21:\"send-contract-turkish\";i:1;s:41:\"invoice-payment-recorded-to-staff-turkish\";i:1;s:25:\"auto-close-ticket-turkish\";i:1;s:47:\"new-project-discussion-created-to-staff-turkish\";i:1;s:50:\"new-project-discussion-created-to-customer-turkish\";i:1;s:45:\"new-project-file-uploaded-to-customer-turkish\";i:1;s:42:\"new-project-file-uploaded-to-staff-turkish\";i:1;s:50:\"new-project-discussion-comment-to-customer-turkish\";i:1;s:47:\"new-project-discussion-comment-to-staff-turkish\";i:1;s:37:\"staff-added-as-project-member-turkish\";i:1;s:32:\"estimate-expiry-reminder-turkish\";i:1;s:32:\"proposal-expiry-reminder-turkish\";i:1;s:25:\"new-staff-created-turkish\";i:1;s:31:\"contact-forgot-password-turkish\";i:1;s:32:\"contact-password-reseted-turkish\";i:1;s:28:\"contact-set-password-turkish\";i:1;s:29:\"staff-forgot-password-turkish\";i:1;s:30:\"staff-password-reseted-turkish\";i:1;s:27:\"assigned-to-project-turkish\";i:1;s:41:\"task-added-attachment-to-contacts-turkish\";i:1;s:34:\"task-commented-to-contacts-turkish\";i:1;s:25:\"new-lead-assigned-turkish\";i:1;s:24:\"client-statement-turkish\";i:1;s:32:\"ticket-assigned-to-admin-turkish\";i:1;s:38:\"new-client-registered-to-admin-turkish\";i:1;s:38:\"new-web-to-lead-form-submitted-turkish\";i:1;s:33:\"two-factor-authentication-turkish\";i:1;s:36:\"project-finished-to-customer-turkish\";i:1;s:34:\"credit-note-send-to-client-turkish\";i:1;s:35:\"task-status-change-to-staff-turkish\";i:1;s:38:\"task-status-change-to-contacts-turkish\";i:1;s:28:\"reminder-email-staff-turkish\";i:1;s:34:\"contract-comment-to-client-turkish\";i:1;s:33:\"contract-comment-to-admin-turkish\";i:1;s:25:\"send-subscription-turkish\";i:1;s:35:\"subscription-payment-failed-turkish\";i:1;s:29:\"subscription-canceled-turkish\";i:1;s:38:\"subscription-payment-succeeded-turkish\";i:1;s:36:\"contract-expiration-to-staff-turkish\";i:1;s:28:\"gdpr-removal-request-turkish\";i:1;s:33:\"gdpr-removal-request-lead-turkish\";i:1;s:37:\"client-registration-confirmed-turkish\";i:1;s:32:\"contract-signed-to-staff-turkish\";i:1;s:36:\"customer-subscribed-to-staff-turkish\";i:1;s:34:\"contact-verification-email-turkish\";i:1;s:51:\"new-customer-profile-file-uploaded-to-staff-turkish\";i:1;s:35:\"event-notification-to-staff-turkish\";i:1;s:26:\"new-client-created-italian\";i:1;s:30:\"invoice-send-to-client-italian\";i:1;s:31:\"new-ticket-opened-admin-italian\";i:1;s:20:\"ticket-reply-italian\";i:1;s:27:\"ticket-autoresponse-italian\";i:1;s:32:\"invoice-payment-recorded-italian\";i:1;s:30:\"invoice-overdue-notice-italian\";i:1;s:28:\"invoice-already-send-italian\";i:1;s:32:\"new-ticket-created-staff-italian\";i:1;s:31:\"estimate-send-to-client-italian\";i:1;s:29:\"ticket-reply-to-admin-italian\";i:1;s:29:\"estimate-already-send-italian\";i:1;s:27:\"contract-expiration-italian\";i:1;s:21:\"task-assigned-italian\";i:1;s:30:\"task-added-as-follower-italian\";i:1;s:22:\"task-commented-italian\";i:1;s:29:\"task-added-attachment-italian\";i:1;s:34:\"estimate-declined-to-staff-italian\";i:1;s:34:\"estimate-accepted-to-staff-italian\";i:1;s:32:\"proposal-client-accepted-italian\";i:1;s:33:\"proposal-send-to-customer-italian\";i:1;s:32:\"proposal-client-declined-italian\";i:1;s:33:\"proposal-client-thank-you-italian\";i:1;s:34:\"proposal-comment-to-client-italian\";i:1;s:33:\"proposal-comment-to-admin-italian\";i:1;s:38:\"estimate-thank-you-to-customer-italian\";i:1;s:34:\"task-deadline-notification-italian\";i:1;s:21:\"send-contract-italian\";i:1;s:41:\"invoice-payment-recorded-to-staff-italian\";i:1;s:25:\"auto-close-ticket-italian\";i:1;s:47:\"new-project-discussion-created-to-staff-italian\";i:1;s:50:\"new-project-discussion-created-to-customer-italian\";i:1;s:45:\"new-project-file-uploaded-to-customer-italian\";i:1;s:42:\"new-project-file-uploaded-to-staff-italian\";i:1;s:50:\"new-project-discussion-comment-to-customer-italian\";i:1;s:47:\"new-project-discussion-comment-to-staff-italian\";i:1;s:37:\"staff-added-as-project-member-italian\";i:1;s:32:\"estimate-expiry-reminder-italian\";i:1;s:32:\"proposal-expiry-reminder-italian\";i:1;s:25:\"new-staff-created-italian\";i:1;s:31:\"contact-forgot-password-italian\";i:1;s:32:\"contact-password-reseted-italian\";i:1;s:28:\"contact-set-password-italian\";i:1;s:29:\"staff-forgot-password-italian\";i:1;s:30:\"staff-password-reseted-italian\";i:1;s:27:\"assigned-to-project-italian\";i:1;s:41:\"task-added-attachment-to-contacts-italian\";i:1;s:34:\"task-commented-to-contacts-italian\";i:1;s:25:\"new-lead-assigned-italian\";i:1;s:24:\"client-statement-italian\";i:1;s:32:\"ticket-assigned-to-admin-italian\";i:1;s:38:\"new-client-registered-to-admin-italian\";i:1;s:38:\"new-web-to-lead-form-submitted-italian\";i:1;s:33:\"two-factor-authentication-italian\";i:1;s:36:\"project-finished-to-customer-italian\";i:1;s:34:\"credit-note-send-to-client-italian\";i:1;s:35:\"task-status-change-to-staff-italian\";i:1;s:38:\"task-status-change-to-contacts-italian\";i:1;s:28:\"reminder-email-staff-italian\";i:1;s:34:\"contract-comment-to-client-italian\";i:1;s:33:\"contract-comment-to-admin-italian\";i:1;s:25:\"send-subscription-italian\";i:1;s:35:\"subscription-payment-failed-italian\";i:1;s:29:\"subscription-canceled-italian\";i:1;s:38:\"subscription-payment-succeeded-italian\";i:1;s:36:\"contract-expiration-to-staff-italian\";i:1;s:28:\"gdpr-removal-request-italian\";i:1;s:33:\"gdpr-removal-request-lead-italian\";i:1;s:37:\"client-registration-confirmed-italian\";i:1;s:32:\"contract-signed-to-staff-italian\";i:1;s:36:\"customer-subscribed-to-staff-italian\";i:1;s:34:\"contact-verification-email-italian\";i:1;s:51:\"new-customer-profile-file-uploaded-to-staff-italian\";i:1;s:35:\"event-notification-to-staff-italian\";i:1;}', 0);
INSERT INTO `ms_options` (`id`, `name`, `value`, `autoload`) VALUES
(213, 'proposal_accept_identity_confirmation', '1', 0),
(214, 'estimate_accept_identity_confirmation', '1', 0),
(215, 'new_task_auto_follower_current_member', '0', 1),
(216, 'task_biillable_checked_on_creation', '1', 1),
(217, 'predefined_clientnote_credit_note', '', 1),
(218, 'predefined_terms_credit_note', '', 1),
(219, 'next_credit_note_number', '1', 1),
(220, 'credit_note_prefix', 'CN-', 1),
(221, 'credit_note_number_decrement_on_delete', '1', 1),
(222, 'pdf_format_credit_note', 'A4-PORTRAIT', 1),
(223, 'show_pdf_signature_credit_note', '1', 0),
(224, 'show_credit_note_reminders_on_calendar', '1', 1),
(225, 'show_amount_due_on_invoice', '1', 1),
(226, 'show_total_paid_on_invoice', '1', 1),
(227, 'show_credits_applied_on_invoice', '1', 1),
(228, 'staff_members_create_inline_lead_status', '1', 1),
(229, 'staff_members_create_inline_customer_groups', '1', 1),
(230, 'staff_members_create_inline_ticket_services', '1', 1),
(231, 'staff_members_save_tickets_predefined_replies', '1', 1),
(232, 'staff_members_create_inline_contract_types', '1', 1),
(233, 'staff_members_create_inline_expense_categories', '1', 1),
(234, 'show_project_on_credit_note', '1', 1),
(235, 'proposals_auto_operations_hour', '21', 1),
(236, 'estimates_auto_operations_hour', '21', 1),
(237, 'contracts_auto_operations_hour', '21', 1),
(238, 'credit_note_number_format', '1', 1),
(239, 'allow_non_admin_members_to_import_leads', '0', 1),
(240, 'e_sign_legal_text', 'By clicking on \"Sign\", I consent to be legally bound by this electronic representation of my signature.', 1),
(241, 'show_pdf_signature_contract', '1', 1),
(242, 'view_contract_only_logged_in', '0', 1),
(243, 'show_subscriptions_in_customers_area', '1', 1),
(244, 'calendar_only_assigned_tasks', '0', 1),
(245, 'after_subscription_payment_captured', 'send_invoice_and_receipt', 1),
(246, 'mail_engine', 'phpmailer', 1),
(247, 'gdpr_enable_terms_and_conditions', '0', 1),
(248, 'privacy_policy', '', 1),
(249, 'terms_and_conditions', '', 1),
(250, 'gdpr_enable_terms_and_conditions_lead_form', '0', 1),
(251, 'gdpr_enable_terms_and_conditions_ticket_form', '0', 1),
(252, 'gdpr_contact_enable_right_to_be_forgotten', '0', 1),
(253, 'show_gdpr_in_customers_menu', '1', 1),
(254, 'show_gdpr_link_in_footer', '1', 1),
(255, 'enable_gdpr', '0', 1),
(256, 'gdpr_on_forgotten_remove_invoices_credit_notes', '0', 1),
(257, 'gdpr_on_forgotten_remove_estimates', '0', 1),
(258, 'gdpr_enable_consent_for_contacts', '0', 1),
(259, 'gdpr_consent_public_page_top_block', '', 1),
(260, 'gdpr_page_top_information_block', '', 1),
(261, 'gdpr_enable_lead_public_form', '0', 1),
(262, 'gdpr_show_lead_custom_fields_on_public_form', '0', 1),
(263, 'gdpr_lead_attachments_on_public_form', '0', 1),
(264, 'gdpr_enable_consent_for_leads', '0', 1),
(265, 'gdpr_lead_enable_right_to_be_forgotten', '0', 1),
(266, 'allow_staff_view_invoices_assigned', '1', 1),
(267, 'gdpr_data_portability_leads', '0', 1),
(268, 'gdpr_lead_data_portability_allowed', '', 1),
(269, 'gdpr_contact_data_portability_allowed', '', 1),
(270, 'gdpr_data_portability_contacts', '0', 1),
(271, 'allow_staff_view_estimates_assigned', '1', 1),
(272, 'gdpr_after_lead_converted_delete', '0', 1),
(273, 'gdpr_show_terms_and_conditions_in_footer', '0', 1),
(274, 'save_last_order_for_tables', '0', 1),
(275, 'company_logo_dark', '', 1),
(276, 'customers_register_require_confirmation', '0', 1),
(277, 'allow_non_admin_staff_to_delete_ticket_attachments', '0', 1),
(278, 'receive_notification_on_new_ticket_replies', '1', 0),
(279, 'google_client_id', '', 1),
(280, 'enable_google_picker', '1', 1),
(281, 'show_ticket_reminders_on_calendar', '1', 1),
(282, 'ticket_import_reply_only', '0', 1),
(283, 'visible_customer_profile_tabs', 'all', 0),
(284, 'show_project_on_invoice', '1', 1),
(285, 'show_project_on_estimate', '1', 1),
(286, 'staff_members_create_inline_lead_source', '1', 1),
(287, 'upgraded_from_version', '', 0),
(288, 'lead_unique_validation', '[\"email\"]', 1),
(289, 'last_upgrade_copy_data', '', 1),
(290, 'sms_clickatell_api_key', '', 1),
(291, 'sms_clickatell_active', '0', 1),
(292, 'sms_clickatell_initialized', '1', 1),
(293, 'sms_msg91_sender_id', '', 1),
(294, 'sms_msg91_auth_key', '', 1),
(295, 'sms_msg91_active', '0', 1),
(296, 'sms_msg91_initialized', '1', 1),
(297, 'sms_twilio_account_sid', '', 1),
(298, 'sms_twilio_auth_token', '', 1),
(299, 'sms_twilio_phone_number', '', 1),
(300, 'sms_twilio_active', '0', 1),
(301, 'sms_twilio_initialized', '1', 1),
(302, 'auto_backup_enabled', '0', 1),
(303, 'auto_backup_every', '7', 1),
(304, 'last_auto_backup', '', 1),
(305, 'delete_backups_older_then', '0', 1),
(306, 'paymentmethod_two_checkout_active', '0', 1),
(307, 'paymentmethod_two_checkout_label', '2Checkout', 1),
(308, 'paymentmethod_two_checkout_account_number', '', 0),
(309, 'paymentmethod_two_checkout_private_key', '', 0),
(310, 'paymentmethod_two_checkout_publishable_key', '', 0),
(311, 'paymentmethod_two_checkout_currencies', 'USD,EUR', 0),
(312, 'paymentmethod_two_checkout_test_mode_enabled', '1', 0),
(313, 'paymentmethod_two_checkout_default_selected', '1', 1),
(314, 'paymentmethod_two_checkout_initialized', '1', 1),
(315, 'paymentmethod_stripe_ideal_active', '0', 1),
(316, 'paymentmethod_stripe_ideal_label', 'Stripe iDEAL', 1),
(317, 'paymentmethod_stripe_ideal_api_secret_key', '', 0),
(318, 'paymentmethod_stripe_ideal_api_publishable_key', '', 0),
(319, 'paymentmethod_stripe_ideal_description_dashboard', 'Payment for Invoice {invoice_number}', 0),
(320, 'paymentmethod_stripe_ideal_statement_descriptor', 'Payment for Invoice {invoice_number}', 0),
(321, 'paymentmethod_stripe_ideal_webhook_key', '351015eb458cd97241ea59e9e186aab1', 0),
(322, 'paymentmethod_stripe_ideal_currencies', 'EUR', 0),
(323, 'paymentmethod_stripe_ideal_test_mode_enabled', '1', 0),
(324, 'paymentmethod_stripe_ideal_default_selected', '1', 1),
(325, 'paymentmethod_stripe_ideal_initialized', '1', 1),
(326, 'paymentmethod_stripe_active', '0', 1),
(327, 'paymentmethod_stripe_label', 'Stripe Checkout', 1),
(328, 'paymentmethod_stripe_api_secret_key', '', 0),
(329, 'paymentmethod_stripe_api_publishable_key', '', 0),
(330, 'paymentmethod_stripe_description_dashboard', 'Payment for Invoice {invoice_number}', 0),
(331, 'paymentmethod_stripe_webhook_key', 'ff8052a3dfbad55be57980bbcde37663', 0),
(332, 'paymentmethod_stripe_currencies', 'USD,CAD', 0),
(333, 'paymentmethod_stripe_allow_primary_contact_to_update_credit_card', '1', 0),
(334, 'paymentmethod_stripe_test_mode_enabled', '1', 0),
(335, 'paymentmethod_stripe_default_selected', '1', 1),
(336, 'paymentmethod_stripe_initialized', '1', 1),
(337, 'paymentmethod_payu_money_active', '0', 1),
(338, 'paymentmethod_payu_money_label', 'PayU Money', 1),
(339, 'paymentmethod_payu_money_key', '', 0),
(340, 'paymentmethod_payu_money_salt', '', 0),
(341, 'paymentmethod_payu_money_description_dashboard', 'Payment for Invoice {invoice_number}', 0),
(342, 'paymentmethod_payu_money_currencies', 'INR', 0),
(343, 'paymentmethod_payu_money_test_mode_enabled', '1', 0),
(344, 'paymentmethod_payu_money_default_selected', '1', 1),
(345, 'paymentmethod_payu_money_initialized', '1', 1),
(346, 'paymentmethod_paypal_checkout_active', '0', 1),
(347, 'paymentmethod_paypal_checkout_label', 'Paypal Smart Checkout', 1),
(348, 'paymentmethod_paypal_checkout_client_id', '', 0),
(349, 'paymentmethod_paypal_checkout_secret', '', 0),
(350, 'paymentmethod_paypal_checkout_payment_description', 'Payment for Invoice {invoice_number}', 0),
(351, 'paymentmethod_paypal_checkout_currencies', 'USD,CAD,EUR', 0),
(352, 'paymentmethod_paypal_checkout_test_mode_enabled', '1', 0),
(353, 'paymentmethod_paypal_checkout_default_selected', '1', 1),
(354, 'paymentmethod_paypal_checkout_initialized', '1', 1),
(355, 'paymentmethod_paypal_active', '0', 1),
(356, 'paymentmethod_paypal_label', 'Paypal', 1),
(357, 'paymentmethod_paypal_username', '', 0),
(358, 'paymentmethod_paypal_password', '', 0),
(359, 'paymentmethod_paypal_signature', '', 0),
(360, 'paymentmethod_paypal_description_dashboard', 'Payment for Invoice {invoice_number}', 0),
(361, 'paymentmethod_paypal_currencies', 'EUR,USD', 0),
(362, 'paymentmethod_paypal_test_mode_enabled', '1', 0),
(363, 'paymentmethod_paypal_default_selected', '1', 1),
(364, 'paymentmethod_paypal_initialized', '1', 1),
(365, 'paymentmethod_mollie_active', '0', 1),
(366, 'paymentmethod_mollie_label', 'Mollie', 1),
(367, 'paymentmethod_mollie_api_key', '', 0),
(368, 'paymentmethod_mollie_description_dashboard', 'Payment for Invoice {invoice_number}', 0),
(369, 'paymentmethod_mollie_currencies', 'EUR', 0),
(370, 'paymentmethod_mollie_test_mode_enabled', '1', 0),
(371, 'paymentmethod_mollie_default_selected', '1', 1),
(372, 'paymentmethod_mollie_initialized', '1', 1),
(373, 'paymentmethod_paypal_braintree_active', '0', 1),
(374, 'paymentmethod_paypal_braintree_label', 'Braintree', 1),
(375, 'paymentmethod_paypal_braintree_merchant_id', '', 0),
(376, 'paymentmethod_paypal_braintree_api_public_key', '', 0),
(377, 'paymentmethod_paypal_braintree_api_private_key', '', 0),
(378, 'paymentmethod_paypal_braintree_currencies', 'USD', 0),
(379, 'paymentmethod_paypal_braintree_paypal_enabled', '1', 0),
(380, 'paymentmethod_paypal_braintree_test_mode_enabled', '1', 0),
(381, 'paymentmethod_paypal_braintree_default_selected', '1', 1),
(382, 'paymentmethod_paypal_braintree_initialized', '1', 1),
(383, 'paymentmethod_instamojo_active', '0', 1),
(384, 'paymentmethod_instamojo_label', 'Instamojo', 1),
(385, 'paymentmethod_instamojo_api_key', '', 0),
(386, 'paymentmethod_instamojo_auth_token', '', 0),
(387, 'paymentmethod_instamojo_description_dashboard', 'Payment for Invoice {invoice_number}', 0),
(388, 'paymentmethod_instamojo_currencies', 'INR', 0),
(389, 'paymentmethod_instamojo_test_mode_enabled', '1', 0),
(390, 'paymentmethod_instamojo_default_selected', '1', 1),
(391, 'paymentmethod_instamojo_initialized', '1', 1),
(392, 'paymentmethod_authorize_sim_active', '0', 1),
(393, 'paymentmethod_authorize_sim_label', 'Authorize.net SIM', 1),
(394, 'paymentmethod_authorize_sim_api_login_id', '', 0),
(395, 'paymentmethod_authorize_sim_api_transaction_key', '', 0),
(396, 'paymentmethod_authorize_sim_api_secret_key', '', 0),
(397, 'paymentmethod_authorize_sim_description_dashboard', 'Payment for Invoice {invoice_number}', 0),
(398, 'paymentmethod_authorize_sim_currencies', 'USD', 0),
(399, 'paymentmethod_authorize_sim_test_mode_enabled', '0', 0),
(400, 'paymentmethod_authorize_sim_developer_mode_enabled', '1', 0),
(401, 'paymentmethod_authorize_sim_default_selected', '1', 1),
(402, 'paymentmethod_authorize_sim_initialized', '1', 1),
(403, 'paymentmethod_authorize_aim_active', '0', 1),
(404, 'paymentmethod_authorize_aim_label', 'Authorize.net AIM', 1),
(405, 'paymentmethod_authorize_aim_api_login_id', '', 0),
(406, 'paymentmethod_authorize_aim_api_transaction_key', '', 0),
(407, 'paymentmethod_authorize_aim_description_dashboard', 'Payment for Invoice {invoice_number}', 0),
(408, 'paymentmethod_authorize_aim_currencies', 'USD', 0),
(409, 'paymentmethod_authorize_aim_test_mode_enabled', '0', 0),
(410, 'paymentmethod_authorize_aim_developer_mode_enabled', '1', 0),
(411, 'paymentmethod_authorize_aim_default_selected', '1', 1),
(412, 'paymentmethod_authorize_aim_initialized', '1', 1),
(413, 'sms_trigger_invoice_overdue_notice', '', 0),
(414, 'sms_trigger_invoice_payment_recorded', '', 0),
(415, 'sms_trigger_estimate_expiration_reminder', '', 0),
(416, 'sms_trigger_proposal_expiration_reminder', '', 0),
(417, 'sms_trigger_proposal_new_comment_to_customer', '', 0),
(418, 'sms_trigger_proposal_new_comment_to_staff', '', 0),
(419, 'sms_trigger_contract_new_comment_to_customer', '', 0),
(420, 'sms_trigger_contract_new_comment_to_staff', '', 0),
(421, 'sms_trigger_contract_expiration_reminder', '', 0),
(422, 'sms_trigger_staff_reminder', '', 0),
(423, 'survey_send_emails_per_cron_run', '100', 1),
(424, 'last_survey_send_cron', '', 1),
(425, 'theme_style', '[]', 1),
(426, 'theme_style_custom_admin_area', '', 1),
(427, 'theme_style_custom_clients_area', '', 1),
(428, 'theme_style_custom_clients_and_admin_area', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_payment_modes`
--

CREATE TABLE `ms_payment_modes` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `show_on_pdf` int(11) NOT NULL DEFAULT 0,
  `invoices_only` int(11) NOT NULL DEFAULT 0,
  `expenses_only` int(11) NOT NULL DEFAULT 0,
  `selected_by_default` int(11) NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_payment_modes`
--

INSERT INTO `ms_payment_modes` (`id`, `name`, `description`, `show_on_pdf`, `invoices_only`, `expenses_only`, `selected_by_default`, `active`) VALUES
(1, 'Bank', NULL, 0, 0, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ms_pinned_projects`
--

CREATE TABLE `ms_pinned_projects` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_projectdiscussioncomments`
--

CREATE TABLE `ms_projectdiscussioncomments` (
  `id` int(11) NOT NULL,
  `discussion_id` int(11) NOT NULL,
  `discussion_type` varchar(10) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `content` text NOT NULL,
  `staff_id` int(11) NOT NULL,
  `contact_id` int(11) DEFAULT 0,
  `fullname` varchar(191) DEFAULT NULL,
  `file_name` varchar(191) DEFAULT NULL,
  `file_mime_type` varchar(70) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_projectdiscussions`
--

CREATE TABLE `ms_projectdiscussions` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `show_to_customer` tinyint(1) NOT NULL DEFAULT 0,
  `datecreated` datetime NOT NULL,
  `last_activity` datetime DEFAULT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `contact_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_projects`
--

CREATE TABLE `ms_projects` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `clientid` int(11) NOT NULL,
  `billing_type` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `deadline` date DEFAULT NULL,
  `project_created` date NOT NULL,
  `date_finished` datetime DEFAULT NULL,
  `progress` int(11) DEFAULT 0,
  `progress_from_tasks` int(11) NOT NULL DEFAULT 1,
  `project_cost` decimal(15,2) DEFAULT NULL,
  `project_rate_per_hour` decimal(15,2) DEFAULT NULL,
  `estimated_hours` decimal(15,2) DEFAULT NULL,
  `addedfrom` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_project_activity`
--

CREATE TABLE `ms_project_activity` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 0,
  `contact_id` int(11) NOT NULL DEFAULT 0,
  `fullname` varchar(100) DEFAULT NULL,
  `visible_to_customer` int(11) NOT NULL DEFAULT 0,
  `description_key` varchar(191) NOT NULL COMMENT 'Language file key',
  `additional_data` text DEFAULT NULL,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_project_files`
--

CREATE TABLE `ms_project_files` (
  `id` int(11) NOT NULL,
  `file_name` varchar(191) NOT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `filetype` varchar(50) DEFAULT NULL,
  `dateadded` datetime NOT NULL,
  `last_activity` datetime DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `visible_to_customer` tinyint(1) DEFAULT 0,
  `staffid` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL DEFAULT 0,
  `external` varchar(40) DEFAULT NULL,
  `external_link` text DEFAULT NULL,
  `thumbnail_link` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_project_members`
--

CREATE TABLE `ms_project_members` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_project_notes`
--

CREATE TABLE `ms_project_notes` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `staff_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_project_settings`
--

CREATE TABLE `ms_project_settings` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_proposals`
--

CREATE TABLE `ms_proposals` (
  `id` int(11) NOT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `addedfrom` int(11) NOT NULL,
  `datecreated` datetime NOT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  `total_tax` decimal(15,2) NOT NULL DEFAULT 0.00,
  `adjustment` decimal(15,2) DEFAULT NULL,
  `discount_percent` decimal(15,2) NOT NULL,
  `discount_total` decimal(15,2) NOT NULL,
  `discount_type` varchar(30) DEFAULT NULL,
  `show_quantity_as` int(11) NOT NULL DEFAULT 1,
  `currency` int(11) NOT NULL,
  `open_till` date DEFAULT NULL,
  `date` date NOT NULL,
  `rel_id` int(11) DEFAULT NULL,
  `rel_type` varchar(40) DEFAULT NULL,
  `assigned` int(11) DEFAULT NULL,
  `hash` varchar(32) NOT NULL,
  `proposal_to` varchar(191) DEFAULT NULL,
  `country` int(11) NOT NULL DEFAULT 0,
  `zip` varchar(50) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `allow_comments` tinyint(1) NOT NULL DEFAULT 1,
  `status` int(11) NOT NULL,
  `estimate_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `date_converted` datetime DEFAULT NULL,
  `pipeline_order` int(11) NOT NULL DEFAULT 0,
  `is_expiry_notified` int(11) NOT NULL DEFAULT 0,
  `acceptance_firstname` varchar(50) DEFAULT NULL,
  `acceptance_lastname` varchar(50) DEFAULT NULL,
  `acceptance_email` varchar(100) DEFAULT NULL,
  `acceptance_date` datetime DEFAULT NULL,
  `acceptance_ip` varchar(40) DEFAULT NULL,
  `signature` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_proposal_comments`
--

CREATE TABLE `ms_proposal_comments` (
  `id` int(11) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `proposalid` int(11) NOT NULL,
  `staffid` int(11) NOT NULL,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_related_items`
--

CREATE TABLE `ms_related_items` (
  `id` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(30) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_reminders`
--

CREATE TABLE `ms_reminders` (
  `id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `date` datetime NOT NULL,
  `isnotified` int(11) NOT NULL DEFAULT 0,
  `rel_id` int(11) NOT NULL,
  `staff` int(11) NOT NULL,
  `rel_type` varchar(40) NOT NULL,
  `notify_by_email` int(11) NOT NULL DEFAULT 1,
  `creator` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_roles`
--

CREATE TABLE `ms_roles` (
  `roleid` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `permissions` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_roles`
--

INSERT INTO `ms_roles` (`roleid`, `name`, `permissions`) VALUES
(1, 'Employee', NULL),
(2, 'CEO', 'a:23:{s:17:\"bulk_pdf_exporter\";a:1:{i:0;s:4:\"view\";}s:9:\"contracts\";a:4:{i:0;s:8:\"view_own\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:12:\"credit_notes\";a:4:{i:0;s:8:\"view_own\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:9:\"customers\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:15:\"email_templates\";a:2:{i:0;s:4:\"view\";i:1;s:4:\"edit\";}s:9:\"estimates\";a:4:{i:0;s:8:\"view_own\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:8:\"expenses\";a:4:{i:0;s:8:\"view_own\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:8:\"invoices\";a:4:{i:0;s:8:\"view_own\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:5:\"items\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:14:\"knowledge_base\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:8:\"payments\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:8:\"projects\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:9:\"proposals\";a:4:{i:0;s:8:\"view_own\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:7:\"reports\";a:1:{i:0;s:4:\"view\";}s:5:\"roles\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:8:\"settings\";a:2:{i:0;s:4:\"view\";i:1;s:4:\"edit\";}s:5:\"staff\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:13:\"subscriptions\";a:4:{i:0;s:8:\"view_own\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:5:\"tasks\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:19:\"checklist_templates\";a:2:{i:0;s:6:\"create\";i:1;s:6:\"delete\";}s:5:\"leads\";a:2:{i:0;s:4:\"view\";i:1;s:6:\"delete\";}s:5:\"goals\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}s:7:\"surveys\";a:4:{i:0;s:4:\"view\";i:1;s:6:\"create\";i:2;s:4:\"edit\";i:3;s:6:\"delete\";}}');

-- --------------------------------------------------------

--
-- Table structure for table `ms_sales_activity`
--

CREATE TABLE `ms_sales_activity` (
  `id` int(11) NOT NULL,
  `rel_type` varchar(20) DEFAULT NULL,
  `rel_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `additional_data` text DEFAULT NULL,
  `staffid` varchar(11) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_services`
--

CREATE TABLE `ms_services` (
  `serviceid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_sessions`
--

CREATE TABLE `ms_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_sessions`
--

INSERT INTO `ms_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('027d479634a7f1eff4c54b1fa73849e59e3e511d', '103.116.177.8', 1562913201, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323931333230313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('0b5f4cadf870194e41e832231c58338e0edbdfa0', '103.116.177.8', 1562924456, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932343435363b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('0c8fd58fa45f2a7a7689e78f689247c1c842d32e', '219.91.237.189', 1562835689, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323833353638393b69735f6d6f62696c657c623a313b),
('140d479f3c412cb4ac508604e0190e5d0f827828', '103.116.179.40', 1563448500, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333434383339393b7265645f75726c7c733a33383a22687474703a2f2f63726d2e666f6f676c65746563682e636f6d2f666f6f646d6f68616c6c612f223b6d6573736167652d64616e6765727c733a32383a22496e76616c696420757365726e616d65206f722070617373776f7264223b5f5f63695f766172737c613a313a7b733a31343a226d6573736167652d64616e676572223b733a333a226f6c64223b7d),
('1453a4d09e54eb1134bdf7452775dcc7f5df212d', '103.17.83.54', 1562930275, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933303132353b69735f6d6f62696c657c623a313b73746166665f757365725f69647c733a313a2232223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('19e5c60ce8b9334a13cf8b494f2a15ef93339a4f', '103.116.178.110', 1563024149, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333032343133383b7265645f75726c7c733a32363a22687474703a2f2f63726d2e666f6f676c65746563682e636f6d2f223b),
('1a56c009dac77f60147bd3080973bf53aaf4b7e5', '103.116.179.40', 1563444774, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333434343737333b7265645f75726c7c733a34333a22687474703a2f2f63726d2e666f6f676c65746563682e636f6d2f666f6f646d6f68616c6c612f61646d696e223b),
('1afaded9c42dea1cf9614b32808f8c5a52ce3c64', '219.91.237.189', 1562834635, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323833343633353b69735f6d6f62696c657c623a313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('1cd304b03dc48eaf0c184f63e925b5a25440e9f4', '103.116.177.8', 1562915606, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323931353630363b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('1ebafb20998a9e4189a06b7c3e2b9388707431e6', '103.116.179.40', 1563445636, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333434353633353b7265645f75726c7c733a34333a22687474703a2f2f63726d2e666f6f676c65746563682e636f6d2f666f6f646d6f68616c6c612f61646d696e223b),
('277556f4ccf00c926c8be27b32611176c84e83cb', '103.116.178.131', 1562845139, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834353133393b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c623a313b),
('2ab6df71052fabcf2aa40c8435e7acd306952103', '103.116.178.131', 1562850711, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323835303435303b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('2ae226894f5fa7bbefee9e2a9dd33e01abeef1fa', '103.116.178.131', 1562850140, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323835303134303b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('2dd0d3216022f2bec7c44570651d7d1a409fd0d5', '103.116.177.8', 1562919940, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323931393934303b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('2eead06f41cf2a497a6cc7c74c3fe50e1997001f', '103.116.178.131', 1562844023, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834343032333b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c623a313b7265645f75726c7c733a32383a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f223b),
('31fe7bad8b19764b02a0f9a16ab787c454dceb5d', '43.248.39.119', 1562852785, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323835323734373b73746166665f757365725f69647c733a313a2234223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('33aa03dfc13f4f182516e4c5af2dcacb1fada482', '103.116.177.8', 1562928621, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932383632313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('36e8f23f68d33d195df01918a5ba69f27e80de5a', '43.248.39.119', 1562847004, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834373030343b),
('3ba060d7df34e5233f630b3f997056d4f98ab964', '103.116.177.8', 1562935951, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933353935313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('4c731103394823e8746d44448a97b148a48f7306', '103.116.178.131', 1562846131, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834363133313b),
('4f227f46fdb72e37f6901e22ebe31e062076e0b5', '103.116.177.8', 1562930286, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933303238363b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('507e586bf3c701482e08095a80bf03e72f943350', '103.116.178.131', 1562825717, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323832353731373b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('5091c64eaa0f1145977aa3e50105e109f267c1db', '103.116.177.8', 1562937810, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933373636363b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('5310ed7ae92aba20111da61d1bd4f95149cc3c82', '103.116.179.40', 1563448750, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333434383735303b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c623a313b),
('54187c83dd731169a9da87edf66a2455bdb6e74c', '103.116.178.131', 1562839713, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323833393731333b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('5a3023c0713245b40b060e6897ae841ae551ed26', '43.248.39.119', 1562847003, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834373030333b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('5c50a21bc173a5e4efbdad0647e5944bc2cd2094', '43.248.39.119', 1562852747, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323835323734373b73746166665f757365725f69647c733a313a2234223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('609c1a9250406f8726901cdcc2ffdfe0ad0531b9', '103.116.179.40', 1563449136, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333434393133363b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c623a313b),
('613a86391748ab07ba739b660d7cc29e2de2c252', '103.116.178.131', 1562825209, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323832353230383b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('616dd6f1f85f3ecd37747773a85d63456e21edcb', '103.17.83.54', 1562924014, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932333738353b69735f6d6f62696c657c623a313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('629b62ae93c60554b1ca25c97874844fd6164ccc', '103.116.177.8', 1562927843, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932373834333b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('6a54d46863823d9c580bebb46a678bce6e3c9c09', '64.233.173.18', 1563017502, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333031373530313b69735f6d6f62696c657c623a313b),
('6a84716afae14db533ea3beccf517272abc212d5', '103.116.177.8', 1562922332, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932323333313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('6d2db4b2f2f93bd38d618414ad2e6a00f1f14dcc', '64.233.173.132', 1562848017, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834383031363b69735f6d6f62696c657c623a313b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('6f3139b8514ef1376fdd75d41cf1f73087818d92', '103.116.178.110', 1562991000, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323939303939383b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('70e0bff903119a0de18bad4dae77f710ae801a40', '103.116.178.131', 1562840891, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834303839313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('711aa5079a4f3c480edf0a359f727f610a252bdd', '103.116.177.8', 1562937666, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933373636363b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('76a3f407e7bdaccae9dde2ed2be38eba2ac86d3f', '64.233.173.17', 1563017501, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333031373530313b69735f6d6f62696c657c623a313b),
('76b6e3cb8167d9a30f3e7702e48bb3a85feda1ec', '103.116.179.40', 1563446315, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333434363131333b7265645f75726c7c733a34333a22687474703a2f2f63726d2e666f6f676c65746563682e636f6d2f666f6f646d6f68616c6c612f61646d696e223b),
('782e076b40ee195039afa23f42d76f93073b4a0c', '103.116.178.110', 1562991305, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323939313330353b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('79b42e089b5d8ffeba0057cb80e68a08fcb38c3f', '103.116.177.8', 1562929635, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932393633353b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('7e36f982dd68cc1e9bd123cc94f8c8f7d5bbb163', '103.116.177.8', 1562923385, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932333338353b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('86ae2e9a287801c2665c4f9fed8919f7d138159d', '43.248.39.119', 1562847242, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834373234323b73746166665f757365725f69647c733a313a2234223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('87c8f76d4eff55f1974048bef28f8d7d2bb0dae1', '103.116.178.131', 1562845531, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834353533313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('8cde8d104a08615cf1f2470e6cf4a1985ac2cef9', '103.37.182.243', 1562847905, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834373930343b69735f6d6f62696c657c623a313b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('90e5faf818a89942ba66e5101fd8d7d5e7bc5537', '103.116.177.8', 1562930641, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933303634313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('95e8548022614afe5030cdfe76cd2dfd283e167f', '103.116.178.131', 1562848259, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834383234353b69735f6d6f62696c657c623a313b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('989003710b67c8236c91ceb8207206f5099ef766', '43.248.39.119', 1562847153, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834373135333b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('9e2aa6b0b7bb8b71bea3d898aa52bf75eb7ab8a1', '103.116.177.8', 1562931017, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933313031373b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('ada45713bc43a5c2b1dd1bf8a083a8b1e02406dc', '103.116.177.8', 1562929971, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932393937313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('b34e20993697be9105845ea798c7183f32beebf5', '103.116.177.8', 1562926852, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932363835323b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a343a2274727565223b),
('b418181e10a38fb5ca2398fe99df6f4c87d945bc', '43.248.39.119', 1562847154, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834373135333b),
('bb9e7e801f145723aecf81f887e70c25fe76bb7f', '103.17.83.54', 1562916294, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323931363135353b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c623a313b),
('c29f8672803b208e73c3b3af1cb6dddd0d880e71', '43.248.39.119', 1562846758, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834363735373b69735f6d6f62696c657c623a313b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('c3a630cc89f1a788bd6cc2818221de8285fc6c25', '103.116.177.8', 1562934497, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933343439373b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b),
('c91c0ffa296e0882e4d32ae48a2aaf7aba6229bf', '103.116.178.110', 1562991307, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323939313330353b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b6d6573736167652d64616e6765727c733a32353a22496e76616c696420656d61696c206f722070617373776f7264223b5f5f63695f766172737c613a313a7b733a31343a226d6573736167652d64616e676572223b733a333a226f6c64223b7d),
('dd3d753b7526648fb20a1280bef95f3e069f147f', '103.37.182.243', 1562826453, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323832363333373b69735f6d6f62696c657c623a313b73746166665f757365725f69647c733a313a2232223b73746166665f6c6f676765645f696e7c623a313b7265645f75726c7c733a32383a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f223b73657475702d6d656e752d6f70656e7c733a303a22223b),
('df46625633de86988b9206f0415f03b28d670fb8', '43.248.39.119', 1562850761, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323835303736313b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('e12ac33e5d114f78704b30e889cd607352cd1de2', '103.116.177.8', 1562911771, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323931313736393b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('e6ce1194cbce919032697afea64f1eba606b9219', '103.116.177.8', 1562917696, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323931373639363b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('e82757848999ce7e57dcd8957bda87f6cd7be939', '103.17.83.54', 1562924252, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323932343235313b69735f6d6f62696c657c623a313b7265645f75726c7c733a34383a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e2f6b6e6f776c656467655f62617365223b),
('e99171b9f874aa5e432a29c68024879f4a8de788', '103.116.179.40', 1563449207, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536333434393133363b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('eb9bc23c8a7bcf562f41d5aff51554794ddee08b', '43.248.39.119', 1562850762, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323835303736323b),
('efc2f7488177b20181a841407cce866af1e5ddd6', '103.116.178.131', 1562843703, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834333730333b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('f0642243d2f10447eeb6bfbf9ab597c253b370cf', '219.91.237.189', 1562835396, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323833353339363b69735f6d6f62696c657c623a313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('f13b4c871f55349d82666f79f78db051000a6e1e', '103.116.178.131', 1562846071, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323834363037303b7265645f75726c7c733a33333a22687474703a2f2f6d7963726d2e666f6f676c65746563682e636f6d2f61646d696e223b),
('f30f57c4b74e6732a6d78740bf42f2ed2b17878d', '103.116.178.131', 1562826021, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323832363032313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('f371cdedf31d76983a08d63ba8d37c25665d5f71', '103.116.178.131', 1562850450, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323835303435303b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c623a313b),
('f7b97eb18c7eb8eca199a6add73a4d348855c057', '219.91.237.189', 1562834952, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323833343935323b69735f6d6f62696c657c623a313b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b),
('f9c8e7c4e2ae67d769cf69b338a711632240910a', '103.116.177.8', 1562931352, 0x5f5f63695f6c6173745f726567656e65726174657c693a313536323933313335323b73746166665f757365725f69647c733a313a2231223b73746166665f6c6f676765645f696e7c623a313b73657475702d6d656e752d6f70656e7c733a303a22223b6c656164735f6b616e62616e5f766965777c733a353a2266616c7365223b6d6573736167652d737563636573737c733a32343a22476f616c206164646564207375636365737366756c6c792e223b5f5f63695f766172737c613a313a7b733a31353a226d6573736167652d73756363657373223b733a333a226f6c64223b7d);

-- --------------------------------------------------------

--
-- Table structure for table `ms_shared_customer_files`
--

CREATE TABLE `ms_shared_customer_files` (
  `file_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_spam_filters`
--

CREATE TABLE `ms_spam_filters` (
  `id` int(11) NOT NULL,
  `type` varchar(40) NOT NULL,
  `rel_type` varchar(10) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_staff`
--

CREATE TABLE `ms_staff` (
  `staffid` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `facebook` mediumtext DEFAULT NULL,
  `linkedin` mediumtext DEFAULT NULL,
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
  `admin` int(11) NOT NULL DEFAULT 0,
  `role` int(11) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT 1,
  `default_language` varchar(40) DEFAULT NULL,
  `direction` varchar(3) DEFAULT NULL,
  `media_path_slug` varchar(191) DEFAULT NULL,
  `is_not_staff` int(11) NOT NULL DEFAULT 0,
  `hourly_rate` decimal(15,2) NOT NULL DEFAULT 0.00,
  `two_factor_auth_enabled` tinyint(1) DEFAULT 0,
  `two_factor_auth_code` varchar(100) DEFAULT NULL,
  `two_factor_auth_code_requested` datetime DEFAULT NULL,
  `email_signature` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_staff`
--

INSERT INTO `ms_staff` (`staffid`, `email`, `firstname`, `lastname`, `facebook`, `linkedin`, `phonenumber`, `skype`, `password`, `datecreated`, `profile_image`, `last_ip`, `last_login`, `last_activity`, `last_password_change`, `new_pass_key`, `new_pass_key_requested`, `admin`, `role`, `active`, `default_language`, `direction`, `media_path_slug`, `is_not_staff`, `hourly_rate`, `two_factor_auth_enabled`, `two_factor_auth_code`, `two_factor_auth_code_requested`, `email_signature`) VALUES
(1, 'admin@foogletech.com', 'Super', 'Admin', '', '', '', '', '$2a$08$/./zKcHDYp9.2zqBOo9W7eNoOiXE4bRijAl4gEDUJ4MnTmTPmsxHy', '2019-07-10 10:36:31', NULL, '103.116.179.40', '2019-07-18 16:45:29', '2019-07-18 16:56:47', NULL, NULL, NULL, 1, 0, 1, '', '', NULL, 0, 0.00, 0, NULL, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `ms_staff_departments`
--

CREATE TABLE `ms_staff_departments` (
  `staffdepartmentid` int(11) NOT NULL,
  `staffid` int(11) NOT NULL,
  `departmentid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_staff_permissions`
--

CREATE TABLE `ms_staff_permissions` (
  `staff_id` int(11) NOT NULL,
  `feature` varchar(40) NOT NULL,
  `capability` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_subscriptions`
--

CREATE TABLE `ms_subscriptions` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `description_in_item` tinyint(1) NOT NULL DEFAULT 0,
  `clientid` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `currency` int(11) NOT NULL,
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `stripe_plan_id` text DEFAULT NULL,
  `stripe_subscription_id` text NOT NULL,
  `next_billing_cycle` bigint(20) DEFAULT NULL,
  `ends_at` bigint(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `hash` varchar(32) NOT NULL,
  `created` datetime NOT NULL,
  `created_from` int(11) NOT NULL,
  `date_subscribed` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_surveyresultsets`
--

CREATE TABLE `ms_surveyresultsets` (
  `resultsetid` int(11) NOT NULL,
  `surveyid` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `useragent` varchar(150) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_surveyresultsets`
--

INSERT INTO `ms_surveyresultsets` (`resultsetid`, `surveyid`, `ip`, `useragent`, `date`) VALUES
(1, 1, '103.116.177.8', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '2019-07-12 16:57:30');

-- --------------------------------------------------------

--
-- Table structure for table `ms_surveys`
--

CREATE TABLE `ms_surveys` (
  `surveyid` int(11) NOT NULL,
  `subject` mediumtext NOT NULL,
  `slug` mediumtext NOT NULL,
  `description` text NOT NULL,
  `viewdescription` text DEFAULT NULL,
  `datecreated` datetime NOT NULL,
  `redirect_url` varchar(100) DEFAULT NULL,
  `send` tinyint(1) NOT NULL DEFAULT 0,
  `onlyforloggedin` int(11) DEFAULT 0,
  `fromname` varchar(100) DEFAULT NULL,
  `iprestrict` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `hash` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_surveys`
--

INSERT INTO `ms_surveys` (`surveyid`, `subject`, `slug`, `description`, `viewdescription`, `datecreated`, `redirect_url`, `send`, `onlyforloggedin`, `fromname`, `iprestrict`, `active`, `hash`) VALUES
(1, 'Feedback', 'feedback', 'asd', 'asdsad', '2019-07-12 16:56:30', '', 0, 0, '', 0, 1, '2ff812ef6da62c0866c90045f6b0dea1');

-- --------------------------------------------------------

--
-- Table structure for table `ms_surveysemailsendcron`
--

CREATE TABLE `ms_surveysemailsendcron` (
  `id` int(11) NOT NULL,
  `surveyid` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `emailid` int(11) DEFAULT NULL,
  `listid` varchar(11) DEFAULT NULL,
  `log_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_surveysendlog`
--

CREATE TABLE `ms_surveysendlog` (
  `id` int(11) NOT NULL,
  `surveyid` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `iscronfinished` int(11) NOT NULL DEFAULT 0,
  `send_to_mail_lists` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_taggables`
--

CREATE TABLE `ms_taggables` (
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(20) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `tag_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_tags`
--

CREATE TABLE `ms_tags` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_tasks`
--

CREATE TABLE `ms_tasks` (
  `id` int(11) NOT NULL,
  `name` mediumtext DEFAULT NULL,
  `description` text DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `dateadded` datetime NOT NULL,
  `startdate` date NOT NULL,
  `duedate` date DEFAULT NULL,
  `datefinished` datetime DEFAULT NULL,
  `addedfrom` int(11) NOT NULL,
  `is_added_from_contact` tinyint(1) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `recurring_type` varchar(10) DEFAULT NULL,
  `repeat_every` int(11) DEFAULT NULL,
  `recurring` int(11) NOT NULL DEFAULT 0,
  `is_recurring_from` int(11) DEFAULT NULL,
  `cycles` int(11) NOT NULL DEFAULT 0,
  `total_cycles` int(11) NOT NULL DEFAULT 0,
  `custom_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `last_recurring_date` date DEFAULT NULL,
  `rel_id` int(11) DEFAULT NULL,
  `rel_type` varchar(30) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `billable` tinyint(1) NOT NULL DEFAULT 0,
  `billed` tinyint(1) NOT NULL DEFAULT 0,
  `invoice_id` int(11) NOT NULL DEFAULT 0,
  `hourly_rate` decimal(15,2) NOT NULL DEFAULT 0.00,
  `milestone` int(11) DEFAULT 0,
  `kanban_order` int(11) NOT NULL DEFAULT 0,
  `milestone_order` int(11) NOT NULL DEFAULT 0,
  `visible_to_client` tinyint(1) NOT NULL DEFAULT 0,
  `deadline_notified` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_taskstimers`
--

CREATE TABLE `ms_taskstimers` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `start_time` varchar(64) NOT NULL,
  `end_time` varchar(64) DEFAULT NULL,
  `staff_id` int(11) NOT NULL,
  `hourly_rate` decimal(15,2) NOT NULL DEFAULT 0.00,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_tasks_checklist_templates`
--

CREATE TABLE `ms_tasks_checklist_templates` (
  `id` int(11) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_task_assigned`
--

CREATE TABLE `ms_task_assigned` (
  `id` int(11) NOT NULL,
  `staffid` int(11) NOT NULL,
  `taskid` int(11) NOT NULL,
  `assigned_from` int(11) NOT NULL DEFAULT 0,
  `is_assigned_from_contact` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_task_checklist_items`
--

CREATE TABLE `ms_task_checklist_items` (
  `id` int(11) NOT NULL,
  `taskid` int(11) NOT NULL,
  `description` text NOT NULL,
  `finished` int(11) NOT NULL DEFAULT 0,
  `dateadded` datetime NOT NULL,
  `addedfrom` int(11) NOT NULL,
  `finished_from` int(11) DEFAULT 0,
  `list_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_task_comments`
--

CREATE TABLE `ms_task_comments` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `taskid` int(11) NOT NULL,
  `staffid` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL DEFAULT 0,
  `file_id` int(11) NOT NULL DEFAULT 0,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_task_followers`
--

CREATE TABLE `ms_task_followers` (
  `id` int(11) NOT NULL,
  `staffid` int(11) NOT NULL,
  `taskid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_taxes`
--

CREATE TABLE `ms_taxes` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `taxrate` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_tickets`
--

CREATE TABLE `ms_tickets` (
  `ticketid` int(11) NOT NULL,
  `adminreplying` int(11) NOT NULL DEFAULT 0,
  `userid` int(11) NOT NULL,
  `contactid` int(11) NOT NULL DEFAULT 0,
  `email` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `department` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `service` int(11) DEFAULT NULL,
  `ticketkey` varchar(32) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `message` text DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `lastreply` datetime DEFAULT NULL,
  `clientread` int(11) NOT NULL DEFAULT 0,
  `adminread` int(11) NOT NULL DEFAULT 0,
  `assigned` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_tickets_pipe_log`
--

CREATE TABLE `ms_tickets_pipe_log` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `email_to` varchar(100) NOT NULL,
  `name` varchar(191) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `message` mediumtext NOT NULL,
  `email` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_tickets_predefined_replies`
--

CREATE TABLE `ms_tickets_predefined_replies` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_tickets_priorities`
--

CREATE TABLE `ms_tickets_priorities` (
  `priorityid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_tickets_priorities`
--

INSERT INTO `ms_tickets_priorities` (`priorityid`, `name`) VALUES
(1, 'Low'),
(2, 'Medium'),
(3, 'High');

-- --------------------------------------------------------

--
-- Table structure for table `ms_tickets_status`
--

CREATE TABLE `ms_tickets_status` (
  `ticketstatusid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `isdefault` int(11) NOT NULL DEFAULT 0,
  `statuscolor` varchar(7) DEFAULT NULL,
  `statusorder` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_tickets_status`
--

INSERT INTO `ms_tickets_status` (`ticketstatusid`, `name`, `isdefault`, `statuscolor`, `statusorder`) VALUES
(1, 'Open', 1, '#ff2d42', 1),
(2, 'In progress', 1, '#84c529', 2),
(3, 'Answered', 1, '#0000ff', 3),
(4, 'On Hold', 1, '#c0c0c0', 4),
(5, 'Closed', 1, '#03a9f4', 5);

-- --------------------------------------------------------

--
-- Table structure for table `ms_ticket_attachments`
--

CREATE TABLE `ms_ticket_attachments` (
  `id` int(11) NOT NULL,
  `ticketid` int(11) NOT NULL,
  `replyid` int(11) DEFAULT NULL,
  `file_name` varchar(191) NOT NULL,
  `filetype` varchar(50) DEFAULT NULL,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_ticket_replies`
--

CREATE TABLE `ms_ticket_replies` (
  `id` int(11) NOT NULL,
  `ticketid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `contactid` int(11) NOT NULL DEFAULT 0,
  `name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `date` datetime NOT NULL,
  `message` text DEFAULT NULL,
  `attachment` int(11) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_todos`
--

CREATE TABLE `ms_todos` (
  `todoid` int(11) NOT NULL,
  `description` text NOT NULL,
  `staffid` int(11) NOT NULL,
  `dateadded` datetime NOT NULL,
  `finished` tinyint(1) NOT NULL,
  `datefinished` datetime DEFAULT NULL,
  `item_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_tracked_mails`
--

CREATE TABLE `ms_tracked_mails` (
  `id` int(11) NOT NULL,
  `uid` varchar(32) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(40) NOT NULL,
  `date` datetime NOT NULL,
  `email` varchar(100) NOT NULL,
  `opened` tinyint(1) NOT NULL DEFAULT 0,
  `date_opened` datetime DEFAULT NULL,
  `subject` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_user_auto_login`
--

CREATE TABLE `ms_user_auto_login` (
  `key_id` char(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_agent` varchar(150) NOT NULL,
  `last_ip` varchar(40) NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `staff` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_user_meta`
--

CREATE TABLE `ms_user_meta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `staff_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `client_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `contact_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(191) DEFAULT NULL,
  `meta_value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_user_meta`
--

INSERT INTO `ms_user_meta` (`umeta_id`, `staff_id`, `client_id`, `contact_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 0, 0, 'recent_searches', '[]');

-- --------------------------------------------------------

--
-- Table structure for table `ms_vault`
--

CREATE TABLE `ms_vault` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `server_address` varchar(191) NOT NULL,
  `port` int(11) DEFAULT NULL,
  `username` varchar(191) NOT NULL,
  `password` text NOT NULL,
  `description` text DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `creator_name` varchar(100) DEFAULT NULL,
  `visibility` tinyint(1) NOT NULL DEFAULT 1,
  `share_in_projects` tinyint(1) NOT NULL DEFAULT 0,
  `last_updated` datetime DEFAULT NULL,
  `last_updated_from` varchar(100) DEFAULT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_views_tracking`
--

CREATE TABLE `ms_views_tracking` (
  `id` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_type` varchar(40) NOT NULL,
  `date` datetime NOT NULL,
  `view_ip` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ms_web_to_lead`
--

CREATE TABLE `ms_web_to_lead` (
  `id` int(11) NOT NULL,
  `form_key` varchar(32) NOT NULL,
  `lead_source` int(11) NOT NULL,
  `lead_status` int(11) NOT NULL,
  `notify_lead_imported` int(11) NOT NULL DEFAULT 1,
  `notify_type` varchar(20) DEFAULT NULL,
  `notify_ids` mediumtext DEFAULT NULL,
  `responsible` int(11) NOT NULL DEFAULT 0,
  `name` varchar(191) NOT NULL,
  `form_data` mediumtext DEFAULT NULL,
  `recaptcha` int(11) NOT NULL DEFAULT 0,
  `submit_btn_name` varchar(40) DEFAULT NULL,
  `success_submit_msg` text DEFAULT NULL,
  `language` varchar(40) DEFAULT NULL,
  `allow_duplicate` int(11) NOT NULL DEFAULT 1,
  `mark_public` int(11) NOT NULL DEFAULT 0,
  `track_duplicate_field` varchar(20) DEFAULT NULL,
  `track_duplicate_field_and` varchar(20) DEFAULT NULL,
  `create_task_on_duplicate` int(11) NOT NULL DEFAULT 0,
  `dateadded` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ms_web_to_lead`
--

INSERT INTO `ms_web_to_lead` (`id`, `form_key`, `lead_source`, `lead_status`, `notify_lead_imported`, `notify_type`, `notify_ids`, `responsible`, `name`, `form_data`, `recaptcha`, `submit_btn_name`, `success_submit_msg`, `language`, `allow_duplicate`, `mark_public`, `track_duplicate_field`, `track_duplicate_field_and`, `create_task_on_duplicate`, `dateadded`) VALUES
(1, '9ebf22188487d2a39bc30ae99b977a14', 8, 2, 1, 'specific_staff', 'a:0:{}', 1, 'EGGManiac application form', '[{\"type\":\"header\",\"subtype\":\"h1\",\"label\":\"Thank you for showing interest in EGG Maniac.\"},{\"type\":\"text\",\"required\":true,\"label\":\"Name\",\"className\":\"form-control\",\"name\":\"name\",\"subtype\":\"text\"},{\"type\":\"text\",\"label\":\"Phone\",\"className\":\"form-control\",\"name\":\"phonenumber\",\"subtype\":\"text\"},{\"type\":\"text\",\"subtype\":\"email\",\"label\":\"Email Address\",\"className\":\"form-control\",\"name\":\"email\"},{\"type\":\"text\",\"label\":\"City\",\"className\":\"form-control\",\"name\":\"city\",\"subtype\":\"text\"}]', 0, 'Submit', 'Thank you for showing interest in EGGManiac. We will revert you soon. For any query please contact 8448449938.   ', 'english', 1, 0, '', '', 0, '2019-07-11 17:09:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ms_activity_log`
--
ALTER TABLE `ms_activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staffid` (`staffid`);

--
-- Indexes for table `ms_announcements`
--
ALTER TABLE `ms_announcements`
  ADD PRIMARY KEY (`announcementid`);

--
-- Indexes for table `ms_clients`
--
ALTER TABLE `ms_clients`
  ADD PRIMARY KEY (`userid`),
  ADD KEY `country` (`country`),
  ADD KEY `leadid` (`leadid`),
  ADD KEY `company` (`company`);

--
-- Indexes for table `ms_consents`
--
ALTER TABLE `ms_consents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purpose_id` (`purpose_id`),
  ADD KEY `contact_id` (`contact_id`),
  ADD KEY `lead_id` (`lead_id`);

--
-- Indexes for table `ms_consent_purposes`
--
ALTER TABLE `ms_consent_purposes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_contacts`
--
ALTER TABLE `ms_contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `firstname` (`firstname`),
  ADD KEY `lastname` (`lastname`),
  ADD KEY `email` (`email`),
  ADD KEY `is_primary` (`is_primary`);

--
-- Indexes for table `ms_contact_permissions`
--
ALTER TABLE `ms_contact_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_contracts`
--
ALTER TABLE `ms_contracts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client` (`client`),
  ADD KEY `contract_type` (`contract_type`);

--
-- Indexes for table `ms_contracts_types`
--
ALTER TABLE `ms_contracts_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_contract_comments`
--
ALTER TABLE `ms_contract_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_contract_renewals`
--
ALTER TABLE `ms_contract_renewals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_countries`
--
ALTER TABLE `ms_countries`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `ms_creditnotes`
--
ALTER TABLE `ms_creditnotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency` (`currency`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `ms_creditnote_refunds`
--
ALTER TABLE `ms_creditnote_refunds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_credits`
--
ALTER TABLE `ms_credits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_currencies`
--
ALTER TABLE `ms_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_customers_groups`
--
ALTER TABLE `ms_customers_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `ms_customer_admins`
--
ALTER TABLE `ms_customer_admins`
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `ms_customer_groups`
--
ALTER TABLE `ms_customer_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `groupid` (`groupid`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `ms_customfields`
--
ALTER TABLE `ms_customfields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_customfieldsvalues`
--
ALTER TABLE `ms_customfieldsvalues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `relid` (`relid`),
  ADD KEY `fieldto` (`fieldto`),
  ADD KEY `fieldid` (`fieldid`);

--
-- Indexes for table `ms_departments`
--
ALTER TABLE `ms_departments`
  ADD PRIMARY KEY (`departmentid`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `ms_dismissed_announcements`
--
ALTER TABLE `ms_dismissed_announcements`
  ADD PRIMARY KEY (`dismissedannouncementid`),
  ADD KEY `announcementid` (`announcementid`),
  ADD KEY `staff` (`staff`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `ms_emaillists`
--
ALTER TABLE `ms_emaillists`
  ADD PRIMARY KEY (`listid`);

--
-- Indexes for table `ms_emailtemplates`
--
ALTER TABLE `ms_emailtemplates`
  ADD PRIMARY KEY (`emailtemplateid`);

--
-- Indexes for table `ms_estimates`
--
ALTER TABLE `ms_estimates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `currency` (`currency`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `sale_agent` (`sale_agent`);

--
-- Indexes for table `ms_events`
--
ALTER TABLE `ms_events`
  ADD PRIMARY KEY (`eventid`);

--
-- Indexes for table `ms_expenses`
--
ALTER TABLE `ms_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `category` (`category`),
  ADD KEY `currency` (`currency`);

--
-- Indexes for table `ms_expenses_categories`
--
ALTER TABLE `ms_expenses_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_files`
--
ALTER TABLE `ms_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_id` (`rel_id`),
  ADD KEY `rel_type` (`rel_type`);

--
-- Indexes for table `ms_form_questions`
--
ALTER TABLE `ms_form_questions`
  ADD PRIMARY KEY (`questionid`);

--
-- Indexes for table `ms_form_question_box`
--
ALTER TABLE `ms_form_question_box`
  ADD PRIMARY KEY (`boxid`);

--
-- Indexes for table `ms_form_question_box_description`
--
ALTER TABLE `ms_form_question_box_description`
  ADD PRIMARY KEY (`questionboxdescriptionid`);

--
-- Indexes for table `ms_form_results`
--
ALTER TABLE `ms_form_results`
  ADD PRIMARY KEY (`resultid`);

--
-- Indexes for table `ms_gdpr_requests`
--
ALTER TABLE `ms_gdpr_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_goals`
--
ALTER TABLE `ms_goals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `ms_invoicepaymentrecords`
--
ALTER TABLE `ms_invoicepaymentrecords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoiceid` (`invoiceid`),
  ADD KEY `paymentmethod` (`paymentmethod`);

--
-- Indexes for table `ms_invoices`
--
ALTER TABLE `ms_invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency` (`currency`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `sale_agent` (`sale_agent`),
  ADD KEY `total` (`total`);

--
-- Indexes for table `ms_itemable`
--
ALTER TABLE `ms_itemable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_id` (`rel_id`),
  ADD KEY `rel_type` (`rel_type`),
  ADD KEY `qty` (`qty`),
  ADD KEY `rate` (`rate`);

--
-- Indexes for table `ms_items`
--
ALTER TABLE `ms_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tax` (`tax`),
  ADD KEY `tax2` (`tax2`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `ms_items_groups`
--
ALTER TABLE `ms_items_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_item_tax`
--
ALTER TABLE `ms_item_tax`
  ADD PRIMARY KEY (`id`),
  ADD KEY `itemid` (`itemid`);

--
-- Indexes for table `ms_knowedge_base_article_feedback`
--
ALTER TABLE `ms_knowedge_base_article_feedback`
  ADD PRIMARY KEY (`articleanswerid`);

--
-- Indexes for table `ms_knowledge_base`
--
ALTER TABLE `ms_knowledge_base`
  ADD PRIMARY KEY (`articleid`);

--
-- Indexes for table `ms_knowledge_base_groups`
--
ALTER TABLE `ms_knowledge_base_groups`
  ADD PRIMARY KEY (`groupid`);

--
-- Indexes for table `ms_leads`
--
ALTER TABLE `ms_leads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `company` (`company`),
  ADD KEY `email` (`email`),
  ADD KEY `assigned` (`assigned`),
  ADD KEY `status` (`status`),
  ADD KEY `source` (`source`),
  ADD KEY `lastcontact` (`lastcontact`),
  ADD KEY `dateadded` (`dateadded`),
  ADD KEY `leadorder` (`leadorder`),
  ADD KEY `from_form_id` (`from_form_id`);

--
-- Indexes for table `ms_leads_email_integration`
--
ALTER TABLE `ms_leads_email_integration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_leads_sources`
--
ALTER TABLE `ms_leads_sources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `ms_leads_status`
--
ALTER TABLE `ms_leads_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `ms_lead_activity_log`
--
ALTER TABLE `ms_lead_activity_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_lead_integration_emails`
--
ALTER TABLE `ms_lead_integration_emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_listemails`
--
ALTER TABLE `ms_listemails`
  ADD PRIMARY KEY (`emailid`);

--
-- Indexes for table `ms_maillistscustomfields`
--
ALTER TABLE `ms_maillistscustomfields`
  ADD PRIMARY KEY (`customfieldid`);

--
-- Indexes for table `ms_maillistscustomfieldvalues`
--
ALTER TABLE `ms_maillistscustomfieldvalues`
  ADD PRIMARY KEY (`customfieldvalueid`),
  ADD KEY `listid` (`listid`),
  ADD KEY `customfieldid` (`customfieldid`);

--
-- Indexes for table `ms_mail_queue`
--
ALTER TABLE `ms_mail_queue`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_milestones`
--
ALTER TABLE `ms_milestones`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_modules`
--
ALTER TABLE `ms_modules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_newsfeed_comment_likes`
--
ALTER TABLE `ms_newsfeed_comment_likes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_newsfeed_posts`
--
ALTER TABLE `ms_newsfeed_posts`
  ADD PRIMARY KEY (`postid`);

--
-- Indexes for table `ms_newsfeed_post_comments`
--
ALTER TABLE `ms_newsfeed_post_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_newsfeed_post_likes`
--
ALTER TABLE `ms_newsfeed_post_likes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_notes`
--
ALTER TABLE `ms_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_id` (`rel_id`),
  ADD KEY `rel_type` (`rel_type`);

--
-- Indexes for table `ms_notifications`
--
ALTER TABLE `ms_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_options`
--
ALTER TABLE `ms_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `ms_payment_modes`
--
ALTER TABLE `ms_payment_modes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_pinned_projects`
--
ALTER TABLE `ms_pinned_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `ms_projectdiscussioncomments`
--
ALTER TABLE `ms_projectdiscussioncomments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_projectdiscussions`
--
ALTER TABLE `ms_projectdiscussions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_projects`
--
ALTER TABLE `ms_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `ms_project_activity`
--
ALTER TABLE `ms_project_activity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_project_files`
--
ALTER TABLE `ms_project_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_project_members`
--
ALTER TABLE `ms_project_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `ms_project_notes`
--
ALTER TABLE `ms_project_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_project_settings`
--
ALTER TABLE `ms_project_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `ms_proposals`
--
ALTER TABLE `ms_proposals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_proposal_comments`
--
ALTER TABLE `ms_proposal_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_related_items`
--
ALTER TABLE `ms_related_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_reminders`
--
ALTER TABLE `ms_reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_id` (`rel_id`),
  ADD KEY `rel_type` (`rel_type`),
  ADD KEY `staff` (`staff`);

--
-- Indexes for table `ms_roles`
--
ALTER TABLE `ms_roles`
  ADD PRIMARY KEY (`roleid`);

--
-- Indexes for table `ms_sales_activity`
--
ALTER TABLE `ms_sales_activity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_services`
--
ALTER TABLE `ms_services`
  ADD PRIMARY KEY (`serviceid`);

--
-- Indexes for table `ms_sessions`
--
ALTER TABLE `ms_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `ms_spam_filters`
--
ALTER TABLE `ms_spam_filters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_staff`
--
ALTER TABLE `ms_staff`
  ADD PRIMARY KEY (`staffid`),
  ADD KEY `firstname` (`firstname`),
  ADD KEY `lastname` (`lastname`);

--
-- Indexes for table `ms_staff_departments`
--
ALTER TABLE `ms_staff_departments`
  ADD PRIMARY KEY (`staffdepartmentid`);

--
-- Indexes for table `ms_subscriptions`
--
ALTER TABLE `ms_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientid` (`clientid`),
  ADD KEY `currency` (`currency`),
  ADD KEY `tax_id` (`tax_id`);

--
-- Indexes for table `ms_surveyresultsets`
--
ALTER TABLE `ms_surveyresultsets`
  ADD PRIMARY KEY (`resultsetid`);

--
-- Indexes for table `ms_surveys`
--
ALTER TABLE `ms_surveys`
  ADD PRIMARY KEY (`surveyid`);

--
-- Indexes for table `ms_surveysemailsendcron`
--
ALTER TABLE `ms_surveysemailsendcron`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_surveysendlog`
--
ALTER TABLE `ms_surveysendlog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_taggables`
--
ALTER TABLE `ms_taggables`
  ADD KEY `rel_id` (`rel_id`),
  ADD KEY `rel_type` (`rel_type`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `ms_tags`
--
ALTER TABLE `ms_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `ms_tasks`
--
ALTER TABLE `ms_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rel_id` (`rel_id`),
  ADD KEY `rel_type` (`rel_type`),
  ADD KEY `milestone` (`milestone`),
  ADD KEY `kanban_order` (`kanban_order`);

--
-- Indexes for table `ms_taskstimers`
--
ALTER TABLE `ms_taskstimers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `ms_tasks_checklist_templates`
--
ALTER TABLE `ms_tasks_checklist_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_task_assigned`
--
ALTER TABLE `ms_task_assigned`
  ADD PRIMARY KEY (`id`),
  ADD KEY `taskid` (`taskid`),
  ADD KEY `staffid` (`staffid`);

--
-- Indexes for table `ms_task_checklist_items`
--
ALTER TABLE `ms_task_checklist_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `taskid` (`taskid`);

--
-- Indexes for table `ms_task_comments`
--
ALTER TABLE `ms_task_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file_id` (`file_id`),
  ADD KEY `taskid` (`taskid`);

--
-- Indexes for table `ms_task_followers`
--
ALTER TABLE `ms_task_followers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_taxes`
--
ALTER TABLE `ms_taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_tickets`
--
ALTER TABLE `ms_tickets`
  ADD PRIMARY KEY (`ticketid`),
  ADD KEY `service` (`service`),
  ADD KEY `department` (`department`),
  ADD KEY `status` (`status`),
  ADD KEY `userid` (`userid`),
  ADD KEY `priority` (`priority`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `contactid` (`contactid`);

--
-- Indexes for table `ms_tickets_pipe_log`
--
ALTER TABLE `ms_tickets_pipe_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_tickets_predefined_replies`
--
ALTER TABLE `ms_tickets_predefined_replies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_tickets_priorities`
--
ALTER TABLE `ms_tickets_priorities`
  ADD PRIMARY KEY (`priorityid`);

--
-- Indexes for table `ms_tickets_status`
--
ALTER TABLE `ms_tickets_status`
  ADD PRIMARY KEY (`ticketstatusid`);

--
-- Indexes for table `ms_ticket_attachments`
--
ALTER TABLE `ms_ticket_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_ticket_replies`
--
ALTER TABLE `ms_ticket_replies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_todos`
--
ALTER TABLE `ms_todos`
  ADD PRIMARY KEY (`todoid`);

--
-- Indexes for table `ms_tracked_mails`
--
ALTER TABLE `ms_tracked_mails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_user_meta`
--
ALTER TABLE `ms_user_meta`
  ADD PRIMARY KEY (`umeta_id`);

--
-- Indexes for table `ms_vault`
--
ALTER TABLE `ms_vault`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_views_tracking`
--
ALTER TABLE `ms_views_tracking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ms_web_to_lead`
--
ALTER TABLE `ms_web_to_lead`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ms_activity_log`
--
ALTER TABLE `ms_activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `ms_announcements`
--
ALTER TABLE `ms_announcements`
  MODIFY `announcementid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_clients`
--
ALTER TABLE `ms_clients`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_consents`
--
ALTER TABLE `ms_consents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_consent_purposes`
--
ALTER TABLE `ms_consent_purposes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_contacts`
--
ALTER TABLE `ms_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_contact_permissions`
--
ALTER TABLE `ms_contact_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_contracts`
--
ALTER TABLE `ms_contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_contracts_types`
--
ALTER TABLE `ms_contracts_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_contract_comments`
--
ALTER TABLE `ms_contract_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_contract_renewals`
--
ALTER TABLE `ms_contract_renewals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_countries`
--
ALTER TABLE `ms_countries`
  MODIFY `country_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT for table `ms_creditnotes`
--
ALTER TABLE `ms_creditnotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_creditnote_refunds`
--
ALTER TABLE `ms_creditnote_refunds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_credits`
--
ALTER TABLE `ms_credits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_currencies`
--
ALTER TABLE `ms_currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ms_customers_groups`
--
ALTER TABLE `ms_customers_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_customer_groups`
--
ALTER TABLE `ms_customer_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_customfields`
--
ALTER TABLE `ms_customfields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_customfieldsvalues`
--
ALTER TABLE `ms_customfieldsvalues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_departments`
--
ALTER TABLE `ms_departments`
  MODIFY `departmentid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_dismissed_announcements`
--
ALTER TABLE `ms_dismissed_announcements`
  MODIFY `dismissedannouncementid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_emaillists`
--
ALTER TABLE `ms_emaillists`
  MODIFY `listid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_emailtemplates`
--
ALTER TABLE `ms_emailtemplates`
  MODIFY `emailtemplateid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1629;

--
-- AUTO_INCREMENT for table `ms_estimates`
--
ALTER TABLE `ms_estimates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_events`
--
ALTER TABLE `ms_events`
  MODIFY `eventid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_expenses`
--
ALTER TABLE `ms_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_expenses_categories`
--
ALTER TABLE `ms_expenses_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_files`
--
ALTER TABLE `ms_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_form_questions`
--
ALTER TABLE `ms_form_questions`
  MODIFY `questionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_form_question_box`
--
ALTER TABLE `ms_form_question_box`
  MODIFY `boxid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_form_question_box_description`
--
ALTER TABLE `ms_form_question_box_description`
  MODIFY `questionboxdescriptionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_form_results`
--
ALTER TABLE `ms_form_results`
  MODIFY `resultid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_gdpr_requests`
--
ALTER TABLE `ms_gdpr_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_goals`
--
ALTER TABLE `ms_goals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_invoicepaymentrecords`
--
ALTER TABLE `ms_invoicepaymentrecords`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_invoices`
--
ALTER TABLE `ms_invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_itemable`
--
ALTER TABLE `ms_itemable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_items`
--
ALTER TABLE `ms_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_items_groups`
--
ALTER TABLE `ms_items_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_item_tax`
--
ALTER TABLE `ms_item_tax`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_knowedge_base_article_feedback`
--
ALTER TABLE `ms_knowedge_base_article_feedback`
  MODIFY `articleanswerid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_knowledge_base`
--
ALTER TABLE `ms_knowledge_base`
  MODIFY `articleid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_knowledge_base_groups`
--
ALTER TABLE `ms_knowledge_base_groups`
  MODIFY `groupid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_leads`
--
ALTER TABLE `ms_leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_leads_email_integration`
--
ALTER TABLE `ms_leads_email_integration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'the ID always must be 1', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_leads_sources`
--
ALTER TABLE `ms_leads_sources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ms_leads_status`
--
ALTER TABLE `ms_leads_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ms_lead_activity_log`
--
ALTER TABLE `ms_lead_activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ms_lead_integration_emails`
--
ALTER TABLE `ms_lead_integration_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_listemails`
--
ALTER TABLE `ms_listemails`
  MODIFY `emailid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_maillistscustomfields`
--
ALTER TABLE `ms_maillistscustomfields`
  MODIFY `customfieldid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_maillistscustomfieldvalues`
--
ALTER TABLE `ms_maillistscustomfieldvalues`
  MODIFY `customfieldvalueid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_mail_queue`
--
ALTER TABLE `ms_mail_queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_milestones`
--
ALTER TABLE `ms_milestones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_modules`
--
ALTER TABLE `ms_modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ms_newsfeed_comment_likes`
--
ALTER TABLE `ms_newsfeed_comment_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_newsfeed_posts`
--
ALTER TABLE `ms_newsfeed_posts`
  MODIFY `postid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_newsfeed_post_comments`
--
ALTER TABLE `ms_newsfeed_post_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_newsfeed_post_likes`
--
ALTER TABLE `ms_newsfeed_post_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_notes`
--
ALTER TABLE `ms_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_notifications`
--
ALTER TABLE `ms_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_options`
--
ALTER TABLE `ms_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=429;

--
-- AUTO_INCREMENT for table `ms_payment_modes`
--
ALTER TABLE `ms_payment_modes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_pinned_projects`
--
ALTER TABLE `ms_pinned_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_projectdiscussioncomments`
--
ALTER TABLE `ms_projectdiscussioncomments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_projectdiscussions`
--
ALTER TABLE `ms_projectdiscussions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_projects`
--
ALTER TABLE `ms_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_project_activity`
--
ALTER TABLE `ms_project_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_project_files`
--
ALTER TABLE `ms_project_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_project_members`
--
ALTER TABLE `ms_project_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_project_notes`
--
ALTER TABLE `ms_project_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_project_settings`
--
ALTER TABLE `ms_project_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_proposals`
--
ALTER TABLE `ms_proposals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_proposal_comments`
--
ALTER TABLE `ms_proposal_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_related_items`
--
ALTER TABLE `ms_related_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_reminders`
--
ALTER TABLE `ms_reminders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_roles`
--
ALTER TABLE `ms_roles`
  MODIFY `roleid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_sales_activity`
--
ALTER TABLE `ms_sales_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ms_services`
--
ALTER TABLE `ms_services`
  MODIFY `serviceid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_spam_filters`
--
ALTER TABLE `ms_spam_filters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_staff`
--
ALTER TABLE `ms_staff`
  MODIFY `staffid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ms_staff_departments`
--
ALTER TABLE `ms_staff_departments`
  MODIFY `staffdepartmentid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_subscriptions`
--
ALTER TABLE `ms_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_surveyresultsets`
--
ALTER TABLE `ms_surveyresultsets`
  MODIFY `resultsetid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_surveys`
--
ALTER TABLE `ms_surveys`
  MODIFY `surveyid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_surveysemailsendcron`
--
ALTER TABLE `ms_surveysemailsendcron`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_surveysendlog`
--
ALTER TABLE `ms_surveysendlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_tags`
--
ALTER TABLE `ms_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_tasks`
--
ALTER TABLE `ms_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_taskstimers`
--
ALTER TABLE `ms_taskstimers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_tasks_checklist_templates`
--
ALTER TABLE `ms_tasks_checklist_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_task_assigned`
--
ALTER TABLE `ms_task_assigned`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_task_checklist_items`
--
ALTER TABLE `ms_task_checklist_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_task_comments`
--
ALTER TABLE `ms_task_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_task_followers`
--
ALTER TABLE `ms_task_followers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_taxes`
--
ALTER TABLE `ms_taxes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_tickets`
--
ALTER TABLE `ms_tickets`
  MODIFY `ticketid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_tickets_pipe_log`
--
ALTER TABLE `ms_tickets_pipe_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_tickets_predefined_replies`
--
ALTER TABLE `ms_tickets_predefined_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_tickets_priorities`
--
ALTER TABLE `ms_tickets_priorities`
  MODIFY `priorityid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ms_tickets_status`
--
ALTER TABLE `ms_tickets_status`
  MODIFY `ticketstatusid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ms_ticket_attachments`
--
ALTER TABLE `ms_ticket_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_ticket_replies`
--
ALTER TABLE `ms_ticket_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_todos`
--
ALTER TABLE `ms_todos`
  MODIFY `todoid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_tracked_mails`
--
ALTER TABLE `ms_tracked_mails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_user_meta`
--
ALTER TABLE `ms_user_meta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ms_vault`
--
ALTER TABLE `ms_vault`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_views_tracking`
--
ALTER TABLE `ms_views_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ms_web_to_lead`
--
ALTER TABLE `ms_web_to_lead`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
