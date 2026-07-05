-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 05, 2026 at 10:57 AM
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
-- Database: `db_ci4`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2026-05-13-020503', 'App\\Database\\Migrations\\Product', 'default', 'App', 1778638431, 1),
(2, '2026-05-13-020503', 'App\\Database\\Migrations\\User', 'default', 'App', 1778638431, 1),
(3, '2026-05-13-020504', 'App\\Database\\Migrations\\Transaction', 'default', 'App', 1778638431, 1),
(4, '2026-05-13-020504', 'App\\Database\\Migrations\\TransactionDetail', 'default', 'App', 1778638431, 1),
(5, '2026-05-20-020253', 'App\\Database\\Migrations\\AddDeletedAtToTables', 'default', 'App', 1779242614, 2),
(6, '2026-07-02-100000', 'App\\Database\\Migrations\\AddPpnBiayaAdminKuponToTransaction', 'default', 'App', 1782960466, 3);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `harga` double NOT NULL,
  `jumlah` int(5) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `nama`, `harga`, `jumlah`, `foto`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'ASUS TUF A15 FA506NF', 10899000, 5, 'asus_tuf_a15.jpg', '2026-05-13 09:17:30', NULL, NULL),
(2, 'Asus Vivobook 14 A1404ZA', 6899000, 7, 'asus_vivobook_14.jpg', '2026-05-13 09:17:30', NULL, NULL),
(3, 'Lenovo IdeaPad Slim 3-14IAU7', 6299000, 5, 'lenovo_idepad_slim_3.jpg', '2026-05-13 09:17:30', NULL, NULL),
(4, 'Yoga Slim 7i Aura Editions', 25000000, 25, '', '2026-06-19 19:31:27', '2026-06-19 19:36:51', '2026-06-19 19:36:51');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `total_harga` double NOT NULL,
  `alamat` text NOT NULL,
  `ongkir` double DEFAULT NULL,
  `ppn` double DEFAULT NULL,
  `biaya_admin` double DEFAULT NULL,
  `kupon_code` varchar(20) DEFAULT NULL,
  `diskon_kupon` double DEFAULT NULL,
  `status` int(1) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `username`, `total_harga`, `alamat`, `ongkir`, `ppn`, `biaya_admin`, `kupon_code`, `diskon_kupon`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'kamidi', 10939000, 'tanjnungsari 6 ', 40000, NULL, NULL, NULL, NULL, 0, '2026-06-16 18:58:53', '2026-06-16 18:58:53', NULL),
(2, 'kamidi', 10924000, 'tanjnungsari 6 ', 25000, NULL, NULL, NULL, NULL, 0, '2026-06-19 19:19:02', '2026-06-19 19:19:02', NULL),
(3, 'kamidi', 33263684, 'tanjnungsari 6 ', 195000, 4271520, 320364, 'HEMAT20', 7119200, 0, '2026-07-02 09:49:39', '2026-07-02 09:49:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_detail`
--

CREATE TABLE `transaction_detail` (
  `id` int(11) UNSIGNED NOT NULL,
  `transaction_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `jumlah` int(5) NOT NULL,
  `diskon` double DEFAULT NULL,
  `subtotal_harga` double NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_detail`
--

INSERT INTO `transaction_detail` (`id`, `transaction_id`, `product_id`, `jumlah`, `diskon`, `subtotal_harga`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, 0, 10899000, '2026-06-16 18:58:53', '2026-06-16 18:58:53', NULL),
(2, 2, 1, 1, 0, 10899000, '2026-06-19 19:19:02', '2026-06-19 19:19:02', NULL),
(3, 3, 1, 2, 0, 21798000, '2026-07-02 09:49:39', '2026-07-02 09:49:39', NULL),
(4, 3, 2, 2, 0, 13798000, '2026-07-02 09:49:39', '2026-07-02 09:49:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `role`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'bagas64', 'phutagalung@kuswandari.asia', '$2y$10$9GHBSRWwsJgrH85Rce45.ubiyERQce8rtJXGqyvWc.jsV46b/Efsy', 'guest', '2026-05-13 09:19:03', NULL, NULL),
(2, 'banara54', 'rahmi96@usada.asia', '$2y$10$vawjNCfUPz/4os.Tlkf.V.U74OChRMXlIuMP1fj6zjM5vMdZiNevO', 'admin', '2026-05-13 09:19:03', NULL, NULL),
(3, 'michelle.putra', 'puspa.wasita@suryatmi.co.id', '$2y$10$ZW5SCj54TxasUZr6CQNAXOnJ6ra.YWxyUv5v8MprHymjI.B2R9zlu', 'admin', '2026-05-13 09:19:03', NULL, NULL),
(4, 'nasrullah52', 'gutami@budiman.go.id', '$2y$10$pdSnCCLJhPFdmqqbaF4oBu/CIx6dSAhLoFlrViUNwGtxtXNxCHxO.', 'guest', '2026-05-13 09:19:03', NULL, NULL),
(5, 'yance.prabowo', 'lidya94@wastuti.co', '$2y$10$QRRaA1KEoI7teZuOd75fte1Xq9yYrCVDFkNVSSyVE2cnO1mlH01Vm', 'admin', '2026-05-13 09:19:03', NULL, NULL),
(6, 'gyuniar', 'anastasia33@yuliarti.biz.id', '$2y$10$ztVIYmB9HU7jUXyFmo8FPORco4Ye6iC5L83S1XKg3Fy4wlTyxeLNy', 'guest', '2026-05-13 09:19:03', NULL, NULL),
(7, 'santoso.yani', 'prasetyo.nyana@gmail.co.id', '$2y$10$p3L9ReriPkysC3kB3F5lq.WtS5mIyDRaAuOknAKKaXOxBOV3k22WS', 'guest', '2026-05-13 09:19:03', NULL, NULL),
(8, 'cinta05', 'maryadi.nalar@hariyah.web.id', '$2y$10$kKFk9Jo5BIJa3uzlqvRee.m1Tb8QrQAe4dXoWQ0Do3tKF2LQuPhMK', 'guest', '2026-05-13 09:19:03', NULL, NULL),
(9, 'osaragih', 'rjailani@yahoo.co.id', '$2y$10$m7yctPxsUfB0ZcMWczl.C.PG7tJH3WUJGoNbndfc15urvCOqJRIA6', 'guest', '2026-05-13 09:19:03', NULL, NULL),
(10, 'kamidi', 'vianvrick@gmail.com', '$2y$10$0QK0yhrDDZ2R43Womw/r6efWE14nLPkCmHKzl7m98tc..FkQ.ssw6', 'admin', '2026-05-13 09:19:03', NULL, NULL),
(11, 'april', 'april@gmail.com', '$2a$12$570Qo16Mu4SHSYvcXZgo3uhLi1wcABAsaGecg7.4aX9a5sMNHj4jm', 'admin', '2025-07-01 19:36:09', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
