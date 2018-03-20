-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 20, 2018 at 05:53 PM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `andro_park`
--
CREATE DATABASE IF NOT EXISTS `andro_park` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `andro_park`;

-- --------------------------------------------------------

--
-- Table structure for table `entry_table`
--

CREATE TABLE IF NOT EXISTS `entry_table` (
  `entry_id` int(5) NOT NULL,
  `RFID_no` varchar(8) NOT NULL,
  `parking_id` int(5) NOT NULL,
  `arrival_time` time NOT NULL,
  `arrival_date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `entry_table`:
--   `parking_id`
--       `parking_station` -> `parking_id`
--   `RFID_no`
--       `rfid_details` -> `RFID_no`
--

--
-- Dumping data for table `entry_table`
--

INSERT INTO `entry_table` (`entry_id`, `RFID_no`, `parking_id`, `arrival_time`, `arrival_date`) VALUES
(1, '100', 1, '04:00:00', '2018-03-14'),
(2, '1234', 1, '05:00:00', '2018-03-07'),
(3, '100', 1, '07:00:00', '2018-03-14'),
(4, '100', 1, '09:00:00', '2018-03-08');

--
-- Triggers `entry_table`
--
DELIMITER $$
CREATE TRIGGER `calculation` AFTER INSERT ON `entry_table`
 FOR EACH ROW update transaction_table set cars_occupied := cars_occupied+1 WHERE parking_id=1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `exit_table`
--

CREATE TABLE IF NOT EXISTS `exit_table` (
  `exit_id` int(8) NOT NULL,
  `RFID_no` varchar(8) NOT NULL,
  `parking_id` int(5) NOT NULL,
  `depature_time` time NOT NULL,
  `depature_date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `exit_table`:
--   `parking_id`
--       `parking_station` -> `parking_id`
--   `RFID_no`
--       `rfid_details` -> `RFID_no`
--

--
-- Dumping data for table `exit_table`
--

INSERT INTO `exit_table` (`exit_id`, `RFID_no`, `parking_id`, `depature_time`, `depature_date`) VALUES
(1, '100', 1, '07:00:00', '2018-03-14'),
(2, '1234', 1, '10:00:00', '2018-03-08'),
(3, '100', 1, '07:00:00', '2018-03-15'),
(4, '100', 1, '15:00:00', '2018-03-08');

--
-- Triggers `exit_table`
--
DELIMITER $$
CREATE TRIGGER `calculation_exit` AFTER INSERT ON `exit_table`
 FOR EACH ROW UPDATE transaction_table set cars_occupied:=cars_occupied-1 where parking_id=1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `history_table`
--

CREATE TABLE IF NOT EXISTS `history_table` (
  `history_id` int(8) NOT NULL,
  `RFID_no` varchar(8) NOT NULL,
  `entry_id` int(8) NOT NULL,
  `exit_id` int(8) NOT NULL,
  `entry_time` time NOT NULL,
  `exit_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `history_table`:
--   `exit_id`
--       `exit_table` -> `exit_id`
--   `entry_id`
--       `entry_table` -> `entry_id`
--   `RFID_no`
--       `rfid_details` -> `RFID_no`
--

-- --------------------------------------------------------

--
-- Table structure for table `parking_station`
--

CREATE TABLE IF NOT EXISTS `parking_station` (
  `parking_id` int(5) NOT NULL,
  `parking_name` char(30) NOT NULL,
  `parking_longitude` float NOT NULL,
  `parking_latitude` float NOT NULL,
  `parking_status` tinyint(1) NOT NULL,
  `parking_slots` int(3) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `parking_station`:
--

--
-- Dumping data for table `parking_station`
--

INSERT INTO `parking_station` (`parking_id`, `parking_name`, `parking_longitude`, `parking_latitude`, `parking_status`, `parking_slots`) VALUES
(1, 'madhaper', 75, 78, 1, 120);

-- --------------------------------------------------------

--
-- Table structure for table `rfid_details`
--

CREATE TABLE IF NOT EXISTS `rfid_details` (
  `RFID_id` int(8) NOT NULL,
  `RFID_no` varchar(8) NOT NULL,
  `RFID_car_no` varchar(6) NOT NULL,
  `RFID_aadhar` int(12) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `rfid_details`:
--

--
-- Dumping data for table `rfid_details`
--

INSERT INTO `rfid_details` (`RFID_id`, `RFID_no`, `RFID_car_no`, `RFID_aadhar`) VALUES
(1, '100', '123', 254166168),
(2, '1234', '3333', 4444);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_table`
--

CREATE TABLE IF NOT EXISTS `transaction_table` (
  `transaction_id` int(11) NOT NULL,
  `parking_id` int(11) NOT NULL,
  `cars_occupied` int(3) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `transaction_table`:
--   `parking_id`
--       `parking_station` -> `parking_id`
--

--
-- Dumping data for table `transaction_table`
--

INSERT INTO `transaction_table` (`transaction_id`, `parking_id`, `cars_occupied`) VALUES
(2, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `user_request`
--

CREATE TABLE IF NOT EXISTS `user_request` (
  `user_request_id` int(6) NOT NULL,
  `parking_id` int(5) NOT NULL,
  `user_unique_id` varchar(10) NOT NULL,
  `user_request_date` date NOT NULL,
  `user_request_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `user_request`:
--   `parking_id`
--       `parking_station` -> `parking_id`
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `entry_table`
--
ALTER TABLE `entry_table`
  ADD PRIMARY KEY (`entry_id`), ADD KEY `entry_id` (`entry_id`), ADD KEY `RFID_no` (`RFID_no`), ADD KEY `parking_id` (`parking_id`), ADD KEY `RFID_no_2` (`RFID_no`);

--
-- Indexes for table `exit_table`
--
ALTER TABLE `exit_table`
  ADD PRIMARY KEY (`exit_id`), ADD KEY `exit_id` (`exit_id`), ADD KEY `RFID_no` (`RFID_no`), ADD KEY `parking_id` (`parking_id`), ADD KEY `RFID_no_2` (`RFID_no`), ADD KEY `RFID_no_3` (`RFID_no`);

--
-- Indexes for table `history_table`
--
ALTER TABLE `history_table`
  ADD PRIMARY KEY (`history_id`), ADD KEY `RFID_no` (`RFID_no`), ADD KEY `entry_id` (`entry_id`), ADD KEY `exit_id` (`exit_id`), ADD KEY `RFID_no_2` (`RFID_no`);

--
-- Indexes for table `parking_station`
--
ALTER TABLE `parking_station`
  ADD PRIMARY KEY (`parking_id`), ADD KEY `parking_id` (`parking_id`);

--
-- Indexes for table `rfid_details`
--
ALTER TABLE `rfid_details`
  ADD PRIMARY KEY (`RFID_no`), ADD UNIQUE KEY `RFID_id` (`RFID_id`), ADD KEY `RFID_id_2` (`RFID_id`), ADD KEY `RFID_no` (`RFID_no`);

--
-- Indexes for table `transaction_table`
--
ALTER TABLE `transaction_table`
  ADD PRIMARY KEY (`transaction_id`), ADD KEY `parking_id` (`parking_id`);

--
-- Indexes for table `user_request`
--
ALTER TABLE `user_request`
  ADD PRIMARY KEY (`user_request_id`), ADD KEY `user_request_id` (`user_request_id`), ADD KEY `parking_id` (`parking_id`), ADD KEY `user_unique_id` (`user_unique_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `entry_table`
--
ALTER TABLE `entry_table`
  MODIFY `entry_id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `exit_table`
--
ALTER TABLE `exit_table`
  MODIFY `exit_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `history_table`
--
ALTER TABLE `history_table`
  MODIFY `history_id` int(8) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `parking_station`
--
ALTER TABLE `parking_station`
  MODIFY `parking_id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `rfid_details`
--
ALTER TABLE `rfid_details`
  MODIFY `RFID_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `transaction_table`
--
ALTER TABLE `transaction_table`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user_request`
--
ALTER TABLE `user_request`
  MODIFY `user_request_id` int(6) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `entry_table`
--
ALTER TABLE `entry_table`
ADD CONSTRAINT `entry_table_ibfk_1` FOREIGN KEY (`parking_id`) REFERENCES `parking_station` (`parking_id`),
ADD CONSTRAINT `entry_table_ibfk_2` FOREIGN KEY (`RFID_no`) REFERENCES `rfid_details` (`RFID_no`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `exit_table`
--
ALTER TABLE `exit_table`
ADD CONSTRAINT `exit_table_ibfk_1` FOREIGN KEY (`parking_id`) REFERENCES `parking_station` (`parking_id`),
ADD CONSTRAINT `exit_table_ibfk_2` FOREIGN KEY (`RFID_no`) REFERENCES `rfid_details` (`RFID_no`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `history_table`
--
ALTER TABLE `history_table`
ADD CONSTRAINT `history_table_ibfk_1` FOREIGN KEY (`exit_id`) REFERENCES `exit_table` (`exit_id`),
ADD CONSTRAINT `history_table_ibfk_2` FOREIGN KEY (`entry_id`) REFERENCES `entry_table` (`entry_id`),
ADD CONSTRAINT `history_table_ibfk_3` FOREIGN KEY (`RFID_no`) REFERENCES `rfid_details` (`RFID_no`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `transaction_table`
--
ALTER TABLE `transaction_table`
ADD CONSTRAINT `transaction_table_ibfk_1` FOREIGN KEY (`parking_id`) REFERENCES `parking_station` (`parking_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_request`
--
ALTER TABLE `user_request`
ADD CONSTRAINT `user_request_ibfk_1` FOREIGN KEY (`parking_id`) REFERENCES `parking_station` (`parking_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
