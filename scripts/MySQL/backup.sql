-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 13, 2022 at 10:04 PM
-- Server version: 8.0.29-0ubuntu0.20.04.3
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fb`
--
CREATE DATABASE IF NOT EXISTS `fb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `fb`;

-- --------------------------------------------------------

--
-- Table structure for table `audit`
--

CREATE TABLE `audit` (
  `id` mediumint UNSIGNED NOT NULL,
  `blog_id` mediumint UNSIGNED NOT NULL,
  `changetype` enum('NEW','EDIT','DELETE') NOT NULL,
  `changetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `audit`
--

INSERT INTO `audit` (`id`, `blog_id`, `changetype`) VALUES
(1, 1, 'NEW'),
(2, 2, 'NEW'),
(3, 1, 'DELETE'),
(4, 1, 'EDIT');

-- --------------------------------------------------------

--
-- Table structure for table `blog`
--

CREATE TABLE `blog` (
  `id` mediumint UNSIGNED NOT NULL,
  `title` text,
  `content` text,
  `deleted` tinyint UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `blog`
--

INSERT INTO `blog` (`id`, `title`, `content`, `deleted`) VALUES
(1, 'blog1', 'myfirstblog', 0),
(2, 'blog2', 'mysecondblog', 0);

--
-- Triggers `blog`
--
DELIMITER $$
CREATE TRIGGER `blog_after_insert` AFTER INSERT ON `blog` FOR EACH ROW BEGIN
INSERT INTO audit (blog_id, changetype) VALUES (NEW.id, 'NEW');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `blog_after_update` AFTER UPDATE ON `blog` FOR EACH ROW BEGIN
IF NEW.deleted THEN
SET @changetype = 'DELETE';
ELSE
SET @changetype = 'EDIT';
END IF;
INSERT INTO audit (blog_id, changetype) VALUES (NEW.id,
@changetype);
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit`
--
ALTER TABLE `audit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `changetype` (`changetype`),
  ADD KEY `changetime` (`changetime`);

--
-- Indexes for table `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deleted` (`deleted`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit`
--
ALTER TABLE `audit`
  MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `blog`
--
ALTER TABLE `blog`
  MODIFY `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit`
--
ALTER TABLE `audit`
  ADD CONSTRAINT `FK_audit_blog_id` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
-- Database: `guest_house`
--
CREATE DATABASE IF NOT EXISTS `guest_house` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `guest_house`;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `hotelno` varchar(10) NOT NULL,
  `guestno` decimal(5,0) NOT NULL,
  `datefrom` date NOT NULL,
  `dateto` date DEFAULT NULL,
  `roomno` decimal(5,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`hotelno`, `guestno`, `datefrom`, `dateto`, `roomno`) VALUES
('ch01', '10006', '2004-04-21', NULL, '1101'),
('ch02', '10002', '2004-04-25', '2004-05-06', '801'),
('dc01', '10003', '2004-05-20', NULL, '1001'),
('dc01', '10007', '2006-05-13', '2011-05-15', '1001'),
('fb01', '10001', '2004-04-01', '2004-04-08', '501'),
('fb01', '10001', '2004-05-01', NULL, '701'),
('fb01', '10004', '2004-04-15', '2004-05-15', '601'),
('fb01', '10005', '2004-05-02', '2004-05-07', '501'),
('fb02', '10001', '2004-04-05', '2022-02-03', '1001'),
('fb02', '10003', '2004-04-05', '2010-04-04', '1001');

-- --------------------------------------------------------

--
-- Table structure for table `guest`
--

CREATE TABLE `guest` (
  `guestno` decimal(5,0) NOT NULL,
  `guestname` varchar(20) DEFAULT NULL,
  `guestaddress` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `guest`
--

INSERT INTO `guest` (`guestno`, `guestname`, `guestaddress`) VALUES
('10001', 'John Kay', '56 High St, London'),
('10002', 'Mike Ritchie', '18 Tain St, London'),
('10003', 'Mary Tregear', '5 Tarbot Rd, Aberdeen'),
('10004', 'Joe Keogh', '2 Fergus Dr, Aberdeen'),
('10005', 'Carol Farrel', '6 Achray St, Glasgow'),
('10006', 'Tina Murphy', '63 Well St, Glasgow'),
('10007', 'Tony Shaw', '12 Park Pl, Glasgow');

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `hotelno` varchar(10) NOT NULL,
  `hotelname` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`hotelno`, `hotelname`, `city`) VALUES
('ch01', 'Omni Shoreham', 'London'),
('ch02', 'Phoenix Park', 'London'),
('dc01', 'Latham', 'Berlin'),
('fb01', 'Grosvenor', 'London'),
('fb02', 'Watergate', 'Paris');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `roomno` decimal(5,0) NOT NULL,
  `hotelno` varchar(10) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`roomno`, `hotelno`, `type`, `price`) VALUES
