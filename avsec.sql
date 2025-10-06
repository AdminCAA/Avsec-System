-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 06, 2025 at 10:37 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `avsec`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_area_categories`
--

CREATE TABLE `audit_area_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_area_categories`
--

INSERT INTO `audit_area_categories` (`id`, `category_name`, `name`, `created_at`, `updated_at`) VALUES
(2, 'Airport Operator', 'Recruitment, Training and Certification - Airport Operator', '2025-05-17 17:52:28', '2025-07-25 16:57:14'),
(3, 'Airport Operator', 'Procedures for Screening Persons and Cabin Baggage - Airport Operator', '2025-05-17 17:53:06', '2025-07-25 16:57:05'),
(4, 'Airport Operator', 'Security Measures Relating to Firearm Handling - Airport Operator', '2025-05-17 17:53:30', '2025-07-25 16:57:29'),
(5, 'Airport Operator', 'Screening Points - Airport Operator', '2025-05-17 17:53:59', '2025-07-25 16:57:22'),
(6, 'Airport Operator', 'Hold Baggage System (security) - Airport Operator', '2025-05-17 17:54:21', '2025-07-25 16:54:58'),
(7, 'Airport Operator', 'Airside Access Control - Airport Operator', '2025-05-17 17:54:42', '2025-07-25 16:54:41'),
(8, 'Airport Operator', 'Perimeter Control - Airport Operator', '2025-05-17 17:55:01', '2025-07-25 16:56:56'),
(9, 'Airport Operator', 'Airport Identification System - Airport Operator', '2025-05-17 17:55:26', '2025-07-25 16:54:07'),
(10, 'Airport Operator', 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', '2025-05-17 17:55:44', '2025-07-25 16:54:51'),
(11, 'Airport Operator', 'Terminal Building/ Security Restricted Areas - Airport Operator', '2025-05-17 17:56:05', '2025-07-25 16:57:35'),
(14, 'Airport Operator', 'Landside - Airport Operator', '2025-05-19 05:29:09', '2025-07-25 16:55:05'),
(18, 'Airline Operator', 'Left Behind Items On Transit Flights - Airline Operator', '2025-06-11 10:08:12', '2025-07-25 16:55:39'),
(21, 'Airline Operator', 'Organisations and Operations - Airline Operator', '2025-07-25 08:07:53', '2025-07-25 16:56:43'),
(24, 'Regulated Agent', 'Airport Identification System - Regulated Agent', '2025-07-25 16:43:38', '2025-07-25 16:54:30'),
(26, 'Airport Operator', 'Taxi runway - Airport Operator', '2025-07-31 11:56:00', '2025-07-31 11:56:00');

-- --------------------------------------------------------

--
-- Table structure for table `audit_questions`
--

CREATE TABLE `audit_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `audit_area_name` varchar(255) DEFAULT NULL,
  `audit_area_category_id` bigint(20) UNSIGNED NOT NULL,
  `question` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_questions`
--

INSERT INTO `audit_questions` (`id`, `audit_area_name`, `audit_area_category_id`, `question`, `created_at`, `updated_at`) VALUES
(4, 'Recruitment, Training and Certification - Airport Operator', 2, 'Does the airport conduct aviation security training on staff members?', '2025-05-19 07:46:50', '2025-05-19 07:46:50'),
(5, 'Recruitment, Training and Certification - Airport Operator', 2, 'Are staff members subjected to search when entering the airport restricted area?', '2025-05-19 07:47:06', '2025-05-19 07:47:06'),
(6, 'Recruitment, Training and Certification - Airport Operator', 2, 'Are records of aviation security training kept for inspections purposes?', '2025-05-19 07:47:32', '2025-05-19 07:47:32'),
(7, 'Procedures for Screening Persons and Cabin Baggage - Airport Operator', 3, 'Is there permit system in place to prevent unauthorized access onto restricted areas?', '2025-05-19 07:47:51', '2025-05-19 07:47:51'),
(8, 'Procedures for Screening Persons and Cabin Baggage - Airport Operator', 3, 'Is there access control into restricted areas?', '2025-05-19 07:48:04', '2025-05-19 07:48:04'),
(9, 'Procedures for Screening Persons and Cabin Baggage - Airport Operator', 3, 'What documents are passengers required to have when accessing restricted areas?', '2025-05-19 07:48:18', '2025-05-19 07:48:18'),
(10, 'Procedures for Screening Persons and Cabin Baggage - Airport Operator', 3, 'Has the airport developed detailed procedures for?\n i.  the positioning of screening staff is effectively implemented as per the national requirements.\n ii. the positioning of screening staff is effectively implemented as per the national requirements.\n iii. the number of persons within the screening area is limited to a number that can be effectively controlled. In this regard, the airport security staff should be able to identify the rightful owner of the baggage that will be subject to an additional search.', '2025-05-19 07:49:42', '2025-05-19 07:49:42'),
(11, 'Security Measures Relating to Firearm Handling - Airport Operator', 4, 'Are procedures in place for carriage of firearms?', '2025-05-19 07:50:16', '2025-05-19 07:50:16'),
(12, 'Security Measures Relating to Firearm Handling - Airport Operator', 4, 'Has the staff been trained on the acceptance of firearms?', '2025-05-19 07:50:30', '2025-05-19 07:50:30'),
(13, 'Security Measures Relating to Firearm Handling - Airport Operator', 4, 'Is the airport licensed by the appropriate Authority to use firearms?', '2025-05-19 07:51:02', '2025-05-19 07:51:02'),
(14, 'Screening Points - Airport Operator', 5, 'Is the staffing requirement as per ASP?', '2025-05-19 07:51:53', '2025-05-19 07:51:53'),
(15, 'Screening Points - Airport Operator', 5, 'Is there procedure for prohibited items?', '2025-05-19 07:52:08', '2025-05-19 07:52:08'),
(16, 'Screening Points - Airport Operator', 5, 'Is there a confiscated item bin at the SCP?', '2025-05-19 07:52:24', '2025-05-19 07:52:24'),
(17, 'Hold Baggage System (security) - Airport Operator', 6, 'Is hold baggage screening implemented?', '2025-05-19 07:52:44', '2025-05-19 07:52:44'),
(18, 'Hold Baggage System (security) - Airport Operator', 6, 'X-ray equipment condition (initial daily test log).', '2025-05-19 07:53:00', '2025-05-19 07:53:00'),
(19, 'Hold Baggage System (security) - Airport Operator', 6, 'Does the screening comply with the ASP and CAA requirements?', '2025-05-19 07:53:14', '2025-05-19 07:53:14'),
(20, 'Hold Baggage System (security) - Airport Operator', 6, 'Are registers available?', '2025-05-19 07:53:29', '2025-05-19 07:53:29'),
(21, 'Hold Baggage System (security) - Airport Operator', 6, 'Are there security measures in place for safe guarding of hold baggage?', '2025-05-19 07:53:42', '2025-05-19 07:53:42'),
(23, 'Airside Access Control - Airport Operator', 7, 'Communication equipment in the Access control point.', '2025-05-19 07:54:49', '2025-05-19 07:54:49'),
(24, 'Airside Access Control - Airport Operator', 7, 'Appropriate staffing number in the Access control point.', '2025-05-19 07:55:09', '2025-05-19 07:55:09'),
(25, 'Airside Access Control - Airport Operator', 7, 'Access control Stop-List.', '2025-05-19 07:55:32', '2025-05-19 07:55:32'),
(26, 'Perimeter Control - Airport Operator', 8, 'Is there physical barrier erected around the airport?', '2025-05-19 07:55:55', '2025-05-19 07:55:55'),
(27, 'Perimeter Control - Airport Operator', 8, 'Is there perimeter fence adequately maintained?', '2025-05-19 07:56:31', '2025-05-19 07:56:31'),
(29, 'Airport Identification System - Airport Operator', 9, 'Type of the fence and height.', '2025-05-19 07:57:33', '2025-05-19 07:57:33'),
(30, 'Airport Identification System - Airport Operator', 8, 'Are security patrols conducted along the perimeter as per ASP requirements?', '2025-05-19 07:57:47', '2025-05-19 07:57:47'),
(31, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 9, 'Has the airport established procedures for the airport personnel ID pass system, in order to include, amongst other elements:', '2025-05-19 07:58:23', '2025-05-19 07:58:23'),
(32, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 9, 'an effective and prompt mechanism to retrieve badges from persons who have ceased to require airport ID passes.', '2025-05-19 07:58:35', '2025-05-19 07:58:35'),
(33, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 9, 'a clear distinction in the airport ID passes to easily identify holders of ID passes who should be escorted at all times in the SRA.', '2025-05-19 07:58:56', '2025-05-19 07:58:56'),
(34, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 10, 'Is there a contingency plan in place?', '2025-05-19 07:59:11', '2025-05-19 07:59:11'),
(35, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 10, 'Are emergency drills/contingency exercise conducted?', '2025-05-19 07:59:26', '2025-05-19 07:59:26'),
(36, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 10, 'How regularly are emergency drills held?', '2025-05-19 07:59:39', '2025-05-19 07:59:39'),
(37, 'Terminal Building/ Security Restricted Areas - Airport Operator', 11, 'Armed personnel in the lobby.', '2025-05-19 07:59:55', '2025-05-19 07:59:55'),
(38, 'Terminal Building/ Security Restricted Areas - Airport Operator', 11, 'Suspicious items in the lobby.', '2025-05-19 08:00:16', '2025-05-19 08:00:16'),
(39, 'Terminal Building/ Security Restricted Areas - Airport Operator', 11, 'Suspicious persons in the lobby.', '2025-05-19 08:00:33', '2025-05-19 08:00:33'),
(40, 'Terminal Building/ Security Restricted Areas - Airport Operator', 11, 'Monitoring of the security procedures applied by airport tenants facilities with access rights from landside to airside.', '2025-05-19 08:00:45', '2025-05-19 08:00:45'),
(41, 'Landside - Airport Operator', 14, 'Suspicious persons in the area.', '2025-05-19 08:01:11', '2025-05-19 08:01:11'),
(42, 'Landside - Airport Operator', 14, 'Vehicles parked during long periods.', '2025-05-19 08:01:23', '2025-05-19 08:01:23'),
(43, 'Landside - Airport Operator', 14, 'Vehicles parked in areas not permitted or without driver.', '2025-05-19 08:01:40', '2025-05-19 08:01:40'),
(44, 'Landside - Airport Operator', 14, 'Does the ASC coordinate issues related to landside security as required by the national documentation?', '2025-05-19 08:01:51', '2025-05-19 08:01:51'),
(47, 'Left Behind Items On Transit Flights  -  Airline Operator', 18, 'The tester attempts the test item (dummy bag) in designated seats or compatment(Observer whether the security personnel conducting the checks identifies and report /remove the test item)', '2025-06-11 10:14:43', '2025-06-11 10:14:43'),
(49, 'Screening Points - Airport Operator', 5, 'Damp Question', '2025-07-25 08:09:02', '2025-07-25 17:29:03'),
(50, 'Taxi runway - Airport Operator', 26, 'Has this question has been edited before ?', '2025-07-31 11:57:33', '2025-09-10 09:59:47'),
(51, 'Taxi runway - Airport Operator', 26, 'This is just a sample question about the taxi runway', '2025-07-31 18:33:16', '2025-09-10 09:57:29');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('avsec_information_system_cache_22b856c81276bbb6a301fcdb5ae6094d', 'i:1;', 1759738572),
('avsec_information_system_cache_22b856c81276bbb6a301fcdb5ae6094d:timer', 'i:1759738572;', 1759738572),
('avsec_information_system_cache_2f2ba16699661a8a715ef6a54b0f00aa', 'i:1;', 1755005784),
('avsec_information_system_cache_2f2ba16699661a8a715ef6a54b0f00aa:timer', 'i:1755005784;', 1755005784),
('avsec_information_system_cache_356a192b7913b04c54574d18c28d46e6395428ab', 'i:1;', 1755007254),
('avsec_information_system_cache_356a192b7913b04c54574d18c28d46e6395428ab:timer', 'i:1755007254;', 1755007254),
('avsec_information_system_cache_46a1cfa7855c2c1eff8773d655e1a6e1', 'i:1;', 1755005490),
('avsec_information_system_cache_46a1cfa7855c2c1eff8773d655e1a6e1:timer', 'i:1755005490;', 1755005490),
('avsec_information_system_cache_58a529729abdfedf1f6a0f17c1ebdaf4', 'i:2;', 1759738652),
('avsec_information_system_cache_58a529729abdfedf1f6a0f17c1ebdaf4:timer', 'i:1759738652;', 1759738652),
('avsec_information_system_cache_c6be2cf7c13d9a527ee2fe401bbae3c7', 'i:1;', 1756370438),
('avsec_information_system_cache_c6be2cf7c13d9a527ee2fe401bbae3c7:timer', 'i:1756370437;', 1756370438),
('avsec_information_system_cache_david.chamanga@caa.co.zm|127.0.0.1', 'i:1;', 1754661865),
('avsec_information_system_cache_david.chamanga@caa.co.zm|127.0.0.1:timer', 'i:1754661865;', 1754661865),
('avsec_information_system_cache_e91cebb592fab1597562f6fefd16414c', 'i:2;', 1755005288),
('avsec_information_system_cache_e91cebb592fab1597562f6fefd16414c:timer', 'i:1755005288;', 1755005288),
('avsec_information_system_cache_felix.mantini@caa.co.zm|127.0.0.1', 'i:1;', 1759738381),
('avsec_information_system_cache_felix.mantini@caa.co.zm|127.0.0.1:timer', 'i:1759738381;', 1759738381),
('avsec_information_system_cache_fortify.2fa_codes.029e016e0df6cca8be1b8cee85ea9e0e', 'i:58560619;', 1756818655),
('avsec_information_system_cache_fortify.2fa_codes.140e2dab615e0af460274f0c4c7410b0', 'i:58508658;', 1755259820),
('avsec_information_system_cache_fortify.2fa_codes.16fda6740e22b74984b467d0310cd19d', 'i:58548704;', 1756461207),
('avsec_information_system_cache_fortify.2fa_codes.360157506e7ee2afdff17b3d9b4a218c', 'i:58566882;', 1757006545),
('avsec_information_system_cache_fortify.2fa_codes.3c73d2c14d0e25dc52cab4e90461ccb1', 'i:58557518;', 1756725623),
('avsec_information_system_cache_fortify.2fa_codes.757560a5e383c8776ab39d54f19e2a39', 'i:58557230;', 1756716981),
('avsec_information_system_cache_fortify.2fa_codes.986fd0a9ec02af9dcb6164f2ca7e2a9c', 'i:58508657;', 1755259794),
('avsec_information_system_cache_fortify.2fa_codes.ac5c5f64315d21efe1a01d0af26f3222', 'i:58565937;', 1756978193),
('avsec_information_system_cache_fortify.2fa_codes.cef14aa7838e07352bea0eda77d6dd11', 'i:58559871;', 1756796211),
('avsec_information_system_cache_fortify.2fa_codes.cf475dc8ca42d885c8a2c2edc2a4b15d', 'i:58529177;', 1755875394),
('avsec_information_system_cache_fortify.2fa_codes.f15d15cfed3aa9fa3c0aafdc433961d5', 'i:58577290;', 1757318785),
('avsec_information_system_cache_fortify.2fa_codes.f182d84c6edfc53eea3f4b89f72c2a44', 'i:58577968;', 1757339119),
('avsec_information_system_cache_kelvin.mwamba@gmail.com|127.0.0.1', 'i:1;', 1755005491),
('avsec_information_system_cache_kelvin.mwamba@gmail.com|127.0.0.1:timer', 'i:1755005491;', 1755005491),
('avsec_information_system_cache_mike.chileshe@gmail.com|127.0.0.1', 'i:2;', 1755005288),
('avsec_information_system_cache_mike.chileshe@gmail.com|127.0.0.1:timer', 'i:1755005288;', 1755005288);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `certifications`
--

CREATE TABLE `certifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `certification_name` varchar(255) NOT NULL,
  `certification_body` varchar(255) NOT NULL,
  `date_issued` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `certification_number` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `certification_type` varchar(255) NOT NULL,
  `certification_file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `certifications`
--

INSERT INTO `certifications` (`id`, `user_id`, `certification_name`, `certification_body`, `date_issued`, `expiry_date`, `certification_number`, `status`, `score`, `remarks`, `certification_type`, `certification_file`, `created_at`, `updated_at`) VALUES
(3, 13, 'Screening Of Persons Using HHMD', 'ZCAAx', '2025-06-18', '2025-06-21', 'ZCAA/2025/3', 'Active', 90, 'Passed at first attempt', 'Certification', 'certifications/AtdVqjRExcBijbkLPXNwr4m0rXNeBTK0M0BX2zzi.pdf', '2025-06-17 12:49:20', '2025-06-23 11:42:16'),
(4, 13, 'Theory Exams', 'CAA', '2025-07-25', '2025-07-31', 'CAA/2025/1', 'Active', 82, 'Initial', 'Certification', 'certifications/6G2LPKpaT2Nkib07O4GrEb0sOBxyPcNDCtlXnZUY.pdf', '2025-07-25 08:36:09', '2025-07-25 08:36:09');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(3, 'AVSEC', 'cdsafdsfs', '2025-08-05 13:18:34', '2025-08-05 13:51:32'),
(4, 'AGA', 'fdsafdsafds', '2025-08-05 13:18:45', '2025-08-05 13:18:45');

-- --------------------------------------------------------

--
-- Table structure for table `facilities`
--

CREATE TABLE `facilities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_number` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `department_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `facilities`
--

