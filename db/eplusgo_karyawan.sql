-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 15, 2020 at 10:38 AM
-- Server version: 5.7.30-0ubuntu0.18.04.1
-- PHP Version: 5.6.40-30+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eplusgo_karyawan`
--

-- --------------------------------------------------------

--
-- Table structure for table `cuti`
--

CREATE TABLE `cuti` (
  `id` int(11) UNSIGNED NOT NULL,
  `karyawan_id` int(11) UNSIGNED NOT NULL,
  `tanggal_cuti` date NOT NULL,
  `jumlah` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `golongan`
--

CREATE TABLE `golongan` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama_golongan` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `gaji_pokok` int(12) NOT NULL,
  `tunjangan_istri` int(12) NOT NULL,
  `tunjangan_anak` int(12) NOT NULL,
  `tunjangan_transport` int(12) NOT NULL,
  `tunjangan_makan` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `id` int(11) UNSIGNED NOT NULL,
  `nip` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `nik` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `nama` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `jenis_kelamin` enum('pria','wanita') COLLATE utf8_unicode_ci NOT NULL,
  `tempat_lahir` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `telpon` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `agama` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `status_nikah` enum('belum nikah','nikah') COLLATE utf8_unicode_ci NOT NULL,
  `alamat` text COLLATE utf8_unicode_ci NOT NULL,
  `golongan_id` int(11) UNSIGNED NOT NULL,
  `foto` varchar(150) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lembur`
--

CREATE TABLE `lembur` (
  `id` int(11) UNSIGNED NOT NULL,
  `karyawan_id` int(11) UNSIGNED NOT NULL,
  `tanggal_lembur` date NOT NULL,
  `jumlah` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `penggajian`
--

CREATE TABLE `penggajian` (
  `id` int(11) UNSIGNED NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` text COLLATE utf8_unicode_ci NOT NULL,
  `karyawan_id` int(11) UNSIGNED NOT NULL,
  `jumlah_gaji` int(11) NOT NULL,
  `jumlah_lembur` int(11) NOT NULL,
  `potongan` int(11) NOT NULL,
  `total_gaji_diterima` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cuti`
--
ALTER TABLE `cuti`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuti_karyawan_id` (`karyawan_id`);

--
-- Indexes for table `golongan`
--
ALTER TABLE `golongan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `karyawan_golongan_id` (`golongan_id`);

--
-- Indexes for table `lembur`
--
ALTER TABLE `lembur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lembur_karyawan_id` (`karyawan_id`);

--
-- Indexes for table `penggajian`
--
ALTER TABLE `penggajian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `penjualan_pelanggan_id` (`karyawan_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cuti`
--
ALTER TABLE `cuti`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `golongan`
--
ALTER TABLE `golongan`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lembur`
--
ALTER TABLE `lembur`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `penggajian`
--
ALTER TABLE `penggajian`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `cuti`
--
ALTER TABLE `cuti`
  ADD CONSTRAINT `cuti_karyawan_id` FOREIGN KEY (`karyawan_id`) REFERENCES `karyawan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD CONSTRAINT `karyawan_golongan_id` FOREIGN KEY (`golongan_id`) REFERENCES `golongan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lembur`
--
ALTER TABLE `lembur`
  ADD CONSTRAINT `lembur_karyawan_id` FOREIGN KEY (`karyawan_id`) REFERENCES `karyawan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `penggajian`
--
ALTER TABLE `penggajian`
  ADD CONSTRAINT `penggajian_karyawan_id` FOREIGN KEY (`karyawan_id`) REFERENCES `karyawan` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
