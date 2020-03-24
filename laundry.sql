-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Mar 2020 pada 12.34
-- Versi server: 10.1.36-MariaDB
-- Versi PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laundry`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_trans`
--

CREATE TABLE `detail_trans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_trans` int(11) NOT NULL,
  `id_jenis` int(11) NOT NULL,
  `qty` int(50) NOT NULL,
  `subtotal` int(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `detail_trans`
--

INSERT INTO `detail_trans` (`id`, `id_trans`, `id_jenis`, `qty`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 4000, NULL, '2020-02-28 00:06:49'),
(2, 2, 2, 2, 8000, NULL, NULL),
(4, 3, 2, 2, 6000, NULL, NULL),
(5, 3, 2, 1, 3000, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_cuci`
--

CREATE TABLE `jenis_cuci` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_jenis` enum('kering','kering+setrika') COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga_perkilo` int(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jenis_cuci`
--

INSERT INTO `jenis_cuci` (`id`, `nama_jenis`, `harga_perkilo`, `created_at`, `updated_at`) VALUES
(1, 'kering+setrika', 4000, NULL, NULL),
(2, 'kering', 3000, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2020_02_17_065200_pelanggan', 1),
(2, '2020_02_17_065211_transaksi', 1),
(3, '2020_02_17_065223_detail_trans', 1),
(4, '2020_02_17_065235_petugas', 1),
(5, '2020_02_17_065246_jenis_cuci', 1),
(6, '2020_02_17_071257_jenis_cuci', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `alamat`, `telp`, `created_at`, `updated_at`) VALUES
(1, 'Fara', 'Seoul', '1234567890', NULL, '2020-02-27 23:57:19'),
(2, 'v', 'Daegu', '1234567890', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `petugas`
--

CREATE TABLE `petugas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_petugas` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telp` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` enum('admin','petugas') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `petugas`
--

INSERT INTO `petugas` (`id`, `nama_petugas`, `telp`, `username`, `password`, `level`, `created_at`, `updated_at`) VALUES
(1, 'fara', 1234567890, 'fara1', '$2y$10$r1CgwGAjIsUcprRO1CxA0.ZwjQ8hZ3qXAldVYF9bThCBFnF/DXL66', 'admin', '2020-02-23 23:23:47', '2020-02-23 23:23:47'),
(2, 'v', 1234567890, 'v', '$2y$10$y881fugwA9iJpRDpqRykIe5/d82mrhBFmHfkmFA27X9DT44mb5BqK', 'petugas', '2020-02-25 23:30:29', '2020-02-25 23:30:29'),
(3, 'fara', 1234567890, 'fara2', '$2y$10$5kz3QukxGvcn/DvYXKA5.uRA4elb2SbL1Q4gbsm7cRMr69L58TIWW', 'admin', '2020-02-28 00:21:48', '2020-02-28 00:21:48'),
(4, 'JK', 1234567890, 'jk', '$2y$10$VAK75EQTNfIpCkWY1vohwOaXMZUdGeaQF2Ab1.EMebQL3aF6VQyly', 'petugas', '2020-03-22 23:41:16', '2020-03-22 23:41:16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `id_petugas` int(11) NOT NULL,
  `tgl_transaksi` date NOT NULL,
  `tgl_selesai` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id`, `id_pelanggan`, `id_petugas`, `tgl_transaksi`, `tgl_selesai`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2020-03-01', '2020-03-03', NULL, '2020-02-28 00:09:59'),
(2, 2, 2, '2020-02-11', '2020-02-16', NULL, NULL),
(3, 1, 1, '2020-03-10', '2020-03-15', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `detail_trans`
--
ALTER TABLE `detail_trans`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jenis_cuci`
--
ALTER TABLE `jenis_cuci`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detail_trans`
--
ALTER TABLE `detail_trans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `jenis_cuci`
--
ALTER TABLE `jenis_cuci`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `petugas`
--
ALTER TABLE `petugas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