INSERT INTO `facilities` (`id`, `name`, `description`, `category`, `location`, `address`, `contact_number`, `email`, `deleted_at`, `created_at`, `updated_at`, `department_id`, `department_name`) VALUES
(1, 'Spinka Group', 'Eligendi et ut vero modi dicta.', 'Catering Agent', 'Sawaynfort', '4662 Megane Tunnel Suite 514\nLake Emanuelton, RI 00929', '1-732-813-9300', 'kshlerin.violette@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(2, 'Bartell-Bednar', 'Et quia excepturi natus dolorum.', 'Fuel Supplier', 'South Raymondburgh', '458 Rempel Parkway\nOrtizburgh, WA 29532-4171', '802-650-4925', 'ramiro37@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(3, 'Rau-Lakin', 'Error doloribus consequatur a molestiae iusto in.', 'Regulated Agent', 'East Alvera', '5297 Kshlerin Inlet Suite 300\nWest Kennith, MT 56124-8348', '+1-904-979-5401', 'hoeger.maude@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(4, 'Tillman-Schultz', 'Natus unde aut qui quisquam placeat.', 'Catering Agent', 'Port Jake', '639 Koss Mountain Apt. 047\nKuhlmanmouth, MD 85913', '+1-559-312-0186', 'eharris@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(5, 'Muller LLC', 'Fugit illo sequi molestias ipsam quia dolores omnis.', 'Airline Operator', 'Fletcherchester', '74159 Jones Union\nWest Jammie, FL 53448', '217.590.7425', 'turcotte.tatyana@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(6, 'Welch, Wuckert and Padberg', 'Dolor nihil numquam velit repellendus cumque autem.', 'Air Navigation Service Provider', 'Lindtown', '93526 Koch Station Suite 320\nNorth Kayleeland, MI 24977-1182', '+1 (925) 290-8757', 'langworth.geovany@example.net', NULL, '2025-05-17 13:46:19', '2025-08-05 13:51:49', 3, NULL),
(7, 'Johnston Group', 'Et veniam quis optio iste aut.', 'Airport Operator', 'Wunschfurt', '578 Green Cape Apt. 686\nLake Whitney, WY 69641-6091', '+1 (743) 572-8348', 'lang.sabrina@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(8, 'Larson and Sons', 'Aspernatur non voluptatem officia.', 'Fuel Supplier', 'Port Moses', '20859 Moen Junction\nFayton, MS 20337', '+1 (352) 573-5452', 'heloise25@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(9, 'Schumm, Skiles and Hessel', 'Exercitationem non fugit quo atque animi voluptate.', 'Airline Operator', 'Port Salmaberg', '1792 Paige Meadow Suite 660\nSarahbury, GA 83263-4383', '972-443-2245', 'favian71@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(10, 'Brekke, Quitzon and Mayert', 'Sunt dolorum illum quia dignissimos ex.', 'Fuel Supplier', 'Maynardfurt', '122 Darrick Forks Apt. 128\nEast Nicklausstad, PA 24837-7548', '479.450.1427', 'zackary44@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(11, 'Crist, Abshire and Predovic', 'Debitis quia molestiae sed dolores neque cum enim id.', 'Training Organization', 'Lednerstad', '3630 Adela Common Suite 078\nWest Esperanzaview, WA 62355', '207-291-3754', 'jkohler@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(12, 'Abernathy, Friesen and Hermann', 'Autem repudiandae ut occaecati iste cum qui incidunt.', 'Regulated Agent', 'Jonesport', '41802 Welch Well\nZemlakport, WY 95907', '520-414-0464', 'kraig78@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(13, 'Christiansen-Durgan', 'Deleniti blanditiis saepe sint tenetur aut consequatur mollitia aliquam.', 'Air Navigation Service Provider', 'Koelpinview', '107 Isom Springs Suite 701\nNew Loganfort, MS 70267-5256', '+1-551-412-0894', 'waldo.hessel@example.net', NULL, '2025-05-17 13:46:19', '2025-08-05 13:52:04', 3, NULL),
(14, 'Breitenberg PLC', 'Autem amet commodi ducimus enim velit.', 'Regulated Agent', 'West Joanne', '297 Ruben Port Apt. 813\nSouth Raoulhaven, NE 54867', '+16267893642', 'monica21@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(15, 'Littel PLC', 'Et sit rem fugit laboriosam.', 'Catering Agent', 'South Ally', '40516 Dare Turnpike Suite 865\nNorth Elzatown, IL 31599-9818', '1-574-489-0924', 'murphy.wehner@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(16, 'Boyle PLC', 'Necessitatibus ipsa sequi molestias.', 'Airport Operator', 'Port Rebekah', '282 Consuelo Courts\nRobbville, FL 62215-3655', '313-276-1608', 'ulices61@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(17, 'Mohr Inc', 'Beatae aliquid impedit maiores cumque saepe excepturi.', 'Air Navigation Service Provider', 'Estellton', '35637 Rodrigo Lights\nJulianaview, RI 56741', '(820) 919-2422', 'richard.johnston@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(18, 'Reilly, Kunde and Rempel', 'Sit quidem repellat et quia.', 'Fuel Supplier', 'New Lamar', '8462 Willie Crossing\nNorth Caroline, WI 04743-1892', '575.947.2530', 'ecummerata@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(19, 'Homenick-Towne', 'Eum architecto molestias distinctio aut.', 'Outsourced Security Service Provider', 'Melvinatown', '42261 Rosenbaum Route\nOthomouth, ME 76010-2325', '+18287967760', 'akeem.little@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(20, 'Schultz, Paucek and Altenwerth', 'Incidunt voluptatum voluptatibus laboriosam consequatur cum suscipit.', 'Training Organization', 'East Cierraport', '726 Gislason Well\nNorth Viola, LA 95601-8723', '+1-707-479-8000', 'ebba52@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(21, 'Hodkiewicz-Mosciski', 'Deleniti qui omnis officia quidem quibusdam molestiae voluptate.', 'Ground Handling Agent', 'Eviehaven', '719 Mina Loop\nLake Everettport, CA 15354-4540', '516-701-2317', 'cary.streich@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(22, 'Toy, Mann and Koch', 'Nemo in aut itaque voluptatem sit rerum.', 'Airport Operator', 'Port Tobin', '2548 Duane Canyon\nSouth Bonniechester, CO 35620', '+1-202-304-3489', 'rohan.fatima@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(23, 'Abbott-Mayer', 'Consequuntur laudantium reprehenderit dolor omnis eos tenetur possimus.', 'Airline Operator', 'East Zettachester', '788 Thompson Stream Apt. 797\nLake Carlo, WI 03684', '804-364-2446', 'qcremin@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(24, 'Erdman, Grimes and Stehr', 'Quia repellendus perferendis non et.', 'Outsourced Security Service Provider', 'Melodyberg', '934 O\'Conner Walks Suite 510\nKundeburgh, IA 71090', '+1-708-941-2227', 'deven69@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(25, 'Hauck, Morissette and Bradtke', 'Quod eum eos ut tempore ipsum sequi quaerat aliquam.', 'Catering Agent', 'Alexyschester', '5735 Schaden Mills Suite 966\nSouth Lourdes, CA 43420-9771', '+1 (646) 497-5988', 'wilderman.elmer@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(26, 'Davis, Gislason and Emmerich', 'Qui voluptatem explicabo magnam voluptatem perspiciatis.', 'Fuel Supplier', 'West Theresa', '36793 Hamill Branch\nEast Blancaport, NH 68231', '+1.540.834.3135', 'hmosciski@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(27, 'O\'Conner Group', 'Dolor dolor voluptatem ratione.', 'Regulated Agent', 'Lake Stanley', '86083 Beulah Park\nPort Furman, WV 11220', '806-748-8495', 'jamar.hand@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(28, 'Hahn-Brekke', 'Commodi neque consequatur dolores illo dolor.', 'Air Navigation Service Provider', 'Lake Toby', '1732 Hilma Summit\nAntonettaview, TN 52948', '(380) 907-8666', 'kmckenzie@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(29, 'Breitenberg-Hickle', 'Ut accusamus expedita distinctio et.', 'Training Organization', 'East Carsonside', '15945 Keven Inlet\nNorth Ellaberg, VA 16370-5041', '754.842.3466', 'violette.roberts@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(30, 'Volkman, Keeling and Durgan', 'Quasi est reprehenderit laboriosam.', 'Airline Operator', 'East Davionchester', '537 Albin Freeway Apt. 685\nWest Gayle, AL 33063', '607-596-9884', 'parker.kameron@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(31, 'Blanda Group', 'Voluptas reiciendis dignissimos repudiandae numquam repudiandae id.', 'Catering Agent', 'New Nicholemouth', '480 Fahey Cliffs Suite 311\nEast Josephshire, DE 18311-5559', '+1-617-341-9233', 'uparisian@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(32, 'Greenfelder-Funk', 'Recusandae et tenetur rem sequi.', 'Catering Agent', 'North Jacynthe', '3859 Beer Overpass Apt. 691\nHiltonshire, WI 09130', '1-347-800-4776', 'whessel@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(33, 'Zemlak-Wiegand', 'Aperiam dolorem iure quibusdam omnis.', 'Outsourced Security Service Provider', 'Lake Antonio', '774 Schinner Fort Suite 186\nCandiceborough, MI 81494', '+1-559-982-5900', 'flebsack@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(34, 'Erdman and Sons', 'Atque autem at modi nulla dolorem ut tempora.', 'Catering Agent', 'Port Beatrice', '7219 Annabelle River Suite 005\nSouth Beaufort, IL 54841-8640', '+13519739483', 'okerluke@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(35, 'Weimann and Sons', 'Et dolor animi ipsam tempore enim nihil.', 'Training Organization', 'Port Frederickshire', '247 Crooks Wall\nBrennanmouth, VA 94957-0899', '+1 (314) 338-4750', 'chanel.doyle@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(36, 'Jakubowski, Daniel and Emmerich', 'Ea iste occaecati vel sunt.', 'Ground Handling Agent', 'Powlowskiland', '3773 Nils Shores Apt. 574\nBartellport, CA 62217', '1-734-689-4432', 'cali.metz@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(37, 'Moen, Hickle and Cartwright', 'Sequi quas cum vel.', 'Regulated Agent', 'West Bradleyview', '742 Donnelly Knoll\nSouth Lillian, IN 88173-4071', '+1-509-264-3068', 'hamill.nikko@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(38, 'Kutch LLC', 'Adipisci soluta ut quia vero non.', 'Training Organization', 'Kadenfurt', '70648 Ernest Mountains Apt. 461\nHesterview, NM 12354', '+1.563.323.2622', 'tyler.hartmann@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(39, 'McDermott, Lemke and Weissnat', 'Ut autem quae ut et.', 'Regulated Agent', 'Schmittmouth', '46700 Silas Lakes\nWest Suzannemouth, NY 92010-6402', '940-763-4026', 'madie.cruickshank@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(40, 'Keeling and Sons', 'Laboriosam inventore facere culpa iusto.', 'Air Navigation Service Provider', 'Port Arloberg', '86496 Lesch Plaza\nNorth Jordi, PA 83737', '+1.240.400.6876', 'mrosenbaum@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(41, 'Mayert, Pfeffer and Lynch', 'Quo cupiditate iusto velit et dolores.', 'Ground Handling Agent', 'Murphyhaven', '6973 Trever Port\nMuellerchester, ID 80366', '(951) 212-5672', 'lynch.rosetta@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(42, 'Oberbrunner, Jacobson and Flatley', 'Ut nesciunt vel earum qui voluptatem earum est.', 'Airport Operator', 'O\'Reillyhaven', '5522 Max Walk Suite 921\nWest Deborah, IA 05476-8228', '+1.234.410.5317', 'whermann@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(43, 'Nolan, Zulauf and Stanton', 'Distinctio sed adipisci suscipit in.', 'Air Navigation Service Provider', 'Jazlynland', '6818 Antoinette Estates Suite 984\nEddiemouth, PA 47613-9126', '+19738280526', 'letitia46@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(44, 'Borer, Koss and Bashirian', 'Ex et velit autem corrupti voluptas voluptatem.', 'Regulated Agent', 'New Garret', '677 Beatty Valley Apt. 703\nSouth Michaleside, HI 11318', '(539) 660-8724', 'bernier.gerry@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(45, 'Abbott, Morar and Emmerich', 'Adipisci consequatur vero officiis qui magni amet aut.', 'Catering Agent', 'VonRuedenburgh', '67084 Rahul Manor Suite 410\nAbigayleburgh, MN 86863', '1-212-210-4471', 'oswaldo.gottlieb@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(46, 'Kunde, Fritsch and Johnson', 'Quo sunt laudantium rem cum consectetur qui.', 'Training Organization', 'Kennyburgh', '9462 Telly Rue\nLake Imelda, ME 74806-2890', '1-936-850-1114', 'torphy.isabell@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(47, 'Kerluke-Smitham', 'Architecto commodi ab dolor deleniti ipsum rerum.', 'Airline Operator', 'Port Jerroldberg', '907 Darrin Valleys Suite 525\nSarahside, VT 65715', '+1-831-433-8406', 'bwhite@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(48, 'Bosco-Blanda', 'Qui dolorum numquam occaecati aut vel sed.', 'Training Organization', 'Eloiseburgh', '71629 Armstrong Avenue\nBrentside, TX 06920', '440.303.1688', 'haylee.mcdermott@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(49, 'Purdy, Kemmer and King', 'Excepturi non non voluptatem iste nulla.', 'Catering Agent', 'New Unamouth', '4034 Wintheiser Green\nLednertown, IL 43054', '443.855.3306', 'mcglynn.kevon@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(50, 'Champlin, Ferry and Lowe', 'Facilis illum porro itaque amet quaerat cum vero voluptas.', 'Fuel Supplier', 'East Magnoliaside', '6701 Pollich Centers\nStehrchester, NC 18745', '(479) 633-5810', 'acronin@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(51, 'O\'Keefe, Schneider and Donnelly', 'Qui aspernatur et autem ratione provident.', 'Air Navigation Service Provider', 'Lindgrenmouth', '3447 Torey Park\nWest Tavares, MN 97034-1404', '+16294237083', 'reginald.hane@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(52, 'Leffler-Braun', 'Eveniet quibusdam corrupti voluptatem commodi.', 'Training Organization', 'West Eldredbury', '150 Hahn Light\nLake Shakira, NJ 61587-1824', '1-813-378-7342', 'shanahan.clementine@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(53, 'Quigley, Rowe and Howell', 'Ut et qui et tenetur possimus voluptas.', 'Fuel Supplier', 'Erdmanland', '12350 Stamm Rue Suite 744\nLake Hector, IA 67468', '(248) 353-0606', 'ohara.bennett@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(54, 'Hintz, Schowalter and Yost', 'Magni iure quidem culpa accusantium cum non officia.', 'Air Navigation Service Provider', 'Meredithfort', '2168 Kozey Mews Apt. 569\nStiedemannhaven, NE 30345-6377', '1-609-624-3638', 'donnelly.penelope@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(55, 'Berge and Sons', 'Maiores voluptatem laborum aut aperiam.', 'Airport Operator', 'Klockoshire', '656 Denesik Glen\nMacfurt, MS 63864-7401', '831.364.0271', 'zita11@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(56, 'Connelly, Hirthe and Carroll', 'Dolore omnis quia maiores ea quos ipsa.', 'Outsourced Security Service Provider', 'New Kory', '40884 Amir Junction\nPurdybury, MI 43873-9197', '(858) 935-1644', 'ncremin@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(57, 'Stoltenberg PLC', 'Atque nulla pariatur occaecati dolores animi non.', 'Airport Operator', 'Devonteland', '938 Keeley Lane\nNikolaustown, AZ 54541-0316', '480-264-1569', 'okeefe.green@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(58, 'Prohaska LLC', 'Et omnis eius vel sunt dolores dolore placeat.', 'Training Organization', 'Lake Melisaport', '5114 Rath Passage\nNew Kevinland, NM 01928-7817', '1-737-442-1130', 'fkerluke@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(59, 'Pagac LLC', 'Dolorum non facilis autem asperiores quia sit nulla.', 'Outsourced Security Service Provider', 'Emmetthaven', '5986 Cummerata Mall Suite 900\nNyachester, MA 10294', '+13179391418', 'schroeder.clare@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(60, 'Douglas LLC', 'Ratione incidunt facere distinctio similique.', 'Training Organization', 'Gerlachport', '9844 Regan Loop Apt. 311\nNorth Manuel, NY 17136', '+1.831.389.3278', 'dagmar72@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(61, 'Paucek, Walker and Abbott', 'Consequatur aut et maiores nostrum corrupti.', 'Training Organization', 'East Sheila', '277 White Gardens\nSouth Audreannefurt, CO 04072', '(731) 527-6819', 'dstiedemann@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(62, 'Koelpin-Howell', 'Ut et autem quia sit dicta ea.', 'Fuel Supplier', 'Hesselton', '412 Swaniawski Ways Apt. 484\nWinnifredport, MA 19480-4103', '(916) 241-4718', 'witting.frieda@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(63, 'Moore Group', 'Ea earum est ullam modi voluptatem ducimus quos.', 'Fuel Supplier', 'West Joelport', '3830 Krystal Views Suite 988\nPhilipside, MN 82511-9953', '1-440-468-3362', 'esteban18@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(64, 'Bradtke LLC', 'Esse placeat ex ut consequatur perspiciatis corporis non.', 'Air Navigation Service Provider', 'South Lea', '498 Lydia Manors\nNew Amie, NH 62564-0699', '(972) 752-2851', 'nayeli42@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(65, 'Hansen-Quigley', 'Et distinctio quis dolorem quia optio voluptatum.', 'Airline Operator', 'Jadefort', '680 Owen Union Apt. 808\nSouth Chasityside, WA 89450', '+1-206-951-0441', 'turner.maxie@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(66, 'Klocko-Crist', 'Cumque nam deserunt dolor laboriosam.', 'Training Organization', 'Osinskiberg', '5373 Franecki Forges\nNorth Genesis, ME 77537', '470.898.4049', 'america67@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(67, 'Schiller Group', 'Illum fuga provident qui fugiat rem similique quia.', 'Catering Agent', 'East Amanda', '28952 Lorine Gardens\nEast Warrenmouth, NV 90173', '+1.878.256.0157', 'eduardo60@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(68, 'Haley-Koss', 'Blanditiis nemo error soluta et.', 'Fuel Supplier', 'Estellside', '25711 Narciso Glens Apt. 036\nKrisburgh, NM 33285', '959-704-5225', 'tbartoletti@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(69, 'Hane-Turcotte', 'Voluptatem pariatur distinctio possimus excepturi qui.', 'Fuel Supplier', 'Wolfberg', '73825 Ophelia Avenue Suite 408\nGeorgianaville, OR 52231', '+1-707-235-4510', 'otha68@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(70, 'Daugherty-Wilderman', 'Quisquam velit exercitationem sed quisquam.', 'Air Navigation Service Provider', 'Stiedemannville', '784 Paul Corner\nNorth Orlo, MO 24045', '+1-229-891-7099', 'gfahey@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(71, 'Reichert-Zulauf', 'Et provident repellat illum odio.', 'Outsourced Security Service Provider', 'North Caterinastad', '4259 Karina Point\nNew Eve, MS 34967-6056', '1-314-917-8164', 'terrence.kunde@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(72, 'O\'Kon LLC', 'Itaque quia esse eius repellat cumque.', 'Regulated Agent', 'Parisianton', '5316 Haley Ferry\nWest Danielle, RI 17426', '+1-678-221-1602', 'shemar78@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(73, 'Mitchell and Sons', 'Nihil dolorum debitis doloremque consectetur sit aliquid.', 'Training Organization', 'Reynoldsburgh', '78483 Wiza Run\nFaymouth, ND 92035', '(802) 345-0126', 'conn.reinhold@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(74, 'Hamill LLC', 'Amet commodi veniam harum itaque aut.', 'Outsourced Security Service Provider', 'East Quincy', '1260 Daniel Inlet Suite 700\nJohnpaulville, UT 89858-7768', '716.476.9105', 'dfarrell@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(75, 'Langosh LLC', 'Corrupti repellendus occaecati nisi.', 'Training Organization', 'Kaiatown', '970 Francesco Summit\nWest Natasha, MA 15351', '+1-727-381-8230', 'aurelio.schroeder@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(76, 'Kerluke, Douglas and Bauch', 'Accusantium reiciendis harum totam.', 'Regulated Agent', 'West Isidroburgh', '182 Kaylee Views Suite 245\nEast Lawson, AR 28634', '(586) 630-0781', 'elisa54@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(77, 'Gusikowski Group', 'Perferendis maiores cum tempora modi.', 'Outsourced Security Service Provider', 'Bernierbury', '62498 Wuckert Ports Apt. 978\nEast Chaunceybury, VA 21275', '626-897-7739', 'jaylin27@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(78, 'Ward, Ebert and Reinger', 'Qui numquam aut est quo rerum quidem eos.', 'Airline Operator', 'Tillmanton', '2568 Mackenzie Curve Apt. 777\nPort Susannaton, AL 27573-9355', '1-561-970-5950', 'keeley98@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(79, 'Tremblay-Schneider', 'Consequatur ut sint voluptas at.', 'Airport Operator', 'Juwanchester', '872 Effertz Mount\nSouth Genevieve, WA 02315-1006', '432.361.3185', 'dwintheiser@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(80, 'Rutherford and Sons', 'Aspernatur totam odit et iusto et.', 'Catering Agent', 'Clemmieview', '4435 Jefferey Ranch\nDarronport, AL 88558-6228', '+1.856.874.5832', 'lkerluke@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(81, 'O\'Connell-Bernhard', 'Architecto consequatur accusamus quis deserunt consequatur et accusantium pariatur.', 'Fuel Supplier', 'Nolantown', '74157 Mann Rapid Suite 551\nLake Lexie, IL 62824-2591', '283.501.5017', 'osinski.liliana@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(82, 'O\'Hara, Durgan and Gusikowski', 'Quasi debitis laborum atque quod.', 'Ground Handling Agent', 'South Flossieside', '509 Boehm Squares Suite 702\nLake Duncan, VA 68945', '530.876.4138', 'lkohler@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(83, 'Glover-Collins', 'Repellendus ea dolor est rerum.', 'Fuel Supplier', 'Pollichbury', '2630 Johns Landing Apt. 463\nPort Coyview, OH 62183', '678.456.9545', 'emilio96@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(84, 'Osinski-Ziemann', 'Et voluptates quo voluptatem unde sed.', 'Catering Agent', 'South Tristonchester', '9990 Karolann Locks Suite 350\nNorth Kristinfurt, MA 72634', '760-805-7369', 'reginald16@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(85, 'Connelly-Bruen', 'Pariatur sapiente aperiam veniam autem alias explicabo possimus corrupti.', 'Airline Operator', 'Marksfort', '985 Jean Points Suite 012\nLake Bettyview, SD 59933-4590', '(682) 826-2979', 'francisca.hauck@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(86, 'Streich-O\'Hara', 'Aut dolores magni eum saepe alias.', 'Ground Handling Agent', 'Port Ruthie', '10367 Stokes Station Apt. 052\nNorth Dorothy, IA 00528', '216.599.9300', 'sauer.destinee@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(87, 'Raynor-O\'Reilly', 'Ut sunt optio sint nisi qui sit perspiciatis.', 'Outsourced Security Service Provider', 'Cartwrightchester', '371 Moises Highway\nNew Morganville, MS 02681', '239.609.3169', 'electa25@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(88, 'Gibson-Kihn', 'Veniam consequatur blanditiis impedit sequi.', 'Outsourced Security Service Provider', 'Alisamouth', '243 Carley Mission Suite 318\nMitchellside, MS 68551', '(305) 422-6530', 'patsy.west@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(89, 'Herman, Gislason and Gerhold', 'Excepturi numquam ut quidem ut vero.', 'Catering Agent', 'North Violet', '3659 Ledner Curve Apt. 599\nKerlukestad, WA 90353-4096', '586-562-3905', 'kraig.dubuque@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(90, 'Murphy, Gislason and Tremblay', 'Qui libero ullam optio ex.', 'Training Organization', 'Erdmanville', '709 Twila Glens Suite 672\nPort Saraishire, WV 03685', '878-717-2050', 'blick.gene@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(91, 'Schoen, Schinner and McGlynn', 'Pariatur molestiae magnam deleniti libero ea hic aperiam.', 'Air Navigation Service Provider', 'East Kathrynville', '835 Clotilde Mountains\nPort Wilfredo, NH 81415-8772', '+1.484.200.7523', 'lou.schroeder@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(92, 'Blick-Herman', 'Earum recusandae sint et tempore delectus occaecati at eos.', 'Outsourced Security Service Provider', 'Bogisichbury', '696 Rolfson Falls Apt. 654\nKeshawnville, GA 21900', '260-849-0004', 'qschneider@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(93, 'Boehm-Lakin', 'Enim maiores numquam expedita nihil.', 'Airline Operator', 'Jessyport', '149 Haley Passage\nLake Wymanhaven, AR 47465-7663', '(607) 767-7599', 'lebsack.beth@example.net', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(94, 'Hills-Barton', 'Qui itaque et tempora atque repellendus quasi.', 'Airport Operator', 'Braunmouth', '72811 Murray Spur Suite 989\nMargretborough, IA 41456', '+1-680-687-0570', 'kaya.ondricka@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(95, 'Becker PLC', 'Voluptatibus placeat labore veritatis recusandae cum.', 'Airline Operator', 'O\'Reillyton', '7853 Zulauf Lakes\nPort Franciscafurt, UT 21033-4520', '+1 (814) 525-3908', 'hermiston.jaquan@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(96, 'Homenick-Tromp', 'Adipisci consectetur praesentium fugit.', 'Ground Handling Agent', 'Port Emmanuellemouth', '2537 Kuhlman Shoals Suite 601\nDaveberg, MN 65809-9200', '(845) 447-7691', 'aliza30@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(97, 'Bahringer-Farrell', 'Officia quaerat perspiciatis dolores beatae.', 'Regulated Agent', 'West Bruce', '64058 Maxie Harbors\nWehnerland, NV 88697', '(434) 945-1134', 'ubartell@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(98, 'Barrows Group', 'Magnam similique fuga dolore cum quo sunt voluptates.', 'Airline Operator', 'Kovacekfurt', '5414 Jillian Light Apt. 908\nAdamschester, SC 50245-9322', '+1.281.740.4364', 'michaela.beer@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(99, 'Runolfsdottir-Frami', 'Laudantium veniam accusantium doloribus perspiciatis nam adipisci.', 'Airline Operator', 'Port Tony', '12372 Cassin Valley Apt. 028\nRiverview, OH 05274-2339', '+1.954.532.1411', 'camden41@example.org', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(100, 'Feil Ltd', 'Non non a consequatur libero ratione voluptatibus.', 'Airline Operator', 'East Flavie', '334 Mellie Well\nHagenestown, OK 43256-4965', '(646) 224-8280', 'zbauch@example.com', NULL, '2025-05-17 13:46:19', '2025-05-17 13:46:19', NULL, NULL),
(101, 'KKIA', 'This is in Lusaka', 'Airport Operator', 'Lusaka', 'Lusaka', '097655433', 'info@kkia.co.zm', NULL, '2025-05-17 15:30:25', '2025-08-05 13:47:58', 3, 'AVESC'),
(102, 'Zambia Civil Aviation Authority', 'This is an aviation  regulatory Institution', 'Regulatory Authority', 'Lusaka', 'Lusaka Garden City', '09862727362', 'civil.aviation@caa.co.zm', NULL, '2025-07-21 07:37:42', '2025-07-21 07:37:42', NULL, NULL),
(103, 'TEST AIRLINE', 'cdsafdfdsafdsa', 'Airline Operator', 'Lusaka', 'Lusaka', '097535636', 'test@airline.com', NULL, '2025-07-25 08:03:26', '2025-07-25 08:03:26', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `follow_ups`
--

CREATE TABLE `follow_ups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `selected_checklist_question_id` bigint(20) UNSIGNED NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `followup_comments` text NOT NULL,
  `followup_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `follow_ups`
--

INSERT INTO `follow_ups` (`id`, `title`, `user_id`, `selected_checklist_question_id`, `user_name`, `followup_comments`, `followup_date`, `created_at`, `updated_at`) VALUES
(4, 'First Follwup', 1, 87, 'Felix Mantini', 'This is a first followup on this quality control matter', '2025-08-05', '2025-08-04 05:15:45', '2025-08-04 05:15:45'),
(5, 'Second Followup', 1, 87, 'Felix Mantini', 'This is a second followup', '2025-08-05', '2025-08-04 05:17:56', '2025-08-04 05:17:56'),
(6, 'bvdsbvcbvsbvdsbvdsbvcvcxbvbv', 1, 87, 'Felix Mantini', ',m ,mx.,xnlmbvddl,msl,fdnmbl,n.,s vd., .,df', '2025-08-22', '2025-08-22 12:07:25', '2025-08-22 12:07:25');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_schedules`
--

CREATE TABLE `maintenance_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `security_equipment_id` bigint(20) UNSIGNED NOT NULL,
  `last_performed_date` date DEFAULT NULL,
  `next_due_date` date NOT NULL,
  `maintenance_type` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `assigned_to` varchar(255) DEFAULT NULL,
  `frequency` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `maintenance_schedules`
--

INSERT INTO `maintenance_schedules` (`id`, `security_equipment_id`, `last_performed_date`, `next_due_date`, `maintenance_type`, `status`, `assigned_to`, `frequency`, `description`, `created_at`, `updated_at`) VALUES
(5, 287, '2025-06-13', '2025-06-20', 'repair', 'cancelled', 'NEON TECHNOLOGY', 'monthly', 'This was done, Successfully', '2025-06-06 12:35:24', '2025-06-06 12:35:24'),
(6, 287, '2025-06-12', '2025-06-12', 'replacement', 'completed', 'Yanni Technologies', 'yearly', 'The maintenance was successful.', '2025-06-11 04:26:59', '2025-06-11 04:26:59'),
(7, 287, '2025-06-12', '2025-06-20', 'replacement', 'completed', 'Felix', 'yearly', 'The was successful', '2025-06-11 07:36:02', '2025-06-11 07:36:02'),
(8, 356, '2025-06-12', '2025-06-28', 'replacement', 'completed', 'A&G Engineering', 'monthly', 'Successful', '2025-06-11 10:01:24', '2025-06-11 10:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_05_08_132847_create_permission_tables', 2),
(9, '2025_05_14_141417_create_facilities_table', 3),
(10, '2025_05_16_072117_create_quality_controls_table', 3),
(11, '2025_05_17_155458_create_audit_area_categories_table', 4),
(12, '2025_05_17_160005_create_audit_questions_table', 5),
(13, '2025_05_19_122915_create_selected_checklist_questions_table', 6),
(14, '2025_05_20_092808_add_audit_area_name_to_audit_questions_table', 7),
(15, '2025_05_20_120051_add_category_name_to_audit_area_categories_table', 8),
(16, '2025_05_21_104527_add_audit_area_name_to_selected_checklist_questions_table', 9),
(17, '2025_05_21_120137_add_audit_question_id_to_selected_checklist_questions_table', 10),
(18, '2025_05_21_144536_add_questions_response_to_selected_checklist_questions_table', 11),
(20, '2025_05_22_082322_add_date_quality_control_to_selected_checklist_questions_table', 12),
(30, '2025_05_28_102741_create_security_equipment_table', 13),
(31, '2025_06_05_133919_create_maintenance_schedules_table', 14),
(32, '2025_06_11_105930_add_nrc_to_users_table', 15),
(33, '2025_06_11_130427_create_trainings_table', 16),
(34, '2025_06_11_131930_create_training_user_table', 16),
(35, '2025_06_11_134230_add_phone_to_users_table', 17),
(38, '2025_06_13_083822_add_facility_name_to_users_table', 18),
(39, '2025_06_14_105724_create_qualifications_table', 19),
(42, '2025_06_14_105746_create_certifications_table', 20),
(43, '2025_06_23_145940_add_qualification_file_to_qualifications_table', 21),
(44, '2025_07_02_141615_create_quality_control_alerts_table', 22),
(45, '2025_07_10_134920_add_evidence_file_to_selected_checklist_questions', 23),
(46, '2025_07_12_145258_add_modified_at_to_selected_checklist_questions', 24),
(47, '2025_07_14_105424_add_end_date_to_quality_controls', 25),
(48, '2025_07_21_103145_create_quality_control_user_table', 26),
(49, '2025_07_25_184020_remove_unique_from_name_in_audit_area_categories_table', 27),
(50, '2025_07_27_190146_add_immediate_corrective_action_to_selected_checklist_questions', 28),
(53, '2025_07_27_190951_create_follow_ups_table', 29),
(54, '2025_08_05_103320_create_departments_table', 30),
(55, '2025_08_05_103652_add_department_id_to_users', 30),
(56, '2025_08_05_112143_add_department_id_to_quality_controls', 30),
(58, '2025_08_05_152158_add_department_id_to_facilities', 31),
(59, '2025_08_08_110323_add_two_factor_columns_to_users_table', 32),
(60, '2025_08_25_135236_add_designation_to_users', 33),
(62, '2025_08_28_101447_add_cap_file_to_selected_checklist_questions', 34);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(4, 'App\\Models\\User', 1),
(4, 'App\\Models\\User', 3),
(4, 'App\\Models\\User', 4),
(4, 'App\\Models\\User', 22),
(4, 'App\\Models\\User', 23),
(5, 'App\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'view permissions', 'web', '2025-05-09 19:55:04', '2025-05-12 08:46:50'),
(5, 'create permissions', 'web', '2025-05-09 19:56:41', '2025-05-09 19:56:41'),
(6, 'delete permissions', 'web', '2025-05-11 03:37:24', '2025-05-11 03:37:24'),
(7, 'edit permissions', 'web', '2025-05-11 03:39:57', '2025-05-11 03:39:57'),
(16, 'view roles', 'web', '2025-05-13 08:08:50', '2025-05-13 08:08:50'),
(17, 'create roles', 'web', '2025-05-13 08:09:01', '2025-05-13 08:09:01'),
(18, 'edit roles', 'web', '2025-05-13 08:09:13', '2025-05-13 08:09:13'),
(19, 'delete roles', 'web', '2025-05-13 08:09:26', '2025-05-13 08:09:26');

-- --------------------------------------------------------

--
-- Table structure for table `qualifications`
--

CREATE TABLE `qualifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `qualification_type` varchar(255) NOT NULL,
  `qualification_name` varchar(255) NOT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `date_obtained` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `qualification_file` varchar(255) DEFAULT NULL,
  `qualification_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `qualifications`
--

INSERT INTO `qualifications` (`id`, `user_id`, `qualification_type`, `qualification_name`, `institution`, `date_obtained`, `created_at`, `updated_at`, `qualification_file`, `qualification_number`) VALUES
(3, 13, 'Certificate', 'Computer Systems EngineeringX', 'NORTEC', '2025-06-24', '2025-06-23 14:33:56', '2025-07-25 08:16:05', 'qualifications/3e9DidMxMD2zKY6ldRSgTUedo2YWJdamBN5NLSNO.pdf', 'NORTEC/2005/12');

-- --------------------------------------------------------

--
-- Table structure for table `quality_controls`
--

CREATE TABLE `quality_controls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `facility_id` bigint(20) UNSIGNED NOT NULL,
  `control_type` varchar(60) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `scheduled_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(60) NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `department_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quality_controls`
--

INSERT INTO `quality_controls` (`id`, `facility_id`, `control_type`, `title`, `description`, `scheduled_date`, `end_date`, `status`, `created_at`, `updated_at`, `department_id`, `department_name`) VALUES
(1, 31, 'Inspection', 'Minus Perferendis Odio Voluptatem Vel', 'Id eaque nemo possimus repellendus est qui. Officiis quis et asperiores esse. Reprehenderit dicta soluta dolorum sunt voluptate quae ut.', '2025-05-17', '2025-07-18', 'In Progress', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(2, 79, 'Security Test', 'Iure Maiores Quaerat Quasi', 'Eius enim praesentium nihil voluptatum ut in reiciendis. Iure quia quia alias eligendi porro. Voluptas perspiciatis dolor suscipit incidunt velit voluptate. Est quibusdam nulla assumenda reiciendis quia.', '2025-05-13', '2025-07-18', 'In Progress', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(3, 43, 'Inspection', 'Ut Cupiditate Ducimus Natus', 'Quisquam optio quos est. Repellat deserunt voluptatem sapiente deserunt esse iure dolore ut. Ducimus et minima qui voluptatibus omnis consequuntur a dolorum. Non non velit consequatur mollitia ratione.', '2025-05-20', '2025-07-18', 'Pending', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(4, 76, 'Inspection', 'Eum Debitis Et', 'Inventore est at et. Architecto maxime consequatur molestiae fugiat et voluptatem. Aut est sit ad iusto aspernatur aspernatur beatae.', '2025-06-07', '2025-07-18', 'Overdue', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(5, 32, 'Security Test', 'Cupiditate Enim Culpa Quia', 'Aut non provident rerum velit. Nobis nesciunt quam qui aut dolor sed provident praesentium. Est impedit maiores vel consequatur repellendus voluptas. Iusto corporis sed amet quia aperiam rerum pariatur.', '2025-05-08', '2025-07-18', 'In Progress', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(6, 32, 'Security Test', 'Recusandae Ea Aut Magnam Nulla', 'Atque suscipit porro aliquam. Eum optio praesentium omnis. Porro aspernatur temporibus harum et doloremque consequatur.', '2025-06-12', '2025-07-18', 'Overdue', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(7, 26, 'Inspection', 'Non Nesciunt Veniam Earum Dolores Molestias', 'Asperiores earum ipsum soluta est. At aut dignissimos nulla aspernatur neque. Debitis ab quisquam est eius commodi debitis est.', '2025-05-13', '2025-07-18', 'In Progress', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(8, 62, 'Inspection', 'Tempore Ipsum Amet', 'Reprehenderit sequi ut odio eos et aut. Veniam soluta error repudiandae qui quis. Nostrum deleniti quos quo voluptatem ut. Molestias et eaque tempora similique error.', '2025-05-24', '2025-07-18', 'Overdue', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(9, 44, 'Inspection', 'Et Ad Et', 'Officia et sed laboriosam saepe porro non omnis. Esse quaerat dolores corporis magnam ut et quo. Et maiores voluptatem minima saepe qui. Sequi accusantium sed voluptatibus blanditiis totam sequi magnam.', '2025-05-30', '2025-07-18', 'In Progress', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(10, 23, 'Security Test', 'Nemo Quaerat Incidunt Esse Repudiandae Non', 'Quia est voluptas ea omnis non ad. Nostrum ratione itaque sunt sit quam non.', '2025-06-15', '2025-07-18', 'In Progress', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(11, 43, 'Inspection', 'Quo Totam Incidunt', 'Maiores voluptatibus nobis accusamus quis. Ut temporibus et et sed cumque repudiandae amet. Culpa ducimus totam aut neque adipisci repellendus qui.', '2025-05-30', '2025-07-18', 'Pending', '2025-05-17 16:48:22', '2025-05-17 16:48:22', NULL, NULL),
(13, 91, 'Audit', 'Iusto Iusto Nemo', 'Dolores aperiam molestiae voluptas aut sequi dolores in. Nostrum velit id excepturi explicabo velit at. Voluptatem laudantium doloremque fugit et non sed nesciunt. Quidem maiores et laudantium ea placeat.', '2025-05-24', '2025-07-18', 'In Progress', '2025-05-17 16:48:44', '2025-05-17 16:48:44', NULL, NULL),
(14, 90, 'Audit', 'Omnis Tempore Corporis Natus', 'Voluptas sunt consequatur magni deserunt doloribus ut quia rerum. Perferendis ducimus illo rem vero. Odio voluptas voluptates consequatur saepe. Similique quam sequi consequatur asperiores accusamus. Amet ipsam unde quas aliquid dolor placeat accusamus.', '2025-06-16', '2025-07-18', 'Overdue', '2025-05-17 16:48:44', '2025-05-17 16:48:44', NULL, NULL),
(15, 5, 'Audit', 'Perspiciatis Commodi Beatae Distinctio Sunt', 'Eaque est dolorem ea neque. Saepe dolorem quis quidem reiciendis tempora saepe dignissimos. Magni natus optio minima dolorum voluptatem.', '2025-05-14', '2025-07-18', 'Pending', '2025-05-17 16:48:44', '2025-05-17 16:48:44', NULL, NULL),
(16, 65, 'Security Test', 'In Rem Aspernatur Reprehenderit Impedit Earum', 'Non officia explicabo magnam vitae iure voluptates. Quae qui neque qui fugiat perspiciatis omnis. Quidem perspiciatis voluptates unde commodi deleniti magni. Libero voluptatum sunt voluptatem molestiae non. Sunt numquam doloremque optio qui.', '2025-05-08', '2025-07-18', 'Completed', '2025-05-17 16:48:44', '2025-05-17 16:48:44', NULL, NULL),
(17, 50, 'Audit', 'Dicta Aliquam Totam Quam Aperiam Aliquid', 'Sed vitae non mollitia sit autem soluta et. Aut nam nihil aut.', '2025-06-05', '2025-07-18', 'Completed', '2025-05-17 16:48:45', '2025-05-17 16:48:45', NULL, NULL),
(20, 59, 'Inspection', 'Et Enim Sit', 'Culpa aut veritatis omnis officia error. Natus delectus rem voluptatem qui quia voluptas. Reiciendis incidunt cumque blanditiis molestiae illum nostrum tenetur aut. Quis minus et beatae in aut dolore quis.', '2025-06-01', '2025-07-18', 'Overdue', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(21, 100, 'Security Test', 'Vel Nesciunt Sit Fugit Consequuntur', 'Architecto nihil beatae aut suscipit. Dolore consequatur quidem ut. Tenetur in quod non quibusdam. Aut quas qui velit inventore alias laboriosam.', '2025-06-10', '2025-07-18', 'Overdue', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(22, 37, 'Audit', 'Animi Reprehenderit Ex Neque', 'Fugiat eos voluptas laboriosam culpa dolore. Nulla facilis recusandae ea ipsa et delectus. Eos placeat quae nihil et veritatis non.', '2025-06-12', '2025-07-07', 'In Progress', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(23, 20, 'Inspection', 'Optio Quas Eos', 'Ab debitis dignissimos autem fugit est. Necessitatibus modi sit est nostrum fugit temporibus. Dolorem eum nemo illum est.', '2025-06-02', '2025-07-18', 'In Progress', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(24, 10, 'Security Test', 'Minus Aut Voluptatem Quis', 'Aperiam sequi illo molestiae non quibusdam et at quisquam. Enim libero ea quia. Consequuntur velit rerum ducimus dicta repellendus qui. Ut ut excepturi aut nisi aut et ratione.', '2025-06-10', '2025-07-18', 'Overdue', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(25, 44, 'Security Test', 'Laborum Ad Enim Perspiciatis', 'Unde rem soluta sunt omnis velit ipsa non. Consequatur sed rerum non facilis asperiores error earum. Neque laborum amet et qui. Unde non voluptatem autem labore ullam.', '2025-05-29', '2025-07-18', 'In Progress', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(26, 24, 'Inspection', 'Sunt Possimus Hic Dignissimos Aliquid Inventore', 'Nam quis dolorum voluptatibus ea. Atque maiores quidem dolorem impedit. Aliquam dolores est consequuntur ratione est. Sit iusto dolorem reiciendis velit dolor et saepe.', '2025-06-08', '2025-07-18', 'Overdue', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(27, 19, 'Security Test', 'Distinctio Optio Qui Error Id Saepe', 'Quam aut explicabo labore aut fugiat. Dolor alias labore laudantium veniam odio distinctio a. Perferendis non molestiae eos quo qui ipsa. Ipsa suscipit ut in accusamus.', '2025-06-09', '2025-07-18', 'Completed', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(28, 52, 'Audit', 'Distinctio Et Iusto Asperiores Doloribus Hic', 'Quaerat ad voluptas quo. Repellendus laborum quisquam omnis adipisci voluptatum sed aut. Nihil ab et modi quis. Maxime repellendus quis qui sequi fuga repudiandae. Pariatur et sed porro.', '2025-05-21', '2025-07-18', 'In Progress', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(29, 86, 'Security Test', 'Debitis Sint Autem', 'Aut omnis voluptates molestiae rerum. Alias animi quis reprehenderit natus sit a. Odit labore dicta optio doloremque. Officiis incidunt facilis ad et perspiciatis.', '2025-05-17', '2025-07-18', 'In Progress', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(30, 18, 'Security Test', 'Nam Autem Minus Ad Dicta', 'Aliquid aliquid in occaecati mollitia eum. Ad inventore ut quibusdam. Et dolorem natus cupiditate ipsum nobis distinctio est.', '2025-06-16', '2025-07-18', 'Pending', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(31, 25, 'Security Test', 'Error Ad Optio Adipisci', 'Deleniti qui reprehenderit impedit a ut qui ea. Culpa ut et recusandae et tenetur. Blanditiis dolorem cupiditate sequi et iusto ea. Sed dolores et facilis ducimus.', '2025-06-03', '2025-07-18', 'Overdue', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(32, 30, 'Inspection', 'Quia Cupiditate In Illo Expedita Ullam', 'Accusamus quasi veritatis deserunt nam quia odit deserunt placeat. Id modi quasi nobis delectus quisquam. Nesciunt doloribus iusto nesciunt tenetur quae.', '2025-06-08', '2025-07-18', 'Completed', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(33, 71, 'Inspection', 'Velit Et Vitae Voluptas Voluptas Qui', 'Dolor quibusdam non vel impedit minima dolor. Aut impedit accusamus neque unde modi ut. Cumque sed ab eos nostrum.', '2025-05-07', '2025-07-18', 'In Progress', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(34, 50, 'Inspection', 'Laboriosam Praesentium Molestiae', 'Quia qui repellat nesciunt et eum quisquam. Commodi vero et culpa cum est. Dolores deserunt at non inventore.', '2025-05-19', '2025-07-18', 'Overdue', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(35, 36, 'Audit', 'In Dignissimos Provident Mollitia Molestiae Excepturi', 'Sit libero eos architecto. Et architecto impedit dolor esse est optio. Hic iste veniam sint aut sunt temporibus repudiandae. Qui tempora consectetur quia sed.', '2025-06-02', '2025-07-18', 'In Progress', '2025-05-17 16:48:49', '2025-05-17 16:48:49', NULL, NULL),
(37, 50, 'Inspection', 'Reiciendis Illo Consequuntur', 'Ullam laboriosam deleniti facere tempora a. Aut perferendis sunt quam voluptatem qui. Est quo laborum autem dicta unde est. Provident itaque eveniet vel distinctio ut.', '2025-05-26', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(38, 71, 'Inspection', 'Velit Id Rerum', 'Rerum praesentium iste autem necessitatibus. Possimus deleniti consequuntur ea et voluptas repudiandae. Et et debitis et velit corporis molestiae blanditiis. Animi adipisci consequuntur omnis ipsam nemo.', '2025-05-10', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(39, 3, 'Inspection', 'Rem Repellendus Alias Ipsam', 'Soluta dolores quo ipsum nihil incidunt eius. Praesentium commodi est voluptate. Ad est eaque est assumenda. Et qui est et tempora in quis.', '2025-05-23', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(40, 9, 'Security Test', 'Saepe Blanditiis Aut Et Inventore Necessitatibus', 'Molestiae fugit est ullam corporis saepe et et. Quisquam ab enim rerum quia vero quia. Cum et odit voluptas atque nobis voluptatem.', '2025-05-14', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(41, 7, 'Inspection', 'Consectetur Consequatur Ipsa Nihil Aperiam', 'Qui velit ipsum asperiores odit doloribus voluptatem. Commodi officiis id explicabo. Quod esse et animi aliquid sit est molestias reprehenderit. Possimus molestiae aut deserunt ea illum est et.', '2025-05-12', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(42, 91, 'Inspection', 'At Natus Dolorem', 'Quasi voluptatibus natus non ducimus vel voluptate quia ex. Atque ea molestiae et ex laudantium molestiae odio. Qui amet sed aliquam et fugiat explicabo consequuntur ducimus. Consectetur qui omnis et mollitia assumenda quis.', '2025-05-20', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(43, 91, 'Security Test', 'Voluptates Facilis Modi', 'Nobis iste autem consequuntur sit reprehenderit tempora. Est rerum aliquid fugit omnis. Nihil non officia eligendi fugiat.', '2025-06-10', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(44, 5, 'Security Test', 'Sit Ipsam Aut', 'Nisi ducimus consequatur dolores excepturi at. Voluptas voluptatum autem dicta facilis ipsa. Quos facere dolor qui recusandae culpa nostrum earum. Atque est voluptas vel.', '2025-06-09', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(45, 30, 'Security Test', 'Quis Totam Consequuntur Rerum Et', 'Illo quae ut nobis placeat sed a sed. Qui facilis reprehenderit illo earum. Non dignissimos nesciunt aut dolor.', '2025-05-09', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(46, 92, 'Audit', 'Facilis Amet Minus Voluptatem', 'Perspiciatis sed aut repudiandae hic. Aut dolore rerum reprehenderit mollitia impedit at. Dolores ipsum ea exercitationem mollitia. Ea et numquam quos rerum dolore placeat officiis eum.', '2025-05-30', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(47, 46, 'Audit', 'Ut Debitis Dolorem Voluptate', 'Ea ipsa ut omnis reprehenderit autem quia. Quia hic quasi qui error id. Modi quo dolores rerum autem corrupti itaque cum.', '2025-05-31', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(48, 30, 'Audit', 'Animi Non Ut Autem', 'Voluptatem amet consequatur quia consequatur minus. Ut illum nulla modi laudantium dolore molestias. Natus dolor et voluptates soluta quibusdam. Qui sapiente ut quis non suscipit sapiente expedita quas.', '2025-06-04', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(49, 1, 'Inspection', 'Exercitationem Doloribus Accusamus Alias', 'Distinctio et magnam velit in sunt. Dolore rerum amet velit sed distinctio assumenda dolores et. Tenetur assumenda iusto ut veniam quis ut laboriosam.', '2025-06-11', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(50, 52, 'Inspection', 'Aut Non Quibusdam Ea Aut', 'Blanditiis odit quidem impedit asperiores omnis explicabo. In impedit quo itaque in fuga dignissimos. Quisquam ducimus numquam voluptatem porro consectetur aut possimus. Qui rerum deserunt aperiam illo nostrum sit.', '2025-06-13', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(51, 71, 'Security Test', 'Et Minima Reiciendis', 'Sit delectus accusantium blanditiis aliquam rerum natus expedita expedita. Delectus provident aliquam expedita aperiam.', '2025-05-23', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(52, 62, 'Audit', 'Qui Debitis Quibusdam', 'Rerum est accusamus aliquid cum. Maiores dignissimos deleniti dolorum commodi dicta rerum sint.', '2025-06-15', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(53, 4, 'Inspection', 'Porro Distinctio Sed', 'Quas iure similique neque laboriosam. Commodi minus dicta rem asperiores vero earum. Ut ut maiores blanditiis.', '2025-06-03', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(54, 89, 'Security Test', 'Laboriosam Et Doloremque', 'Pariatur similique nulla quas. Reiciendis optio et ex eveniet accusantium neque ut. Recusandae eveniet impedit maiores rerum molestias qui. Illo at architecto est quia. Ducimus aut quia ut sunt.', '2025-06-16', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(55, 40, 'Security Test', 'Nam Ea Suscipit Ipsum Enim Eos', 'Voluptate eaque iure soluta dolores eius. Perferendis occaecati ad quae mollitia. Dignissimos sit maxime sint labore ratione facilis. Nesciunt dolores vel non deserunt.', '2025-05-13', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(56, 94, 'Security Test', 'Id Aut Perspiciatis Occaecati', 'Consequatur voluptas et ut nulla magnam in. Enim et facilis omnis.', '2025-05-07', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(57, 12, 'Inspection', 'Quis Debitis Rerum Autem', 'Consequatur debitis dicta voluptas. Ab qui enim aut necessitatibus.', '2025-05-18', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(58, 9, 'Security Test', 'Aut Rerum Ea Minima Adipisci', 'Id est blanditiis tempora. Error enim ab quo non ut. Nam quas ut asperiores sint possimus incidunt quaerat. Ut aliquam nam porro tempora.', '2025-05-20', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(59, 87, 'Audit', 'Cupiditate Rerum Temporibus', 'Maiores fugiat iusto vel dolores pariatur saepe. Non repellat maxime est earum accusamus et corrupti. Ut quia et quis qui beatae recusandae dicta error. Illo sequi quod architecto facilis. In quaerat voluptatem reiciendis sunt aut repudiandae.', '2025-05-20', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(60, 56, 'Security Test', 'Rerum Ea Pariatur Exercitationem Sint', 'Id est aut alias sunt beatae neque. Fuga quis voluptatem consequuntur officia temporibus temporibus. Ut similique et at aspernatur.', '2025-05-16', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(61, 65, 'Audit', 'Mollitia Id Voluptatum Quidem Nisi Quae', 'Id commodi eius molestiae enim consequuntur dolores sunt. Dolorem sed nam non eos aliquid in. Fugit magnam consequatur aperiam labore consectetur et.', '2025-05-23', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(62, 5, 'Inspection', 'Quas Ipsa Et', 'Suscipit voluptatem voluptatem dignissimos reprehenderit ex. Rerum veniam velit expedita cumque aut dolor. Alias non iusto eius qui facilis aut. Est inventore dolor cum saepe.', '2025-05-22', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(63, 44, 'Audit', 'Laudantium Asperiores Ipsa Assumenda Optio Earum', 'Qui quaerat commodi voluptatem deleniti quidem. Optio voluptatem officia recusandae et. Molestiae optio quia illo nihil officiis voluptatem est.', '2025-05-11', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(64, 47, 'Security Test', 'Iste Saepe Sed Hic', 'Voluptate dolores pariatur occaecati voluptatem animi sunt est. Doloremque vel laboriosam et quia nam eum. Tempora aut expedita esse dignissimos ut totam vel. Consequatur dignissimos aut eos quia reprehenderit consequuntur numquam.', '2025-05-15', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(65, 50, 'Security Test', 'Architecto Enim Totam Facere', 'Laboriosam molestiae et tempore officiis. Consequuntur et qui omnis eveniet. Numquam nulla omnis distinctio corporis ratione minima. Alias eligendi ea et quidem.', '2025-06-16', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(66, 72, 'Inspection', 'Officiis Et Itaque', 'Architecto qui facere totam incidunt. Id voluptatem quas facere dolor incidunt. Et voluptate aut rerum dolorem pariatur atque enim.', '2025-06-04', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(67, 2, 'Audit', 'Eius Consequuntur Soluta Optio Unde', 'Doloribus nam laudantium laborum libero expedita. Veniam modi quo repudiandae omnis id. Rerum aut id nulla doloribus. Nihil repudiandae nam ad accusamus quis dicta ut.', '2025-06-04', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(68, 42, 'Inspection', 'Nisi Non Cum Eius Quod Expedita', 'Inventore eaque molestiae nostrum architecto totam sint praesentium. Eveniet et qui maxime officia. Nesciunt nulla quisquam neque veritatis sequi aut.', '2025-05-09', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(69, 38, 'Security Test', 'Culpa Ea Molestiae Molestiae Dignissimos', 'Id voluptas est perferendis tempore. Dolores inventore ex quasi in vero. Fuga eos aut ut et.', '2025-06-01', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(70, 53, 'Security Test', 'Porro Quod Sint', 'Nihil distinctio neque modi ea hic quaerat ipsum non. Asperiores officia vel aut aut voluptas vitae. Inventore perferendis et placeat incidunt facilis sequi. Magnam et aut magnam dolores perferendis ut esse.', '2025-05-22', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(71, 6, 'Inspection', 'Aut Aut Totam Sapiente Illum Voluptas', 'Voluptatibus nostrum officiis amet molestias. Sed ipsum iusto qui. Ad sed autem quia blanditiis consequuntur. Quo ad maiores sint nostrum corporis fugit.', '2025-05-17', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(72, 87, 'Audit', 'Consequatur Quis Rem Vero', 'Aspernatur illum saepe sapiente laudantium laboriosam et nihil. Voluptates ratione repudiandae nemo. Repellendus aspernatur et eveniet ut.', '2025-06-12', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(73, 71, 'Audit', 'Amet Eaque Consequuntur Sed', 'Blanditiis rerum voluptatum et quis repudiandae. Omnis minus ipsa dolorem repellat. Et repellendus molestias unde deleniti quod odit repellat. Ut laudantium recusandae minima aut molestiae.', '2025-05-12', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(74, 28, 'Inspection', 'Maiores Consequatur At', 'Blanditiis omnis illum reprehenderit placeat quae voluptatem et. Ipsum tenetur deserunt velit pariatur. Reiciendis unde illum est et illo. Iusto aut minima sit sit.', '2025-05-26', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(75, 30, 'Inspection', 'Nisi Ut Ad', 'Maxime ratione laboriosam cupiditate voluptate. Suscipit placeat deserunt sapiente ipsa aspernatur. Facere eos dolorem modi eos. Iure officia quia aut inventore voluptatem voluptatum et.', '2025-05-28', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(76, 47, 'Inspection', 'Corrupti Qui Eum Molestias Consequatur Inventore', 'Ipsam perferendis laborum minima qui necessitatibus itaque illo. Ex illum deserunt aut rerum iusto corrupti tempora. Voluptatum veniam sit nam sit.', '2025-05-11', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(77, 100, 'Inspection', 'Qui Quia Eos Et Saepe', 'Dicta autem dolores aliquam et ratione quidem eveniet ut. Sapiente autem dolorem saepe itaque quisquam rerum beatae natus. Libero molestias facilis unde delectus. Laboriosam unde omnis omnis molestias libero voluptas quis.', '2025-05-28', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(78, 87, 'Audit', 'Maiores Unde Quia Deleniti', 'Eum aut sit reiciendis voluptas culpa aliquam blanditiis. Omnis soluta reiciendis fugiat dignissimos.', '2025-05-10', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(79, 81, 'Audit', 'Amet Laboriosam Odit Qui Labore Ut', 'Voluptate est aut necessitatibus dolore. Est quam assumenda a molestias. Laudantium ut quia eaque vel.', '2025-05-31', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(80, 69, 'Security Test', 'Quia Numquam Perferendis Quia', 'Amet veniam et voluptatem velit. Similique qui ut sint ab repudiandae labore. Dolorem corrupti deserunt ut voluptatem nesciunt ut culpa nulla. Dolorem deserunt soluta ipsa et.', '2025-05-21', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(81, 7, 'Audit', 'Nostrum Dolorem Voluptatibus Et Autem', 'Iure provident aut et. Saepe et deserunt cumque et tenetur. Est blanditiis commodi est cumque et possimus officia. Amet nulla deleniti possimus vel ea iure rem tenetur. In nulla quae quia pariatur.', '2025-06-02', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(82, 11, 'Audit', 'Sed Laudantium Magni Perspiciatis Recusandae Fugiat', 'Qui in veniam atque fuga vel tempore. Quo assumenda commodi et dolores iure nulla qui deleniti. Dolorum ducimus autem a possimus voluptatem. Omnis dolores accusantium sed consequuntur.', '2025-06-15', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(83, 32, 'Security Test', 'Quod Molestiae Deserunt Saepe', 'Quas sit quis quia. Aut est maiores et corrupti. Distinctio nisi aut aut. Quo laudantium minus assumenda doloremque eum dolorem suscipit sed.', '2025-05-11', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(84, 26, 'Inspection', 'Quia Autem Animi', 'Voluptate dignissimos facilis placeat esse. Libero qui vitae ut porro. Ut et vel dolores reprehenderit dicta fuga voluptate.', '2025-05-15', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(85, 51, 'Security Test', 'Dignissimos Expedita Quaerat Iusto Aut Eligendi', 'Explicabo corrupti molestiae qui doloribus. Autem aut adipisci sed error. Cumque nostrum inventore repellendus cum.', '2025-05-21', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(86, 74, 'Audit', 'Possimus Est Est Quidem Et Eos', 'In beatae atque aut corrupti minima aliquid corrupti. Aperiam non accusantium quis dolorem veniam. Autem in quidem omnis nostrum voluptatem corrupti et. Quos et tempora est natus est.', '2025-06-10', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(87, 40, 'Audit', 'Iste Vel Id Tempore Eos In', 'Consequatur dolores ipsa ut iste et non. Et rerum enim sit voluptatibus. Provident et aut est enim fugit tempore.', '2025-06-10', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(88, 41, 'Security Test', 'Qui Reprehenderit Quae', 'Facere quo deserunt et consectetur quis fugit pariatur. Dolorem quos distinctio eveniet error optio nihil. Autem voluptas totam cupiditate architecto aut. Dolorem sunt ducimus laudantium.', '2025-06-09', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(89, 64, 'Security Test', 'Quaerat Pariatur Nostrum Voluptatem Amet', 'Explicabo natus voluptas sed consequatur voluptatibus ab. Et asperiores molestias et. Ducimus aspernatur dignissimos ad possimus dolores fuga laboriosam. At rem et sunt ea magni.', '2025-05-11', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(90, 47, 'Inspection', 'Et Possimus Ut', 'Qui est velit vitae veniam nam. Dignissimos quisquam eum est velit ullam reiciendis. Odit eos ratione commodi. Sit aperiam commodi nobis debitis aut quibusdam.', '2025-05-22', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(91, 81, 'Inspection', 'Distinctio Molestiae Molestias Minima', 'Molestias eaque et tenetur saepe sunt repellendus. Veritatis aperiam magnam eius temporibus quo. Modi unde aspernatur ab sed tenetur consequatur et.', '2025-06-08', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(92, 9, 'Audit', 'Qui Voluptatum Dolor Accusantium Consequuntur', 'Quo pariatur aut consequatur consequatur aperiam eius quaerat et. Quia necessitatibus eligendi cumque harum cupiditate reiciendis fugit voluptatum. Rerum in sint sed corporis facilis est reprehenderit. Doloribus et sed veritatis harum. Reprehenderit architecto sit eum illo tempore harum esse ut.', '2025-05-25', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(93, 20, 'Security Test', 'Impedit Qui Possimus', 'Nisi rerum autem in in. Culpa nesciunt qui earum molestiae. Eius ipsam incidunt omnis vero ratione non accusamus facere.', '2025-06-09', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(94, 100, 'Security Test', 'Porro Rerum Culpa Et Error Deserunt', 'In et est et et consequuntur nihil nesciunt quia. Ad voluptatem porro quaerat et expedita ipsam non. Similique ea corporis velit eos.', '2025-05-28', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(95, 37, 'Inspection', 'Eius Aliquid Exercitationem Cupiditate Quibusdam', 'Quo eaque deserunt rem nesciunt. Ut harum adipisci et facere quas aut. Adipisci sed quod voluptatem nobis amet.', '2025-05-26', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(96, 4, 'Audit', 'Quo Deserunt Et Fugiat Consectetur', 'Nisi ut dolor quas quis et tempore. In architecto modi cum cupiditate in accusantium consequuntur. Laborum saepe vel dolorem laboriosam.', '2025-05-15', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(97, 74, 'Audit', 'Sit Sunt Sit', 'Quas alias aut architecto ea rerum beatae rem dicta. Quas et totam voluptatem non dignissimos ipsa quo. Soluta hic quis eligendi et fugit praesentium.', '2025-05-07', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(98, 8, 'Security Test', 'Dolor Et Rerum Et', 'Dolores tenetur ut eveniet consequuntur et. Ducimus autem neque excepturi voluptatibus molestias. Enim tempora iusto voluptatem eius quis sit mollitia quis. Dolorem omnis facilis sint minus ullam error laboriosam. Explicabo qui voluptas et aut.', '2025-06-06', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(99, 73, 'Security Test', 'Assumenda Consequuntur Vero Laudantium Porro', 'Sunt aut earum est veritatis voluptatem temporibus. Labore exercitationem delectus nesciunt est perferendis quasi quam.', '2025-06-03', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(100, 25, 'Security Test', 'Adipisci Ducimus Quis', 'Eum asperiores sequi sed possimus. Est odio minima sit earum et. Reiciendis fuga id voluptatem qui qui placeat assumenda.', '2025-05-14', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(101, 34, 'Security Test', 'Fugit Vitae Temporibus Et Perspiciatis', 'Commodi quibusdam perspiciatis suscipit quo itaque sunt. Eum qui qui aliquam nisi temporibus. Possimus facilis facere dignissimos aperiam. Dolorem nihil soluta dolore doloribus alias suscipit quia illo. Ratione debitis quis inventore dolore quidem quaerat ut pariatur.', '2025-05-14', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(102, 8, 'Audit', 'Molestiae Sed Architecto Modi', 'Ab et voluptas quasi eos. Dolores temporibus nisi est. Voluptatibus rerum vitae sint. Vero sed et sit rem.', '2025-06-05', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(103, 20, 'Audit', 'Et Aut Recusandae', 'Molestiae nisi inventore temporibus modi. Rem sit aspernatur iure. Est repellat sit neque delectus est. Sit possimus corporis nobis nulla ea repellat quis.', '2025-06-04', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(104, 60, 'Audit', 'Exercitationem Vero Voluptatem Corporis Quia Accusamus', 'Blanditiis omnis quaerat deleniti voluptatibus excepturi. Quidem et inventore rerum doloremque aliquam. Neque hic dolorum dolor aut. Facere repellendus tempora est quae.', '2025-05-26', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(105, 51, 'Inspection', 'Iure Odit Dolorem Eos Impedit Provident', 'Sunt similique quis sint consequuntur. Saepe alias autem qui debitis facere sit. Aliquam quo ab fuga inventore ex iusto. Expedita tempore eos aut beatae quod.', '2025-06-02', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(106, 21, 'Inspection', 'Expedita Quasi Placeat Aut Possimus', 'Aliquid quis sit laboriosam corrupti in. Vel vitae debitis voluptatem perferendis. Voluptatum amet quibusdam molestiae consectetur repellat.', '2025-05-19', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(107, 49, 'Security Test', 'Et Cum Fugiat Ducimus', 'Quia maiores nulla non et voluptas maiores aliquid. Eum quo dolor nostrum. Illum ab sit magni ea quidem consequatur accusamus. Ipsum ea quos perspiciatis eum nesciunt doloremque aspernatur.', '2025-05-26', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(108, 5, 'Inspection', 'Sunt Ipsa Consequatur Voluptas Et Fugiat', 'Molestiae vitae eum aut voluptate et. Aperiam id reiciendis quidem beatae ut quas aliquam molestiae. Sunt sint voluptate omnis rem.', '2025-05-10', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(109, 39, 'Security Test', 'Dolor Aut Iure', 'Omnis voluptatibus et inventore maxime voluptatem fugit consequatur perferendis. Illo et distinctio dolores assumenda repellat. Consequatur explicabo nemo excepturi atque.', '2025-06-01', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(110, 43, 'Inspection', 'Adipisci Sint Dignissimos Voluptatem Placeat', 'Tempora corporis rerum aspernatur pariatur. Ex laboriosam voluptatem sed tempora. Eum aliquam voluptatem quo adipisci iure minima. Ut eum qui quia nihil in ullam.', '2025-05-14', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(111, 70, 'Security Test', 'Aut Sed Soluta', 'Velit cumque eos et quia a molestiae. Facilis cumque officia rem nostrum sint. Sapiente perspiciatis sit provident corporis commodi voluptatum. Inventore sed adipisci saepe eius quia qui aspernatur.', '2025-05-24', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(112, 11, 'Audit', 'Explicabo Doloremque Reiciendis Minus Provident', 'Dolorum iusto ut provident ea. Tempore expedita nemo placeat et dignissimos molestiae. Quo vero id consequuntur aliquam suscipit nihil nostrum autem. Debitis cupiditate perferendis quas ut id ut.', '2025-06-14', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(113, 56, 'Security Test', 'Fuga Eos Odio Cumque Et Eaque', 'Quia sequi expedita quia corporis. Eaque molestiae commodi nihil magnam aliquid. Vel voluptate ducimus consequatur molestiae rerum.', '2025-06-15', '2025-07-18', 'In Progress', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(114, 74, 'Inspection', 'Aut Accusamus Eveniet Ratione', 'Molestiae fuga voluptatem quod sunt minus minima aliquam. Saepe velit a exercitationem sit quis. Impedit quo ut sed voluptates. Deleniti corrupti minima tempora saepe nam officiis voluptatem minus.', '2025-05-30', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(115, 19, 'Audit', 'Omnis Nostrum Molestiae Beatae Laudantium Et', 'Numquam libero ut aut quos ipsa. Enim ea quos repellat omnis. Excepturi vero qui dolorem velit eius quae libero libero. Et ad quis dolorum.', '2025-05-31', '2025-07-18', 'Pending', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(116, 44, 'Security Test', 'Hic Est Aut Rerum', 'Laudantium nihil possimus et nihil sed. Repudiandae dolores pariatur aspernatur nemo laborum sit tenetur at. Qui perspiciatis atque repellat inventore saepe. Vel quo quos incidunt autem sunt vel quos.', '2025-06-16', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(117, 72, 'Audit', 'Enim Facere Tenetur Quam Porro', 'Consequuntur dolorem eos in est. Numquam sapiente quidem vero. Impedit repudiandae quis dolores eius.', '2025-05-13', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(118, 80, 'Inspection', 'Ducimus Nihil Consequatur Sit', 'Voluptas beatae quia consequatur laboriosam quo possimus est. Earum quia assumenda adipisci aut ex facilis. Qui sed et fugit autem quae totam quibusdam quaerat. Dolorem aut esse voluptatum hic.', '2025-05-09', '2025-07-18', 'Completed', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(119, 97, 'Inspection', 'Aliquid Ut Quo Quos', 'Voluptate optio non quia esse sequi veritatis dolorum. Ea porro laboriosam quam ex id pariatur excepturi eum. Animi ipsam in eveniet culpa voluptates est rerum. Itaque aut voluptates et provident debitis non sed.', '2025-05-10', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(120, 28, 'Security Test', 'Quod Voluptatibus Vel Error Ab', 'Debitis ut reiciendis aliquam qui. Dolores rem dicta commodi aut. Aperiam aliquam aspernatur explicabo vel praesentium officia voluptates. Sed nisi ea voluptatum accusantium magnam labore et est.', '2025-05-25', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(121, 86, 'Audit', 'Sapiente Illo Sit Dolores Aperiam Qui', 'Perspiciatis aliquam officiis cum qui tempore ad. Commodi corporis enim illo quis. Qui eius nihil quo qui voluptatibus odit pariatur. Quidem sit ut ut odio impedit omnis cumque.', '2025-05-15', '2025-07-18', 'Overdue', '2025-05-17 16:49:05', '2025-05-17 16:49:05', NULL, NULL),
(123, 91, 'Inspection', 'Iusto Ut Qui Tempora Autem Aspernatur', 'Consequatur quod rerum officiis quidem. Aut voluptas qui optio et dolorem aliquid repellat ut. Consequatur rerum cum omnis perferendis. Aut illo est architecto.', '2025-06-01', '2025-07-18', 'Overdue', '2025-05-17 16:49:30', '2025-05-17 16:49:30', NULL, NULL),
(124, 82, 'Inspection', 'Laudantium Assumenda Ipsum Et Nam Harum', 'Cum officiis possimus ipsa qui. Doloribus porro perferendis voluptatum libero a et. Voluptatibus consequatur sequi illo error ratione.', '2025-06-09', '2025-07-18', 'Pending', '2025-05-17 16:49:30', '2025-05-17 16:49:30', NULL, NULL),
(125, 84, 'Security Test', 'Tempore Laborum Doloribus Deleniti Laudantium', 'Quia laboriosam id maiores necessitatibus occaecati iusto placeat. Soluta nostrum dolores facilis aut veniam et.', '2025-06-05', '2025-07-18', 'Completed', '2025-05-17 16:49:30', '2025-05-17 16:49:30', NULL, NULL),
(126, 57, 'Security Test', 'Et Aut Ex Commodi Ea', 'Hic sapiente temporibus quisquam reprehenderit officiis. Sunt fugiat inventore id cupiditate. Expedita quo eum consectetur omnis sed. Ad qui et sit corrupti.', '2025-06-04', '2025-07-18', 'Overdue', '2025-05-17 16:49:30', '2025-05-17 16:49:30', NULL, NULL),
(127, 42, 'Security Test', 'Odit Sit Et Adipisci Asperiores', 'Eligendi et error esse et commodi. Qui et adipisci voluptate rerum repellat.', '2025-06-02', '2025-07-18', 'In Progress', '2025-05-17 16:49:30', '2025-05-17 16:49:30', NULL, NULL),
(129, 60, 'Audit', 'Voluptatibus Illum Quae', 'Et molestiae iste error similique. Qui iusto qui ipsum neque et. Officiis aut vel perspiciatis at maxime magni. Ipsam vel non quod mollitia asperiores quas illo.', '2025-05-27', '2025-07-18', 'Pending', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(130, 77, 'Security Test', 'Quasi Accusamus Et Corporis', 'Sed sed aut id repellat sunt sint. Quia repellendus voluptas pariatur in. Tempora illo molestiae omnis fugit perspiciatis.', '2025-05-19', '2025-07-18', 'Overdue', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(131, 55, 'Security Test', 'Recusandae Nesciunt Non', 'Enim soluta nam voluptatem natus temporibus temporibus doloribus. Impedit commodi qui delectus nobis blanditiis omnis. Fugit accusamus dolor nesciunt error repellat consequatur.', '2025-05-12', '2025-07-18', 'In Progress', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(132, 93, 'Security Test', 'Id Libero Ut Atque Et Voluptates', 'Nemo quasi eum molestias dolores at qui voluptatem. Cupiditate dolor quia explicabo est et enim est. Commodi eos voluptas aspernatur magni ratione.', '2025-05-25', '2025-07-18', 'In Progress', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(133, 42, 'Inspection', 'Nulla Sunt Ut Et Aut', 'Ut nostrum ut eum excepturi ut. Consequatur occaecati alias cupiditate sit. Eaque quos reiciendis ut a error. Voluptatem dicta perspiciatis quia fuga.', '2025-06-11', '2025-07-18', 'In Progress', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(134, 97, 'Security Test', 'Laboriosam Consequatur Aperiam Autem Omnis In', 'Et nihil distinctio ad exercitationem. Ullam vel minima in distinctio et. Aperiam nihil veniam et tempora. Deleniti est sint velit corrupti.', '2025-05-09', '2025-07-18', 'Pending', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(135, 80, 'Inspection', 'Et Eaque Tempore Non Magnam', 'Saepe quidem iste earum debitis voluptatem doloremque. Est nisi sint sint culpa ducimus voluptas saepe. Harum odit deserunt consequuntur quibusdam.', '2025-05-26', '2025-07-18', 'Overdue', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(136, 74, 'Security Test', 'Ut A Facere', 'Nostrum vitae ipsum perspiciatis nisi. Sint rerum assumenda deleniti atque deleniti alias et. Hic quo quo facilis. Porro voluptatum tenetur soluta. Aspernatur eligendi eum necessitatibus placeat voluptatum doloribus eveniet.', '2025-05-11', '2025-07-18', 'Completed', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(137, 78, 'Inspection', 'Amet Expedita Impedit Possimus Sunt Quia', 'Et inventore labore quis. A sunt ab optio. Sequi expedita est velit rerum dolore odio.', '2025-05-19', '2025-07-18', 'Completed', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(138, 10, 'Audit', 'Facere Nihil Sapiente Ab', 'Ex consectetur ut rem dignissimos. Quaerat soluta corrupti accusantium est. Et non at ipsam vitae odit.', '2025-05-30', '2025-07-18', 'In Progress', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(139, 28, 'Inspection', 'Est Quia Est Exercitationem Est Enim', 'Placeat voluptates debitis aut cupiditate totam. Est voluptas ea consectetur neque quas itaque. Amet quo error unde quae. Reiciendis rerum sapiente odit voluptatem optio ea.', '2025-06-14', '2025-07-18', 'In Progress', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(140, 74, 'Security Test', 'Nam Necessitatibus Et Reprehenderit', 'Possimus excepturi dicta cum accusantium reprehenderit. Numquam vero tempora cupiditate autem aperiam quis et.', '2025-06-10', '2025-07-18', 'In Progress', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(141, 26, 'Inspection', 'Necessitatibus Non Aliquid Eius', 'Possimus sed vero blanditiis veritatis fugiat dicta consequatur. Illum laborum quam voluptatem voluptate. Rerum pariatur dolore cum ea corrupti fuga fugit. Ex libero sint nemo quibusdam fugiat.', '2025-05-10', '2025-07-18', 'In Progress', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(142, 40, 'Audit', 'Temporibus Voluptatem Ducimus Inventore', 'Aut aut et corrupti voluptatum distinctio nihil corrupti. Qui ipsam officiis hic qui. Dolore cum quasi velit rerum ab.', '2025-05-14', '2025-07-18', 'Completed', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(143, 45, 'Audit', 'Sint At Labore', 'Praesentium fugit nesciunt dolore. Illum voluptatem et consequatur quisquam quidem. Nostrum ut voluptatem tenetur dolorum deleniti. Et quae cumque sunt reiciendis aut temporibus maxime. Doloribus qui laudantium cum magnam voluptas accusamus omnis.', '2025-05-17', '2025-07-18', 'Completed', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(144, 97, 'Security Test', 'Eum Dolor Perspiciatis Nisi Provident', 'Architecto amet ratione sequi voluptatem id id odio. Qui fugit sed impedit sed doloribus dolore libero est. Tempora voluptatem est adipisci vero ducimus est iure.', '2025-06-08', '2025-07-18', 'Overdue', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(145, 52, 'Inspection', 'Molestiae Autem Necessitatibus Eos', 'Corrupti non adipisci fuga. Impedit mollitia voluptas aut ut odio atque inventore. Tenetur vel quisquam asperiores assumenda.', '2025-05-20', '2025-07-18', 'In Progress', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(146, 94, 'Audit', 'Ut Reiciendis Ut Labore Vero Voluptates', 'Omnis cumque odio labore facere labore esse. Ut voluptas ut perferendis et voluptatem. Non veritatis debitis eligendi enim dolor ut amet. Nobis ab dolore est ut optio ut labore.', '2025-06-06', '2025-07-18', 'Overdue', '2025-05-17 16:49:33', '2025-05-17 16:49:33', NULL, NULL),
(148, 40, 'Audit', 'A Omnis Est Sapiente Facilis Vero', 'Earum qui nobis doloremque facilis. Asperiores amet voluptatem fugit qui ratione quaerat. Voluptas quas commodi dolores iusto natus consequatur. Error est praesentium tempora ipsum perferendis repellendus.', '2025-05-13', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(149, 86, 'Security Test', 'Minima Et Voluptatibus', 'Consequatur laboriosam est omnis natus autem. Velit similique alias reiciendis voluptas quam autem iusto.', '2025-05-07', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(150, 20, 'Security Test', 'Blanditiis Eos Quis', 'Praesentium qui occaecati veniam voluptas iusto voluptatem esse. Eaque tempore quasi cupiditate qui qui consequatur. Officia sapiente voluptatem et et. Quam saepe vel harum rerum et sunt.', '2025-05-14', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(151, 13, 'Security Test', 'Reprehenderit Repellendus Sint Doloremque Accusantium', 'Modi cum rerum molestias rerum. Qui inventore ut dolorum corporis fugit. Repellendus nesciunt voluptatum voluptatem.', '2025-05-12', '2025-07-18', 'Completed', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(152, 83, 'Audit', 'Id Rerum Sit Est Voluptatum', 'Est non esse ab optio vero mollitia. Assumenda accusantium eius quia odit ut non omnis. Quia nemo exercitationem consectetur quam error placeat facilis.', '2025-06-15', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(153, 32, 'Security Test', 'Saepe Enim Possimus Expedita Corrupti', 'Maiores doloribus numquam nesciunt quas. Aperiam quae eveniet eius omnis nostrum enim. Et quae sunt nobis ea magnam aut sint consequatur.', '2025-05-20', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(154, 79, 'Audit', 'Omnis Molestiae Eveniet Reiciendis', 'Consectetur exercitationem voluptatem omnis quod sunt mollitia quas. Possimus praesentium reprehenderit incidunt amet quia. Perspiciatis animi rerum sit et. Numquam aut debitis nesciunt aut commodi rerum.', '2025-05-17', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(155, 85, 'Audit', 'Sunt Ut Molestiae', 'Et eos veritatis excepturi ut. Possimus asperiores minus sint sint dolore id fuga quisquam. Laudantium ducimus minima neque dolore.', '2025-05-08', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(156, 93, 'Audit', 'Voluptate Et Sed Nemo Eum', 'Quidem veniam quidem deserunt dolores. Aut vel sequi sit possimus deleniti dolorum. Ut placeat quia ea molestiae.', '2025-06-16', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(157, 27, 'Inspection', 'Voluptatem Repellendus Doloribus Soluta', 'Qui ratione quis itaque. Ratione qui labore eos et libero nam. Qui minus ipsum fugit velit odit asperiores. Aut hic tempore iste provident molestias sint sed.', '2025-06-09', '2025-07-18', 'Completed', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(158, 31, 'Audit', 'Molestias Et Hic Voluptas', 'Magni officia totam aspernatur in quia non quasi. Porro repellat consequuntur quas et.', '2025-05-21', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(159, 35, 'Security Test', 'Aperiam Vel Repellendus Dolorum Eveniet Dolores', 'Eius cupiditate sit nulla id et ut saepe. Tempore reprehenderit similique quaerat consequatur. Voluptate doloribus accusantium molestias ipsum voluptatem. Aut blanditiis saepe ipsum et.', '2025-05-31', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(160, 8, 'Inspection', 'Ea Sint Alias Et Vero Odit', 'Velit perferendis eos provident reprehenderit. Autem deleniti aperiam ipsum consequuntur vel ipsum. Ea pariatur maxime quos ut.', '2025-05-26', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(161, 34, 'Inspection', 'Sint Pariatur Neque Excepturi Ut Rem', 'Aut ipsam eligendi itaque. Id unde excepturi non sunt. Fugiat in commodi magni harum optio.', '2025-05-24', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(162, 62, 'Audit', 'Provident Qui Nostrum Minus Eligendi Aut', 'Qui modi blanditiis culpa reprehenderit aut neque ea rerum. Quia non nulla sunt. Placeat maxime magnam rem soluta.', '2025-06-12', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(163, 83, 'Audit', 'Ipsam Quos Sint Modi', 'Eos earum quaerat amet cum eligendi delectus. Qui nihil exercitationem iure quam molestias error ab. Nostrum voluptatem non reprehenderit distinctio a. Culpa et suscipit est eum voluptatem.', '2025-05-30', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(164, 67, 'Audit', 'Quia Eum Velit', 'Magnam et dolor et est dolorem. Asperiores ipsum voluptate et perferendis consequuntur. Alias eos magni vitae alias porro aliquam. Ut et nam quia assumenda.', '2025-05-13', '2025-07-18', 'Completed', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(165, 78, 'Security Test', 'Ut Et Consectetur Et', 'Et magnam quidem eum autem fugit hic. Necessitatibus laudantium sit quia enim. Nulla et dolor consequatur ratione.', '2025-05-08', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL);
INSERT INTO `quality_controls` (`id`, `facility_id`, `control_type`, `title`, `description`, `scheduled_date`, `end_date`, `status`, `created_at`, `updated_at`, `department_id`, `department_name`) VALUES
(166, 27, 'Inspection', 'Est Eligendi Sequi Animi Vel', 'Quos eos aut omnis. Et totam tempora nihil eveniet qui nobis. Veritatis et dolorum aut dolore alias quam.', '2025-06-15', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(167, 28, 'Inspection', 'Eos Corrupti Quisquam Dolores Et Dolore', 'Odio nostrum ut dolor explicabo omnis tenetur quo et. Repellat ut est fugit rerum et aperiam. Maiores dolores ipsa nemo sint ex ipsam est corrupti. Commodi aliquam ipsam aliquid qui repellat.', '2025-05-12', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(168, 72, 'Inspection', 'Culpa Adipisci Sapiente Et', 'Ducimus minima necessitatibus facere quidem laborum. Dolores tempore expedita ipsum maiores. Dolorum nesciunt doloribus aut laboriosam. Consequatur architecto ipsum officiis. Et ad et magni dolor autem voluptatum iste.', '2025-06-15', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(169, 64, 'Security Test', 'Ipsa Qui Quasi Voluptate', 'Alias dignissimos magni nesciunt facere aliquid rerum atque quisquam. Sit aut enim quasi non accusantium nisi aut est. Et eveniet officia et qui laboriosam accusamus et. Et vel quia qui totam sit.', '2025-05-23', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(170, 80, 'Security Test', 'Quidem Architecto Ut', 'Quia optio excepturi excepturi nostrum sed libero ut necessitatibus. Voluptatem sit quos distinctio iusto. Blanditiis tempore at libero rerum architecto. Ipsam commodi consequatur maiores et autem.', '2025-06-16', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(171, 84, 'Inspection', 'Esse Similique A Non', 'Alias quia ad maiores sit aut laborum voluptatem. Esse minus officiis illum repellat voluptatum nihil error voluptas. Non corrupti vel dolorum perspiciatis et rerum.', '2025-06-13', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(172, 72, 'Security Test', 'Non Molestias Dolorum Pariatur', 'Quidem sunt omnis vero sunt numquam ipsum. Sit omnis natus omnis sequi est sit recusandae.', '2025-05-24', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(173, 11, 'Security Test', 'Omnis Reiciendis Repellendus Adipisci Praesentium', 'Repudiandae saepe asperiores aut dolorum dolores. Dignissimos iure cum exercitationem qui magni. Provident voluptas voluptas libero repudiandae qui.', '2025-05-09', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(174, 56, 'Audit', 'Nesciunt Vel Aut Sunt Ipsam', 'Ut esse itaque et dolorem. Quo et aliquid consequatur rerum eaque aut. Officiis provident repellat non accusamus et nulla. Asperiores tempora mollitia est voluptatem quam.', '2025-06-09', '2025-07-18', 'Completed', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(175, 94, 'Security Test', 'Illum Dolore Itaque Asperiores Commodi Velit', 'Et voluptatibus officia dolor sit. Aliquam cum asperiores veritatis dolorem deserunt voluptas. Quos qui vitae nihil libero quam fugiat.', '2025-05-07', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(176, 101, 'Security Test', 'Aliquid Quis Minus', 'Distinctio cupiditate et ut quae. Deleniti nobis ipsam natus dicta repellat odio laborum. Incidunt alias eum sed sit et. Ipsam cum perferendis ut impedit.', '2025-05-27', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(177, 69, 'Inspection', 'Sit Dignissimos Id', 'Et quos voluptas quaerat ad eaque in possimus. Soluta itaque rem facere et facilis error. Blanditiis velit tempora impedit et quasi non ut.', '2025-05-20', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(178, 37, 'Audit', 'Neque Consectetur Minus Nihil Consequatur', 'Neque aut laudantium possimus alias est quo. Dolores fugit suscipit eum sed assumenda illo iure odit. Corporis praesentium ut ad et commodi placeat.', '2025-05-18', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(179, 47, 'Inspection', 'Voluptatibus Quo Ut', 'Eaque voluptate enim aut pariatur commodi. Blanditiis excepturi dolore sit. A sit perspiciatis culpa ad accusamus. Aut laborum quo mollitia optio.', '2025-05-20', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(180, 76, 'Inspection', 'Dolores Voluptas Voluptas Sunt Illo Voluptatem', 'Numquam temporibus voluptatibus ad rerum accusantium. Beatae quia voluptatem repellendus porro exercitationem et molestiae. Accusamus aliquam et inventore aspernatur sunt voluptatem voluptas libero.', '2025-05-29', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(181, 82, 'Audit', 'Inventore Voluptatem Expedita Voluptas Esse', 'Recusandae magnam fugit totam beatae sit nulla. Accusantium voluptatem et minima ducimus voluptate asperiores. Adipisci eos officiis fuga et corrupti quo eius. Sed harum minima libero ut earum sit enim. Molestias quaerat sint et perspiciatis temporibus id et.', '2025-06-06', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(182, 16, 'Security Test', 'Non Unde Odio Reiciendis Ut Et', 'Facilis quia labore velit quas enim. Quisquam minima nam fuga cupiditate dolorem. Dolores modi cumque laborum et ullam facere.', '2025-05-29', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(183, 3, 'Security Test', 'Nam Qui Consequuntur Dolorem Non Ullam', 'Commodi commodi recusandae in unde et. Fuga non nemo ea provident vel consectetur. Possimus consequatur necessitatibus adipisci quibusdam et eaque delectus. Inventore cumque aut et asperiores.', '2025-05-19', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(184, 25, 'Inspection', 'Nulla Explicabo Accusantium Et Quibusdam', 'Earum id et minus qui est. Impedit reiciendis est et. Voluptatibus nulla tenetur non aut doloremque et. Asperiores non placeat doloremque quasi quos voluptatem laboriosam quis.', '2025-05-15', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(185, 15, 'Audit', 'Sed Est Tenetur Quidem Iure', 'Accusantium illum assumenda temporibus praesentium sunt quaerat. Nobis expedita eaque porro natus odit. Dolores velit iure ut ut rerum non ea. Accusantium repudiandae et eos aut deleniti. Et voluptatem esse aut fugiat.', '2025-06-07', '2025-07-18', 'Completed', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(186, 17, 'Security Test', 'Dolore Nesciunt Id', 'Itaque et error libero quia temporibus. Recusandae unde enim mollitia neque quas. Aperiam at et non assumenda. Vero qui et est et iure veniam eum.', '2025-05-30', '2025-07-18', 'Completed', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(187, 62, 'Inspection', 'Tempore Omnis Odio Repellendus', 'Quidem dolorem laboriosam officiis odit et. Nostrum assumenda autem accusamus rem perspiciatis autem tempora. Ipsum qui nihil illo harum modi.', '2025-06-01', '2025-07-18', 'Completed', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(188, 9, 'Security Test', 'Placeat Et Vel Distinctio Fugiat', 'Dolor rerum quibusdam aliquid quo. Fugit ut magnam perspiciatis est maiores et saepe. Ratione accusantium placeat rem repellendus voluptas.', '2025-05-16', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(189, 6, 'Inspection', 'Velit Provident Animi Et', 'Ut est et voluptatibus quia. Odit ratione non autem libero aliquam sed quis. Adipisci sint porro et voluptatibus qui neque impedit. Nisi ipsam cupiditate pariatur neque et.', '2025-05-08', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(190, 37, 'Inspection', 'Sint Voluptatum Ut', 'Provident est rerum numquam. Corporis ipsum eaque ratione iste dolores illo. Non maxime tenetur qui sapiente. Ut voluptate ratione eum.', '2025-05-30', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(191, 34, 'Security Test', 'Est Qui Assumenda Dolor Est Vel', 'Aperiam id qui commodi architecto ut nihil sed. Quia odio ducimus et error tenetur culpa impedit. Magni suscipit aut qui.', '2025-05-09', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(192, 83, 'Inspection', 'Eveniet Eius Et Ipsa Aut', 'Beatae non quis eum sunt voluptatem. Quia reiciendis deleniti accusantium omnis magni. Veritatis et ex commodi provident quasi nisi. At ullam molestias provident incidunt magnam. Quam dolores deleniti alias vero quas tenetur tempore.', '2025-05-15', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(193, 14, 'Audit', 'Tempore Veniam Fugit', 'Sint accusantium a tempora inventore. Aut fugiat temporibus ut iure animi a. Aliquid doloremque sed amet occaecati natus. Et et consequatur provident tempore architecto. Praesentium ut aliquam repellat hic soluta quasi.', '2025-05-16', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(194, 32, 'Inspection', 'Quos Assumenda Quaerat Alias', 'Voluptas cum non dolorem voluptatem exercitationem. Enim voluptatem ab provident veritatis dicta ut et. Optio sit qui in modi cum sit iure. Aliquam libero velit ea id non.', '2025-05-10', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(195, 68, 'Inspection', 'Possimus Delectus Voluptatum Sed Autem', 'Corporis magnam perspiciatis aut aliquid. Eligendi eos nulla autem culpa iste magnam. Culpa earum aut autem nihil optio.', '2025-05-10', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(196, 72, 'Security Test', 'Blanditiis Consectetur Ut Saepe', 'Ad et explicabo dolorum qui doloribus et est. Odit fuga harum voluptatem est. Voluptatem laborum officiis voluptas doloremque qui.', '2025-05-07', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(197, 76, 'Security Test', 'Qui Ipsam Et Aperiam', 'Nam quia enim ut tenetur. Odit iure error et ab labore placeat. Mollitia id ducimus et quaerat quibusdam omnis ducimus. Sunt pariatur numquam velit ut soluta exercitationem architecto.', '2025-05-28', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(198, 23, 'Security Test', 'Laboriosam Quam Unde', 'Eligendi fugiat ipsam voluptatem. Reprehenderit quia assumenda officia id qui in excepturi.', '2025-05-26', '2025-07-18', 'Pending', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(199, 23, 'Security Test', 'Accusantium Et Quasi Aut', 'Sed placeat dolores blanditiis et. Et libero sit natus tenetur necessitatibus pariatur.', '2025-05-26', '2025-07-18', 'Overdue', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(200, 48, 'Security Test', 'Rerum Consequuntur Ab Dolor Ex', 'Fugit reprehenderit vel ratione optio non minus. Non veritatis perferendis ipsum doloremque.', '2025-06-10', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(201, 60, 'Security Test', 'Hic Sunt Id', 'Aspernatur a officia qui debitis. Ut doloribus quod sed. Magni inventore rem sit. Nesciunt dolorem molestias aut adipisci est.', '2025-05-30', '2025-07-18', 'In Progress', '2025-05-17 16:49:35', '2025-05-17 16:49:35', NULL, NULL),
(203, 22, 'Security Test', 'Molestiae Magnam In Laborum Sit', 'Velit laborum consectetur provident animi repellat saepe. Voluptate officiis qui consequuntur.', '2025-05-30', '2025-07-18', 'Completed', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(204, 63, 'Security Test', 'Doloribus Voluptatem Ipsam In', 'Assumenda amet unde ut quae at ipsum blanditiis similique. Dicta vero enim aperiam eos est et. Est nisi quis et est sed harum mollitia.', '2025-05-17', '2025-07-18', 'In Progress', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(205, 40, 'Inspection', 'Facere Et Quasi Provident', 'Vel vel repellendus aliquid corporis perferendis ab. Velit eos odio laudantium id omnis voluptatibus. Necessitatibus ut unde suscipit ut quisquam consequatur.', '2025-06-08', '2025-07-18', 'In Progress', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(206, 70, 'Audit', 'Rem Exercitationem Facilis', 'Quibusdam iusto molestiae dignissimos et repellendus mollitia. Quia natus minus dolorem ducimus maxime inventore. Itaque nisi qui vel voluptatem molestiae voluptatibus.', '2025-06-01', '2025-07-18', 'In Progress', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(207, 82, 'Audit', 'Ex Qui Nihil Et Quo', 'Est est ipsum eligendi perspiciatis labore. Veniam aliquam non sint sit non consectetur voluptatibus.', '2025-05-19', '2025-07-18', 'Overdue', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(208, 45, 'Inspection', 'Ullam Nihil Voluptatem Cum', 'Natus sit in consequatur nihil error iste. Delectus fuga officia provident odio temporibus voluptas pariatur. Ducimus pariatur veritatis perferendis saepe ipsa rerum. Odio modi dolor ipsum libero.', '2025-05-26', '2025-07-18', 'In Progress', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(209, 52, 'Audit', 'Voluptatum Vitae Et', 'Non eius aperiam omnis et qui sed ad. Voluptatibus ad rerum quod et voluptates quo laboriosam sunt. Blanditiis at et in aperiam eum quo ea.', '2025-06-14', '2025-07-18', 'Completed', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(210, 64, 'Security Test', 'Explicabo Voluptatem Incidunt', 'Nulla suscipit a ut assumenda eum est. Ipsa porro voluptatem quis reprehenderit. Consectetur corporis tempora a est. Veniam sequi eaque cumque aut voluptates explicabo suscipit est.', '2025-06-14', '2025-07-18', 'In Progress', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(211, 46, 'Security Test', 'Sit Nam Ipsa Sed Sit Ipsa', 'Nesciunt voluptas voluptas eaque id alias quo. Quisquam ut omnis molestiae in dolores natus. Ea pariatur sit neque dolores. Nisi ipsum illum blanditiis delectus aperiam.', '2025-05-27', '2025-07-18', 'In Progress', '2025-05-17 16:49:37', '2025-05-17 16:49:37', NULL, NULL),
(213, 83, 'Inspection', 'Fugiat Quod Voluptatem', 'Esse voluptatem maxime nesciunt voluptatem voluptatum ut. Non tenetur corporis minima quo. Saepe accusantium quia consequuntur consequatur harum dolorum modi.', '2025-06-11', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(214, 9, 'Security Test', 'Iure Est Voluptatem Facere', 'Sunt quo a ut mollitia laboriosam est aut explicabo. Sapiente magni minima facilis alias. Omnis nihil in molestiae laborum aut saepe molestias non. Hic at est totam quidem ut.', '2025-05-22', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(215, 96, 'Audit', 'Maxime Velit Et Aperiam', 'Et et libero debitis et vel est. Voluptate facilis quod iusto architecto. Et aliquam rerum porro non necessitatibus fugiat placeat incidunt. Dolor ratione neque non ratione in rem.', '2025-06-15', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(216, 51, 'Audit', 'Laboriosam Aut Est Aut Recusandae', 'Praesentium consequuntur qui sed ut fugiat. Sed beatae in harum accusantium quam aspernatur dolorem saepe. Labore et ut eaque officia quia nihil sit minus. Doloribus voluptate molestiae officiis quisquam omnis ut.', '2025-06-16', '2025-07-18', 'Completed', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(217, 43, 'Security Test', 'Iure Aut Harum Deserunt Impedit Et', 'Sit ut qui earum tenetur nihil at. Aut odit ab ut ullam a. Rerum quasi ea qui illo. Recusandae accusantium sit possimus fuga ea ipsum sunt.', '2025-06-01', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(218, 5, 'Security Test', 'Et Quis Eligendi Error', 'Consequatur molestiae ratione nihil quasi possimus quisquam. Sapiente est nihil rem unde repudiandae officiis. Voluptates dolorum quo totam nobis quo. Hic vel officiis illum aut dolor.', '2025-06-10', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(219, 98, 'Audit', 'Neque Ut Commodi', 'Esse rerum et ut reprehenderit voluptatem est aut qui. Laudantium aspernatur ut ipsam autem.', '2025-06-15', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(220, 34, 'Security Test', 'Et Deserunt Praesentium', 'Facilis distinctio et ipsam harum fugiat beatae rerum voluptatibus. Voluptate velit fugiat blanditiis. Sit autem quibusdam nihil a velit eveniet.', '2025-05-25', '2025-07-18', 'Completed', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(221, 91, 'Security Test', 'Corporis Est Iure Sit Blanditiis Illum', 'Dignissimos voluptatem suscipit deserunt optio natus dignissimos. Quis dolorem non sed repellat est accusantium doloremque. Voluptatem autem occaecati aspernatur. Velit harum culpa ut eius eligendi ipsam quia.', '2025-06-04', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(222, 44, 'Audit', 'Quod Provident Voluptatibus Aut Magnam', 'Quis amet quidem ad quisquam officiis. Et facilis dolorem qui ratione. Alias ut unde dolorem ut voluptas facilis. Minima nulla quidem ab facilis quaerat. Vel voluptatem mollitia architecto in at.', '2025-05-22', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(223, 89, 'Audit', 'Laudantium Pariatur Aut Voluptatum Voluptas', 'Repellendus sit tenetur incidunt quasi maiores exercitationem et. Perspiciatis molestias eligendi sit et qui architecto.', '2025-06-02', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(224, 82, 'Inspection', 'Mollitia Sed Nulla Placeat', 'Est voluptatem quasi eius ut nemo deleniti quis. Quis dolor fugit est dolor. Facilis et culpa voluptatem et molestiae sed quia beatae. Dolorem debitis quaerat maxime qui ea veniam officia qui.', '2025-05-07', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(225, 91, 'Security Test', 'Dicta Fuga Libero Iure Aut', 'Molestiae beatae illum et non. Excepturi laborum eos et expedita est. Sunt sit iste inventore placeat sit non. Nulla debitis recusandae est.', '2025-06-07', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(226, 29, 'Security Test', 'Omnis Totam Alias', 'Sunt officia adipisci nulla vel non. Perferendis impedit et velit facere id et quia. Dolorem tempore unde minus minus et. Aliquam dolor enim suscipit et.', '2025-06-01', '2025-07-18', 'Completed', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(227, 62, 'Audit', 'Reprehenderit Quia Sunt Aut Iste', 'Veniam et nobis deleniti eaque et cumque tenetur. Culpa autem cum totam quis inventore blanditiis exercitationem. Blanditiis voluptatem sint earum consequatur earum aut. Commodi in nisi id doloribus qui enim.', '2025-05-24', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(228, 8, 'Inspection', 'Et Qui Sint Qui Sequi', 'Ipsam sint necessitatibus qui quia id sint et. Aspernatur quaerat doloribus et vel earum ut. Eos saepe a sit atque quidem repellat sunt debitis. A neque quis perferendis reiciendis temporibus.', '2025-05-11', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(229, 16, 'Audit', 'Fugit Omnis Dolores Qui', 'Autem aut quisquam voluptatem corrupti. Assumenda beatae eos aut voluptates quia sint.', '2025-06-09', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(230, 44, 'Audit', 'Sed Commodi Fugiat Iure Voluptatem', 'Quaerat quae eos velit ad recusandae. Ut nihil voluptatem possimus debitis omnis sunt vel. Reprehenderit est dolorum voluptates a blanditiis fugit. Velit quaerat aut corrupti aliquid.', '2025-06-14', '2025-07-18', 'Pending', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(231, 28, 'Audit', 'Ipsam Ea Nostrum', 'Asperiores quos ex incidunt dolores cum eaque voluptatem. Libero id qui consectetur odit quos quasi. Rerum reiciendis eos aut. Molestias quo ratione exercitationem sapiente officia non autem.', '2025-05-24', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(232, 68, 'Audit', 'Qui Similique Possimus Tenetur Quam Est', 'Et quis aliquam quisquam ducimus error. In minima dolorem fuga.', '2025-05-31', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(233, 8, 'Security Test', 'Id Aut Quo', 'Ullam nihil aspernatur dolore minus optio. Voluptas placeat qui itaque et omnis minima dolor. Porro qui explicabo provident labore et. Autem labore dicta officia omnis adipisci. Ut sed non et et occaecati maxime.', '2025-05-21', '2025-07-18', 'Completed', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(234, 69, 'Security Test', 'Officia Odit Similique Ut', 'Molestiae qui illo voluptatem quia nemo optio. Sapiente omnis aut ea sunt placeat minima. Dolorem consectetur voluptatum nihil et illum earum. Voluptatem voluptates aut qui velit nihil et. Consequatur molestias aut dolorem molestiae.', '2025-05-08', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(235, 90, 'Inspection', 'Quia Iusto Velit Et', 'Nesciunt quis eos delectus id nihil qui dolor. Consequatur sapiente quo ut est. Debitis unde harum nobis id repellat.', '2025-05-27', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(236, 88, 'Inspection', 'Expedita Rerum Aspernatur Reiciendis Doloremque A', 'Saepe dicta qui voluptatibus reprehenderit similique in dolor. Et qui voluptas autem voluptatem laborum ut optio. Voluptatem nulla ullam dolores sequi maiores consequatur. Eveniet rerum dolore sunt.', '2025-05-24', '2025-07-18', 'Completed', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(237, 41, 'Audit', 'Occaecati Quo Aut Corporis', 'Necessitatibus blanditiis laudantium voluptatem in at explicabo. Libero beatae accusantium tenetur distinctio eaque suscipit et ipsum. Quia quia quasi provident consequatur et nihil rerum.', '2025-05-21', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(238, 39, 'Inspection', 'Qui A Sed', 'Ipsa optio corrupti cumque culpa neque possimus. Ab aperiam rerum consequatur exercitationem. Porro nihil nobis iste explicabo consequuntur.', '2025-06-14', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(239, 8, 'Audit', 'Magni Facilis Reiciendis Quia Similique', 'Eveniet aut ipsam est vero corporis quae. Ipsam ab facere a modi veniam ipsa temporibus. Numquam nihil quos cupiditate ut nam dolorem et. Ea voluptas quaerat exercitationem cum ratione vel.', '2025-05-10', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(240, 43, 'Audit', 'Eveniet Iusto Officiis', 'Illo autem a voluptate consequatur cupiditate. Facilis quis dolor itaque impedit quis quibusdam. Necessitatibus quae aliquid commodi voluptatem voluptas. Ipsa et et et voluptas aut aliquid amet. At suscipit dolorum voluptatem velit excepturi.', '2025-05-26', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(241, 33, 'Audit', 'Rerum Accusantium Nemo Dolor Ducimus Eligendi', 'Consequuntur ea doloribus nobis aut consectetur. Quis et laborum totam id. Vitae voluptatem incidunt id repellat et nobis neque sequi. Iusto non sunt sed odio sit vero est.', '2025-06-04', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(242, 28, 'Inspection', 'Magni Ut Repellat Sit Inventore', 'Sed libero quod est saepe eos laborum non. Incidunt est vel et tempore praesentium et et voluptates.', '2025-05-20', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(243, 79, 'Audit', 'Aut Similique Tempora Et', 'Quibusdam esse eius et et est. Sed rerum minima ex culpa quia neque iste. Nulla pariatur aspernatur eius nobis dolore vero.', '2025-05-07', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(244, 79, 'Audit', 'Maiores Occaecati Mollitia RecusandaeXXX', 'Tempora praesentium odio corrupti officia accusamus dolorum. Est dignissimos ullam et et necessitatibus. Distinctio ratione est atque eos adipisci dicta laudantium velit. Sint labore vitae possimus inventore odit harum rerum.', '2025-05-19', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-07-08 09:00:09', NULL, NULL),
(245, 76, 'Security Test', 'Autem Et Rerum Sint Nostrum Excepturi', 'Accusamus aut praesentium non est eligendi. Sed nihil dolorem optio vero praesentium. Natus quaerat neque vel illo sed est ut. Non quam nihil nihil incidunt velit amet.', '2025-06-02', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(246, 54, 'Inspection', 'Consequuntur Deleniti Fugiat Est Harum Ex', 'Deserunt dolorem recusandae eum ratione quia omnis. Et consequatur eaque molestias veniam necessitatibus earum vel. Id error minima omnis voluptas. Magni soluta aut quia libero dolor excepturi nisi.', '2025-06-01', '2025-07-18', 'Completed', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(247, 69, 'Inspection', 'Dolore Non Qui Repellat Suscipit Est', 'Dolore labore sunt enim in quisquam voluptas eius. Sit est nisi molestiae est adipisci sint praesentium. Labore cum nemo magni accusamus perspiciatis.', '2025-05-13', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(248, 27, 'Audit', 'Ea Dolor Vero Earum Hic Odit', 'Rerum sunt veritatis perspiciatis suscipit tenetur. Ipsum repellendus quas quidem. Sit facilis soluta aspernatur libero tempora.', '2025-05-21', '2025-07-18', 'Pending', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(249, 65, 'Inspection', 'Enim Quis Voluptates', 'Modi est tenetur ipsa voluptates. Nihil tempore consectetur repellendus error. Ducimus nisi qui odio nulla modi consequatur repudiandae. Aperiam voluptas mollitia odio pariatur. Itaque quidem et optio nesciunt et nesciunt.', '2025-05-21', '2025-07-18', 'Pending', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(250, 45, 'Security Test', 'Quas Qui Aut', 'Enim aspernatur asperiores eaque. Voluptatum quia eaque necessitatibus voluptas blanditiis natus.', '2025-05-13', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(251, 35, 'Audit', 'Et Molestiae Veritatis', 'Nihil provident dicta quibusdam autem rerum praesentium. Et sint sunt doloribus minus.', '2025-05-29', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(252, 68, 'Inspection', 'Voluptatem In Impedit Occaecati Sunt Consectetur', 'Qui nam perferendis harum animi. Dolor quos aut et possimus. Quaerat provident ut labore non nisi cumque.', '2025-05-15', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(253, 46, 'Security Test', 'Ad Sit Eaque Ea Quae', 'Accusamus vero soluta aut eius. Quis unde sed et accusamus natus id. Tenetur doloremque nisi nisi fugiat quis aspernatur.', '2025-05-14', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(254, 20, 'Inspection', 'Eum Illum Ut Excepturi Quo', 'Placeat libero inventore perferendis eligendi. Sit sunt possimus natus porro aut dolorem mollitia. Ullam qui molestiae saepe culpa molestias at. Similique iusto officia et voluptate ab rerum.', '2025-06-13', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(255, 87, 'Audit', 'Numquam Aliquid Modi In Est', 'Ut quae aut repudiandae dolores explicabo. Magni non qui dolore dicta consequatur fugit. Qui quae illo ducimus dolorem tempora quam. Enim et numquam non cumque accusamus.', '2025-05-30', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(256, 75, 'Inspection', 'Esse Necessitatibus Accusamus Quasi', 'Quis quae exercitationem sit excepturi dolor excepturi. Fugit harum voluptatem voluptatibus delectus. Saepe voluptatem nihil qui praesentium quia cumque officia eius. Atque assumenda ut magni enim odio at magni.', '2025-05-31', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(257, 101, 'Security Test', 'Voluptas Nihil Impedit Consequatur Maiores Asperiores', 'Adipisci velit repudiandae error. Odit non nihil ut laudantium. Vitae aut blanditiis placeat ipsa totam rem.', '2025-05-17', '2025-07-18', 'Completed', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(258, 76, 'Inspection', 'Sint Quia Laborum', 'Rem quia est sapiente ut veritatis. Corrupti vitae unde dolor. Suscipit ad animi non vero mollitia illum expedita.', '2025-05-22', '2025-07-18', 'Completed', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(259, 60, 'Audit', 'Ipsam Quos Sunt Exercitationem Excepturi Incidunt', 'Error cupiditate fuga repudiandae sapiente. Iusto et voluptatem ad repellat fuga voluptates nam.', '2025-05-23', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(260, 9, 'Inspection', 'Quia Aliquid Architecto Ad Ipsa', 'Ducimus ducimus eligendi accusantium dolores accusantium distinctio. Excepturi ullam laudantium libero nulla ullam quidem delectus distinctio.', '2025-05-07', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(261, 79, 'Inspection', 'Excepturi Sed Veritatis Et Rerum', 'Ipsum iusto repudiandae autem nobis atque expedita dolorem ea. Perferendis ut cupiditate tempore quo quibusdam. Ipsam temporibus tempore perspiciatis vitae. Repellendus et ea optio cum et rerum dolorem.', '2025-05-26', '2025-07-18', 'Overdue', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(262, 14, 'Audit', 'Soluta Doloremque Sequi', 'Qui omnis qui nihil neque mollitia eligendi tempore quo. Id rerum labore suscipit ipsa rerum distinctio tempora. Pariatur illum incidunt dolores excepturi.', '2025-06-03', '2025-07-18', 'In Progress', '2025-05-17 16:49:39', '2025-05-17 16:49:39', NULL, NULL),
(264, 24, 'Audit', 'Cum Cum Asperiores Vitae Sunt Dolorum', 'Sed ipsam non rerum quia sint molestiae distinctio. Neque non illo atque velit et saepe consequatur. Totam quia maiores non. Asperiores voluptatem dolores dolorem nihil.', '2025-05-21', '2025-07-18', 'Completed', '2025-05-17 16:50:14', '2025-05-17 16:50:14', NULL, NULL),
(265, 50, 'Audit', 'Dolore Tempore Sed Deserunt Aperiam Molestias', 'Eos fugiat est est temporibus voluptas enim nam. Cupiditate velit molestias ducimus et est. Temporibus rerum quas placeat incidunt ex. Harum temporibus vel doloribus corporis ut labore nostrum.', '2025-05-14', '2025-07-18', 'Completed', '2025-05-17 16:50:14', '2025-05-17 16:50:14', NULL, NULL),
(267, 76, 'Audit', 'Qui Praesentium Sint Aliquam', 'Autem et mollitia repellendus ut quia velit ratione cum. Laboriosam fugiat libero officiis omnis similique vel natus molestiae. Veniam iste aut libero quisquam nam architecto quis accusantium. Facere pariatur voluptatum doloremque consequatur dolorem quae.', '2025-05-22', '2025-07-18', 'Overdue', '2025-05-17 16:50:36', '2025-05-17 16:50:36', NULL, NULL),
(268, 74, 'Security Test', 'Aliquam Dolore Laboriosam Dignissimos', 'Sit molestiae at non aliquid. Laboriosam earum totam veritatis qui voluptatem. Recusandae repellendus vitae numquam cumque quisquam dolorem.', '2025-06-06', '2025-07-18', 'Pending', '2025-05-17 16:50:36', '2025-05-17 16:50:36', NULL, NULL),
(270, 36, 'Inspection', 'Quia Et VoluptatumX', 'Esse sunt consequatur laudantium ducimus cumque. Consectetur distinctio consequatur molestiae et. Ut sint consequatur molestiae sit consequatur voluptas error.X', '2025-05-13', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-19 09:57:16', NULL, NULL),
(271, 49, 'Audit', 'Distinctio Rerum Porro Tenetur Qui', 'Eum ut fuga et repellat quasi earum. Odit quis sit natus. Saepe excepturi porro error minus ad dolor voluptas culpa.', '2025-06-05', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(272, 60, 'Audit', 'Quis Nam Voluptas Quo Reiciendis', 'Quia non quas aut voluptate asperiores doloremque ducimus. Iure explicabo sint labore deserunt ut magnam corrupti. Quisquam qui ut a sed aliquid tempora nihil. Sunt doloremque sint molestiae voluptate quae corrupti provident. Facilis quis necessitatibus sit modi esse.', '2025-06-16', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(273, 77, 'Inspection', 'Rerum Et Eum Sint', 'Architecto illo sed ut ut dolores laudantium tempora consectetur. Voluptatum aliquid alias omnis facere.', '2025-05-22', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(274, 98, 'Audit', 'Aliquam Omnis Aut Fuga Consequatur', 'A sunt accusantium dolores delectus dolores est suscipit nihil. Voluptatem illum eum illo sint iure. Modi voluptates aut voluptate odit eaque.', '2025-05-27', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(275, 45, 'Inspection', 'Eligendi Quas Ut Reprehenderit', 'Exercitationem aut placeat aut aliquid voluptates enim. Ut sint consequuntur quia numquam. Ut expedita qui accusantium repellat sapiente. Ut illum iusto nisi inventore ipsam.', '2025-05-19', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(276, 40, 'Security Test', 'Molestiae Doloremque Expedita', 'Velit aut et deleniti aut dolores fugiat est. Eos repellendus sed rem eos rerum. Magni nulla minima labore.', '2025-05-10', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-07-26 17:23:24', NULL, NULL),
(277, 48, 'Security Test', 'Enim Numquam Et Sunt Eveniet Vel', 'Facilis rerum omnis rerum qui soluta. Aperiam expedita modi mollitia impedit quibusdam officia. Cupiditate inventore et quod in officia a sed.', '2025-06-07', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(278, 89, 'Inspection', 'Aut Et Provident Occaecati Quia Vitae', 'Nisi qui blanditiis ea. Voluptatum assumenda vero debitis vitae. Odio quisquam quia fuga nihil ratione.', '2025-05-21', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(279, 83, 'Inspection', 'Est Consequatur Totam', 'Voluptates officia nobis nihil pariatur harum doloribus. Optio qui tempore eveniet voluptate provident laudantium dolor inventore.', '2025-06-13', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(280, 71, 'Inspection', 'Quas At Eum Ex Vitae Et', 'Est placeat fuga velit non eum. Corrupti beatae consectetur porro quas minima dolore doloribus eveniet. Voluptates nemo ipsum et consectetur. Sunt sed alias et tempore eveniet veritatis doloribus.', '2025-05-08', '2025-07-18', 'Completed', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(281, 42, 'Security Test', 'Iure Quidem Omnis Tempora Corporis', 'Vitae quo quam est nisi. Sit et recusandae quis nesciunt saepe.', '2025-05-30', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(282, 60, 'Audit', 'Numquam Sed Vero Asperiores Quaerat', 'Perspiciatis vel accusantium quas minus nihil eligendi. Maiores animi tempore quia iure recusandae et. Architecto dicta consectetur quia. Delectus aspernatur amet sed vitae. Non cumque dolorem aut suscipit eum.', '2025-06-08', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(283, 60, 'Inspection', 'Error Sint Odio Fugit', 'Dolorem eum perspiciatis deserunt voluptatem sed. Adipisci tempore eos reiciendis pariatur et. Veniam est sed a qui maxime voluptas nulla. Id consequatur eligendi et modi et quibusdam consequatur.', '2025-05-13', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(284, 91, 'Inspection', 'Officiis Dolor Voluptatem Nemo Ratione', 'Iste voluptatem necessitatibus ut totam earum quia at. Eos numquam culpa itaque iste. Optio magni consequatur vero nobis qui. Voluptas quia recusandae magni inventore sint illo dolorum.', '2025-05-08', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(285, 31, 'Audit', 'Dolorem Deleniti Atque Autem Enim Illum', 'Quia voluptatum enim omnis qui aliquam. Quia natus ut ducimus voluptas nam. Ut distinctio sunt enim omnis rerum fuga odit. Est natus ratione nesciunt cumque illum repellat.', '2025-06-11', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(286, 42, 'Security Test', 'Veritatis Et Aliquam Culpa', 'Aut similique voluptates magnam asperiores voluptatibus. Dolor iusto eos quos corporis reprehenderit. Eius excepturi maiores quas et esse vero aut. Ut laborum mollitia omnis rerum beatae dicta saepe quo. Et repudiandae qui nostrum necessitatibus.', '2025-05-11', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(287, 5, 'Inspection', 'Ut Corrupti Amet Voluptates Sunt Fugit', 'Iste dolores architecto quae accusantium reiciendis ad. Inventore praesentium possimus at qui. Et asperiores incidunt neque molestiae omnis quidem deserunt. Ipsam qui voluptatibus tempora quibusdam tenetur.', '2025-06-01', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(288, 95, 'Audit', 'Sint Quia Assumenda Ratione', 'Quasi dolorem inventore et nihil non vel. Quo praesentium blanditiis culpa laborum. Quia harum aspernatur quidem officia voluptates molestiae.', '2025-05-07', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(289, 9, 'Security Test', 'Mollitia Iure Optio Vitae', 'Voluptate quasi veniam ex deserunt dicta. Sit in voluptatibus incidunt accusamus quaerat. Maiores praesentium sit perspiciatis qui magnam recusandae. Esse officia dignissimos velit dolore autem.', '2025-06-06', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(290, 59, 'Audit', 'Aut Quia Quod Rerum Ut', 'Consequatur ab et et aperiam. Numquam voluptatem consequatur sequi ipsum inventore. Provident recusandae libero doloribus rem animi. Consequatur corporis accusamus occaecati dolorum officia dolores.', '2025-06-13', '2025-07-18', 'Completed', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(291, 38, 'Security Test', 'Sint Et Ea Ullam Maiores Dolor', 'Corrupti odit dignissimos odio accusantium sint enim occaecati. Nihil voluptas aut consequuntur. Nihil minus vero omnis praesentium inventore et. Minus voluptas et rerum ab.', '2025-05-31', '2025-07-18', 'Completed', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(292, 16, 'Inspection', 'A Molestiae Necessitatibus', 'Fugit rerum dolor quam ut architecto nesciunt officia. Qui est amet consequatur quod pariatur. Odit sed nobis adipisci est consequatur facilis voluptate.', '2025-06-10', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-07-26 17:23:42', NULL, NULL),
(293, 87, 'Inspection', 'Id Ut Debitis', 'Est numquam expedita consectetur minima fugiat dolorem mollitia animi. Id voluptatum nesciunt officiis aut non et iure dolor. Tempora numquam consequatur et ab recusandae sint.', '2025-05-28', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(294, 7, 'Inspection', 'A Vel Illo', 'Nemo rerum aliquid harum. At consequatur autem praesentium ipsa natus voluptatem a sit.', '2025-06-14', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(295, 28, 'Security Test', 'Aspernatur Aut Possimus', 'Provident architecto eius dolor natus est et. Incidunt voluptatibus qui cumque incidunt nihil quaerat. Voluptate aliquam fuga cupiditate distinctio nostrum aspernatur ut consectetur.', '2025-06-05', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-07-26 17:23:08', NULL, NULL),
(296, 36, 'Security Test', 'Aut Et Labore', 'Quis nobis facere et aliquid vitae. Praesentium magnam blanditiis nesciunt. Itaque quos distinctio omnis incidunt dolores assumenda nam. Aut error veritatis molestiae placeat.', '2025-05-11', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(297, 31, 'Audit', 'Doloremque Veritatis Assumenda Odit Cupiditate Ratione', 'Sit repellat ab perspiciatis nulla quod sunt ullam. Voluptatem et placeat provident molestias. Dolores id officia est nisi. Est consequatur est consectetur repudiandae incidunt a minima.', '2025-06-08', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(298, 1, 'Audit', 'Quo Nulla Qui Aperiam Qui Quae', 'Dolorem corporis ut tempora ex minus sed quia. Voluptate magnam ut eum consequuntur. Quibusdam quia non eos sit quasi nobis. Voluptas et ipsam et temporibus omnis cum dolorum qui.', '2025-05-22', '2025-07-18', 'Completed', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(299, 42, 'Inspection', 'Aut Sit Voluptates Non Ea Ea', 'Et quia nulla iure non eaque nihil possimus. Aut quod et error. Beatae sunt non aut sequi repudiandae quia numquam laudantium.', '2025-05-13', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(300, 52, 'Audit', 'Provident Ea Aut Quo', 'Voluptates molestiae et aut. Voluptas ut veniam qui. Molestiae consequatur rerum reprehenderit inventore sint.', '2025-05-21', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(301, 37, 'Audit', 'Quis Consequatur Reiciendis Nemo Odio Sit', 'Et natus beatae quae. Ut voluptas quidem quia magnam perferendis. Minus quibusdam adipisci ut dolor voluptates. Necessitatibus possimus nihil autem quidem qui numquam.', '2025-06-13', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(302, 62, 'Audit', 'Totam Mollitia Cum Nemo Non Sit', 'Voluptatem quia non cupiditate aut perferendis ut. Suscipit ad non alias ullam. Dolores voluptates nesciunt consequatur porro et.', '2025-06-14', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(303, 16, 'Security Test', 'Doloribus Nihil Sint', 'Voluptas quasi ullam corrupti eum rerum. Ullam id corrupti aliquid dolores magni. Nobis est similique ex quis.', '2025-06-15', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(304, 56, 'Inspection', 'Unde Tempora Cupiditate', 'Rerum cupiditate voluptatem sapiente occaecati impedit. Atque unde aperiam voluptatem excepturi iste. Quo at aspernatur itaque ea corrupti saepe.', '2025-05-28', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(305, 95, 'Inspection', 'Iusto Minus Nihil', 'In possimus molestias reprehenderit autem nemo ea. Culpa blanditiis nisi perferendis qui occaecati est saepe. Similique enim sequi non ad facere. Quia officia molestias corrupti.', '2025-05-26', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(306, 42, 'Audit', 'Maiores A Iure Aut Distinctio Ut', 'Ut ut eveniet repellat. Sit mollitia totam maiores alias maiores. Nemo sed veritatis aut.', '2025-05-14', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(307, 41, 'Audit', 'Aut Et Sed Ea', 'Nobis veniam aperiam sapiente quia eveniet pariatur. Doloribus modi sint esse voluptatem. Eos rerum voluptatem ut tenetur.', '2025-06-07', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(308, 32, 'Inspection', 'Deserunt Tenetur Eius Ab Dignissimos', 'Molestiae omnis quisquam quas voluptatem. Consectetur iste odit eos voluptatum quaerat pariatur. Enim nemo consequuntur quia quis impedit temporibus praesentium. Provident molestiae voluptate fuga ullam quae.', '2025-05-22', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(309, 25, 'Audit', 'Est Neque Sed Et', 'Est architecto ipsam vero beatae et voluptatibus eum. Distinctio ea perferendis quia quibusdam incidunt voluptatem. Inventore dolor voluptatem optio assumenda voluptate laborum.', '2025-06-08', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(310, 57, 'Security Test', 'Atque Animi Voluptatem Quasi Quia', 'Voluptatibus eos atque nisi nostrum. Sapiente ipsam et autem consequatur. Eaque provident et asperiores dolore rerum velit dicta. Earum ratione veritatis rerum iusto. Cumque cum id quaerat harum placeat quia.', '2025-05-20', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(311, 8, 'Inspection', 'Quibusdam Odit Quo', 'Ducimus inventore et quia qui dolores consequatur. Nam temporibus molestias deserunt necessitatibus voluptas corrupti voluptas. Tempora officia cumque et nobis labore soluta.', '2025-05-09', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(312, 18, 'Inspection', 'Aliquam Vitae Nulla', 'Ipsa corporis eveniet nisi reprehenderit totam laborum ut. Sapiente voluptatem dolorum mollitia rem voluptates voluptas. Provident esse recusandae quis eius eveniet qui nam. Nihil incidunt distinctio et earum. Et consectetur est animi provident.', '2025-06-03', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(313, 15, 'Inspection', 'Eum Eum Dolorum Harum Atque', 'Nostrum et quidem quidem quisquam praesentium et. Sint nemo perspiciatis error labore quia et.', '2025-05-28', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(314, 86, 'Inspection', 'Ipsam Et Laudantium', 'Voluptas nesciunt necessitatibus sed possimus sunt consequatur quas. Sint dicta unde aut soluta sunt. Pariatur omnis odio exercitationem quod. Ratione corrupti ullam facere est autem blanditiis.', '2025-06-02', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(315, 98, 'Inspection', 'Eum Ipsam Maiores Rerum', 'Voluptatem repellat quia corrupti ab. Dolore nobis dolores facilis voluptas officia aut veniam. Et magnam sit sed unde. Sed quisquam voluptas quia vel aut sed.', '2025-06-02', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(316, 13, 'Inspection', 'Animi Quia Error Occaecati', 'Vel id non quod est reiciendis incidunt. Id quia harum quo perferendis excepturi voluptas quisquam. Amet quod voluptas aut. Dicta sed quia dolorem dolor aut.', '2025-05-11', '2025-07-18', 'Pending', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(317, 57, 'Security Test', 'Pariatur Et Necessitatibus Suscipit Qui Non', 'Similique ut sapiente et aut omnis dolorum pariatur. Nisi omnis consequuntur ea alias. Ut eaque ex illum vel omnis odit nihil. Accusantium eligendi totam unde vel.', '2025-05-21', '2025-07-18', 'In Progress', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(318, 27, 'Inspection', 'Nisi Labore Ipsa', 'Sapiente nulla sapiente quo illo incidunt numquam. Sed vitae labore pariatur qui maiores delectus. Neque quos impedit ea et. Magnam qui officiis a consequatur. Ex eum magni error iste voluptatem architecto qui.', '2025-06-10', '2025-07-18', 'Completed', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(319, 92, 'Security Test', 'Facilis Alias Repellendus Totam Sint Culpa', 'Vel impedit dolore et voluptas porro et. Totam qui earum consequuntur porro maiores. Perspiciatis assumenda nihil sint aliquam. Et quia aliquam incidunt amet id repellat.', '2025-05-16', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(320, 80, 'Audit', 'Vero Explicabo Repellat Eaque Unde Modi', 'Dolores labore ut unde quam ex ex. Inventore aliquam beatae eaque odio ipsa at. Odit aut totam voluptate eveniet. Ut rerum eos repellendus sed qui quis aut.', '2025-05-11', '2025-07-18', 'Completed', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(321, 66, 'Audit', 'Et Consequatur Voluptatum Incidunt', 'Dolore minus sed dolores temporibus quia qui. Aut odio dolorem similique doloribus sed aut dolorum. Iure maiores voluptate dolorem velit ducimus quis.', '2025-05-07', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(322, 21, 'Security Test', 'Incidunt Molestiae Iusto Officia Et', 'Assumenda sunt ipsum id totam dicta saepe. Eum qui fugit et voluptatem cumque similique. Laudantium consequatur doloribus voluptas sed possimus. Minima laborum odio distinctio sunt possimus.', '2025-06-11', '2025-07-18', 'Overdue', '2025-05-17 16:50:51', '2025-05-17 16:50:51', NULL, NULL),
(327, 79, 'Inspection', 'Tremblay-Schneider INSPECTION', 'dfsaDSAfasfdsafads', '2025-05-24', '2025-07-18', 'Pending', '2025-05-23 09:35:15', '2025-05-23 09:35:15', NULL, NULL),
(328, 79, 'Security Test', 'TEST Tremblay-Schneider', 'JBVSJA IJDISNDI OJDONDKSAO JDASNJKNJKDNJK', '2025-05-31', '2025-07-18', 'Pending', '2025-05-23 09:46:40', '2025-05-23 09:46:40', NULL, NULL),
(329, 47, 'Security Test', 'TEST', 'jbvcjhcvnkcxvmkcxvkmcv', '2025-06-12', '2025-07-18', 'Pending', '2025-06-11 10:02:27', '2025-06-11 10:15:51', NULL, NULL),
(330, 101, 'Inspection', 'Inspection of KKIA', 'This is a decription of the insptoin', '2025-06-17', '2025-07-18', 'Pending', '2025-06-16 11:00:40', '2025-07-14 11:56:32', NULL, NULL),
(331, 101, 'Inspection', 'Inspection of Airport KKIA', 'vsdfdsagfdsg', '2025-07-14', '2025-07-18', 'Pending', '2025-07-14 10:16:27', '2025-07-14 11:54:33', NULL, NULL),
(332, 101, 'Inspection', 'Protection of Hold Baggage', 'jkdsgahnb WTRWTW kbcsikjb', '2025-07-25', '2025-07-25', 'Completed', '2025-07-25 06:55:51', '2025-08-06 08:30:32', 3, 'AVSECXZ'),
(334, 101, 'Inspection', 'Perimeter Fencing', NULL, '2025-08-23', '2025-08-29', 'Pending', '2025-08-22 12:25:30', '2025-08-22 12:25:30', 3, NULL),
(335, 101, 'Inspection', 'RUN WAY Inspection', NULL, '2025-09-01', '2025-09-01', 'Pending', '2025-09-01 11:51:06', '2025-09-01 11:51:06', 3, NULL);
INSERT INTO `quality_controls` (`id`, `facility_id`, `control_type`, `title`, `description`, `scheduled_date`, `end_date`, `status`, `created_at`, `updated_at`, `department_id`, `department_name`) VALUES
(336, 101, 'Inspection', 'Inspection of Taxiways', NULL, '2025-09-04', '2025-09-10', 'Pending', '2025-09-04 07:34:26', '2025-09-04 07:34:26', 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quality_control_alerts`
--

CREATE TABLE `quality_control_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quality_control_id` bigint(20) UNSIGNED NOT NULL,
  `source_alert_id` int(11) DEFAULT NULL,
  `source_alert_name` varchar(255) DEFAULT NULL,
  `alert_type` varchar(255) NOT NULL,
  `alert_description` varchar(255) NOT NULL,
  `alert_status` varchar(255) NOT NULL,
  `alert_date` date DEFAULT NULL,
  `alert_resolved_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quality_control_alerts`
--

INSERT INTO `quality_control_alerts` (`id`, `quality_control_id`, `source_alert_id`, `source_alert_name`, `alert_type`, `alert_description`, `alert_status`, `alert_date`, `alert_resolved_date`, `created_at`, `updated_at`) VALUES
(1, 244, 62, NULL, 'Audit', 'The quality control needs you attention.', 'Open', '2025-07-08', NULL, '2025-07-08 09:00:09', '2025-07-08 09:00:09'),
(2, 244, 63, NULL, 'Audit', 'The quality control needs you attention.', 'Open', '2025-07-08', NULL, '2025-07-08 09:00:09', '2025-07-08 09:00:09'),
(3, 244, 62, NULL, 'Audit', 'The quality control needs you attention.', 'Open', '2025-07-08', NULL, '2025-07-08 09:13:23', '2025-07-08 09:13:23'),
(4, 244, 63, NULL, 'Audit', 'The quality control needs you attention.', 'Open', '2025-07-08', NULL, '2025-07-08 09:13:23', '2025-07-08 09:13:23'),
(5, 244, 62, NULL, 'Audit', 'The quality control needs you attention.', 'Open', '2025-07-08', NULL, '2025-07-08 11:43:06', '2025-07-08 11:43:06'),
(6, 244, 63, NULL, 'Audit', 'The quality control needs you attention.', 'Open', '2025-07-08', NULL, '2025-07-08 11:43:06', '2025-07-08 11:43:06'),
(7, 244, 62, NULL, 'Audit', 'The quality control needs you attention.', 'Open', '2025-07-08', NULL, '2025-07-08 13:26:49', '2025-07-08 13:26:49'),
(8, 244, 63, NULL, 'Audit', 'The quality control needs you attention.', 'Open', '2025-07-08', NULL, '2025-07-08 13:26:49', '2025-07-08 13:26:49');

-- --------------------------------------------------------

--
-- Table structure for table `quality_control_questions`
--

CREATE TABLE `quality_control_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `audit_area_category_id` bigint(20) UNSIGNED NOT NULL,
  `question` text NOT NULL,
  `audit_area_type` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quality_control_user`
--

CREATE TABLE `quality_control_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `quality_control_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quality_control_user`
--

INSERT INTO `quality_control_user` (`id`, `user_id`, `quality_control_id`, `created_at`, `updated_at`) VALUES
(5, 15, 329, NULL, NULL),
(6, 14, 329, NULL, NULL),
(11, 14, 331, '2025-07-22 08:49:46', '2025-07-22 08:49:46'),
(12, 14, 332, '2025-07-25 06:58:58', '2025-07-25 06:58:58'),
(14, 15, 330, '2025-07-26 17:34:20', '2025-07-26 17:34:20'),
(15, 1, 332, '2025-08-06 08:39:23', '2025-08-06 08:39:23'),
(18, 15, 334, '2025-09-01 08:37:19', '2025-09-01 08:37:19'),
(19, 15, 335, '2025-09-01 11:52:52', '2025-09-01 11:52:52'),
(20, 15, 336, '2025-09-04 07:36:59', '2025-09-04 07:36:59'),
(21, 14, 336, '2025-09-04 07:37:39', '2025-09-04 07:37:39');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'Admin', 'web', '2025-05-13 11:14:32', '2025-05-13 11:14:32'),
(5, 'Super Admins', 'web', '2025-05-14 11:15:34', '2025-05-14 11:15:34');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(4, 4),
(4, 5),
(5, 4),
(5, 5),
(6, 4),
(6, 5),
(7, 4),
(7, 5),
(16, 4),
(16, 5),
(17, 4),
(17, 5),
(18, 4),
(18, 5),
(19, 4),
(19, 5);

-- --------------------------------------------------------

--
-- Table structure for table `security_equipment`
--

CREATE TABLE `security_equipment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `facility_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `serial_number` varchar(150) DEFAULT NULL,
  `facility_name` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `security_equipment`
--

INSERT INTO `security_equipment` (`id`, `facility_id`, `name`, `serial_number`, `facility_name`, `description`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Baggage Conveyor Scanner', 'APTMGADJ-31958', 'Spinka Group', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(2, 1, 'Handheld Metal Detector', 'RE8K55CE-59686', 'Spinka Group', 'Used for secondary screening of passengers.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(3, 1, 'Surveillance Camera (CCTV)', 'ASBUUSTG-29707', 'Spinka Group', 'Monitors activity within the facility perimeter.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(4, 1, 'Digital Evidence Recording System', 'IFNMKHS0-38674', 'Spinka Group', 'Captures and stores video/audio evidence securely.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(5, 1, 'Sniffer Dog Kennel / Deployment Point', '5AJEW0PN-1493', 'Spinka Group', 'Designated area for explosive detection dog teams.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(6, 1, 'Vehicle Barrier / Bollard', 'ZQH1MALH-83934', 'Spinka Group', 'Stops unauthorized vehicle entry.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(7, 2, 'Infrared Thermal Scanner', 'EABAT9X3-54279', 'Bartell-Bednar', 'Detects elevated body temperature remotely.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(8, 2, 'Sniffer Dog Kennel / Deployment Point', 'PIHDRVFB-12631', 'Bartell-Bednar', 'Designated area for explosive detection dog teams.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(9, 2, 'Baggage Conveyor Scanner', 'AIKMVMXL-79480', 'Bartell-Bednar', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(10, 3, 'Handheld Metal Detector', 'IUBMHUJH-1542', 'Rau-Lakin', 'Used for secondary screening of passengers.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(11, 3, 'Under Vehicle Surveillance System', 'SXJLC6LH-39992', 'Rau-Lakin', 'Inspects the underside of vehicles entering restricted zones.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(12, 3, 'Baggage Conveyor Scanner', '3CSRLUZG-3798', 'Rau-Lakin', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(13, 3, 'Baggage Conveyor Scanner', 'D6KKHSFR-72211', 'Rau-Lakin', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(14, 3, 'Biometric Access Terminal', 'NSVG9CWZ-55052', 'Rau-Lakin', 'Controls access using fingerprint or retina scan authentication.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(15, 4, 'TSA Approved Screening Table', '506I3TLD-92290', 'Tillman-Schultz', 'Standard table for manual screening of carry-ons.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(16, 4, 'Automated License Plate Recognition (ALPR)', 'S3MNBGLT-7208', 'Tillman-Schultz', 'Reads and verifies license plates automatically.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(17, 4, 'Under Vehicle Surveillance System', 'ZHXFUU0H-51524', 'Tillman-Schultz', 'Inspects the underside of vehicles entering restricted zones.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(18, 5, 'Bullet-Resistant Guard Booth', 'GCU3S8V2-87644', 'Muller LLC', 'Protected space for on-site security personnel.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(19, 5, 'Explosive Detection System (EDS)', 'DTJJIQ5K-49750', 'Muller LLC', 'Advanced detection system for explosives in baggage.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(20, 5, 'Emergency Communication System', 'TF3JBGIA-45759', 'Muller LLC', 'Two-way communication system for emergency response.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(21, 5, 'Handheld Metal Detector', 'PMTZ5BWS-47525', 'Muller LLC', 'Used for secondary screening of passengers.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(22, 5, 'Full-Body Scanner', 'DPZLTKZ5-96602', 'Muller LLC', 'Scans passengers for concealed threats or contraband.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(23, 6, 'Biometric Access Terminal', 'B1XMXLKL-98025', 'Welch, Wuckert and Padberg', 'Controls access using fingerprint or retina scan authentication.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(24, 6, 'Bullet-Resistant Guard Booth', 'AY8ZDJVK-41306', 'Welch, Wuckert and Padberg', 'Protected space for on-site security personnel.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(25, 6, 'Perimeter Intrusion Detection System', 'BVLROOM0-96663', 'Welch, Wuckert and Padberg', 'Alerts security on unauthorized perimeter breaches.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(26, 6, 'Radiation Detection Portal', 'YMBRV0DI-98127', 'Welch, Wuckert and Padberg', 'Detects radioactive materials passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(27, 6, 'Biometric Access Terminal', 'TW1PHSPG-6469', 'Welch, Wuckert and Padberg', 'Controls access using fingerprint or retina scan authentication.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(28, 7, 'Biometric Access Terminal', 'OQE0YHPU-46149', 'Johnston Group', 'Controls access using fingerprint or retina scan authentication.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(29, 7, 'Surveillance Camera (CCTV)', 'HHTGCDLC-10174', 'Johnston Group', 'Monitors activity within the facility perimeter.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(30, 7, 'TSA Approved Screening Table', 'VNU09AJR-61961', 'Johnston Group', 'Standard table for manual screening of carry-ons.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(32, 8, 'Facial Recognition Terminal', 'IU02XPRB-43759', 'Larson and Sons', 'Automated identity verification using facial features.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(33, 8, 'Full-Body Scanner', 'QNDZECJJ-42527', 'Larson and Sons', 'Scans passengers for concealed threats or contraband.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(34, 8, 'Radiation Detection Portal', '472Z5G2C-51393', 'Larson and Sons', 'Detects radioactive materials passing through.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(35, 8, 'Automated License Plate Recognition (ALPR)', 'GBBVO9AV-99572', 'Larson and Sons', 'Reads and verifies license plates automatically.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(36, 9, 'TSA Approved Screening Table', 'ILOFIZHH-96464', 'Schumm, Skiles and Hessel', 'Standard table for manual screening of carry-ons.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(37, 9, 'Bullet-Resistant Guard Booth', 'CGFEDKDL-65185', 'Schumm, Skiles and Hessel', 'Protected space for on-site security personnel.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(38, 9, 'Biometric Access Terminal', 'GRXGOW8G-47088', 'Schumm, Skiles and Hessel', 'Controls access using fingerprint or retina scan authentication.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(39, 9, 'X-ray Baggage Scanner', 'B2SKEHTM-76900', 'Schumm, Skiles and Hessel', 'Scans luggage and carry-on bags for prohibited items.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(40, 10, 'Full-Body Scanner', 'ZIFX5HQL-66048', 'Brekke, Quitzon and Mayert', 'Scans passengers for concealed threats or contraband.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(41, 10, 'Walk-Through Metal Detector', 'IK4BCD8S-84307', 'Brekke, Quitzon and Mayert', 'Detects concealed metal objects on persons passing through.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(42, 10, 'Digital Evidence Recording System', 'PRCQ5U73-12468', 'Brekke, Quitzon and Mayert', 'Captures and stores video/audio evidence securely.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(43, 11, 'Handheld Metal Detector', 'VCOU517P-77340', 'Crist, Abshire and Predovic', 'Used for secondary screening of passengers.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(44, 11, 'X-ray Baggage Scanner', 'C4KFGZND-1909', 'Crist, Abshire and Predovic', 'Scans luggage and carry-on bags for prohibited items.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(45, 11, 'Metal Detection Archway with Counting System', 'WLTXHJXU-77171', 'Crist, Abshire and Predovic', 'Metal detector with integrated people counter.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(46, 11, 'Explosive Detection System (EDS)', 'XZDYMVF1-10909', 'Crist, Abshire and Predovic', 'Advanced detection system for explosives in baggage.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(47, 11, 'Infrared Thermal Scanner', '203MYFWT-32493', 'Crist, Abshire and Predovic', 'Detects elevated body temperature remotely.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(48, 12, 'Perimeter Intrusion Detection System', '0KJSNQYH-59790', 'Abernathy, Friesen and Hermann', 'Alerts security on unauthorized perimeter breaches.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(49, 12, 'Facial Recognition Terminal', 'JWSCX0WL-80183', 'Abernathy, Friesen and Hermann', 'Automated identity verification using facial features.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(50, 12, 'Digital Evidence Recording System', 'PF6NHLF5-75569', 'Abernathy, Friesen and Hermann', 'Captures and stores video/audio evidence securely.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(51, 12, 'Infrared Thermal Scanner', 'PBIZ50KI-87752', 'Abernathy, Friesen and Hermann', 'Detects elevated body temperature remotely.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(52, 13, 'Sniffer Dog Kennel / Deployment Point', '29LXZKXA-11250', 'Christiansen-Durgan', 'Designated area for explosive detection dog teams.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(53, 13, 'Drone Detection System', '4CSWMU4L-60396', 'Christiansen-Durgan', 'Identifies and alerts on unauthorized drone activity.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(54, 13, 'Drone Detection System', 'UNVONP4L-29231', 'Christiansen-Durgan', 'Identifies and alerts on unauthorized drone activity.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(55, 14, 'Sniffer Dog Kennel / Deployment Point', 'XVZ4KXBH-54695', 'Breitenberg PLC', 'Designated area for explosive detection dog teams.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(56, 14, 'Perimeter Intrusion Detection System', '9HS9TBWT-24017', 'Breitenberg PLC', 'Alerts security on unauthorized perimeter breaches.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(57, 14, 'Handheld Metal Detector', 'KZOVPI88-89673', 'Breitenberg PLC', 'Used for secondary screening of passengers.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(58, 14, 'Walk-Through Metal Detector', 'GNTKHEUU-24316', 'Breitenberg PLC', 'Detects concealed metal objects on persons passing through.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(59, 15, 'Bullet-Resistant Guard Booth', 'NCVJKKBO-80853', 'Littel PLC', 'Protected space for on-site security personnel.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(60, 15, 'Vehicle Barrier / Bollard', 'ZYCJUKEV-45655', 'Littel PLC', 'Stops unauthorized vehicle entry.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(61, 15, 'Baggage Conveyor Scanner', 'BREPDQQA-13234', 'Littel PLC', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(62, 16, 'Radiation Detection Portal', 'RJB1KKFT-38042', 'Boyle PLC', 'Detects radioactive materials passing through.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(63, 16, 'Drone Detection System', 'MF3EGFWU-16252', 'Boyle PLC', 'Identifies and alerts on unauthorized drone activity.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(64, 16, 'Vehicle Barrier / Bollard', 'L78SHXXX-16525', 'Boyle PLC', 'Stops unauthorized vehicle entry.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(65, 16, 'X-ray Baggage Scanner', 'NGYDXRJ7-67340', 'Boyle PLC', 'Scans luggage and carry-on bags for prohibited items.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(66, 16, 'Infrared Thermal Scanner', '6G95ZJGZ-83895', 'Boyle PLC', 'Detects elevated body temperature remotely.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(67, 17, 'Drone Detection System', 'WPSBBD6Q-76785', 'Mohr Inc', 'Identifies and alerts on unauthorized drone activity.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(68, 17, 'Automated License Plate Recognition (ALPR)', 'DPH1CZVI-27531', 'Mohr Inc', 'Reads and verifies license plates automatically.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(69, 17, 'X-ray Baggage Scanner', 'YY1VWC6P-58849', 'Mohr Inc', 'Scans luggage and carry-on bags for prohibited items.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(70, 17, 'Infrared Thermal Scanner', 'OPOX6VZH-53814', 'Mohr Inc', 'Detects elevated body temperature remotely.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(71, 17, 'Sniffer Dog Kennel / Deployment Point', 'W5NUYJWN-77357', 'Mohr Inc', 'Designated area for explosive detection dog teams.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(72, 17, 'Explosive Trace Detector', 'YK0OSSBS-44630', 'Mohr Inc', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(73, 18, 'Metal Detection Archway with Counting System', 'GAIY6EDT-19589', 'Reilly, Kunde and Rempel', 'Metal detector with integrated people counter.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(74, 18, 'Bullet-Resistant Guard Booth', 'THACUOWS-80261', 'Reilly, Kunde and Rempel', 'Protected space for on-site security personnel.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(75, 18, 'Vehicle Barrier / Bollard', 'HZ1J52S1-54039', 'Reilly, Kunde and Rempel', 'Stops unauthorized vehicle entry.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(76, 18, 'Baggage Conveyor Scanner', 'GUXEUBHW-3785', 'Reilly, Kunde and Rempel', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(77, 18, 'Access Control Panel', 'ZXAFP6N1-98514', 'Reilly, Kunde and Rempel', 'Manages and logs secure access to restricted areas.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(78, 19, 'Emergency Communication System', 'AVHCNJ5F-31391', 'Homenick-Towne', 'Two-way communication system for emergency response.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(79, 19, 'Digital Evidence Recording System', 'P2PBG8CB-11072', 'Homenick-Towne', 'Captures and stores video/audio evidence securely.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(80, 19, 'Surveillance Camera (CCTV)', 'XPNKBBN2-30379', 'Homenick-Towne', 'Monitors activity within the facility perimeter.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(81, 20, 'Vehicle Barrier / Bollard', 'WXXVBSYN-80035', 'Schultz, Paucek and Altenwerth', 'Stops unauthorized vehicle entry.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(82, 20, 'Biometric Access Terminal', 'ITY8JZAY-46768', 'Schultz, Paucek and Altenwerth', 'Controls access using fingerprint or retina scan authentication.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(83, 20, 'X-ray Baggage Scanner', 'LAMUSHPP-90869', 'Schultz, Paucek and Altenwerth', 'Scans luggage and carry-on bags for prohibited items.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(84, 20, 'Under Vehicle Surveillance System', 'IEFZ3Q84-35420', 'Schultz, Paucek and Altenwerth', 'Inspects the underside of vehicles entering restricted zones.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(85, 21, 'Biometric Access Terminal', 'AM3RGQBJ-46569', 'Hodkiewicz-Mosciski', 'Controls access using fingerprint or retina scan authentication.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(86, 21, 'Facial Recognition Terminal', '6WVADHQX-83662', 'Hodkiewicz-Mosciski', 'Automated identity verification using facial features.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(87, 21, 'Full-Body Scanner', 'M1LFPIJG-94254', 'Hodkiewicz-Mosciski', 'Scans passengers for concealed threats or contraband.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(88, 21, 'Access Control Panel', 'RTU6XTCW-15339', 'Hodkiewicz-Mosciski', 'Manages and logs secure access to restricted areas.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(89, 22, 'X-ray Baggage Scanner', '1SKSZET1-36707', 'Toy, Mann and Koch', 'Scans luggage and carry-on bags for prohibited items.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(90, 22, 'Full-Body Scanner', '2AEXCMRK-42363', 'Toy, Mann and Koch', 'Scans passengers for concealed threats or contraband.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(91, 22, 'Digital Evidence Recording System', 'YX0PTOQ0-98798', 'Toy, Mann and Koch', 'Captures and stores video/audio evidence securely.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(92, 22, 'Perimeter Intrusion Detection System', 'P1Z1H7BH-23691', 'Toy, Mann and Koch', 'Alerts security on unauthorized perimeter breaches.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(93, 23, 'Access Control Panel', '8US42OZ8-97125', 'Abbott-Mayer', 'Manages and logs secure access to restricted areas.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(94, 23, 'Surveillance Camera (CCTV)', 'YYYT2XG0-46591', 'Abbott-Mayer', 'Monitors activity within the facility perimeter.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(95, 23, 'Access Control Panel', 'T4FIS2U4-11691', 'Abbott-Mayer', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(96, 23, 'Infrared Thermal Scanner', 'PWTYEZG8-75356', 'Abbott-Mayer', 'Detects elevated body temperature remotely.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(97, 23, 'Radiation Detection Portal', 'POTKCWXZ-69438', 'Abbott-Mayer', 'Detects radioactive materials passing through.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(98, 24, 'Infrared Thermal Scanner', 'JSOAZVPI-98158', 'Erdman, Grimes and Stehr', 'Detects elevated body temperature remotely.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(99, 24, 'Handheld Metal Detector', 'LV7TQ2CW-33259', 'Erdman, Grimes and Stehr', 'Used for secondary screening of passengers.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(100, 24, 'Biometric Access Terminal', 'ZJSUQP4N-46924', 'Erdman, Grimes and Stehr', 'Controls access using fingerprint or retina scan authentication.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(101, 24, 'Metal Detection Archway with Counting System', 'KKKSJ589-55612', 'Erdman, Grimes and Stehr', 'Metal detector with integrated people counter.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(102, 25, 'Facial Recognition Terminal', 'FJ7EVASO-99005', 'Hauck, Morissette and Bradtke', 'Automated identity verification using facial features.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(103, 25, 'Perimeter Intrusion Detection System', 'OIHYO1I8-20456', 'Hauck, Morissette and Bradtke', 'Alerts security on unauthorized perimeter breaches.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(104, 25, 'Bullet-Resistant Guard Booth', 'MG3TGSJ0-58037', 'Hauck, Morissette and Bradtke', 'Protected space for on-site security personnel.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(105, 25, 'Sniffer Dog Kennel / Deployment Point', '5GYS0NWM-86301', 'Hauck, Morissette and Bradtke', 'Designated area for explosive detection dog teams.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(106, 25, 'Access Control Panel', '3DNVNBRP-5073', 'Hauck, Morissette and Bradtke', 'Manages and logs secure access to restricted areas.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(107, 26, 'Baggage Conveyor Scanner', 'AJWDYFYN-3251', 'Davis, Gislason and Emmerich', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(108, 26, 'Security Intercom', 'R76B34OR-89467', 'Davis, Gislason and Emmerich', 'Entry point audio/video communication device.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(109, 26, 'Sniffer Dog Kennel / Deployment Point', 'GJ8WKXCR-93611', 'Davis, Gislason and Emmerich', 'Designated area for explosive detection dog teams.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(110, 26, 'Handheld Metal Detector', '7CDGUPAJ-38370', 'Davis, Gislason and Emmerich', 'Used for secondary screening of passengers.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(111, 27, 'Bullet-Resistant Guard Booth', '5CFSVV4M-10961', 'O\'Conner Group', 'Protected space for on-site security personnel.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(112, 27, 'Perimeter Intrusion Detection System', '7K1WTTYD-7736', 'O\'Conner Group', 'Alerts security on unauthorized perimeter breaches.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(113, 27, 'Radiation Detection Portal', 'CWINPO1Q-85422', 'O\'Conner Group', 'Detects radioactive materials passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(114, 27, 'Security Intercom', 'C3ZS9WT1-41443', 'O\'Conner Group', 'Entry point audio/video communication device.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(115, 27, 'Sniffer Dog Kennel / Deployment Point', 'RHISDU3J-8110', 'O\'Conner Group', 'Designated area for explosive detection dog teams.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(116, 28, 'Vehicle Barrier / Bollard', '11DX7H12-89187', 'Hahn-Brekke', 'Stops unauthorized vehicle entry.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(117, 28, 'Bullet-Resistant Guard Booth', '1Y49KQOL-86247', 'Hahn-Brekke', 'Protected space for on-site security personnel.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(118, 28, 'Under Vehicle Surveillance System', 'VCVMVSSV-3350', 'Hahn-Brekke', 'Inspects the underside of vehicles entering restricted zones.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(119, 28, 'Radiation Detection Portal', 'I67GSAKP-64241', 'Hahn-Brekke', 'Detects radioactive materials passing through.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(120, 28, 'Digital Evidence Recording System', 'QGTFUAXV-3212', 'Hahn-Brekke', 'Captures and stores video/audio evidence securely.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(121, 29, 'Full-Body Scanner', 'QIGWVGLT-24439', 'Breitenberg-Hickle', 'Scans passengers for concealed threats or contraband.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(122, 29, 'Perimeter Intrusion Detection System', 'GHE4WBZD-44704', 'Breitenberg-Hickle', 'Alerts security on unauthorized perimeter breaches.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(123, 29, 'Metal Detection Archway with Counting System', 'BTDNG2GE-50960', 'Breitenberg-Hickle', 'Metal detector with integrated people counter.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(124, 29, 'Under Vehicle Surveillance System', 'QO31KAPR-33614', 'Breitenberg-Hickle', 'Inspects the underside of vehicles entering restricted zones.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(125, 30, 'Security Intercom', 'T6KHT7TY-7710', 'Volkman, Keeling and Durgan', 'Entry point audio/video communication device.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(126, 30, 'Bullet-Resistant Guard Booth', 'LHMMQ85D-80661', 'Volkman, Keeling and Durgan', 'Protected space for on-site security personnel.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(127, 30, 'Walk-Through Metal Detector', 'P1SAU4RW-2024', 'Volkman, Keeling and Durgan', 'Detects concealed metal objects on persons passing through.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(128, 30, 'Explosive Detection System (EDS)', 'DVZAGX16-81269', 'Volkman, Keeling and Durgan', 'Advanced detection system for explosives in baggage.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(129, 30, 'Vehicle Barrier / Bollard', 'XCXYWELM-87667', 'Volkman, Keeling and Durgan', 'Stops unauthorized vehicle entry.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(130, 31, 'Vehicle Barrier / Bollard', '8RNWQG0O-19116', 'Blanda Group', 'Stops unauthorized vehicle entry.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(131, 31, 'Surveillance Camera (CCTV)', 'QOBJVM9A-53705', 'Blanda Group', 'Monitors activity within the facility perimeter.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(132, 31, 'Handheld Metal Detector', 'WJUB4R7Y-63798', 'Blanda Group', 'Used for secondary screening of passengers.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(133, 31, 'Drone Detection System', 'NNW0PPPL-64869', 'Blanda Group', 'Identifies and alerts on unauthorized drone activity.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(134, 31, 'Metal Detection Archway with Counting System', '4RQCA1GD-27602', 'Blanda Group', 'Metal detector with integrated people counter.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(136, 32, 'X-ray Baggage Scanner', '9QE4BR9L-16039', 'Greenfelder-Funk', 'Scans luggage and carry-on bags for prohibited items.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(137, 32, 'Explosive Trace Detector', 'K44NPZGF-79787', 'Greenfelder-Funk', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(138, 32, 'TSA Approved Screening Table', 'ZUTLXWF6-21670', 'Greenfelder-Funk', 'Standard table for manual screening of carry-ons.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(139, 32, 'Infrared Thermal Scanner', 'YIFYDRFW-88983', 'Greenfelder-Funk', 'Detects elevated body temperature remotely.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(140, 32, 'Walk-Through Metal Detector', 'LTFJLBY3-36701', 'Greenfelder-Funk', 'Detects concealed metal objects on persons passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(141, 33, 'Automated License Plate Recognition (ALPR)', 'ZTNUPXOA-56044', 'Zemlak-Wiegand', 'Reads and verifies license plates automatically.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(142, 33, 'Access Control Panel', 'MSAIH3SG-1570', 'Zemlak-Wiegand', 'Manages and logs secure access to restricted areas.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(143, 33, 'Surveillance Camera (CCTV)', 'D35ZMJT4-67327', 'Zemlak-Wiegand', 'Monitors activity within the facility perimeter.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(144, 33, 'Security Intercom', 'QDZHYIMR-72509', 'Zemlak-Wiegand', 'Entry point audio/video communication device.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(145, 33, 'Bullet-Resistant Guard Booth', '1CQFD95Y-33314', 'Zemlak-Wiegand', 'Protected space for on-site security personnel.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(146, 34, 'Walk-Through Metal Detector', 'N8DPSIM6-75531', 'Erdman and Sons', 'Detects concealed metal objects on persons passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(147, 34, 'Full-Body Scanner', 'XMXBYHIN-14940', 'Erdman and Sons', 'Scans passengers for concealed threats or contraband.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(148, 34, 'Vehicle Barrier / Bollard', 'JWWEEBHE-30586', 'Erdman and Sons', 'Stops unauthorized vehicle entry.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(149, 34, 'Perimeter Intrusion Detection System', 'LX6FJBCQ-49889', 'Erdman and Sons', 'Alerts security on unauthorized perimeter breaches.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(150, 35, 'Explosive Detection System (EDS)', 'ULRU8YWR-92222', 'Weimann and Sons', 'Advanced detection system for explosives in baggage.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(151, 35, 'Drone Detection System', '06IDR2WY-84548', 'Weimann and Sons', 'Identifies and alerts on unauthorized drone activity.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(152, 35, 'Vehicle Barrier / Bollard', 'PF4DPERM-39205', 'Weimann and Sons', 'Stops unauthorized vehicle entry.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(153, 35, 'TSA Approved Screening Table', '4SJF0P4W-8918', 'Weimann and Sons', 'Standard table for manual screening of carry-ons.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(154, 35, 'Metal Detection Archway with Counting System', '8JUOC0ZQ-19423', 'Weimann and Sons', 'Metal detector with integrated people counter.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(155, 35, 'Radiation Detection Portal', '5PTCHDWP-28942', 'Weimann and Sons', 'Detects radioactive materials passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(156, 36, 'Infrared Thermal Scanner', '9RP9QIVT-56598', 'Jakubowski, Daniel and Emmerich', 'Detects elevated body temperature remotely.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(157, 36, 'Radiation Detection Portal', 'H6JCY32V-88319', 'Jakubowski, Daniel and Emmerich', 'Detects radioactive materials passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(158, 36, 'Infrared Thermal Scanner', '1XEGRLUO-52174', 'Jakubowski, Daniel and Emmerich', 'Detects elevated body temperature remotely.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(159, 36, 'Emergency Communication System', 'IPSKNWMP-12443', 'Jakubowski, Daniel and Emmerich', 'Two-way communication system for emergency response.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(160, 36, 'Access Control Panel', 'B4FINYXA-83440', 'Jakubowski, Daniel and Emmerich', 'Manages and logs secure access to restricted areas.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(161, 37, 'Handheld Metal Detector', 'UEOODXF6-32976', 'Moen, Hickle and Cartwright', 'Used for secondary screening of passengers.', 'Decommissioned', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(162, 37, 'Walk-Through Metal Detector', 'WZBUAIN9-73127', 'Moen, Hickle and Cartwright', 'Detects concealed metal objects on persons passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(163, 37, 'Automated License Plate Recognition (ALPR)', 'CV2GGK4G-22545', 'Moen, Hickle and Cartwright', 'Reads and verifies license plates automatically.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(164, 38, 'Surveillance Camera (CCTV)', 'ZYJOQB6G-52102', 'Kutch LLC', 'Monitors activity within the facility perimeter.', 'Due for Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(165, 38, 'Vehicle Barrier / Bollard', 'ZHRYX0WV-27852', 'Kutch LLC', 'Stops unauthorized vehicle entry.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(166, 38, 'Perimeter Intrusion Detection System', 'LBWG8O72-11442', 'Kutch LLC', 'Alerts security on unauthorized perimeter breaches.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(167, 38, 'Facial Recognition Terminal', '5QA47P2U-37192', 'Kutch LLC', 'Automated identity verification using facial features.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(168, 39, 'TSA Approved Screening Table', 'UW3JCU0W-11361', 'McDermott, Lemke and Weissnat', 'Standard table for manual screening of carry-ons.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(169, 39, 'Bullet-Resistant Guard Booth', 'RI6KXKZL-74780', 'McDermott, Lemke and Weissnat', 'Protected space for on-site security personnel.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(170, 39, 'Explosive Detection System (EDS)', 'OOBUOYCH-59307', 'McDermott, Lemke and Weissnat', 'Advanced detection system for explosives in baggage.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(171, 39, 'Biometric Access Terminal', '7Z1KHHXR-79148', 'McDermott, Lemke and Weissnat', 'Controls access using fingerprint or retina scan authentication.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(172, 39, 'X-ray Baggage Scanner', 'FECDU8IA-98314', 'McDermott, Lemke and Weissnat', 'Scans luggage and carry-on bags for prohibited items.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(173, 39, 'Digital Evidence Recording System', 'GYPMN3VX-14070', 'McDermott, Lemke and Weissnat', 'Captures and stores video/audio evidence securely.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(174, 40, 'Drone Detection System', 'V9DMWQ5P-21553', 'Keeling and Sons', 'Identifies and alerts on unauthorized drone activity.', 'Under Maintenance', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(175, 40, 'Emergency Communication System', 'H2RBQQK9-34753', 'Keeling and Sons', 'Two-way communication system for emergency response.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(176, 40, 'Under Vehicle Surveillance System', 'REA8THVU-84696', 'Keeling and Sons', 'Inspects the underside of vehicles entering restricted zones.', 'Active', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(177, 40, 'Digital Evidence Recording System', 'PW22R9GU-34309', 'Keeling and Sons', 'Captures and stores video/audio evidence securely.', 'Inactive', NULL, '2025-06-03 05:26:34', '2025-06-03 05:26:34'),
(178, 40, 'Emergency Communication System', 'JOYPIBPZ-8827', 'Keeling and Sons', 'Two-way communication system for emergency response.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(179, 40, 'Perimeter Intrusion Detection System', 'DQQAO6XV-34162', 'Keeling and Sons', 'Alerts security on unauthorized perimeter breaches.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(180, 41, 'Radiation Detection Portal', 'MXFJKJOO-9703', 'Mayert, Pfeffer and Lynch', 'Detects radioactive materials passing through.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(181, 41, 'Under Vehicle Surveillance System', 'WA5R412H-26552', 'Mayert, Pfeffer and Lynch', 'Inspects the underside of vehicles entering restricted zones.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(182, 41, 'Infrared Thermal Scanner', 'YPWAZOJ9-61013', 'Mayert, Pfeffer and Lynch', 'Detects elevated body temperature remotely.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(183, 41, 'Bullet-Resistant Guard Booth', 'OWAOBULV-93562', 'Mayert, Pfeffer and Lynch', 'Protected space for on-site security personnel.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(184, 41, 'Security Intercom', 'GOG0HWUA-66383', 'Mayert, Pfeffer and Lynch', 'Entry point audio/video communication device.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(185, 41, 'Handheld Metal Detector', 'QEG94BIS-32862', 'Mayert, Pfeffer and Lynch', 'Used for secondary screening of passengers.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(186, 42, 'Walk-Through Metal Detector', 'MMFZASVY-94264', 'Oberbrunner, Jacobson and Flatley', 'Detects concealed metal objects on persons passing through.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(187, 42, 'Digital Evidence Recording System', 'IB670TWS-51726', 'Oberbrunner, Jacobson and Flatley', 'Captures and stores video/audio evidence securely.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(188, 42, 'X-ray Baggage Scanner', '65WYTZHM-39086', 'Oberbrunner, Jacobson and Flatley', 'Scans luggage and carry-on bags for prohibited items.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(189, 42, 'Biometric Access Terminal', 'SO4Q0KBO-71028', 'Oberbrunner, Jacobson and Flatley', 'Controls access using fingerprint or retina scan authentication.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(190, 42, 'Facial Recognition Terminal', 'TDA8RPGW-62494', 'Oberbrunner, Jacobson and Flatley', 'Automated identity verification using facial features.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(191, 43, 'Explosive Trace Detector', 'YG32NJT3-50454', 'Nolan, Zulauf and Stanton', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(192, 43, 'Explosive Trace Detector', '6JIIQGX2-3308', 'Nolan, Zulauf and Stanton', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(193, 43, 'Baggage Conveyor Scanner', 'XMYD3Q11-16127', 'Nolan, Zulauf and Stanton', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(194, 43, 'Emergency Communication System', 'PPOR6QGV-9520', 'Nolan, Zulauf and Stanton', 'Two-way communication system for emergency response.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(195, 43, 'Surveillance Camera (CCTV)', 'FNGPQJQY-23573', 'Nolan, Zulauf and Stanton', 'Monitors activity within the facility perimeter.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(196, 43, 'Surveillance Camera (CCTV)', 'X7SHTROA-79945', 'Nolan, Zulauf and Stanton', 'Monitors activity within the facility perimeter.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(197, 44, 'Access Control Panel', 'Q3SUFLCB-80621', 'Borer, Koss and Bashirian', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(198, 44, 'Explosive Detection System (EDS)', '891FYY6M-75187', 'Borer, Koss and Bashirian', 'Advanced detection system for explosives in baggage.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(199, 44, 'Automated License Plate Recognition (ALPR)', 'RXRDIR8Q-84237', 'Borer, Koss and Bashirian', 'Reads and verifies license plates automatically.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(200, 44, 'Infrared Thermal Scanner', 'EJAOPMAB-65179', 'Borer, Koss and Bashirian', 'Detects elevated body temperature remotely.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(201, 45, 'Full-Body Scanner', 'TRAI6WNL-37407', 'Abbott, Morar and Emmerich', 'Scans passengers for concealed threats or contraband.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(202, 45, 'Baggage Conveyor Scanner', 'HVPAZDUK-41985', 'Abbott, Morar and Emmerich', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(203, 45, 'Emergency Communication System', 'SWUUXFPM-81238', 'Abbott, Morar and Emmerich', 'Two-way communication system for emergency response.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(204, 45, 'Facial Recognition Terminal', 'PWU5UT9K-7980', 'Abbott, Morar and Emmerich', 'Automated identity verification using facial features.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(205, 45, 'Explosive Detection System (EDS)', 'WJVLX3YE-63784', 'Abbott, Morar and Emmerich', 'Advanced detection system for explosives in baggage.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(206, 45, 'Facial Recognition Terminal', 'SFKQLSPT-99070', 'Abbott, Morar and Emmerich', 'Automated identity verification using facial features.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(207, 46, 'Drone Detection System', 'TXVROGLV-22306', 'Kunde, Fritsch and Johnson', 'Identifies and alerts on unauthorized drone activity.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(208, 46, 'Explosive Trace Detector', 'W1EBX9NX-61843', 'Kunde, Fritsch and Johnson', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(209, 46, 'X-ray Baggage Scanner', '46AZRDSA-36805', 'Kunde, Fritsch and Johnson', 'Scans luggage and carry-on bags for prohibited items.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(210, 46, 'Perimeter Intrusion Detection System', 'AWLJF4HC-80084', 'Kunde, Fritsch and Johnson', 'Alerts security on unauthorized perimeter breaches.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(211, 46, 'Sniffer Dog Kennel / Deployment Point', 'DLSRQN4N-71350', 'Kunde, Fritsch and Johnson', 'Designated area for explosive detection dog teams.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(212, 46, 'Baggage Conveyor Scanner', 'HCTNXYZ4-52737', 'Kunde, Fritsch and Johnson', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(213, 47, 'Digital Evidence Recording System', 'KCAM9NEC-46306', 'Kerluke-Smitham', 'Captures and stores video/audio evidence securely.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(214, 47, 'Baggage Conveyor Scanner', 'GVKL5IZR-95334', 'Kerluke-Smitham', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(215, 47, 'Sniffer Dog Kennel / Deployment Point', 'QYJHWNMT-70685', 'Kerluke-Smitham', 'Designated area for explosive detection dog teams.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(216, 47, 'Vehicle Barrier / Bollard', '4WS0S4A6-57357', 'Kerluke-Smitham', 'Stops unauthorized vehicle entry.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(217, 47, 'Full-Body Scanner', 'FWUAWQ2Y-23805', 'Kerluke-Smitham', 'Scans passengers for concealed threats or contraband.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(218, 47, 'Handheld Metal Detector', '3T9ZBUP6-86044', 'Kerluke-Smitham', 'Used for secondary screening of passengers.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(219, 48, 'TSA Approved Screening Table', 'JDCNLXPC-48461', 'Bosco-Blanda', 'Standard table for manual screening of carry-ons.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(220, 48, 'Under Vehicle Surveillance System', 'NSGZLVCQ-37163', 'Bosco-Blanda', 'Inspects the underside of vehicles entering restricted zones.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(221, 48, 'Access Control Panel', 'RKKTTWI8-51997', 'Bosco-Blanda', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(222, 48, 'Access Control Panel', 'KMUJFO22-40867', 'Bosco-Blanda', 'Manages and logs secure access to restricted areas.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(223, 48, 'Explosive Detection System (EDS)', 'GT94MCSJ-72530', 'Bosco-Blanda', 'Advanced detection system for explosives in baggage.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(224, 48, 'TSA Approved Screening Table', 'ZAT7SGUZ-94712', 'Bosco-Blanda', 'Standard table for manual screening of carry-ons.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(225, 49, 'Explosive Detection System (EDS)', 'I3PZFLZZ-68197', 'Purdy, Kemmer and King', 'Advanced detection system for explosives in baggage.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(226, 49, 'Explosive Detection System (EDS)', 'SCWE24BP-5062', 'Purdy, Kemmer and King', 'Advanced detection system for explosives in baggage.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(227, 49, 'Access Control Panel', '3SRII4AJ-46922', 'Purdy, Kemmer and King', 'Manages and logs secure access to restricted areas.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(228, 49, 'Handheld Metal Detector', 'YIMLPL3T-29652', 'Purdy, Kemmer and King', 'Used for secondary screening of passengers.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(229, 50, 'TSA Approved Screening Table', 'PXMLUHMX-2947', 'Champlin, Ferry and Lowe', 'Standard table for manual screening of carry-ons.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(230, 50, 'Perimeter Intrusion Detection System', 'SZTOCBP2-94674', 'Champlin, Ferry and Lowe', 'Alerts security on unauthorized perimeter breaches.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(231, 50, 'Metal Detection Archway with Counting System', 'WMF6UOOB-50918', 'Champlin, Ferry and Lowe', 'Metal detector with integrated people counter.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(232, 50, 'TSA Approved Screening Table', 'MJBHU5RE-50065', 'Champlin, Ferry and Lowe', 'Standard table for manual screening of carry-ons.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(233, 50, 'Infrared Thermal Scanner', 'SQRXCCYA-68407', 'Champlin, Ferry and Lowe', 'Detects elevated body temperature remotely.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(234, 50, 'Radiation Detection Portal', 'CKDWZSN7-35878', 'Champlin, Ferry and Lowe', 'Detects radioactive materials passing through.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(235, 51, 'Access Control Panel', 'CQFCTMG5-68534', 'O\'Keefe, Schneider and Donnelly', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(236, 51, 'TSA Approved Screening Table', 'CY4XXPEO-50797', 'O\'Keefe, Schneider and Donnelly', 'Standard table for manual screening of carry-ons.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(237, 51, 'Infrared Thermal Scanner', 'HDOXNGA7-63417', 'O\'Keefe, Schneider and Donnelly', 'Detects elevated body temperature remotely.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(238, 51, 'Metal Detection Archway with Counting System', 'ZBPUHUD5-5872', 'O\'Keefe, Schneider and Donnelly', 'Metal detector with integrated people counter.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(239, 51, 'Under Vehicle Surveillance System', '1WXZ0H65-7052', 'O\'Keefe, Schneider and Donnelly', 'Inspects the underside of vehicles entering restricted zones.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(240, 52, 'Baggage Conveyor Scanner', 'VM8LOZIK-20478', 'Leffler-Braun', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(241, 52, 'Vehicle Barrier / Bollard', 'MC8P95FX-88841', 'Leffler-Braun', 'Stops unauthorized vehicle entry.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(242, 52, 'Perimeter Intrusion Detection System', 'WPJSKUTH-49353', 'Leffler-Braun', 'Alerts security on unauthorized perimeter breaches.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(243, 52, 'Full-Body Scanner', 'A1KZ2SVX-34142', 'Leffler-Braun', 'Scans passengers for concealed threats or contraband.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(244, 53, 'Under Vehicle Surveillance System', 'ZXKRZPRA-67480', 'Quigley, Rowe and Howell', 'Inspects the underside of vehicles entering restricted zones.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(245, 53, 'Digital Evidence Recording System', 'FGTSOLQE-93416', 'Quigley, Rowe and Howell', 'Captures and stores video/audio evidence securely.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35');
INSERT INTO `security_equipment` (`id`, `facility_id`, `name`, `serial_number`, `facility_name`, `description`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(246, 53, 'Explosive Detection System (EDS)', 'JPCYP9VZ-33332', 'Quigley, Rowe and Howell', 'Advanced detection system for explosives in baggage.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(247, 53, 'Full-Body Scanner', 'ASE3EO26-70406', 'Quigley, Rowe and Howell', 'Scans passengers for concealed threats or contraband.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(248, 53, 'Facial Recognition Terminal', 'KKV3UXVE-5794', 'Quigley, Rowe and Howell', 'Automated identity verification using facial features.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(249, 54, 'Explosive Detection System (EDS)', 'TEAQP7RR-35259', 'Hintz, Schowalter and Yost', 'Advanced detection system for explosives in baggage.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(250, 54, 'Under Vehicle Surveillance System', '9FGEBX49-67360', 'Hintz, Schowalter and Yost', 'Inspects the underside of vehicles entering restricted zones.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(251, 54, 'Digital Evidence Recording System', 'LNZEFD3O-23043', 'Hintz, Schowalter and Yost', 'Captures and stores video/audio evidence securely.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(252, 54, 'Security Intercom', 'QTLK0VUH-48057', 'Hintz, Schowalter and Yost', 'Entry point audio/video communication device.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(253, 54, 'Radiation Detection Portal', 'VXYWK6LE-47143', 'Hintz, Schowalter and Yost', 'Detects radioactive materials passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(254, 54, 'Explosive Detection System (EDS)', 'JF5Q3MEI-43878', 'Hintz, Schowalter and Yost', 'Advanced detection system for explosives in baggage.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(255, 55, 'Security Intercom', 'O2OFYV5P-60558', 'Berge and Sons', 'Entry point audio/video communication device.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(256, 55, 'Facial Recognition Terminal', 'H1IOZ4JQ-45725', 'Berge and Sons', 'Automated identity verification using facial features.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(257, 55, 'Baggage Conveyor Scanner', 'C2RDZWFG-74863', 'Berge and Sons', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(258, 55, 'Radiation Detection Portal', 'K4LL3G3I-84105', 'Berge and Sons', 'Detects radioactive materials passing through.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(259, 56, 'Baggage Conveyor Scanner', '60RXCHCM-63871', 'Connelly, Hirthe and Carroll', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(260, 56, 'Facial Recognition Terminal', 'XSE3BXBJ-28846', 'Connelly, Hirthe and Carroll', 'Automated identity verification using facial features.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(261, 56, 'Biometric Access Terminal', 'HBQQ54KF-58135', 'Connelly, Hirthe and Carroll', 'Controls access using fingerprint or retina scan authentication.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(262, 56, 'Walk-Through Metal Detector', 'JXVEOXME-44070', 'Connelly, Hirthe and Carroll', 'Detects concealed metal objects on persons passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(263, 57, 'Emergency Communication System', 'ZYGEKK20-60776', 'Stoltenberg PLC', 'Two-way communication system for emergency response.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(264, 57, 'Baggage Conveyor Scanner', 'VSCZDAXX-11042', 'Stoltenberg PLC', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(265, 57, 'Bullet-Resistant Guard Booth', '4IK5KXTT-74857', 'Stoltenberg PLC', 'Protected space for on-site security personnel.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(266, 57, 'Baggage Conveyor Scanner', 'LLKNESCZ-16048', 'Stoltenberg PLC', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(267, 58, 'Digital Evidence Recording System', 'IACH9GE0-16843', 'Prohaska LLC', 'Captures and stores video/audio evidence securely.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(268, 58, 'Explosive Detection System (EDS)', 'DN0MRYGD-67228', 'Prohaska LLC', 'Advanced detection system for explosives in baggage.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(269, 58, 'Explosive Trace Detector', 'ENRSREDS-15361', 'Prohaska LLC', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(270, 58, 'Under Vehicle Surveillance System', 'NNDDOF4Y-77748', 'Prohaska LLC', 'Inspects the underside of vehicles entering restricted zones.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(271, 58, 'Baggage Conveyor Scanner', 'KQ1X0SH2-70182', 'Prohaska LLC', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(272, 58, 'Drone Detection System', 'R5979NXQ-50520', 'Prohaska LLC', 'Identifies and alerts on unauthorized drone activity.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(273, 59, 'Biometric Access Terminal', 'CNBPTRP3-24611', 'Pagac LLC', 'Controls access using fingerprint or retina scan authentication.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(274, 59, 'Walk-Through Metal Detector', 'WTEEMFSX-13154', 'Pagac LLC', 'Detects concealed metal objects on persons passing through.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(275, 59, 'Drone Detection System', 'Q2BQUH8C-426', 'Pagac LLC', 'Identifies and alerts on unauthorized drone activity.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(276, 59, 'Bullet-Resistant Guard Booth', 'WWCDLIH1-96009', 'Pagac LLC', 'Protected space for on-site security personnel.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(277, 59, 'Explosive Detection System (EDS)', 'X1VNUFWO-791', 'Pagac LLC', 'Advanced detection system for explosives in baggage.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(278, 60, 'Baggage Conveyor Scanner', 'TGESW6M6-89493', 'Douglas LLC', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(279, 60, 'Digital Evidence Recording System', '75GZJUBC-75993', 'Douglas LLC', 'Captures and stores video/audio evidence securely.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(280, 60, 'Automated License Plate Recognition (ALPR)', 'XHEYSWWV-36522', 'Douglas LLC', 'Reads and verifies license plates automatically.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(281, 60, 'Biometric Access Terminal', 'FP2C6GKY-52623', 'Douglas LLC', 'Controls access using fingerprint or retina scan authentication.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(282, 61, 'Facial Recognition Terminal', 'J9PFWK09-51911', 'Paucek, Walker and Abbott', 'Automated identity verification using facial features.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(283, 61, 'X-ray Baggage Scanner', 'HZOGZGHS-65058', 'Paucek, Walker and Abbott', 'Scans luggage and carry-on bags for prohibited items.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(284, 61, 'Metal Detection Archway with Counting System', 'K31OSYLU-4295', 'Paucek, Walker and Abbott', 'Metal detector with integrated people counter.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(285, 61, 'Emergency Communication System', '1CYJLTKD-81294', 'Paucek, Walker and Abbott', 'Two-way communication system for emergency response.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(286, 62, 'Biometric Access Terminal', 'RNQTNARK-2619', 'Koelpin-Howell', 'Controls access using fingerprint or retina scan authentication.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(287, 62, 'Access Control Panel', 'BIYNTBOU-16151', 'Koelpin-Howell', 'Manages and logs secure access to restricted areas.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(289, 63, 'Walk-Through Metal Detector', 'XMT4JM2O-77418', 'Moore Group', 'Detects concealed metal objects on persons passing through.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(290, 63, 'Metal Detection Archway with Counting System', '37M7CAAI-61661', 'Moore Group', 'Metal detector with integrated people counter.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(291, 63, 'Automated License Plate Recognition (ALPR)', 'NVQ7PHH2-44746', 'Moore Group', 'Reads and verifies license plates automatically.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(292, 64, 'Drone Detection System', 'B35IYFSU-47020', 'Bradtke LLC', 'Identifies and alerts on unauthorized drone activity.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(293, 64, 'Explosive Trace Detector', 'ESRA2G7S-61669', 'Bradtke LLC', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(294, 64, 'Biometric Access Terminal', 'MLZX41VH-9847', 'Bradtke LLC', 'Controls access using fingerprint or retina scan authentication.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(295, 65, 'Radiation Detection Portal', 'PZRERK30-25465', 'Hansen-Quigley', 'Detects radioactive materials passing through.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(296, 65, 'Sniffer Dog Kennel / Deployment Point', 'TKERAQZO-28804', 'Hansen-Quigley', 'Designated area for explosive detection dog teams.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(297, 65, 'Explosive Detection System (EDS)', 'XBJWNL0H-26642', 'Hansen-Quigley', 'Advanced detection system for explosives in baggage.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(298, 65, 'Perimeter Intrusion Detection System', 'DALE9NJY-46388', 'Hansen-Quigley', 'Alerts security on unauthorized perimeter breaches.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(299, 65, 'Walk-Through Metal Detector', 'SB2WT2TO-15919', 'Hansen-Quigley', 'Detects concealed metal objects on persons passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(300, 66, 'Digital Evidence Recording System', 'FHMKNFES-232', 'Klocko-Crist', 'Captures and stores video/audio evidence securely.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(301, 66, 'Biometric Access Terminal', 'PGDQJ4AC-35619', 'Klocko-Crist', 'Controls access using fingerprint or retina scan authentication.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(302, 66, 'Explosive Detection System (EDS)', 'FWOEGMKK-6241', 'Klocko-Crist', 'Advanced detection system for explosives in baggage.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(303, 66, 'Explosive Detection System (EDS)', 'IREGGWEB-7618', 'Klocko-Crist', 'Advanced detection system for explosives in baggage.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(304, 67, 'Surveillance Camera (CCTV)', 'BWSN62XA-98422', 'Schiller Group', 'Monitors activity within the facility perimeter.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(305, 67, 'Baggage Conveyor Scanner', 'SBAKI2UN-71278', 'Schiller Group', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(306, 67, 'Baggage Conveyor Scanner', 'NUAI200I-11402', 'Schiller Group', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(307, 67, 'Metal Detection Archway with Counting System', 'U6EC7VJF-9592', 'Schiller Group', 'Metal detector with integrated people counter.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(308, 67, 'Digital Evidence Recording System', 'ZCTFH5UE-57639', 'Schiller Group', 'Captures and stores video/audio evidence securely.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(309, 67, 'Perimeter Intrusion Detection System', 'KNG3I67U-97187', 'Schiller Group', 'Alerts security on unauthorized perimeter breaches.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(310, 68, 'Access Control Panel', 'G35Y6IG0-35633', 'Haley-Koss', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(311, 68, 'Emergency Communication System', 'GIUVFRLO-64713', 'Haley-Koss', 'Two-way communication system for emergency response.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(312, 68, 'Surveillance Camera (CCTV)', 'HXTVHROF-14478', 'Haley-Koss', 'Monitors activity within the facility perimeter.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(313, 69, 'Sniffer Dog Kennel / Deployment Point', 'ZFLTF4TQ-76570', 'Hane-Turcotte', 'Designated area for explosive detection dog teams.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(314, 69, 'Under Vehicle Surveillance System', 'ZSJEZQBF-8992', 'Hane-Turcotte', 'Inspects the underside of vehicles entering restricted zones.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(315, 69, 'Explosive Detection System (EDS)', 'FUX0QO1R-41536', 'Hane-Turcotte', 'Advanced detection system for explosives in baggage.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(316, 69, 'X-ray Baggage Scanner', 'APPEXRVK-26744', 'Hane-Turcotte', 'Scans luggage and carry-on bags for prohibited items.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(317, 69, 'Infrared Thermal Scanner', 'CPXCBAOA-42971', 'Hane-Turcotte', 'Detects elevated body temperature remotely.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(318, 69, 'Under Vehicle Surveillance System', '0BOS6TLH-2618', 'Hane-Turcotte', 'Inspects the underside of vehicles entering restricted zones.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(319, 70, 'Under Vehicle Surveillance System', 'WNIMSTCU-24975', 'Daugherty-Wilderman', 'Inspects the underside of vehicles entering restricted zones.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(320, 70, 'Under Vehicle Surveillance System', '5T37IPXK-22880', 'Daugherty-Wilderman', 'Inspects the underside of vehicles entering restricted zones.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(321, 70, 'Infrared Thermal Scanner', 'BLQ1FNA2-9300', 'Daugherty-Wilderman', 'Detects elevated body temperature remotely.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(322, 70, 'Emergency Communication System', 'ZWC4R3FD-31376', 'Daugherty-Wilderman', 'Two-way communication system for emergency response.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(323, 70, 'Automated License Plate Recognition (ALPR)', 'S0XLVFW1-8866', 'Daugherty-Wilderman', 'Reads and verifies license plates automatically.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(324, 71, 'Under Vehicle Surveillance System', 'OFETTY0E-62684', 'Reichert-Zulauf', 'Inspects the underside of vehicles entering restricted zones.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(325, 71, 'Drone Detection System', 'JM9NUZQR-58220', 'Reichert-Zulauf', 'Identifies and alerts on unauthorized drone activity.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(327, 71, 'Perimeter Intrusion Detection System', '4JMMQTAR-62518', 'Reichert-Zulauf', 'Alerts security on unauthorized perimeter breaches.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(329, 71, 'Digital Evidence Recording System', 'TNKC0V1Q-79729', 'Reichert-Zulauf', 'Captures and stores video/audio evidence securely.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(330, 72, 'Automated License Plate Recognition (ALPR)', 'TMKILV2K-88894', 'O\'Kon LLC', 'Reads and verifies license plates automatically.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(331, 72, 'Drone Detection System', 'XDSPVTSJ-24759', 'O\'Kon LLC', 'Identifies and alerts on unauthorized drone activity.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(332, 72, 'Digital Evidence Recording System', 'ZXIZDTEF-20346', 'O\'Kon LLC', 'Captures and stores video/audio evidence securely.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(333, 72, 'Under Vehicle Surveillance System', 'LSELTCIH-92995', 'O\'Kon LLC', 'Inspects the underside of vehicles entering restricted zones.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(334, 73, 'Facial Recognition Terminal', '3P1QQA5H-43640', 'Mitchell and Sons', 'Automated identity verification using facial features.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(335, 73, 'Perimeter Intrusion Detection System', '91QB8JVP-75674', 'Mitchell and Sons', 'Alerts security on unauthorized perimeter breaches.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(336, 73, 'Perimeter Intrusion Detection System', 'BPM2ZI0D-81641', 'Mitchell and Sons', 'Alerts security on unauthorized perimeter breaches.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(337, 74, 'Metal Detection Archway with Counting System', 'NT9PK2S6-56413', 'Hamill LLC', 'Metal detector with integrated people counter.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(338, 74, 'Facial Recognition Terminal', 'PSY944IY-26368', 'Hamill LLC', 'Automated identity verification using facial features.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(339, 74, 'Access Control Panel', 'H71SFHHR-73506', 'Hamill LLC', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(340, 75, 'Facial Recognition Terminal', 'CDLZHUL9-23826', 'Langosh LLC', 'Automated identity verification using facial features.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(341, 75, 'Radiation Detection Portal', 'IIJZM9VU-31671', 'Langosh LLC', 'Detects radioactive materials passing through.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(342, 75, 'Facial Recognition Terminal', '9XGUEFU1-47883', 'Langosh LLC', 'Automated identity verification using facial features.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(343, 75, 'Access Control Panel', 'OK1JBUHV-67250', 'Langosh LLC', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(344, 75, 'Automated License Plate Recognition (ALPR)', 'J6AQG4K4-80253', 'Langosh LLC', 'Reads and verifies license plates automatically.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(345, 76, 'Explosive Detection System (EDS)', 'TO5OTLXO-88066', 'Kerluke, Douglas and Bauch', 'Advanced detection system for explosives in baggage.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(346, 76, 'Vehicle Barrier / Bollard', 'W4JMPGHT-20650', 'Kerluke, Douglas and Bauch', 'Stops unauthorized vehicle entry.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(347, 76, 'Drone Detection System', 'HM6QZPJN-93476', 'Kerluke, Douglas and Bauch', 'Identifies and alerts on unauthorized drone activity.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(348, 77, 'Metal Detection Archway with Counting System', 'VIDROS4Z-79328', 'Gusikowski Group', 'Metal detector with integrated people counter.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(349, 77, 'Sniffer Dog Kennel / Deployment Point', 'HCQBYZA8-65088', 'Gusikowski Group', 'Designated area for explosive detection dog teams.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(350, 77, 'Vehicle Barrier / Bollard', 'J4JJQF8A-16587', 'Gusikowski Group', 'Stops unauthorized vehicle entry.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(351, 77, 'Infrared Thermal Scanner', 'PVZ3OIQE-51050', 'Gusikowski Group', 'Detects elevated body temperature remotely.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(352, 78, 'TSA Approved Screening Table', 'BXNOOLDH-56673', 'Ward, Ebert and Reinger', 'Standard table for manual screening of carry-ons.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(353, 78, 'Infrared Thermal Scanner', 'SWWECJ7L-20434', 'Ward, Ebert and Reinger', 'Detects elevated body temperature remotely.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(354, 78, 'Sniffer Dog Kennel / Deployment Point', 'PNXMHKFW-20388', 'Ward, Ebert and Reinger', 'Designated area for explosive detection dog teams.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(355, 78, 'TSA Approved Screening Table', 'HB29HKLA-9531', 'Ward, Ebert and Reinger', 'Standard table for manual screening of carry-ons.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(356, 79, 'Full-Body Scanner', '9WUO1SF0-2350', 'Tremblay-Schneider', 'Scans passengers for concealed threats or contraband.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(357, 79, 'Drone Detection System', 'CEAXGK2T-46023', 'Tremblay-Schneider', 'Identifies and alerts on unauthorized drone activity.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(358, 79, 'Full-Body Scanner', 'PB2XAEES-34239', 'Tremblay-Schneider', 'Scans passengers for concealed threats or contraband.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(359, 79, 'Full-Body Scanner', 'WAICJND9-85618', 'Tremblay-Schneider', 'Scans passengers for concealed threats or contraband.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(360, 79, 'Under Vehicle Surveillance System', 'Y2FJHAVO-84389', 'Tremblay-Schneider', 'Inspects the underside of vehicles entering restricted zones.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(361, 80, 'X-ray Baggage Scanner', 'YEWIXK0Q-27909', 'Rutherford and Sons', 'Scans luggage and carry-on bags for prohibited items.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(362, 80, 'Sniffer Dog Kennel / Deployment Point', 'DWNYR2BJ-71861', 'Rutherford and Sons', 'Designated area for explosive detection dog teams.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(363, 80, 'Explosive Detection System (EDS)', 'F0J8SY4L-33000', 'Rutherford and Sons', 'Advanced detection system for explosives in baggage.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(364, 80, 'Biometric Access Terminal', 'N3IUF6O2-74281', 'Rutherford and Sons', 'Controls access using fingerprint or retina scan authentication.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(365, 81, 'Explosive Trace Detector', 'BOSHDKBN-56166', 'O\'Connell-Bernhard', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(366, 81, 'Emergency Communication System', 'WQTP6I1Z-18501', 'O\'Connell-Bernhard', 'Two-way communication system for emergency response.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(367, 81, 'Infrared Thermal Scanner', '5D2BL9FL-28092', 'O\'Connell-Bernhard', 'Detects elevated body temperature remotely.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(368, 81, 'Under Vehicle Surveillance System', 'V4QQXY5B-69285', 'O\'Connell-Bernhard', 'Inspects the underside of vehicles entering restricted zones.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(369, 82, 'TSA Approved Screening Table', 'LWYNYRSL-3345', 'O\'Hara, Durgan and Gusikowski', 'Standard table for manual screening of carry-ons.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(370, 82, 'Emergency Communication System', 'MANNQ13M-75288', 'O\'Hara, Durgan and Gusikowski', 'Two-way communication system for emergency response.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(371, 82, 'Digital Evidence Recording System', 'GZK44MEH-46175', 'O\'Hara, Durgan and Gusikowski', 'Captures and stores video/audio evidence securely.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(372, 82, 'Explosive Detection System (EDS)', 'DPNFE23N-26414', 'O\'Hara, Durgan and Gusikowski', 'Advanced detection system for explosives in baggage.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(373, 82, 'Explosive Trace Detector', 'XEBUJEZD-23988', 'O\'Hara, Durgan and Gusikowski', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(374, 82, 'Metal Detection Archway with Counting System', 'HH6JDRCU-58783', 'O\'Hara, Durgan and Gusikowski', 'Metal detector with integrated people counter.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(375, 83, 'Access Control Panel', '3GIAYBEX-67506', 'Glover-Collins', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(376, 83, 'Security Intercom', 'NNSYXENW-17668', 'Glover-Collins', 'Entry point audio/video communication device.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(377, 83, 'Infrared Thermal Scanner', '6BXZNXDE-69017', 'Glover-Collins', 'Detects elevated body temperature remotely.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(378, 83, 'Handheld Metal Detector', 'BJV2C30Z-88664', 'Glover-Collins', 'Used for secondary screening of passengers.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(379, 84, 'Emergency Communication System', 'O3DR2AUU-98770', 'Osinski-Ziemann', 'Two-way communication system for emergency response.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(380, 84, 'Radiation Detection Portal', 'TBLB4SUW-72371', 'Osinski-Ziemann', 'Detects radioactive materials passing through.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(381, 84, 'TSA Approved Screening Table', '9ASOUKXN-84163', 'Osinski-Ziemann', 'Standard table for manual screening of carry-ons.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(382, 84, 'Under Vehicle Surveillance System', 'DKZABMIC-24732', 'Osinski-Ziemann', 'Inspects the underside of vehicles entering restricted zones.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(383, 84, 'Explosive Trace Detector', 'H41MAL5B-20820', 'Osinski-Ziemann', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(384, 85, 'Facial Recognition Terminal', 'JM3NW7SA-54655', 'Connelly-Bruen', 'Automated identity verification using facial features.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(385, 85, 'Radiation Detection Portal', 'GNFQ6LEJ-19995', 'Connelly-Bruen', 'Detects radioactive materials passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(386, 85, 'Biometric Access Terminal', 'XCEVGM55-2206', 'Connelly-Bruen', 'Controls access using fingerprint or retina scan authentication.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(387, 86, 'Radiation Detection Portal', 'OPFQKQ2T-97481', 'Streich-O\'Hara', 'Detects radioactive materials passing through.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(388, 86, 'Explosive Detection System (EDS)', '2XKDKHU9-97617', 'Streich-O\'Hara', 'Advanced detection system for explosives in baggage.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(389, 86, 'Full-Body Scanner', 'LZVD7LSW-32671', 'Streich-O\'Hara', 'Scans passengers for concealed threats or contraband.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(390, 86, 'Metal Detection Archway with Counting System', 'F2KBJAIJ-46938', 'Streich-O\'Hara', 'Metal detector with integrated people counter.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(391, 86, 'Infrared Thermal Scanner', 'TC8HTHFP-78231', 'Streich-O\'Hara', 'Detects elevated body temperature remotely.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(392, 87, 'Handheld Metal Detector', 'NCPMOZ2S-55883', 'Raynor-O\'Reilly', 'Used for secondary screening of passengers.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(393, 87, 'Access Control Panel', 'RNTBIYXM-47494', 'Raynor-O\'Reilly', 'Manages and logs secure access to restricted areas.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(394, 87, 'Security Intercom', '6YKGI8CZ-32354', 'Raynor-O\'Reilly', 'Entry point audio/video communication device.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(395, 87, 'Vehicle Barrier / Bollard', 'VAHFNQLI-53979', 'Raynor-O\'Reilly', 'Stops unauthorized vehicle entry.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(396, 88, 'Biometric Access Terminal', 'NJDN1PVU-36045', 'Gibson-Kihn', 'Controls access using fingerprint or retina scan authentication.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(397, 88, 'Baggage Conveyor Scanner', 'OBNOGBDZ-58782', 'Gibson-Kihn', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(398, 88, 'Automated License Plate Recognition (ALPR)', 'RIIZUUNV-40326', 'Gibson-Kihn', 'Reads and verifies license plates automatically.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(399, 88, 'Infrared Thermal Scanner', 'H5GTXUNH-80519', 'Gibson-Kihn', 'Detects elevated body temperature remotely.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(401, 89, 'Walk-Through Metal Detector', '7YJRTVZL-35601', 'Herman, Gislason and Gerhold', 'Detects concealed metal objects on persons passing through.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(402, 89, 'Bullet-Resistant Guard Booth', 'NORZWZKE-96473', 'Herman, Gislason and Gerhold', 'Protected space for on-site security personnel.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(403, 90, 'Handheld Metal Detector', '3XYI5F5E-7795', 'Murphy, Gislason and Tremblay', 'Used for secondary screening of passengers.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(404, 90, 'Drone Detection System', 'HIKATLXU-21416', 'Murphy, Gislason and Tremblay', 'Identifies and alerts on unauthorized drone activity.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(405, 90, 'Access Control Panel', '9RPRDYPS-26557', 'Murphy, Gislason and Tremblay', 'Manages and logs secure access to restricted areas.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(406, 91, 'Emergency Communication System', 'WPHGC61G-69855', 'Schoen, Schinner and McGlynn', 'Two-way communication system for emergency response.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(407, 91, 'Facial Recognition Terminal', 'MZNOR7A1-74432', 'Schoen, Schinner and McGlynn', 'Automated identity verification using facial features.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(408, 91, 'Facial Recognition Terminal', 'Z78TJOO4-24207', 'Schoen, Schinner and McGlynn', 'Automated identity verification using facial features.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(409, 91, 'Surveillance Camera (CCTV)', 'KTNGLHP8-24102', 'Schoen, Schinner and McGlynn', 'Monitors activity within the facility perimeter.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(410, 91, 'Drone Detection System', 'ZQTIKBDD-74886', 'Schoen, Schinner and McGlynn', 'Identifies and alerts on unauthorized drone activity.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(411, 92, 'Perimeter Intrusion Detection System', 'SO6BZISH-43598', 'Blick-Herman', 'Alerts security on unauthorized perimeter breaches.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(412, 92, 'Walk-Through Metal Detector', '0VKBS7DM-32656', 'Blick-Herman', 'Detects concealed metal objects on persons passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(413, 92, 'Access Control Panel', 'IA1UBTUP-47842', 'Blick-Herman', 'Manages and logs secure access to restricted areas.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(414, 92, 'Access Control Panel', 'B8AWRGHA-81037', 'Blick-Herman', 'Manages and logs secure access to restricted areas.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(415, 92, 'Explosive Detection System (EDS)', '4M3KEEEL-82430', 'Blick-Herman', 'Advanced detection system for explosives in baggage.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(417, 93, 'Sniffer Dog Kennel / Deployment Point', 'WHAQPVE6-76640', 'Boehm-Lakin', 'Designated area for explosive detection dog teams.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(418, 93, 'Baggage Conveyor Scanner', 'LCLKTDIB-32386', 'Boehm-Lakin', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(419, 93, 'Digital Evidence Recording System', '70UR6LR3-80719', 'Boehm-Lakin', 'Captures and stores video/audio evidence securely.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(420, 93, 'Walk-Through Metal Detector', 'WZEPA43G-16319', 'Boehm-Lakin', 'Detects concealed metal objects on persons passing through.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(421, 93, 'Biometric Access Terminal', 'XBJ4YEKU-30006', 'Boehm-Lakin', 'Controls access using fingerprint or retina scan authentication.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(422, 94, 'Facial Recognition Terminal', 'ONZKMGD4-30970', 'Hills-Barton', 'Automated identity verification using facial features.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(423, 94, 'Access Control Panel', '5GUCHYZD-90301', 'Hills-Barton', 'Manages and logs secure access to restricted areas.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(424, 94, 'Baggage Conveyor Scanner', 'BWFZ2NBV-83670', 'Hills-Barton', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(425, 94, 'Sniffer Dog Kennel / Deployment Point', 'N9WGTYFW-86194', 'Hills-Barton', 'Designated area for explosive detection dog teams.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(426, 94, 'Walk-Through Metal Detector', 'YWTMQHTD-4618', 'Hills-Barton', 'Detects concealed metal objects on persons passing through.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(427, 94, 'Explosive Trace Detector', 'IULJ4K4Z-83014', 'Hills-Barton', 'Identifies trace amounts of explosives on surfaces or belongings.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(428, 95, 'Bullet-Resistant Guard Booth', '9BC9T6JO-32551', 'Becker PLC', 'Protected space for on-site security personnel.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(429, 95, 'Handheld Metal Detector', 'TLGXO3CR-91254', 'Becker PLC', 'Used for secondary screening of passengers.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(430, 95, 'Bullet-Resistant Guard Booth', 'BVYMMSHU-93288', 'Becker PLC', 'Protected space for on-site security personnel.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(431, 95, 'Baggage Conveyor Scanner', 'LJIFWOGO-48275', 'Becker PLC', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(432, 95, 'Security Intercom', 'D5DSAWV9-699', 'Becker PLC', 'Entry point audio/video communication device.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(433, 96, 'Biometric Access Terminal', 'JUDTIUQ1-504', 'Homenick-Tromp', 'Controls access using fingerprint or retina scan authentication.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(434, 96, 'Explosive Detection System (EDS)', 'KMFG33EH-61901', 'Homenick-Tromp', 'Advanced detection system for explosives in baggage.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(435, 96, 'Handheld Metal Detector', 'YQFHVRNT-36284', 'Homenick-Tromp', 'Used for secondary screening of passengers.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(436, 97, 'Metal Detection Archway with Counting System', 'ZHOU8QAA-86516', 'Bahringer-Farrell', 'Metal detector with integrated people counter.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(437, 97, 'Biometric Access Terminal', 'UCCLCKUT-56048', 'Bahringer-Farrell', 'Controls access using fingerprint or retina scan authentication.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(438, 97, 'X-ray Baggage Scanner', '3EWZSWJT-5743', 'Bahringer-Farrell', 'Scans luggage and carry-on bags for prohibited items.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(439, 98, 'Bullet-Resistant Guard Booth', 'MPTPMBVN-79171', 'Barrows Group', 'Protected space for on-site security personnel.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(440, 98, 'Infrared Thermal Scanner', 'PPGKILU7-91224', 'Barrows Group', 'Detects elevated body temperature remotely.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(441, 98, 'Access Control Panel', 'UXU0ITLN-57424', 'Barrows Group', 'Manages and logs secure access to restricted areas.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(442, 98, 'X-ray Baggage Scanner', 'GCM120ZV-35246', 'Barrows Group', 'Scans luggage and carry-on bags for prohibited items.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(443, 98, 'Facial Recognition Terminal', 'DVFCBMWX-94212', 'Barrows Group', 'Automated identity verification using facial features.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(444, 98, 'Baggage Conveyor Scanner', 'LA3EVGTZ-4342', 'Barrows Group', 'Integrated conveyor belt system with real-time X-ray imaging.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(445, 99, 'Handheld Metal Detector', 'NRRMV5YU-15792', 'Runolfsdottir-Frami', 'Used for secondary screening of passengers.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(446, 99, 'Security Intercom', 'TXU0U1O6-33596', 'Runolfsdottir-Frami', 'Entry point audio/video communication device.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(447, 99, 'Perimeter Intrusion Detection System', 'PULOVAXE-21949', 'Runolfsdottir-Frami', 'Alerts security on unauthorized perimeter breaches.', 'Active', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(448, 99, 'Security Intercom', 'Y5CVORA4-36651', 'Runolfsdottir-Frami', 'Entry point audio/video communication device.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(449, 100, 'Vehicle Barrier / Bollard', 'FUEOPSYY-28934', 'Feil Ltd', 'Stops unauthorized vehicle entry.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(450, 100, 'Biometric Access Terminal', 'YZTJ43LG-24725', 'Feil Ltd', 'Controls access using fingerprint or retina scan authentication.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(451, 100, 'Radiation Detection Portal', 'S5BBKQ7X-18547', 'Feil Ltd', 'Detects radioactive materials passing through.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(452, 100, 'Access Control Panel', 'SONAHQ1T-40544', 'Feil Ltd', 'Manages and logs secure access to restricted areas.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(453, 100, 'Under Vehicle Surveillance System', 'W9YPMP6K-28263', 'Feil Ltd', 'Inspects the underside of vehicles entering restricted zones.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(454, 100, 'TSA Approved Screening Table', 'IQY6YYLS-64176', 'Feil Ltd', 'Standard table for manual screening of carry-ons.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(455, 101, 'Automated License Plate Recognition (ALPR)', 'XTAQMMRW-67151', 'KKIA', 'Reads and verifies license plates automatically.', 'Inactive', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(456, 101, 'Emergency Communication System', '2QBOL5VU-3794', 'KKIA', 'Two-way communication system for emergency response.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(457, 101, 'Perimeter Intrusion Detection System', 'YAEN6D3H-85757', 'KKIA', 'Alerts security on unauthorized perimeter breaches.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(458, 101, 'Perimeter Intrusion Detection System', 'NQWTXY6N-56814', 'KKIA', 'Alerts security on unauthorized perimeter breaches.', 'Due for Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(459, 101, 'Biometric Access Terminal', 'R0DUZ90V-31230', 'KKIA', 'Controls access using fingerprint or retina scan authentication.', 'Decommissioned', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35'),
(460, 101, 'Vehicle Barrier / Bollard', 'Z0AH7FFP-44953', 'KKIA', 'Stops unauthorized vehicle entry.', 'Under Maintenance', NULL, '2025-06-03 05:26:35', '2025-06-03 05:26:35');

-- --------------------------------------------------------

--
-- Table structure for table `selected_checklist_questions`
--

CREATE TABLE `selected_checklist_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `audit_question_id` int(11) DEFAULT NULL,
  `audit_area_name` varchar(255) DEFAULT NULL,
  `quality_control_id` bigint(20) UNSIGNED NOT NULL,
  `question` text NOT NULL,
  `question_response` varchar(255) DEFAULT NULL,
  `finding_category` varchar(255) DEFAULT NULL,
  `date_quality_control` varchar(255) DEFAULT NULL,
  `finding_observation` text DEFAULT NULL,
  `action_taken` text DEFAULT NULL,
  `problem_cause` text DEFAULT NULL,
  `short_term_action` text DEFAULT NULL,
  `long_term_action` text DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `follow_up_date` date DEFAULT NULL,
  `proposed_follow_up_action` varchar(255) DEFAULT NULL,
  `date_of_closure` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `evidence_file` varchar(255) DEFAULT NULL,
  `modified_at` date DEFAULT NULL,
  `immediate_corrective_action` text DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `short_term_date` date DEFAULT NULL,
  `long_term_date` date DEFAULT NULL,
  `cap_file` varchar(255) DEFAULT NULL,
  `cap_status` varchar(255) DEFAULT NULL,
  `reason_for_rejection` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `selected_checklist_questions`
--

INSERT INTO `selected_checklist_questions` (`id`, `audit_question_id`, `audit_area_name`, `quality_control_id`, `question`, `question_response`, `finding_category`, `date_quality_control`, `finding_observation`, `action_taken`, `problem_cause`, `short_term_action`, `long_term_action`, `completion_date`, `follow_up_date`, `proposed_follow_up_action`, `date_of_closure`, `status`, `created_at`, `updated_at`, `evidence_file`, `modified_at`, `immediate_corrective_action`, `recommendations`, `reference`, `short_term_date`, `long_term_date`, `cap_file`, `cap_status`, `reason_for_rejection`) VALUES
(62, 1, 'Organisations and Operations - Airport Operator', 244, 'Does the Airport have an approved security programme?', 'Yes', 'Not Compliant(Serious)', '2025-05-28', 'non complaint with minor issues', 'The operator has agreed to develop a security programme', 'Absence of the security programme', 'The operator has agreed to develop a security programme', 'The operator has agreed to develop a security programme', '2025-07-19', '2025-05-28', 'The operator has agreed to develop a security programme', '2025-05-31', 'Open', '2025-05-21 10:21:54', '2025-07-11 18:27:26', 'qc_evidences/SIjrAnZUNPWC5h7JgoYedrGViDh7xMaZEggJY8KX.pdf', '2025-07-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(63, 2, 'Organisations and Operations - Airport Operator', 244, 'Are procedures established for the amendment of the ASP?', 'No', 'Not Compliant(Minor)', '2025-05-21', 'Absence of procedures', 'Procedures to be developed', 'Absence of procedures', 'Procedures to be developed by June, 2025', 'Procedures to be developed by June, 2025 ,and shall be reviewed  quarterly', '2025-07-16', '2025-05-27', 'Procedures to be developed by June, 2025', '2025-05-30', 'Open', '2025-05-21 10:21:54', '2025-05-22 13:07:42', NULL, '2025-07-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(65, 10, 'Procedures for Screening Persons and Cabin Baggage - Airport Operator', 244, 'Has the airport developed detailed procedures for?\n i.  the positioning of screening staff is effectively implemented as per the national requirements.\n ii. the positioning of screening staff is effectively implemented as per the national requirements.\n iii. the number of persons within the screening area is limited to a number that can be effectively controlled. In this regard, the airport security staff should be able to identify the rightful owner of the baggage that will be subject to an additional search.', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-17', NULL, NULL, NULL, 'Open', '2025-05-21 10:23:53', '2025-05-21 10:23:53', NULL, '2025-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(66, 46, 'Organisations and Operations - Airport Operator', 244, 'Has the airport ensured that a structured and robust record management system is established in order to record and monitor progress to ensure that corrective measures to resolve security concerns identified through quality control activities are implemented.', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-20', NULL, NULL, NULL, 'Open', '2025-05-22 11:03:35', '2025-05-22 11:03:35', NULL, '2025-07-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(67, 44, 'Landside - Airport Operator', 244, 'Does the ASC coordinate issues related to landside security as required by the national documentation?', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-12', NULL, NULL, NULL, 'Open', '2025-05-22 11:04:10', '2025-05-22 11:04:10', NULL, '2025-07-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(68, 26, 'Perimeter Control - Airport Operator', 244, 'Is there physical barrier erected around the airport?', 'Yes', 'Not Compliant(Serious)', '2025-05-24', 'Thuic djbkj  hcbsaj j bhcisaknjknjkbdsak', 'Thkjbijsk jkbvsjkljlk kjbcsnknk', 'vczxvsadafdsafsda', 'fdsfdsfds', 'fdsfdvcsvfsdasvsa', '2025-07-10', '2025-05-22', 'vdsafsd vdfsdfsdsafdfdsa', '2025-05-24', 'Open', '2025-05-23 07:49:21', '2025-07-12 17:37:19', NULL, '2025-07-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(69, 27, 'Perimeter Control - Airport Operator\n', 244, 'Is there perimeter fence adequately maintained?', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, 'fdsafdsafsdaf', NULL, NULL, '2025-07-08', '2025-07-12', NULL, '2025-07-12', 'Closed', '2025-05-23 07:49:21', '2025-07-12 18:46:45', NULL, '2025-07-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(70, 1, 'Organisations and Operations - Airport Operator', 328, 'Does the Airport have an approved security programme?', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-10', NULL, NULL, NULL, 'Open', '2025-05-23 12:22:50', '2025-05-23 12:22:50', NULL, '2025-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(71, 3, 'Organisations and Operations - Airport Operator', 244, 'Have copies of ASP been circulated?', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-11', NULL, NULL, NULL, 'Open', '2025-05-23 12:33:31', '2025-05-23 12:33:31', NULL, '2025-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, 33, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 328, 'a clear distinction in the airport ID passes to easily identify holders of ID passes who should be escorted at all times in the SRA.', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-12', NULL, NULL, NULL, 'Open', '2025-05-27 17:51:34', '2025-05-27 17:51:34', NULL, '2025-07-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(73, 1, 'Organisations and Operations - Airport Operator', 327, 'Does the Airport have an approved security programme?', 'Yes', 'Not Compliant(Serious)', '2025-06-12', 'mndvnhdjhgd', NULL, 'NA', NULL, NULL, '2025-07-12', '2025-06-19', NULL, '2025-06-12', 'Open', '2025-06-11 07:23:22', '2025-06-11 07:26:44', NULL, '2025-07-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, 2, 'Organisations and Operations - Airport Operator', 327, 'Are procedures established for the amendment of the ASP?', 'No', 'Not Compliant(Serious)', NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-09', NULL, NULL, NULL, 'Open', '2025-06-11 07:23:22', '2025-06-11 07:23:22', NULL, '2025-07-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(75, 17, 'Hold Baggage System (security) - Airport Operator', 327, 'Is hold baggage screening implemented?', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-13', NULL, NULL, NULL, 'Open', '2025-06-11 07:23:22', '2025-06-11 07:23:22', NULL, '2025-07-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 20, 'Hold Baggage System (security) - Airport Operator', 327, 'Are registers available?', 'No', 'Not Compliant(Serious)', '2025-05-21', 'fgdhgfhghjgj', 'N/A', 'N/A', 'N/A', 'N/A', '2025-07-16', '2025-07-29', 'Onsite', '2025-07-29', 'Open', '2025-06-11 07:23:22', '2025-07-29 11:46:00', NULL, '2025-07-11', 'N/A', 'hfgdhgdhgfd', 'hgfdhgfdsh', '2025-07-29', '2025-07-29', NULL, NULL, NULL),
(79, 15, 'Screening Points - Airport Operator', 330, 'Is there procedure for prohibited items?', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-14', NULL, NULL, NULL, 'Open', '2025-06-16 11:03:38', '2025-06-16 11:03:38', NULL, '2025-07-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 27, 'Perimeter Control - Airport Operator', 330, 'Is there perimeter fence adequately maintained?', 'No', 'Not Compliant(Serious)', '2025-05-21', NULL, NULL, NULL, NULL, NULL, '2025-07-16', NULL, NULL, NULL, 'Open', '2025-06-16 11:03:38', '2025-06-16 11:03:38', NULL, '2025-06-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(82, 1, 'Organisations and Operations - Airport Operator', 331, 'Does the Airport have an approved security programme?', 'Yes', 'Compliant', '2025-07-15', 'vdsfgdfsgsfdgsfdgdsfg', 'gdfsgfdsgfdgdfgfdg', 'gfdsgdsfhdfsh bdfsgfds', 'gfsfgxgsdgfsdhgsdfh', 'hgfdhgdhgdhhgdshg', '2025-07-15', '2025-07-14', 'hgfdhjhgjkgfjhdfjgh', '2025-07-15', 'Open', '2025-07-14 10:22:04', '2025-07-14 10:23:31', 'qc_evidences/tHhGy0ghARuLuJaIXqNNDQdArkS8sVIbR2t4AUyi.pdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(83, 4, 'Recruitment, Training and Certification - Airport Operator', 330, 'Does the airport conduct aviation security training on staff members?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Overdue', '2025-07-15 08:48:39', '2025-07-15 08:48:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(84, 41, 'Landside - Airport Operator', 330, 'Suspicious persons in the area.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Overdue', '2025-07-15 08:48:39', '2025-07-15 08:48:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(87, 17, 'Hold Baggage System (security) - Airport Operator', 332, 'Is hold baggage screening implemented?', 'No', 'Not Compliant(Minor)', '2025-07-29', 'During the inspection it was observed that all training awarenesses conducted by ZACL have not being approved as per national AVSEC requirements. Further there was no proof of payment available at the time of inspections for AVSEC trainings conducted from 7th to 10th February,2023, 14th to 17th February,2023 and 31st January to 3rd February,2023.', 'EWQERWQREW', 'FDSAFSDAFDS', 'VDSAFDAF', 'FWQEWQREW', '2025-07-23', '2025-07-24', 'Administrative', '2025-07-30', 'Open', '2025-07-25 06:58:58', '2025-08-29 08:00:45', 'qc_evidences/qnZFS1Aczu9oMn5R1PTCa7zJa21CG2UsxcaI1XYN.pdf', NULL, 'DADFASFcvdsafsdafgd', 'Ensure that all trainings are approved before being conducted. Ensure all trainings without approval from ZCAA are formalized within 60 days   failure to which they will be considered null and void', 'YYDGD', '2025-07-29', '2025-07-29', NULL, 'Accepted', NULL),
(88, 20, 'Hold Baggage System (security) - Airport Operator', 332, 'Are registers available?', 'Yes', 'Compliant', '2025-07-25', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', '2025-07-25', '2025-07-25', 'N/A', '2025-07-25', 'Closed', '2025-07-25 06:58:58', '2025-07-25 07:51:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(89, 2, 'Organisations and Operations - Airport Operator', 331, 'Are procedures established for the amendment of the ASP?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-25 08:48:12', '2025-07-25 08:48:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(90, 3, 'Organisations and Operations - Airport Operator', 331, 'Have copies of ASP been circulated?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-25 08:48:12', '2025-07-25 08:48:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(91, 46, 'Organisations and Operations - Airport Operator', 331, 'Has the airport ensured that a structured and robust record management system is established in order to record and monitor progress to ensure that corrective measures to resolve security concerns identified through quality control activities are implemented.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-25 08:48:12', '2025-07-25 08:48:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(92, 4, 'Recruitment, Training and Certification - Airport Operator', 331, 'Does the airport conduct aviation security training on staff members?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-25 08:48:12', '2025-07-25 08:48:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(93, 5, 'Recruitment, Training and Certification - Airport Operator', 331, 'Are staff members subjected to search when entering the airport restricted area?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-25 08:48:12', '2025-07-25 08:48:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(94, 6, 'Recruitment, Training and Certification - Airport Operator', 331, 'Are records of aviation security training kept for inspections purposes?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-25 08:48:12', '2025-07-25 08:48:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(95, 9, 'Procedures for Screening Persons and Cabin Baggage - Airport Operator', 332, 'What documents are passengers required to have when accessing restricted areas?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 09:32:05', '2025-07-31 09:32:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(96, 6, 'Recruitment, Training and Certification - Airport Operator', 332, 'Are records of aviation security training kept for inspections purposes?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 11:49:38', '2025-07-31 11:49:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(97, 44, 'Landside - Airport Operator', 332, 'Does the ASC coordinate issues related to landside security as required by the national documentation?', 'No', 'Not Compliant(Serious)', '2025-08-06', 'During the spot check inspection, it was found that a door leading to the apron was found open and unmanned. This presents a significant security risk, potentially allowing unauthorized access to security restricted areas of the airside.', 'Ensure all access doors leading to the apron are secured and monitored at all times. Consider installing an alarm or alert system for unmanned open doors.', 'During the spot check inspection, it was found that a door leading to the apron was found open and unmanned. This presents a significant security risk, potentially allowing unauthorized access to security restricted areas of the airside.', NULL, NULL, '2025-08-14', '2025-08-21', 'Administrative', '2025-08-20', 'Open', '2025-07-31 11:49:38', '2025-08-22 11:55:41', NULL, NULL, 'Ensure all access doors leading to the apron are secured and monitored at all times. Consider installing an alarm or alert system for unmanned open doors.', 'Ensure all access doors leading to the apron are secured and monitored at all times. Consider installing an alarm or alert system for unmanned open doors.', 'NCASP Chp six sec 6.2.3(a)(1), 6.7.15(b)(iii)', NULL, NULL, NULL, NULL, NULL),
(98, 50, 'Taxi runway - Airport Operator', 332, 'fdsagfdsagfdsgdfs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 11:59:06', '2025-07-31 11:59:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(99, 51, 'Taxi runway - Airport Operator', 332, 'cxdtrxvbvugfhj khghijb k,', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 18:34:18', '2025-07-31 18:34:18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(105, 26, 'Perimeter Control - Airport Operator', 334, 'Is there physical barrier erected around the airport?', 'Yes', 'Compliant', '2025-08-29', 'N/A', NULL, NULL, NULL, NULL, NULL, NULL, 'Not Applicable', NULL, 'Closed', '2025-08-26 10:24:27', '2025-08-29 08:36:06', NULL, NULL, 'N/A', 'N/A', 'ASDS23', NULL, NULL, NULL, NULL, NULL),
(106, 27, 'Perimeter Control - Airport Operator', 334, 'Is there perimeter fence adequately maintained?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-26 10:24:27', '2025-08-26 10:24:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(107, 33, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 334, 'a clear distinction in the airport ID passes to easily identify holders of ID passes who should be escorted at all times in the SRA.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-26 10:26:55', '2025-08-26 10:26:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(108, 35, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 334, 'Are emergency drills/contingency exercise conducted?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-26 10:26:55', '2025-08-26 10:26:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(109, 36, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 334, 'How regularly are emergency drills held?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-28 06:59:06', '2025-08-28 06:59:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(110, 34, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 334, 'Is there a contingency plan in place?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-28 06:59:06', '2025-08-28 06:59:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(111, 32, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 334, 'an effective and prompt mechanism to retrieve badges from persons who have ceased to require airport ID passes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-28 06:59:06', '2025-08-28 06:59:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(112, 31, 'Contingency Plans/ Emergency Preparedness and Response - Airport Operator', 334, 'Has the airport established procedures for the airport personnel ID pass system, in order to include, amongst other elements:', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-28 06:59:06', '2025-08-28 06:59:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(117, 50, 'Taxi runway - Airport Operator', 335, 'Has this question has been edited before ?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-03 12:36:22', '2025-10-03 12:36:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(118, 51, 'Taxi runway - Airport Operator', 335, 'This is just a sample question about the taxi runway', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-03 12:36:22', '2025-10-03 12:36:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(119, 17, 'Hold Baggage System (security) - Airport Operator', 335, 'Is hold baggage screening implemented?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-03 12:36:22', '2025-10-03 12:36:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(120, 23, 'Airside Access Control - Airport Operator', 335, 'Communication equipment in the Access control point.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-06 06:00:56', '2025-10-06 06:00:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('FJ3P2nZpjhyo20BIx8CEfqgPmpSmMeYJ8DdTXTbH', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibWpTVExxcEFkTXRSckFaOHpEYXI2MDRKY2J3UzVKR1JsMjhQMFBVcyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1OiJsb2dpbiI7YToyOntzOjI6ImlkIjtpOjE7czo4OiJyZW1lbWJlciI7YjowO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo0MjoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3R3by1mYWN0b3ItY2hhbGxlbmdlIjt9fQ==', 1759738640),
('xJWHy5Zvhc0ZkOR86hQHSxz4F7BbQUiZUR6xCB92', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoibnVsZmJpSldkNU9RUEpHZ3VCZjhkOW5ZSktqR0E0SFQ5UVpwbTR4VCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXVkaXQtcXVlc3Rpb25zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1OiJsb2dpbiI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1759739797);

-- --------------------------------------------------------

--
-- Table structure for table `trainings`
--

CREATE TABLE `trainings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trainings`
--

INSERT INTO `trainings` (`id`, `title`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Theory Exams', 'This is theory exams', '2025-06-11 12:34:07', '2025-06-11 12:34:07'),
(2, 'Screening Of Persons Using HHMD', NULL, '2025-06-11 12:36:32', '2025-06-11 12:36:32'),
(3, 'Hand Search', NULL, '2025-06-11 12:37:16', '2025-06-11 12:37:16'),
(4, 'Operating X-ray Machine', NULL, '2025-06-11 12:37:47', '2025-06-11 12:37:47'),
(5, 'Vehicle Searching', NULL, '2025-06-11 12:38:20', '2025-06-11 12:38:20'),
(6, 'Access Control', NULL, '2025-06-11 12:38:33', '2025-06-11 12:38:33');

-- --------------------------------------------------------

--
-- Table structure for table `training_user`
--

CREATE TABLE `training_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `training_id` bigint(20) UNSIGNED NOT NULL,
  `date_taken` date DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `training_user`
--

INSERT INTO `training_user` (`id`, `user_id`, `training_id`, `date_taken`, `score`, `type`, `created_at`, `updated_at`) VALUES
(1, 9, 1, NULL, 79, NULL, '2025-06-12 19:50:23', '2025-06-12 19:50:23'),
(2, 9, 6, NULL, 78, NULL, '2025-06-12 19:50:23', '2025-06-12 19:50:23'),
(3, 10, 1, NULL, 95, NULL, '2025-06-13 07:02:34', '2025-06-13 07:02:34'),
(4, 10, 2, NULL, 78, NULL, '2025-06-13 07:02:34', '2025-06-13 07:02:34'),
(5, 10, 3, NULL, 90, NULL, '2025-06-13 07:02:34', '2025-06-13 07:02:34'),
(6, 10, 4, NULL, 98, NULL, '2025-06-13 07:02:34', '2025-06-13 07:02:34'),
(7, 10, 5, NULL, 78, NULL, '2025-06-13 07:02:34', '2025-06-13 07:02:34'),
(8, 10, 6, NULL, 56, NULL, '2025-06-13 07:02:34', '2025-06-13 07:02:34'),
(9, 11, 1, NULL, 87, NULL, '2025-06-13 11:08:31', '2025-06-13 11:08:31'),
(10, 11, 4, NULL, 90, NULL, '2025-06-13 11:08:31', '2025-06-13 11:08:31'),
(11, 11, 6, NULL, 78, NULL, '2025-06-13 11:08:31', '2025-06-13 11:08:31'),
(14, 13, 1, NULL, 97, NULL, '2025-06-13 18:02:37', '2025-06-13 18:02:37'),
(15, 13, 5, NULL, 78, NULL, '2025-06-13 18:02:37', '2025-06-13 18:02:37'),
(16, 13, 6, NULL, 87, NULL, '2025-06-13 18:02:37', '2025-06-13 18:02:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `facility_id` int(11) DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `is_certified` varchar(15) DEFAULT NULL,
  `facility_name` varchar(255) DEFAULT NULL,
  `portrait` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `nrc` varchar(12) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `facility_id`, `user_type`, `name`, `email`, `gender`, `phone_number`, `is_certified`, `facility_name`, `portrait`, `signature`, `nrc`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`, `department_id`, `department_name`, `designation`) VALUES
(1, NULL, 'Inspector', 'Felix Mantini', 'felix.mantini@caa.co.zm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 11:59:54', '$2y$12$vWGei9kMNeKnRNCzS9HFze4F4PZz7Ynu7spbjluN7fRw4B3wJWiUi', 'eyJpdiI6Ikc4V1I2S1lScndCbTlRNXRGdFhBcVE9PSIsInZhbHVlIjoicE41KzhUSENwR05ybnc2OWJmZDMyQ1l2Smw1OUxPclBPUHM3ejU3aE1rZz0iLCJtYWMiOiJmMWZlMzMwN2YwZGViYjQxYWFkOTU5OTIwYWNiY2I5ZjE1MTVlYzYwYWUwMzM5YTI2YzJjZjQ4YTUzYmI1ZTA0IiwidGFnIjoiIn0=', 'eyJpdiI6InJGUVVyMjlVYS9uV3piRTNMVGk1MXc9PSIsInZhbHVlIjoiR1VmclVkZWdJN1RqMUE0bVR3cTIzNWJ1VTFRUW1nQ3NJZ25TWDY3d3VzZnVtZ1V6OW9SNllPOFg4aW9VZko2MnJFc2E3bmU3TndPNWlMc0NhK3VMQmU1NXBOeUFZUDBMMnhaNkpuMThWbE4zSkkweDM4UXNpY0xUVUZuUTdleEQ0NCszU25xUmVTRDJ6MEwwNHB2aUtGNngxejdBYTgyNGlQUHM0YzJsT2JtVHdkbjczalZIUWVvOGx4WmJOQ3ZReWw1eWF6V1hqTTdoMjdMYXRobGloZXlwdThtQ01peTlQUm1ST21yZFJmM2VQRjQ5Q0Y4ZVlveGpERXFKcyt2MXdlb3JGcEFUMnlGTzhRd1YrRndHQUE9PSIsIm1hYyI6ImMxZGU2ZTc0ZmIyZmMzNzlkOTM0NzVjOGE1MjVmZDY2MjI2MWExMWIyNTJiMjE3ZTQzMTAxYzkzODIwMmQ3NWMiLCJ0YWciOiIifQ==', NULL, NULL, '2025-04-10 05:54:25', '2025-10-06 06:14:32', 3, 'AVSEC', NULL),
(3, NULL, NULL, 'Kelvin Mwamba', 'kelvin.mwamba@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$12$dkT8TDMc9gHom/AsOitvoeU59.eYXcoTsfMLyQhIM4nhaJFGIUdna', NULL, NULL, NULL, NULL, '2025-05-14 10:36:42', '2025-05-14 10:36:42', NULL, NULL, NULL),
(4, NULL, NULL, 'Emmanuel Lombe', 'emmanuel.lombe@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$12$dkT8TDMc9gHom/AsOitvoeU59.eYXcoTsfMLyQhIM4nhaJFGIUdna', NULL, NULL, NULL, NULL, '2025-05-14 10:37:35', '2025-05-14 10:37:35', NULL, NULL, NULL),
(5, NULL, NULL, 'Peter Nyirongo', 'peter.nyirongo@caa.co.zm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$12$hYEpoyx6W7tuV83Sgt134egYvTVMBD.NoUowUJyT3GJNvyrOxLGcC', NULL, NULL, NULL, NULL, '2025-05-14 10:39:40', '2025-05-14 10:39:40', NULL, NULL, NULL),
(6, NULL, NULL, 'Test User', 'test@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-05-15 06:50:55', '$2y$12$HXAIY3DbifWgDarn.QsTS.zZEt/j6n0g.xHYJ31POq4l4MoKesAiK', NULL, NULL, NULL, 'XDxv9FBKRi', '2025-05-15 06:50:55', '2025-05-15 06:50:55', NULL, NULL, NULL),
(8, NULL, NULL, 'Chilufya Mulenga', 'chilufya.mulenga@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$12$uisDHXgoWYjNxhfV9lYpEuL5nelPuKw2cyJtspP9lp468vdOnQV82', NULL, NULL, NULL, NULL, '2025-05-17 11:46:47', '2025-05-17 11:46:47', NULL, NULL, NULL),
(9, 95, 'Screener', 'James BwalyaB', 'James.Bwalay@gmail.com', 'Male', '260976106192', 'Certified', 'Becker PLC', 'portraits/wpTFMubCV4sugNFMMVQsjqhDrezxRmONTNGz1Y8O.jpg', NULL, '204009/45/1', NULL, '$2y$12$.mdRr2lTF43iRbpXaSXRu./v9805chrdgXkXoVYow/wTdHx7kCTj2', NULL, NULL, NULL, NULL, '2025-06-12 19:50:23', '2025-08-13 05:11:54', NULL, NULL, NULL),
(10, 101, 'Supervisor', 'Charles Chanda', 'charles.chanda@gmail.com', 'Male', '09876353652', 'Certified', 'KKIA', 'portraits/Zmt5gvLFSk2aaJV0kymLYkSh9O3Ym5HSwB1IuJ41.jpg', NULL, '123455/11/1', NULL, '$2y$12$YmNpz.HAwApUAAS/RmBoSe6xC4wUQbIdyndHK1T05PUYufhDsinHO', NULL, NULL, NULL, NULL, '2025-06-13 07:02:34', '2025-06-14 16:00:34', NULL, NULL, NULL),
(11, 31, 'Supervisor', 'Emmanuel Lombe', 'emma@gmail.com', 'Male', '260976106192', 'Not Certified', 'Blanda Group', 'portraits/KsGUGnXo8Kfj9etQXCbLK0cB7aTvcWlGT4O47B1a.jpg', NULL, '204009/45/9', NULL, '$2y$12$BQ.iJ80TFEmh4O3otGE6AOsC8agzckwsk6NnH1UtwfkangJ8Nhili', NULL, NULL, NULL, NULL, '2025-06-13 11:08:31', '2025-06-14 15:59:15', NULL, NULL, NULL),
(13, 97, 'Screener', 'Mike ChilesheX', 'mike.chileshe@gmail.com', 'Female', '097761020322', 'Certified', 'Bahringer-Farrell', 'portraits/vmQE40O4iGDwirKJF5GdHWPVuJaVi1qxDDqenIoP.jpg', NULL, '204044/21/1', NULL, '$2y$12$v..iJBUmRARh4LGRPaE4YuOfhkYSHVT0Rbc94GaOIr0E0.29a/tX2', NULL, NULL, NULL, NULL, '2025-06-13 18:02:37', '2025-06-14 16:25:10', NULL, NULL, NULL),
(14, 102, 'Inspector', 'Nicholus Chinoi', 'Nicholus.Chinoi@caa.co.zm', 'Male', '0976563532', 'Certified', 'Zambia Civil Aviation Authority', 'portraits/f0hYYdHcbWW3ahjIfQDv2cxtMTGEElJUH0oXiPOr.jpg', NULL, '123455/11/1', NULL, '$2y$12$t0/BPd3qF.WTSOhp3OxvT.SWwMFa0atveztORa7M0/qBJcpt4xG4W', NULL, NULL, NULL, NULL, '2025-07-21 07:40:18', '2025-08-13 05:11:12', 3, 'AVSEC', NULL),
(15, 102, 'Inspector', 'Adesi Willombe', 'David.Chamanga@caa.co.zm', 'Male', '0976363625', 'Certified', 'Zambia Civil Aviation Authority', 'portraits/JtfnVBX0FvrhEj5wtnMyRiCy2MVfjPpFMc0OxeL4.jpg', NULL, '204044/21/1', NULL, '$2y$12$tlxwoi36z2zZNWXB9UeL/.WDIOpGNdhvDYCIG7BFVE5ZdSq2OVJx6', NULL, NULL, NULL, NULL, '2025-07-21 07:43:03', '2025-09-01 08:36:53', 3, 'AVSEC', 'AVSEC INSPETOR'),
(16, NULL, NULL, 'Felix Mutale', 'fkmantini2012@gmail.comX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$12$ljMdXx4dbpw1NmUSWzvuiOh8sHljdHUQw0jwjwwr5kw5sSTf/2ZM2', NULL, NULL, NULL, NULL, '2025-08-08 10:05:36', '2025-08-08 10:10:53', 3, 'AVSEC', NULL),
(20, NULL, NULL, 'David', 'umoyoprintex@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$12$2ybEUnaxDqMLcVf8sjYfbeqEXv105vnw3x4SB1wmN1tlnYSGoOSK6', NULL, NULL, NULL, NULL, '2025-08-08 10:37:34', '2025-08-08 10:37:34', NULL, NULL, NULL),
(22, NULL, NULL, 'Nelson Mwankabala', 'Nelson.Mwankabala@gmail.com', 'Male', '0997636363', NULL, NULL, 'portraits/n9Qef880bZB3hFOOU6Fbu5eR8LNQwJtlYDWfCapg.jpg', NULL, '341223/24/1', NULL, '$2y$12$fhI4QbchOpKh0tOzktnu4uEZBNRpUm8udy7LN.9.PiReEu9WmRhcy', NULL, NULL, NULL, NULL, '2025-08-25 12:44:08', '2025-08-25 12:44:08', 3, 'AVSEC', 'Senior AVSEC Officer'),
(23, NULL, NULL, 'James Phiri', 'James.Phiri@gmail.com', 'Male', '0976206195', NULL, NULL, 'portraits/wn2YFxB2kHhibQ0RmoHMFuABUT2wW38alPY15XQa.jpg', NULL, '341223/24/1', NULL, '$2y$12$Tpxi51rtyARQ.LlvSO5Dc.Mx6jkiAJ2d/knQw6MWe89sef1uS/pWa', NULL, NULL, NULL, NULL, '2025-08-25 12:55:47', '2025-08-26 08:29:44', 3, 'AVSEC', 'Senior AVSEC Officer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_area_categories`
--
ALTER TABLE `audit_area_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_questions`
--
ALTER TABLE `audit_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_questions_audit_area_category_id_foreign` (`audit_area_category_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `certifications`
--
ALTER TABLE `certifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_name_unique` (`name`);

--
-- Indexes for table `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `facilities_department_id_foreign` (`department_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `follow_ups`
--
ALTER TABLE `follow_ups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `follow_ups_user_id_foreign` (`user_id`),
  ADD KEY `follow_ups_selected_checklist_question_id_foreign` (`selected_checklist_question_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `maintenance_schedules_security_equipment_id_foreign` (`security_equipment_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `qualifications`
--
ALTER TABLE `qualifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `qualifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `quality_controls`
--
ALTER TABLE `quality_controls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quality_controls_facility_id_foreign` (`facility_id`),
  ADD KEY `quality_controls_department_id_foreign` (`department_id`);

--
-- Indexes for table `quality_control_alerts`
--
ALTER TABLE `quality_control_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quality_control_alerts_quality_control_id_foreign` (`quality_control_id`);

--
-- Indexes for table `quality_control_questions`
--
ALTER TABLE `quality_control_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quality_control_user`
--
ALTER TABLE `quality_control_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quality_control_user_user_id_foreign` (`user_id`),
  ADD KEY `quality_control_user_quality_control_id_foreign` (`quality_control_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `security_equipment`
--
ALTER TABLE `security_equipment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `security_equipment_facility_id_foreign` (`facility_id`);

--
-- Indexes for table `selected_checklist_questions`
--
ALTER TABLE `selected_checklist_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `selected_checklist_questions_quality_control_id_foreign` (`quality_control_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `trainings`
--
ALTER TABLE `trainings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_user`
--
ALTER TABLE `training_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `training_user_user_id_foreign` (`user_id`),
  ADD KEY `training_user_training_id_foreign` (`training_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_department_id_foreign` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_area_categories`
--
ALTER TABLE `audit_area_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `audit_questions`
--
ALTER TABLE `audit_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `certifications`
--
ALTER TABLE `certifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `facilities`
--
ALTER TABLE `facilities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `follow_ups`
--
ALTER TABLE `follow_ups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `qualifications`
--
ALTER TABLE `qualifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `quality_controls`
--
ALTER TABLE `quality_controls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=337;

--
-- AUTO_INCREMENT for table `quality_control_alerts`
--
ALTER TABLE `quality_control_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `quality_control_questions`
--
ALTER TABLE `quality_control_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quality_control_user`
--
ALTER TABLE `quality_control_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `security_equipment`
--
ALTER TABLE `security_equipment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=461;

--
-- AUTO_INCREMENT for table `selected_checklist_questions`
--
ALTER TABLE `selected_checklist_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `trainings`
--
ALTER TABLE `trainings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `training_user`
--
ALTER TABLE `training_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_questions`
--
ALTER TABLE `audit_questions`
  ADD CONSTRAINT `audit_questions_audit_area_category_id_foreign` FOREIGN KEY (`audit_area_category_id`) REFERENCES `audit_area_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `certifications`
--
ALTER TABLE `certifications`
  ADD CONSTRAINT `certifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `facilities`
--
ALTER TABLE `facilities`
  ADD CONSTRAINT `facilities_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `follow_ups`
--
ALTER TABLE `follow_ups`
  ADD CONSTRAINT `follow_ups_selected_checklist_question_id_foreign` FOREIGN KEY (`selected_checklist_question_id`) REFERENCES `selected_checklist_questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `follow_ups_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD CONSTRAINT `maintenance_schedules_security_equipment_id_foreign` FOREIGN KEY (`security_equipment_id`) REFERENCES `security_equipment` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `qualifications`
--
ALTER TABLE `qualifications`
  ADD CONSTRAINT `qualifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quality_controls`
--
ALTER TABLE `quality_controls`
  ADD CONSTRAINT `quality_controls_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `quality_controls_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quality_control_alerts`
--
ALTER TABLE `quality_control_alerts`
  ADD CONSTRAINT `quality_control_alerts_quality_control_id_foreign` FOREIGN KEY (`quality_control_id`) REFERENCES `quality_controls` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quality_control_user`
--
ALTER TABLE `quality_control_user`
  ADD CONSTRAINT `quality_control_user_quality_control_id_foreign` FOREIGN KEY (`quality_control_id`) REFERENCES `quality_controls` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quality_control_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `security_equipment`
--
ALTER TABLE `security_equipment`
  ADD CONSTRAINT `security_equipment_facility_id_foreign` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `selected_checklist_questions`
--
ALTER TABLE `selected_checklist_questions`
  ADD CONSTRAINT `selected_checklist_questions_quality_control_id_foreign` FOREIGN KEY (`quality_control_id`) REFERENCES `quality_controls` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `training_user`
--
ALTER TABLE `training_user`
  ADD CONSTRAINT `training_user_training_id_foreign` FOREIGN KEY (`training_id`) REFERENCES `trainings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `training_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