('501', 'fb01', 'single', '19.00'),
('601', 'fb01', 'double', '29.00'),
('701', 'ch02', 'single', '10.00'),
('701', 'fb01', 'family', '39.00'),
('801', 'ch02', 'double', '15.00'),
('901', 'dc01', 'single', '18.00'),
('1001', 'ch01', 'single', '29.99'),
('1001', 'dc01', 'double', '30.00'),
('1001', 'fb02', 'single', '58.00'),
('1101', 'ch01', 'family', '59.99'),
('1101', 'dc01', 'family', '35.00'),
('1101', 'fb02', 'double', '86.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`hotelno`,`guestno`,`datefrom`),
  ADD KEY `roomno` (`roomno`,`hotelno`),
  ADD KEY `guestno` (`guestno`);

--
-- Indexes for table `guest`
--
ALTER TABLE `guest`
  ADD PRIMARY KEY (`guestno`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`hotelno`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`roomno`,`hotelno`),
  ADD KEY `hotelno` (`hotelno`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`roomno`,`hotelno`) REFERENCES `room` (`roomno`, `hotelno`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`guestno`) REFERENCES `guest` (`guestno`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`hotelno`) REFERENCES `hotel` (`hotelno`);
--
-- Database: `p200051_saad`
--
CREATE DATABASE IF NOT EXISTS `p200051_saad` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `p200051_saad`;

-- --------------------------------------------------------

--
-- Table structure for table `ATTRACTION`
--

CREATE TABLE `ATTRACTION` (
  `ATTRACT_NO` decimal(10,0) NOT NULL,
  `ATTRACT_NAME` varchar(35) DEFAULT NULL,
  `ATTRACT_AGE` decimal(3,0) NOT NULL DEFAULT '0',
  `ATTRACT_CAPACITY` decimal(3,0) NOT NULL,
  `PARK_CODE` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ATTRACTION`
--

INSERT INTO `ATTRACTION` (`ATTRACT_NO`, `ATTRACT_NAME`, `ATTRACT_AGE`, `ATTRACT_CAPACITY`, `PARK_CODE`) VALUES
('10034', 'ThunderCoaster', '11', '34', 'FR1001'),
('10056', 'SpinningTeacups', '4', '62', 'FR1001'),
('10067', 'FlightToStars', '11', '24', 'FR1001'),
('10078', 'Ant-Trap', '23', '30', 'FR1001'),
('10082', NULL, '10', '40', 'ZA1342'),
('10098', 'Carnival', '3', '120', 'FR1001'),
('20056', '3D-Lego_Show', '3', '200', 'UK3452'),
('30011', 'BlackHole2', '12', '34', 'UK3452'),
('30012', 'Pirates', '10', '42', 'UK3452'),
('30044', 'UnderSeaWord', '4', '80', 'UK3452'),
('98764', 'GoldRush', '5', '80', 'ZA1342');

-- --------------------------------------------------------

--
-- Table structure for table `EMPLOYEE`
--

CREATE TABLE `EMPLOYEE` (
  `EMP_NUM` decimal(4,0) NOT NULL,
  `EMP_TITLE` varchar(4) DEFAULT NULL,
  `EMP_LNAME` varchar(15) NOT NULL,
  `EMP_FNAME` varchar(15) NOT NULL,
  `EMP_DOB` date NOT NULL,
  `EMP_HIRE_DATE` date DEFAULT NULL,
  `EMP_AREA_CODE` varchar(4) NOT NULL,
  `EMP_PHONE` varchar(12) NOT NULL,
  `PARK_CODE` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `EMPLOYEE`
--

INSERT INTO `EMPLOYEE` (`EMP_NUM`, `EMP_TITLE`, `EMP_LNAME`, `EMP_FNAME`, `EMP_DOB`, `EMP_HIRE_DATE`, `EMP_AREA_CODE`, `EMP_PHONE`, `PARK_CODE`) VALUES
('100', 'Ms', 'Calderdale', 'Emma', '1972-06-15', '1992-03-15', '0181', '324-9652', 'FR1001'),
('101', 'Ms', 'Ricardo', 'Marshel', '1978-03-19', '1996-04-25', '0181', '324-4472', 'UK3452'),
('102', 'Mr', 'Arshad', 'Arif', '1969-11-14', '1990-12-20', '7253', '675-8993', 'FR1001'),
('103', 'Ms', 'Roberts', 'Anne', '1974-10-16', '1994-08-16', '0181', '898-3456', 'UK3452'),
('104', 'Mr', 'Denver', 'Enrica', '1980-11-08', '2001-10-20', '7253', '504-4434', 'ZA1342'),
('105', 'Ms', 'Namowa', 'Mirrelle', '1990-03-14', '2006-11-08', '0181', '890-3243', 'FR1001'),
('106', 'Mrs', 'Smith', 'Gemma', '1968-02-12', '1989-01-05', '0181', '324-7845', 'ZA1342');

-- --------------------------------------------------------

--
-- Stand-in structure for view `EMP_DETAILS`
-- (See below for the actual view)
--
CREATE TABLE `EMP_DETAILS` (
`EMP_DOB` date
,`EMP_FNAME` varchar(15)
,`EMP_HIRE_DATE` date
,`EMP_LNAME` varchar(15)
,`EMP_NUM` decimal(4,0)
,`PARK_CODE` varchar(10)
,`PARK_NAME` varchar(35)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `EMP_WORKED`
-- (See below for the actual view)
--
CREATE TABLE `EMP_WORKED` (
`ATTRACT_NO` decimal(10,0)
,`DATE_WORKED` date
,`EMP_FNAME` varchar(15)
,`EMP_LNAME` varchar(15)
);

-- --------------------------------------------------------

--
-- Table structure for table `HOURS`
--

CREATE TABLE `HOURS` (
  `EMP_NUM` decimal(4,0) NOT NULL,
  `ATTRACT_NO` decimal(10,0) NOT NULL,
  `HOURS_PER_ATTRACT` decimal(2,0) NOT NULL,
  `HOUR_RATE` decimal(4,2) NOT NULL,
  `DATE_WORKED` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `HOURS`
--

INSERT INTO `HOURS` (`EMP_NUM`, `ATTRACT_NO`, `HOURS_PER_ATTRACT`, `HOUR_RATE`, `DATE_WORKED`) VALUES
('100', '10034', '6', '6.50', '2007-05-18'),
('100', '10034', '6', '6.50', '2007-05-20'),
('101', '10034', '6', '6.50', '2007-05-18'),
('102', '30012', '3', '5.99', '2007-05-23'),
('102', '30044', '6', '5.99', '2007-05-21'),
('102', '30044', '3', '5.99', '2007-05-22'),
('104', '30011', '6', '7.20', '2007-05-21'),
('104', '30012', '6', '7.20', '2007-05-22'),
('105', '10078', '3', '8.50', '2007-05-18'),
('105', '10098', '3', '8.50', '2007-05-18'),
('105', '10098', '6', '8.50', '2007-05-19');

-- --------------------------------------------------------

--
-- Table structure for table `SALES`
--

CREATE TABLE `SALES` (
  `TRANSACTION_NO` decimal(10,0) NOT NULL,
  `PARK_CODE` varchar(10) DEFAULT NULL,
  `SALE_DATE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `SALES`
--

INSERT INTO `SALES` (`TRANSACTION_NO`, `PARK_CODE`, `SALE_DATE`) VALUES
('12781', 'FR1001', '2007-05-18'),
('12782', 'FR1001', '2007-05-18'),
('12783', 'FR1001', '2007-05-18'),
('12784', 'FR1001', '2007-05-18'),
('12785', 'FR1001', '2007-05-18'),
('12786', 'FR1001', '2007-05-18'),
('34534', 'UK3452', '2007-05-18'),
('34535', 'UK3452', '2007-05-18'),
('34536', 'UK3452', '2007-05-18'),
('34537', 'UK3452', '2007-05-18'),
('34538', 'UK3452', '2007-05-18'),
('34539', 'UK3452', '2007-05-18'),
('34540', 'UK3452', '2007-05-18'),
('34541', 'UK3452', '2007-05-18'),
('67589', 'ZA1342', '2007-05-18'),
('67590', 'ZA1342', '2007-05-18'),
('67591', 'ZA1342', '2007-05-18'),
('67592', 'ZA1342', '2007-05-18'),
('67593', 'ZA1342', '2007-05-18');

-- --------------------------------------------------------

--
-- Table structure for table `SALES_LINE`
--

CREATE TABLE `SALES_LINE` (
  `TRANSACTION_NO` decimal(10,0) NOT NULL,
  `LINE_NO` decimal(2,0) NOT NULL,
  `TICKET_NO` decimal(10,0) NOT NULL,
  `LINE_QTY` decimal(4,0) NOT NULL DEFAULT '0',
  `LINE_PRICE` decimal(9,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `SALES_LINE`
--

INSERT INTO `SALES_LINE` (`TRANSACTION_NO`, `LINE_NO`, `TICKET_NO`, `LINE_QTY`, `LINE_PRICE`) VALUES
('12781', '1', '13002', '2', '69.98'),
('12781', '2', '13001', '1', '14.99'),
('12782', '1', '13002', '2', '69.98'),
('12783', '1', '13003', '2', '41.98'),
('12784', '2', '13001', '1', '14.99'),
('12785', '1', '13001', '1', '14.99'),
('12785', '2', '13002', '1', '34.99'),
('12785', '3', '13002', '4', '139.96'),
('34534', '1', '88568', '4', '168.40'),
('34534', '2', '88567', '1', '22.50'),
('34534', '3', '89720', '2', '21.98'),
('34535', '1', '88568', '2', '84.20'),
('34536', '1', '89720', '2', '21.98'),
('34537', '1', '88568', '2', '84.20'),
('34537', '2', '88567', '1', '22.50'),
('34538', '1', '89720', '2', '21.98'),
('34539', '1', '89720', '2', '21.98'),
('34539', '2', '88568', '2', '84.20'),
('34540', '1', '88568', '4', '168.40'),
('34540', '2', '88567', '1', '22.50'),
('34540', '3', '89720', '2', '21.98'),
('34541', '1', '88568', '2', '84.20'),
('67589', '1', '67833', '2', '57.34'),
('67589', '2', '67832', '2', '37.12'),
('67590', '1', '67833', '2', '57.34'),
('67590', '2', '67832', '2', '37.12'),
('67591', '1', '67832', '1', '18.56'),
('67591', '2', '67855', '1', '12.12'),
('67592', '1', '67833', '4', '114.68'),
('67593', '1', '67833', '2', '57.34'),
('67593', '2', '67832', '2', '37.12');

-- --------------------------------------------------------

--
-- Table structure for table `THEMEPARK`
--

CREATE TABLE `THEMEPARK` (
  `PARK_CODE` varchar(10) NOT NULL,
  `PARK_NAME` varchar(35) NOT NULL,
  `PARK_CITY` varchar(50) DEFAULT NULL,
  `PARK_COUNTRY` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `THEMEPARK`
--

INSERT INTO `THEMEPARK` (`PARK_CODE`, `PARK_NAME`, `PARK_CITY`, `PARK_COUNTRY`) VALUES
('FR1001', 'FairyLand', 'PARIS', 'FR'),
('NL1202', 'Efling', 'NOORD', 'NL'),
('SP4533', 'AdventurePort', 'BARCELONA', 'SP'),
('SW2323', 'Labyrinthe', 'LAUSANNE', 'SW'),
('T1000', 'DUMMY1', 'PWR', 'PK'),
('T1001', 'DUMMY2', 'PWR', 'PK'),
('UK2622', 'MiniLand', 'WINDSOR', 'UK'),
('UK3452', 'PleasureLand', 'STOKE', 'UK'),
('ZA1342', 'GoldTown', 'JOHANNESBURG', 'ZA');

-- --------------------------------------------------------

--
-- Table structure for table `TICKET`
--

CREATE TABLE `TICKET` (
  `TICKET_NO` decimal(10,0) NOT NULL,
  `TICKET_PRICE` decimal(4,2) NOT NULL DEFAULT '0.00',
  `TICKET_TYPE` varchar(10) DEFAULT NULL,
  `PARK_CODE` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `TICKET`
--

INSERT INTO `TICKET` (`TICKET_NO`, `TICKET_PRICE`, `TICKET_TYPE`, `PARK_CODE`) VALUES
('11001', '24.99', 'Adult', 'SP4533'),
('11002', '14.99', 'Child', 'SP4533'),
('11003', '10.99', 'Senior', 'SP4533'),
('13001', '18.99', 'Child', 'FR1001'),
('13002', '34.99', 'Adult', 'FR1001'),
('13003', '20.99', 'Senior', 'FR1001'),
('67832', '18.56', 'Child', 'ZA1342'),
('67833', '28.67', 'Adult', 'ZA1342'),
('67855', '12.12', 'Senior', 'ZA1342'),
('88567', '22.50', 'Child', 'UK3452'),
('88568', '42.10', 'Adult', 'UK3452'),
('89720', '10.99', 'Senior', 'UK3452');

-- --------------------------------------------------------

--
-- Stand-in structure for view `TICKET_SALES`
-- (See below for the actual view)
--
CREATE TABLE `TICKET_SALES` (
`AVG(LINE_PRICE)` decimal(13,6)
,`MAX(LINE_PRICE)` decimal(9,2)
,`MIN(LINE_PRICE)` decimal(9,2)
,`PARK_NAME` varchar(35)
);

-- --------------------------------------------------------

--
-- Structure for view `EMP_DETAILS`
--
DROP TABLE IF EXISTS `EMP_DETAILS`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `EMP_DETAILS`  AS  select `E`.`EMP_NUM` AS `EMP_NUM`,`E`.`PARK_CODE` AS `PARK_CODE`,`TP`.`PARK_NAME` AS `PARK_NAME`,`E`.`EMP_LNAME` AS `EMP_LNAME`,`E`.`EMP_FNAME` AS `EMP_FNAME`,`E`.`EMP_HIRE_DATE` AS `EMP_HIRE_DATE`,`E`.`EMP_DOB` AS `EMP_DOB` from (`EMPLOYEE` `E` join `THEMEPARK` `TP` on((`E`.`PARK_CODE` = `TP`.`PARK_CODE`))) ;

-- --------------------------------------------------------

--
-- Structure for view `EMP_WORKED`
--
DROP TABLE IF EXISTS `EMP_WORKED`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `EMP_WORKED`  AS  select `E`.`EMP_LNAME` AS `EMP_LNAME`,`E`.`EMP_FNAME` AS `EMP_FNAME`,`H`.`ATTRACT_NO` AS `ATTRACT_NO`,`H`.`DATE_WORKED` AS `DATE_WORKED` from (`EMPLOYEE` `E` join `HOURS` `H` on((`E`.`EMP_NUM` = `H`.`EMP_NUM`))) ;

-- --------------------------------------------------------

--
-- Structure for view `TICKET_SALES`
--
DROP TABLE IF EXISTS `TICKET_SALES`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `TICKET_SALES`  AS  select `T`.`PARK_NAME` AS `PARK_NAME`,min(`SL`.`LINE_PRICE`) AS `MIN(LINE_PRICE)`,max(`SL`.`LINE_PRICE`) AS `MAX(LINE_PRICE)`,avg(`SL`.`LINE_PRICE`) AS `AVG(LINE_PRICE)` from ((`THEMEPARK` `T` join `SALES` `S` on((`T`.`PARK_CODE` = `S`.`PARK_CODE`))) join `SALES_LINE` `SL` on((`S`.`TRANSACTION_NO` = `SL`.`TRANSACTION_NO`))) group by `T`.`PARK_NAME` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ATTRACTION`
--
ALTER TABLE `ATTRACTION`
  ADD PRIMARY KEY (`ATTRACT_NO`),
  ADD KEY `PARK_CODE` (`PARK_CODE`);

--
-- Indexes for table `EMPLOYEE`
--
ALTER TABLE `EMPLOYEE`
  ADD PRIMARY KEY (`EMP_NUM`),
  ADD KEY `PARK_CODE` (`PARK_CODE`),
  ADD KEY `EMP_LNAME_INDEX` (`EMP_LNAME`(8));

--
-- Indexes for table `HOURS`
--
ALTER TABLE `HOURS`
  ADD PRIMARY KEY (`EMP_NUM`,`ATTRACT_NO`,`DATE_WORKED`),
  ADD KEY `EMP_NUM` (`EMP_NUM`),
  ADD KEY `ATTRACT_NO` (`ATTRACT_NO`);

--
-- Indexes for table `SALES`
--
ALTER TABLE `SALES`
  ADD PRIMARY KEY (`TRANSACTION_NO`),
  ADD KEY `PARK_CODE` (`PARK_CODE`);

--
-- Indexes for table `SALES_LINE`
--
ALTER TABLE `SALES_LINE`
  ADD PRIMARY KEY (`TRANSACTION_NO`,`LINE_NO`),
  ADD KEY `TRANSACTION_NO` (`TRANSACTION_NO`),
  ADD KEY `TICKET_NO` (`TICKET_NO`);

--
-- Indexes for table `THEMEPARK`
--
ALTER TABLE `THEMEPARK`
  ADD PRIMARY KEY (`PARK_CODE`);

--
-- Indexes for table `TICKET`
--
ALTER TABLE `TICKET`
  ADD PRIMARY KEY (`TICKET_NO`),
  ADD KEY `PARK_CODE` (`PARK_CODE`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ATTRACTION`
--
ALTER TABLE `ATTRACTION`
  ADD CONSTRAINT `FK_ATTRACT_PARK` FOREIGN KEY (`PARK_CODE`) REFERENCES `THEMEPARK` (`PARK_CODE`);

--
-- Constraints for table `EMPLOYEE`
--
ALTER TABLE `EMPLOYEE`
  ADD CONSTRAINT `FK_EMP_PARK` FOREIGN KEY (`PARK_CODE`) REFERENCES `THEMEPARK` (`PARK_CODE`);

--
-- Constraints for table `HOURS`
--
ALTER TABLE `HOURS`
  ADD CONSTRAINT `FK_HOURS_ATTRACT` FOREIGN KEY (`ATTRACT_NO`) REFERENCES `ATTRACTION` (`ATTRACT_NO`),
  ADD CONSTRAINT `FK_HOURS_EMP` FOREIGN KEY (`EMP_NUM`) REFERENCES `EMPLOYEE` (`EMP_NUM`);

--
-- Constraints for table `SALES`
--
ALTER TABLE `SALES`
  ADD CONSTRAINT `FK_SALES_PARK` FOREIGN KEY (`PARK_CODE`) REFERENCES `THEMEPARK` (`PARK_CODE`);

--
-- Constraints for table `SALES_LINE`
--
ALTER TABLE `SALES_LINE`
  ADD CONSTRAINT `FK_SALES_LINE_SALES` FOREIGN KEY (`TRANSACTION_NO`) REFERENCES `SALES` (`TRANSACTION_NO`),
  ADD CONSTRAINT `FK_SALES_LINE_TICKET` FOREIGN KEY (`TICKET_NO`) REFERENCES `TICKET` (`TICKET_NO`);

--
-- Constraints for table `TICKET`
--
ALTER TABLE `TICKET`
  ADD CONSTRAINT `FK_TICKET_PARK` FOREIGN KEY (`PARK_CODE`) REFERENCES `THEMEPARK` (`PARK_CODE`);
--
-- Database: `person`
--
CREATE DATABASE IF NOT EXISTS `person` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `person`;

-- --------------------------------------------------------

--
-- Table structure for table `summary`
--

CREATE TABLE `summary` (
  `id` int NOT NULL,
  `total_users` int NOT NULL,
  `Yahoo` int NOT NULL,
  `Hotmail` int NOT NULL,
  `Gmail` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `summary`
--

INSERT INTO `summary` (`id`, `total_users`, `Yahoo`, `Hotmail`, `Gmail`) VALUES
(1, 1, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(35) NOT NULL,
  `password` varchar(35) NOT NULL,
  `email` varchar(35) NOT NULL,
  `salary` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `salary`) VALUES
(1, 'abc123', 'def321', 'abc123@yahoo.com', 30000),
(2, 'xyz789', 'asd123', 'xyz789@gmail.com', 50000),
(6, 'asdf4', 'def321', 'asdf4@gmail.com', 40000);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `deleting_user` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    update summary
    set total_users = total_users - 1;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `inserting_user` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    update summary
    set total_users = total_users + 1;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `summary`
--
ALTER TABLE `summary`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int UNSIGNED NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Dumping data for table `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'server', 'hello', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"db_select[]\":[\"fb\",\"guest_house\",\"p200051_saad\",\"person\",\"phpmyadmin\",\"sales_co\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@SERVER@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Structure of table @TABLE@\",\"latex_structure_continued_caption\":\"Structure of table @TABLE@ (continued)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Content of table @TABLE@\",\"latex_data_continued_caption\":\"Content of table @TABLE@ (continued)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"yaml_structure_or_data\":\"data\",\"\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"csv_columns\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `config_data`) VALUES
('root', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `sales_co`
--
CREATE DATABASE IF NOT EXISTS `sales_co` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `sales_co`;

-- --------------------------------------------------------

--
-- Table structure for table `CUSTOMER`
--

CREATE TABLE `CUSTOMER` (
  `CUS_CODE` float NOT NULL,
  `CUS_LNAME` varchar(15) NOT NULL,
  `CUS_FNAME` varchar(15) NOT NULL,
  `CUS_INITIAL` char(1) DEFAULT NULL,
  `CUS_AREACODE` char(3) NOT NULL DEFAULT '615',
  `CUS_PHONE` char(8) NOT NULL,
  `CUS_BALANCE` float DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `CUSTOMER`
--

INSERT INTO `CUSTOMER` (`CUS_CODE`, `CUS_LNAME`, `CUS_FNAME`, `CUS_INITIAL`, `CUS_AREACODE`, `CUS_PHONE`, `CUS_BALANCE`) VALUES
(10010, 'Ramas', 'Alfred', 'A', '615', '844-2573', 0),
(10011, 'Dunne', 'Leona', 'K', '713', '894-1238', 0),
(10012, 'Smith', 'Kathy', 'W', '615', '894-2285', 345.86),
(10013, 'Olowski', 'Paul', 'F', '615', '894-2180', 536.75),
(10014, 'Orlando', 'Myron', NULL, '615', '222-1672', 0),
(10015, 'O\'Brian', 'Amy', 'B', '713', '442-3381', 0),
(10016, 'Brown', 'James', 'G', '615', '297-1228', 221.19),
(10017, 'Williams', 'George', NULL, '615', '290-2556', 768.93),
(10018, 'Farriss', 'Anne', 'G', '713', '382-7185', 216.55),
(10019, 'Smith', 'Olette', 'K', '615', '297-3809', 0);

-- --------------------------------------------------------

--
-- Table structure for table `INVOICE`
--

CREATE TABLE `INVOICE` (
  `INV_NUMBER` float NOT NULL,
  `CUS_CODE` float NOT NULL,
  `INV_DATE` date NOT NULL,
  `INV_SUBTOTAL` float DEFAULT NULL,
  `INV_TAX` float DEFAULT NULL,
  `INV_TOTAL` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `INVOICE`
--

INSERT INTO `INVOICE` (`INV_NUMBER`, `CUS_CODE`, `INV_DATE`, `INV_SUBTOTAL`, `INV_TAX`, `INV_TOTAL`) VALUES
(1001, 10014, '2004-01-16', 24.9, 1.99, 26.89),
(1002, 10011, '2004-01-16', 9.98, 0.8, 10.78),
(1003, 10012, '2004-01-16', 153.85, 12.31, 166.16),
(1004, 10011, '2004-01-17', 34.97, 2.8, 37.77),
(1005, 10018, '2004-01-17', 70.44, 5.64, 76.08),
(1006, 10014, '2004-01-17', 397.83, 31.83, 429.66),
(1007, 10015, '2004-01-17', 34.97, 2.8, 37.77),
(1008, 10011, '2004-01-17', 399.15, 31.93, 431.08);

-- --------------------------------------------------------

--
-- Table structure for table `LINE`
--

CREATE TABLE `LINE` (
  `INV_NUMBER` float NOT NULL,
  `LINE_NUMBER` float NOT NULL,
  `P_CODE` varchar(10) NOT NULL,
  `LINE_UNITS` float NOT NULL DEFAULT '0',
  `LINE_PRICE` float NOT NULL DEFAULT '0',
  `LINE_TOTAL` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `LINE`
--

INSERT INTO `LINE` (`INV_NUMBER`, `LINE_NUMBER`, `P_CODE`, `LINE_UNITS`, `LINE_PRICE`, `LINE_TOTAL`) VALUES
(1001, 1, '13-Q2/P2', 1, 14.99, 14.99),
(1001, 2, '23109-HB', 1, 9.95, 9.95),
(1002, 1, '54778-2T', 2, 4.99, 9.98),
(1003, 1, '2238/QPD', 1, 38.95, 38.95),
(1003, 2, '1546-QQ2', 1, 39.95, 39.95),
(1003, 3, '13-Q2/P2', 5, 14.99, 74.95),
(1004, 1, '54778-2T', 3, 4.99, 14.97),
(1004, 2, '23109-HB', 2, 9.95, 19.9),
(1005, 1, 'PVC23DRT', 12, 5.87, 70.44),
(1006, 1, 'SM-18277', 3, 6.99, 20.97),
(1006, 2, '2232/QTY', 1, 109.92, 109.92),
(1006, 3, '23109-HB', 1, 9.95, 9.95),
(1006, 4, '89-WRE-Q', 1, 256.99, 256.99),
(1007, 1, '13-Q2/P2', 2, 14.99, 29.98),
(1007, 2, '54778-2T', 1, 4.99, 4.99),
(1008, 1, 'PVC23DRT', 5, 5.87, 29.35),
(1008, 2, 'WR3/TT3', 3, 119.95, 359.85),
(1008, 3, '23109-HB', 1, 9.95, 9.95);

-- --------------------------------------------------------

--
-- Table structure for table `PRODUCT`
--

CREATE TABLE `PRODUCT` (
  `P_CODE` varchar(10) NOT NULL,
  `P_DESCRIPT` varchar(35) NOT NULL,
  `P_INDATE` date NOT NULL,
  `P_ONHAND` float NOT NULL,
  `P_MIN` float NOT NULL,
  `P_PRICE` float NOT NULL,
  `P_DISCOUNT` float NOT NULL,
  `V_CODE` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `PRODUCT`
--

INSERT INTO `PRODUCT` (`P_CODE`, `P_DESCRIPT`, `P_INDATE`, `P_ONHAND`, `P_MIN`, `P_PRICE`, `P_DISCOUNT`, `V_CODE`) VALUES
('11QER/31', 'Power painter, 15 psi., 3-nozzle', '2003-11-03', 8, 5, 109.99, 0, 25595),
('13-Q2/P2', '7.25-in. pwr. saw blade', '2003-12-13', 32, 15, 14.99, 0.0525, 21344),
('14-Q1/L3', '9.00-in. pwr. saw blade', '2003-11-13', 18, 12, 17.49, 0, 21344),
('1546-QQ2', 'Hrd. cloth, 1/4-in., 2x50', '2004-01-04', 15, 8, 39.95, 0, 23119),
('1558-QW1', 'Hrd. cloth, 1/2-in., 3x50', '2004-01-15', 23, 5, 43.99, 0, 23119),
('2232/QTY', 'B&D jigsaw, 12-in. blade', '2003-12-10', 8, 5, 109.92, 0.05, 24288),
('2232/QWE', 'B&D jigsaw, 8-in. blade', '2003-12-24', 6, 5, 99.87, 0.05, 24288),
('2238/QPD', 'B&D cordless drill, 1/2-in.', '2004-01-20', 12, 5, 38.95, 0.0525, 25595),
('23109-HB', 'Claw hammer', '2004-01-20', 23, 10, 9.95, 0.105, 21225),
('23114-AA', 'Sledge hammer, 12 lb.', '2004-01-20', 8, 5, 14.4, 0.05, NULL),
('54778-2T', 'Rat-tail file, 1/8-in. fine', '2003-12-15', 43, 20, 4.99, 0, 21344),
('89-WRE-Q', 'Hicut chain saw, 16 in.', '2004-02-17', 11, 5, 256.99, 0.0525, 24288),
('PVC23DRT', 'PVC pipe, 3.5-in., 8-ft', '2004-02-20', 188, 75, 5.87, 0, NULL),
('SM-18277', '1.25-in. metal screw, 25', '2004-03-01', 172, 75, 6.99, 0, 21225),
('SW-23116', '2.5-in. wd. screw, 50', '2004-02-24', 237, 100, 8.45, 0, 21231),
('WR3/TT3', 'Steel matting, 4\'x8\'x1/6\", .5\" mesh', '2004-01-07', 18, 5, 119.95, 0.105, 25595);

-- --------------------------------------------------------

--
-- Table structure for table `VENDOR`
--

CREATE TABLE `VENDOR` (
  `V_CODE` int NOT NULL,
  `V_NAME` varchar(35) NOT NULL,
  `V_CONTACT` varchar(15) NOT NULL,
  `V_AREACODE` char(3) NOT NULL,
  `V_PHONE` char(8) NOT NULL,
  `V_STATE` char(2) NOT NULL,
  `V_ORDER` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `VENDOR`
--

INSERT INTO `VENDOR` (`V_CODE`, `V_NAME`, `V_CONTACT`, `V_AREACODE`, `V_PHONE`, `V_STATE`, `V_ORDER`) VALUES
(21225, 'Bryson, Inc.', 'Smithson', '615', '223-3234', 'TN', 'Y'),
(21226, 'SuperLoo, Inc.', 'Flushing', '904', '215-8995', 'FL', 'N'),
(21231, 'D&E Supply', 'Singh', '615', '228-3245', 'TN', 'Y'),
(21344, 'Gomez Bros.', 'Ortega', '615', '889-2546', 'KY', 'N'),
(22567, 'Dome Supply', 'Smith', '901', '678-1419', 'GA', 'N'),
(23119, 'Randsets Ltd.', 'Anderson', '901', '678-3998', 'GA', 'Y'),
(24004, 'Brackman Bros.', 'Browning', '615', '228-1410', 'TN', 'N'),
(24288, 'ORDVA, Inc.', 'Hakford', '615', '898-1234', 'TN', 'Y'),
(25443, 'B&K, Inc.', 'Smith', '904', '227-0093', 'FL', 'N'),
(25501, 'Damal Supplies', 'Smythe', '615', '890-3529', 'TN', 'N'),
(25595, 'Rubicon Systems', 'Orton', '904', '456-0092', 'FL', 'Y');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CUSTOMER`
--
ALTER TABLE `CUSTOMER`
  ADD PRIMARY KEY (`CUS_CODE`),
  ADD UNIQUE KEY `CUS_UI1` (`CUS_LNAME`,`CUS_FNAME`);

--
-- Indexes for table `INVOICE`
--
ALTER TABLE `INVOICE`
  ADD PRIMARY KEY (`INV_NUMBER`);

--
-- Indexes for table `LINE`
--
ALTER TABLE `LINE`
  ADD PRIMARY KEY (`INV_NUMBER`,`LINE_NUMBER`),
  ADD UNIQUE KEY `LINE_UI1` (`INV_NUMBER`,`P_CODE`),
  ADD KEY `P_CODE` (`P_CODE`);

--
-- Indexes for table `PRODUCT`
--
ALTER TABLE `PRODUCT`
  ADD PRIMARY KEY (`P_CODE`),
  ADD KEY `PRODUCT_V_CODE_FK` (`V_CODE`);

--
-- Indexes for table `VENDOR`
--
ALTER TABLE `VENDOR`
  ADD PRIMARY KEY (`V_CODE`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `LINE`
--
ALTER TABLE `LINE`
  ADD CONSTRAINT `LINE_ibfk_1` FOREIGN KEY (`INV_NUMBER`) REFERENCES `INVOICE` (`INV_NUMBER`) ON DELETE CASCADE,
  ADD CONSTRAINT `LINE_ibfk_2` FOREIGN KEY (`P_CODE`) REFERENCES `PRODUCT` (`P_CODE`);

--
-- Constraints for table `PRODUCT`
--
ALTER TABLE `PRODUCT`
  ADD CONSTRAINT `PRODUCT_V_CODE_FK` FOREIGN KEY (`V_CODE`) REFERENCES `VENDOR` (`V_CODE`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
