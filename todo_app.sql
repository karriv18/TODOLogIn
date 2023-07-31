-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 31, 2023 at 05:54 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `todo_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_todo`
--

CREATE TABLE `tbl_todo` (
  `id` int(11) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `middle_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `email` varchar(70) NOT NULL,
  `pword` varchar(70) NOT NULL,
  `pro_pic` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_todo`
--

INSERT INTO `tbl_todo` (`id`, `first_name`, `middle_name`, `last_name`, `email`, `pword`, `pro_pic`) VALUES
(1, 'karl', 'esguerra', 'rivera', 'karl@example.com', 'karl', NULL),
(3, 'char', 'esguer', 'river', 'char@example.com', 'char', NULL),
(4, 'Shirly', 'Esguuera', 'Rivera', 'shirly@example.com', 'she', NULL),
(5, 'karl', 'esguerra', 'tan', 'karl@gmail.com', 'sha', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_todo_info`
--

CREATE TABLE `tbl_todo_info` (
  `todo_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `task` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_todo_info`
--

INSERT INTO `tbl_todo_info` (`todo_id`, `id`, `task`) VALUES
(19, 3, 'adf'),
(21, 3, 'adf'),
(22, 3, 'charles'),
(23, 3, 'karl');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_todo`
--
ALTER TABLE `tbl_todo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_todo_info`
--
ALTER TABLE `tbl_todo_info`
  ADD PRIMARY KEY (`todo_id`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_todo`
--
ALTER TABLE `tbl_todo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_todo_info`
--
ALTER TABLE `tbl_todo_info`
  MODIFY `todo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_todo_info`
--
ALTER TABLE `tbl_todo_info`
  ADD CONSTRAINT `tbl_todo_info_ibfk_1` FOREIGN KEY (`id`) REFERENCES `tbl_todo` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
