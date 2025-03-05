-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 05, 2025 at 10:01 PM
-- Server version: 8.0.36
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medicare`
--

-- --------------------------------------------------------

--
-- Table structure for table `health_monitoring`
--

CREATE TABLE `health_monitoring` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `heartRate_bpm` int NOT NULL,
  `oxygenSat_per` decimal(5,2) NOT NULL,
  `bodyTemp_c` decimal(4,2) NOT NULL,
  `assigned_professional` varchar(255) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `health_monitoring`
--

INSERT INTO `health_monitoring` (`id`, `user_id`, `heartRate_bpm`, `oxygenSat_per`, `bodyTemp_c`, `assigned_professional`, `timestamp`) VALUES
(1, 1, 75, 98.50, 36.70, 'Dr. Smith', '2025-03-05 17:25:56'),
(3, 2, 72, 99.00, 36.50, 'Dr. Johnson', '2025-03-05 17:25:56'),
(4, 1, 75, 98.50, 36.70, 'Dr.Smith', '2025-03-05 17:28:32'),
(5, 1, 78, 98.50, 36.70, 'Dr.Smith', '2025-03-05 17:46:34'),
(6, 1, 90, 98.50, 36.70, 'Dr.Smith', '2025-03-05 17:49:41'),
(7, 1, 90, 98.50, 36.70, 'Dr.Smith', '2025-03-05 19:59:39'),
(8, 1, 96, 99.00, 38.70, 'Dr.Smith', '2025-03-05 20:54:57'),
(9, 1, 96, 99.00, 42.70, 'Dr.Smith', '2025-03-05 21:40:45');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `access_key` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `access_key`) VALUES
(2, 'another_key_456'),
(1, 'example_key_123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `health_monitoring`
--
ALTER TABLE `health_monitoring`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `access_key` (`access_key`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `health_monitoring`
--
ALTER TABLE `health_monitoring`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `health_monitoring`
--
ALTER TABLE `health_monitoring`
  ADD CONSTRAINT `health_monitoring_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
