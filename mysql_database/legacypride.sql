-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Mar 2022 pada 15.45
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `legacypride`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `arrestpoints`
--

CREATE TABLE `arrestpoints` (
  `id` int(2) NOT NULL,
  `PosX` float(10,5) NOT NULL DEFAULT 0.00000,
  `PosY` float(10,5) NOT NULL DEFAULT 0.00000,
  `PosZ` float(10,5) NOT NULL DEFAULT 0.00000,
  `VW` int(5) NOT NULL DEFAULT 0,
  `Int` int(5) NOT NULL DEFAULT 0,
  `Type` int(1) NOT NULL DEFAULT 0,
  `jailVW` int(5) NOT NULL DEFAULT 0,
  `jailInt` int(5) NOT NULL DEFAULT 0,
  `jailpos1x` float(10,5) NOT NULL DEFAULT 0.00000,
  `jailpos1y` float(10,5) NOT NULL DEFAULT 0.00000,
  `jailpos1z` float(10,5) NOT NULL DEFAULT 0.00000,
  `jailpos2x` float(10,5) NOT NULL DEFAULT 0.00000,
  `jailpos2y` float(10,5) NOT NULL DEFAULT 0.00000,
  `jailpos2z` float(10,5) NOT NULL DEFAULT 0.00000
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `atms`
--

CREATE TABLE `atms` (
  `id` int(11) NOT NULL,
  `posx` float NOT NULL,
  `posy` float NOT NULL,
  `posz` float NOT NULL,
  `posrx` float NOT NULL,
  `posry` float NOT NULL,
  `posrz` float NOT NULL,
  `interior` int(11) NOT NULL DEFAULT 0,
  `world` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `atms`
--

INSERT INTO `atms` (`id`, `posx`, `posy`, `posz`, `posrx`, `posry`, `posrz`, `interior`, `world`) VALUES
(0, 2248.51, -1759.95, 1014.38, 0, 0, -176.5, 1, 0),
(1, 1491.39, -1010, 26.5137, 0, 0, 88.9, 0, 0),
(2, 1432.66, -1010.11, 26.4837, 0, 0, 88.7, 0, 0),
(3, 1181.14, -1354.75, 13.8547, 0, 0, 92.5, 0, 0),
(4, 1465.92, -1749.89, 15.0853, 0, 0, -179.1, 0, 0),
(5, 1744.98, -1743.81, 13.235, 0, 0, 0, 0, 0),
(6, 391.069, -1805.93, 7.53812, 0, 0, -96.3, 0, 0),
(7, -83.2758, -1183.58, 1.42701, 0, 0, 67, 0, 0),
(8, 317.072, -158.875, 999.253, 0, 0, 88.7, 6, 10),
(9, -11.9034, -30.933, 1003.22, 0, 0, 178.5, 10, 11),
(10, 2196.28, -2209.43, 13.1675, 0.2, 0, 138.3, 0, 0),
(11, 1250.22, -1271.2, 13.221, 0, 0, 97.2, 0, 0),
(12, 312.668, -166.138, 999.601, 0, 0, 0, 6, 37),
(13, 1736.5, -1870.07, 13.8619, 0, 0, -91.6, 0, 0),
(14, 2105.36, -1810.77, 13.3047, 0, 0, -92.4, 0, 0),
(15, 1813.9, -1561.17, 13.2347, 0, 0, 160.6, 0, 0),
(16, 149.145, -1949.98, 3.54344, 0, 0, -31.2, 0, 0),
(17, 1250.3, -1287.3, 1061.06, 0, 0, -178.8, 0, 0),
(18, 1104.13, -1223.01, 15.751, 0, 0, 88.5, 0, 0),
(19, 2236.04, -1664.39, 15.3772, 0, 0, -13.6, 0, 0),
(20, 387.943, 880.985, 23.6348, 0, 0, 0, 0, 2),
(21, 2428.92, -1673, 13.4788, 0, 0, 86.9, 0, 0),
(22, 691.675, -588.908, 16.1559, 0, 0, 0, 0, 0),
(23, 1393.95, 1325.07, 1501.09, 0, 0, 0, 5, 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `banneds`
--

CREATE TABLE `banneds` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(24) DEFAULT 'None',
  `ip` varchar(24) DEFAULT 'None',
  `longip` int(11) DEFAULT 0,
  `ban_expire` bigint(16) DEFAULT 0,
  `ban_date` bigint(16) DEFAULT 0,
  `last_activity_timestamp` bigint(16) DEFAULT 0,
  `admin` varchar(40) DEFAULT 'Server',
  `reason` varchar(128) DEFAULT 'None'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `berry`
--

CREATE TABLE `berry` (
  `id` int(11) NOT NULL,
  `posx` float DEFAULT NULL,
  `posy` float DEFAULT NULL,
  `posz` float DEFAULT NULL,
  `posrx` float DEFAULT NULL,
  `posry` float DEFAULT NULL,
  `posrz` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `berry`
--

INSERT INTO `berry` (`id`, `posx`, `posy`, `posz`, `posrx`, `posry`, `posrz`) VALUES
(0, -548.266, -1542.12, 7.31977, 0, 0, 0),
(1, -553.798, -1538.29, 7.52516, 0, 0, 0),
(2, -552.079, -1542.81, 7.52494, 0, 0, 0),
(4, -550.428, -1539.65, 7.65098, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `bill`
--

CREATE TABLE `bill` (
  `bid` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT -1,
  `name` varchar(128) NOT NULL DEFAULT 'None',
  `target` int(11) NOT NULL DEFAULT -1,
  `ammount` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bisnis`
--

CREATE TABLE `bisnis` (
  `ID` int(11) NOT NULL,
  `owner` varchar(40) NOT NULL DEFAULT '-',
  `name` varchar(40) NOT NULL DEFAULT 'Bisnis',
  `price` int(11) NOT NULL DEFAULT 500000,
  `type` int(11) NOT NULL DEFAULT 1,
  `locked` int(11) NOT NULL DEFAULT 1,
  `money` int(11) NOT NULL DEFAULT 0,
  `prod` int(11) NOT NULL DEFAULT 50,
  `bprice0` int(11) NOT NULL DEFAULT 500,
  `bprice1` int(11) NOT NULL DEFAULT 500,
  `bprice2` int(11) NOT NULL DEFAULT 500,
  `bprice3` int(11) NOT NULL DEFAULT 500,
  `bprice4` int(11) NOT NULL DEFAULT 500,
  `bprice5` int(11) NOT NULL DEFAULT 500,
  `bprice6` int(11) NOT NULL DEFAULT 500,
  `bprice7` int(11) NOT NULL DEFAULT 500,
  `bprice8` int(11) NOT NULL DEFAULT 500,
  `bprice9` int(11) NOT NULL DEFAULT 500,
  `bint` int(11) NOT NULL DEFAULT 0,
  `extposx` float NOT NULL DEFAULT 0,
  `extposy` float NOT NULL DEFAULT 0,
  `extposz` float NOT NULL DEFAULT 0,
  `extposa` float NOT NULL DEFAULT 0,
  `intposx` float NOT NULL DEFAULT 0,
  `intposy` float NOT NULL DEFAULT 0,
  `intposz` float NOT NULL DEFAULT 0,
  `intposa` float NOT NULL DEFAULT 0,
  `pointx` float DEFAULT 0,
  `pointy` float DEFAULT 0,
  `pointz` float DEFAULT 0,
  `visit` bigint(16) NOT NULL DEFAULT 0,
  `restock` tinyint(2) NOT NULL DEFAULT 0,
  `song` varchar(70) NOT NULL DEFAULT '-',
  `ph` mediumint(8) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `bisnis`
--

INSERT INTO `bisnis` (`ID`, `owner`, `name`, `price`, `type`, `locked`, `money`, `prod`, `bprice0`, `bprice1`, `bprice2`, `bprice3`, `bprice4`, `bprice5`, `bprice6`, `bprice7`, `bprice8`, `bprice9`, `bint`, `extposx`, `extposy`, `extposz`, `extposa`, `intposx`, `intposy`, `intposz`, `intposa`, `pointx`, `pointy`, `pointz`, `visit`, `restock`, `song`, `ph`) VALUES
(2, 'Jhonatan_Garner', 'Two Pizza ', 20, 1, 0, 22000, 191, 3000, 2700, 4000, 2000, 3200, 0, 0, 0, 0, 0, 10, 2105.49, -1806.51, 13.5547, 271.384, 363.22, -74.86, 1001.5, 319.72, 377.307, -67.4512, 1001.51, 0, 0, 'http://d.zaix.ru/md8e.jpg', 6111),
(1, 'Jhonatan_Garner', 'Two Equipment', 20, 4, 0, 19977, 194, 5000, 4500, 3700, 4900, 5000, 3100, 2000, 777, 0, 0, 6, 1848.33, -1871.73, 13.5781, 271.185, 316.34, -169.6, 999.6, 357.73, 311.988, -166.131, 999.594, 0, 0, 'http://d.zaix.ru/mdsZ.jpg', 6111),
(0, 'Jhonatan_Garner', '24/7 Two Market', 20, 2, 0, 98555, 95, 7, 8, 10, 23, 5000, 20, 13, 3400, 4700, 0, 6, 1833.73, -1842.58, 13.5781, 268.034, -26.68, -57.92, 1003.54, 357.58, -23.3241, -55.6355, 1003.55, 0, 0, 'http://d.zaix.ru/kwdu.jpg', 6111),
(3, 'JOKER', 'COUNTER HP', 4500000, 2, 0, 4950, 77, 100, 200, 500, 300, 500, 250, 150, 450, 500, 0, 6, 1928.58, -1776.28, 13.5469, 77.1601, -26.68, -57.92, 1003.54, 357.58, -23.0282, -55.655, 1003.55, 0, 0, '-', 6969),
(4, 'Jhonatan_Garner', 'Ganton', 20000, 3, 0, 0, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 2244.37, -1665.56, 15.4766, 165.582, 207.55, -110.67, 1005.13, 0.159997, 207.821, -100.327, 1005.26, 0, 0, 'http://d.zaix.ru/mcgn.jpg', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `contacts`
--

CREATE TABLE `contacts` (
  `ID` int(12) DEFAULT 0,
  `contactID` int(12) NOT NULL,
  `contactName` varchar(32) DEFAULT NULL,
  `contactNumber` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `contacts`
--

INSERT INTO `contacts` (`ID`, `contactID`, `contactName`, `contactNumber`) VALUES
(0, 1, 'om dedi', 9389);

-- --------------------------------------------------------

--
-- Struktur dari tabel `dealership`
--

CREATE TABLE `dealership` (
  `ID` int(11) NOT NULL,
  `owner` varchar(40) CHARACTER SET latin1 NOT NULL DEFAULT '-',
  `name` varchar(40) CHARACTER SET latin1 NOT NULL DEFAULT 'Dealership',
  `price` int(11) NOT NULL DEFAULT 1,
  `type` int(11) NOT NULL DEFAULT 1,
  `locked` int(11) NOT NULL DEFAULT 1,
  `money` int(11) NOT NULL DEFAULT 0,
  `stock` int(11) NOT NULL DEFAULT 100,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `posa` float NOT NULL DEFAULT 0,
  `pointx` float DEFAULT 0,
  `pointy` float DEFAULT 0,
  `pointz` float DEFAULT 0,
  `restock` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `dealership`
--

INSERT INTO `dealership` (`ID`, `owner`, `name`, `price`, `type`, `locked`, `money`, `stock`, `posx`, `posy`, `posz`, `posa`, `pointx`, `pointy`, `pointz`, `restock`) VALUES
(0, 'Frank_Lucaslo', 'Willowfield', 200, 1, 1, 65000, 17, 2057.5, -1897.22, 13.5469, 356.708, 2059.4, -1910.45, 13.5469, 0),
(1, 'JOKER', 'CRAZY RICH', 1000, 3, 1, 0, 0, 542.482, -1293.93, 17.2422, 178.942, 555.565, -1287.34, 17.2422, 0),
(2, 'JOKER', 'Jefferson', 100, 2, 1, 0, 100, 2131.96, -1151.32, 24.0571, 163.603, 2118.02, -1151.13, 24.1773, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `doors`
--

CREATE TABLE `doors` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) DEFAULT 'None',
  `password` varchar(50) DEFAULT '',
  `icon` int(11) DEFAULT 19130,
  `locked` int(11) NOT NULL DEFAULT 0,
  `admin` int(11) NOT NULL DEFAULT 0,
  `vip` int(11) NOT NULL DEFAULT 0,
  `faction` int(11) NOT NULL DEFAULT 0,
  `family` int(11) NOT NULL DEFAULT -1,
  `garage` tinyint(3) NOT NULL DEFAULT 0,
  `custom` int(11) NOT NULL DEFAULT 0,
  `extvw` int(11) DEFAULT 0,
  `extint` int(11) DEFAULT 0,
  `extposx` float DEFAULT 0,
  `extposy` float DEFAULT 0,
  `extposz` float DEFAULT 0,
  `extposa` float DEFAULT 0,
  `intvw` int(11) DEFAULT 0,
  `intint` int(11) NOT NULL DEFAULT 0,
  `intposx` float DEFAULT 0,
  `intposy` float DEFAULT 0,
  `intposz` float DEFAULT 0,
  `intposa` float DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `doors`
--

INSERT INTO `doors` (`ID`, `name`, `password`, `icon`, `locked`, `admin`, `vip`, `faction`, `family`, `garage`, `custom`, `extvw`, `extint`, `extposx`, `extposy`, `extposz`, `extposa`, `intvw`, `intint`, `intposx`, `intposy`, `intposz`, `intposa`) VALUES
(0, 'San Andreas Police Departement', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1554.78, -1675.54, 16.1953, 234.537, 0, 0, 651.699, 2538.18, -89.4551, 267.016),
(1, 'SAPD', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1564.87, -1666.98, 28.3956, 181.587, 0, 10, 218.068, 123.597, 1007.32, 85.0286),
(2, 'San Andreas Police Departement', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1568.68, -1690.12, 6.21875, 184.131, 0, 0, 681.53, 2545.95, -89.4532, 0.652221),
(3, 'City Hall', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1481, -1772.28, 18.7891, 177.517, 0, 1, 1387.57, -12.7882, 1000.98, 274.031),
(4, 'San Andreas Goverment Service', '', 19130, 0, 0, 0, 2, -1, 0, 1, 0, 0, 1485.14, -1824.97, 13.5469, 183.735, 0, 1, 1405.66, -12.4833, 1000.98, 187.405),
(5, 'San Andreas Medical Departement', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 2034.35, -1401.86, 17.2965, 182.651, 0, 1, -2035.83, -58.028, 1060.99, 273.832),
(6, 'San Andreas Medical Departement', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 1, -2007.88, -73.2096, 1060.99, 6.41084, 0, 0, 0, 0, 0, 0),
(7, 'San Andreas Medical Departement', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 1, -2013.29, -73.1903, 1060.99, 2.65063, 0, 0, 0, 0, 0, 0),
(8, 'ASGH Medical Departement', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1172.19, -1321.44, 15.3988, 278.82, 0, 0, 1265.08, -1291.38, 1061.15, 90.6992),
(9, 'ASGH Medical Departement', '', 19130, 0, 0, 0, 3, -1, 0, 1, 0, 0, 1144.88, -1324.18, 13.5853, 78.0049, 0, 0, 1240.7, -1293.2, 1061.15, 93.8326),
(10, 'ASGH Medical Departement', '', 19130, 0, 0, 0, 3, -1, 0, 1, 0, 0, 1163.41, -1329.97, 31.4847, 12.2057, 0, 0, 1243.94, -1297.65, 1061.14, 178.12),
(11, 'San Andreas News Agency', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 649.092, -1360.59, 14.0034, 96.0664, 0, 1, 2451.8, 2282.38, 91.6744, 232.272),
(12, 'San Andreas News Agency Studio', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 740.15, -1351.26, 14.7142, 265.1, 0, 1, 248.441, 1783.74, 701.086, 196.479),
(13, 'Bank Los Santos', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1466.15, -1009.92, 26.8438, 349.268, 0, 255, 2248.58, -1744.27, 1014.78, 2.82001),
(14, 'Taxi Longue', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1752.59, -1894.19, 13.5525, 72.424, 0, 1, -2158.5, 642.905, 1052.38, 184.752),
(15, 'VIP Longue', '', 19130, 0, 0, 1, 0, -1, 0, 1, 0, 0, 1797.65, -1578.89, 14.0861, 280.855, 0, 1, -4107.23, 906.906, 3.10072, 176.818),
(16, 'SANEWS', '', 19130, 0, 0, 0, 4, -1, 0, 0, 0, 1, 2473.41, 2278.42, 91.6868, 178.715, 0, 0, 737.634, -1353.05, 25.2202, 271.198),
(17, 'SANews Base', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 1, 253.447, 1780.27, 701.086, 86.788, 0, 1, 2467.58, 2253.87, 91.6868, 89.1242),
(19, 'Alhambra', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1837.03, -1682.21, 13.323, 87.4758, 0, 3, -2636.87, 1402.56, 906.461, 12.1067),
(20, 'VIP Car Garage', '', 19130, 0, 0, 1, 0, -1, 1, 1, 0, 0, 1827.26, -1538.06, 13.5469, 165.884, 0, 0, 1818.76, -1537.02, 13.3813, 84.7065),
(21, 'VIP Bike Garage', '', 19130, 0, 0, 1, 0, -1, 1, 1, 0, 0, 1754.34, -1594.77, 13.537, 79.0899, 0, 0, 1753.36, -1587.71, 13.3052, 357.622),
(22, 'Pengadilan San Andreas', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1122.71, -2036.91, 69.8942, 91.0696, 0, 1, 1356.01, 717.951, -15.7573, 260.304),
(23, 'Ganton Gym', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2229.87, -1721.23, 13.5609, 301.236, 0, 6, 774.115, -50.4708, 1000.59, 193.784),
(24, 'Sa News Basement', '', 19130, 0, 0, 0, 0, -1, 1, 0, 0, 0, 660.339, -1324.47, 13.1241, 87.6214, 0, 0, 288.313, 1514.63, 1079.45, 10.1491),
(25, 'Exit', '', 19130, 0, 0, 0, 0, -1, 1, 0, 0, 0, 658.193, -1388.54, 13.2717, 87.6214, 0, 0, 286.17, 1564.26, 1079.09, 87.6214),
(26, 'Sa news entertainment', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 267.967, 1530.33, 1079.78, 86.4677, 0, 1, 2466.74, 2279.59, 91.6744, 180.739),
(27, 'Garkot', '', 19130, 0, 0, 0, 0, -1, 1, 0, 0, 0, 1652.97, -1007.41, 24.0586, 44.1212, 0, 0, 1675.3, -2624.88, -55.2407, 179.198),
(28, 'Exit garage', '', 19130, 0, 0, 0, 0, -1, 1, 0, 0, 0, 1620.63, -993.552, 24.0688, 209.373, 0, 0, 1636.54, -2695.47, -54.6627, 94.9105),
(29, 'Da Nuncas Muera Tierra', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2754.32, -1284.53, 56.5938, 181.476, 0, 0, -14.3551, 101.269, 1101.52, 166.141),
(31, 'Pabrik Daging', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1713.12, -61.8784, 3.55469, 314.831, 0, 1, 965.381, 2107.92, 1011.03, 271.437),
(32, 'Sons_of_anarchy', '', 19130, 0, 0, 0, 0, -1, 0, 1, 3, 0, -711.224, 2537.5, 32.3227, 99.1475, 0, 0, 2227.27, 1840.11, 10.8203, 266.997),
(33, 'Auction Office', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1310.25, -1366.8, 13.5066, 12.9983, 0, 18, 1700.53, -1667.8, 20.2188, 94.3211),
(34, '21Th EastSide Hoover', '', 19130, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1864.98, -2021.14, 13.5469, 297.566, 0, 0, 2140.22, -1173.59, -10.8931, 179.857),
(35, 'Mara Salvatrucha13', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2447.88, -1962.69, 13.5469, 4.11247, 0, 0, 2187.84, -1244.91, 1529.11, 66.9935),
(36, 'Street-Gang', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, -49.8941, -269.388, 6.63319, 357.042, 0, 0, 887.657, 1918.16, -88.9744, 271.305),
(37, 'Antariksa', '', 19130, 0, 0, 0, 0, -1, 1, 0, 8, 0, 1361.88, -2545.12, 1198.78, 150.716, 0, 0, 1618.36, -2629.46, 13.5469, 195.053),
(39, 'LIFT', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1274.05, -1641.59, 27.375, 188.983, 0, 0, 1217.22, -1692.67, 19.7344, 87.6649),
(38, 'VERONA BLOCK FAMILIES', 'VERONA', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1191.22, -1652.01, 13.9455, 354.63, 438, 1, 736.03, 1672.08, 501.086, 356.23),
(40, 'ELS SCHOOL', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2755.62, -1400.41, 39.3764, 267.116, 0, 5, 1298.93, -797.01, 1084.01, 179.023),
(41, 'DeathRace Club ', '', 19130, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1833.88, -1125.61, 24.6721, 270.454, 0, 5, 1260.65, -785.432, 1091.91, 91.5207),
(42, 'Second Floor', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 10, 238.963, 114.739, 1010.22, 271.624, 0, 10, 213.979, 117.626, 1003.22, 91.966),
(43, 'SHERIFF', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 626.974, -571.668, 17.9207, 90.3074, 0, 5, 322.457, 302.995, 999.148, 354.857),
(45, 'House', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, -2582.93, 2300.32, 7.00289, 109.281, 0, 0, 0, 0, 0, 0),
(46, 'Fast Furious', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1083.08, -1226.76, 15.851, 91.2724, 0, 2, 1521.1, -47.9091, 1002.13, 267.654),
(47, 'PARADISE', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2421.55, -1219.24, 25.5616, 358.406, 0, 2, 1204.83, -13.8524, 1000.92, 178.497),
(49, 'STAR BUILDING', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1548.64, -1363.79, 326.218, 3.31068, 0, 0, 1570.44, -1337.46, 16.4844, 147.188),
(48, 'KANTIN', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 1, -794.862, 489.28, 1376.2, 179.128, 0, 5, 1284.24, -808.233, 1085.63, 358.52),
(50, 'Ammunation Willowfield', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2400.47, -1982, 13.5469, 177.598, 0, 0, 0, 0, 0, 0),
(51, 'SAGH ADMINISTRATOR', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 271.63, -48.7532, 2.77721, 357.367, 0, 0, -709.774, 1458.82, 79.1032, 78.9527),
(52, 'GUDANG', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 2, 1204.85, 12.6643, 1000.92, 2.01994, 0, 0, 0, 0, 0, 0),
(53, 'SAPD ROOM', '', 19130, 0, 0, 0, 1, -1, 1, 1, 0, 0, 1588.38, -1631.05, 13.3828, 18.0796, 0, 0, 1596.66, -1671.82, 5.88184, 358.567),
(54, 'Insurance Office', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2471.89, -1533.5, 23.6475, 35.1442, 0, 0, 2469.59, -1531.06, 23.6475, 52.2966),
(18, 'Security', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 833.175, -2269.46, 12.1297, 273.504, 0, 3, -2029.69, -119.623, 1035.17, 181.287),
(44, 'Flamboyan Company', 'zx', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1527.8, -772.566, 80.5781, 315.416, 0, 5, 1676.8, -1459.71, 3002.84, 86.534),
(56, 'rollin 30s harlem crips', '', 19130, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2334.69, -1204, 27.9766, 179.82, 5, 5, 318.489, 1115.19, 1083.88, 4.43937);

-- --------------------------------------------------------

--
-- Struktur dari tabel `familys`
--

CREATE TABLE `familys` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT 'None',
  `leader` varchar(50) NOT NULL DEFAULT 'None',
  `motd` varchar(100) NOT NULL DEFAULT 'None',
  `color` int(11) DEFAULT 0,
  `extposx` float DEFAULT 0,
  `extposy` float DEFAULT 0,
  `extposz` float DEFAULT 0,
  `extposa` float DEFAULT 0,
  `intposx` float DEFAULT 0,
  `intposy` float DEFAULT 0,
  `intposz` float DEFAULT 0,
  `intposa` float DEFAULT 0,
  `fint` int(11) NOT NULL DEFAULT 0,
  `Weapon1` int(11) NOT NULL DEFAULT 0,
  `Ammo1` int(11) NOT NULL DEFAULT 0,
  `Weapon2` int(11) NOT NULL DEFAULT 0,
  `Ammo2` int(11) NOT NULL DEFAULT 0,
  `Weapon3` int(11) NOT NULL DEFAULT 0,
  `Ammo3` int(11) NOT NULL DEFAULT 0,
  `Weapon4` int(11) NOT NULL DEFAULT 0,
  `Ammo4` int(11) NOT NULL DEFAULT 0,
  `Weapon5` int(11) NOT NULL DEFAULT 0,
  `Ammo5` int(11) NOT NULL DEFAULT 0,
  `Weapon6` int(11) NOT NULL DEFAULT 0,
  `Ammo6` int(11) NOT NULL DEFAULT 0,
  `Weapon7` int(11) NOT NULL DEFAULT 0,
  `Ammo7` int(11) NOT NULL DEFAULT 0,
  `Weapon8` int(11) NOT NULL DEFAULT 0,
  `Ammo8` int(11) NOT NULL DEFAULT 0,
  `Weapon9` int(11) NOT NULL DEFAULT 0,
  `Ammo9` int(11) NOT NULL DEFAULT 0,
  `Weapon10` int(11) NOT NULL DEFAULT 0,
  `Ammo10` int(11) NOT NULL DEFAULT 0,
  `safex` float DEFAULT 0,
  `safey` float DEFAULT 0,
  `safez` float DEFAULT 0,
  `money` int(11) NOT NULL DEFAULT 0,
  `marijuana` int(11) NOT NULL DEFAULT 0,
  `component` int(11) NOT NULL DEFAULT 0,
  `material` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `familys`
--

INSERT INTO `familys` (`ID`, `name`, `leader`, `motd`, `color`, `extposx`, `extposy`, `extposz`, `extposa`, `intposx`, `intposy`, `intposz`, `intposa`, `fint`, `Weapon1`, `Ammo1`, `Weapon2`, `Ammo2`, `Weapon3`, `Ammo3`, `Weapon4`, `Ammo4`, `Weapon5`, `Ammo5`, `Weapon6`, `Ammo6`, `Weapon7`, `Ammo7`, `Weapon8`, `Ammo8`, `Weapon9`, `Ammo9`, `Weapon10`, `Ammo10`, `safex`, `safey`, `safez`, `money`, `marijuana`, `component`, `material`) VALUES
(0, 'W/S rollin 30s Harlem CRIPS', 'Marquise_Anthony', 'None', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24, 500, 24, 100, 24, 100, 24, 100, 25, 200, 25, 200, 25, 500, 30, 500, 30, 500, 29, 500, 308.25, 1120.44, 1083.88, 625789, 500, 11564, 22625);

-- --------------------------------------------------------

--
-- Struktur dari tabel `farm`
--

CREATE TABLE `farm` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT 'None',
  `leader` varchar(50) NOT NULL DEFAULT 'None',
  `motd` varchar(100) NOT NULL DEFAULT 'None',
  `plantx` float DEFAULT 0,
  `planty` float DEFAULT 0,
  `plantz` float DEFAULT 0,
  `safex` float DEFAULT 0,
  `safey` float DEFAULT 0,
  `safez` float DEFAULT 0,
  `money` int(11) NOT NULL DEFAULT 0,
  `potato` int(11) NOT NULL DEFAULT 0,
  `wheat` int(11) NOT NULL DEFAULT 0,
  `orange` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `gates`
--

CREATE TABLE `gates` (
  `ID` int(11) NOT NULL,
  `model` int(11) NOT NULL DEFAULT 0,
  `password` varchar(36) NOT NULL DEFAULT '',
  `admin` tinyint(3) NOT NULL DEFAULT 0,
  `vip` tinyint(3) NOT NULL DEFAULT 0,
  `faction` tinyint(3) NOT NULL DEFAULT 0,
  `family` int(10) NOT NULL DEFAULT -1,
  `speed` float NOT NULL DEFAULT 2,
  `cX` float NOT NULL,
  `cY` float NOT NULL,
  `cZ` float NOT NULL,
  `cRX` float NOT NULL,
  `cRY` float NOT NULL,
  `cRZ` float NOT NULL,
  `oX` float NOT NULL,
  `oY` float NOT NULL,
  `oZ` float NOT NULL,
  `oRX` float NOT NULL,
  `oRY` float NOT NULL,
  `oRZ` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `gates`
--

INSERT INTO `gates` (`ID`, `model`, `password`, `admin`, `vip`, `faction`, `family`, `speed`, `cX`, `cY`, `cZ`, `cRX`, `cRY`, `cRZ`, `oX`, `oY`, `oZ`, `oRX`, `oRY`, `oRZ`) VALUES
(0, 980, '', 0, 0, 1, -1, 2, 1539.41, -1627.56, 15.0128, 0, 0, 90.2, 1539.41, -1627.56, 9.51278, 0, 0, 90.2),
(1, 986, '', 0, 0, 4, -1, 2, 777.918, -1385.11, 13.6232, 0, 0, 0, 769.928, -1385.11, 13.6232, 0, 0, 0),
(2, 11714, '', 0, 0, 1, -1, 2, 246.188, 72.4709, 1003.87, 0, 0, 89.1, 243.979, 72.5056, 1003.87, 0, 0, 89.1),
(3, 989, '', 0, 0, 0, -1, 2, 2227.56, -2209.11, 14.2969, 0, 0, 61.7, 2232.11, -2213.03, 14.2969, 0, 0, 61.7),
(4, 989, '', 0, 0, 0, -1, 2, 2240.78, -2221.81, 14.3369, 0, 0, 61.1, 2236.69, -2217.7, 14.3369, 0, 0, 61.1),
(5, 980, 'CIOffice', 0, 0, 1, -1, 2, 1411.17, 422.265, 20.3878, 0, 0, -25.5, 1400.68, 427.267, 20.3878, 0, 0, -25.5),
(35, 21, '', 0, 0, 0, -1, 2, 2940.79, -1874.05, 7.88125, 0, 0, 0, 2940.79, -1874.05, 7.88125, 0, 0, 0),
(37, 975, 'James', 0, 0, 0, -1, 2, 2254.62, -108.135, 26.1051, 0, 0, 0, 2254.62, -108.135, 23.7351, 0, 0, 0),
(8, 2963, '', 0, 0, 1, -1, 2, 230.919, 119.709, 1010.22, 0, 0, 90, 228.069, 119.709, 1010.22, 0, 0, 90),
(9, 19912, '', 6, 0, 0, -1, 2, 1528.21, -49.3396, 1002.13, 0, 0, -91.5, 1528.21, -49.3396, 1002.13, 0, 0, -91.5),
(10, 19912, '', 0, 0, 0, -1, 2, 562.539, -1252.86, 17.2422, 0, 0, 30.6, 552.882, -1258.57, 17.2422, 0, 0, 30.6),
(11, 19912, '', 6, 0, 0, -1, 2, 1519.98, -45.8958, 1002.13, 0, 0, 89.7, 1519.98, -45.8958, 1002.13, 0, 0, 89.7),
(12, 19912, '', 6, 0, 0, -1, 2, 453.802, -16.1566, 1001.13, 0, 0, -1.39996, 453.802, -16.1566, 1001.13, 0, 0, -1.39996),
(13, 19912, '', 0, 0, 0, -1, 2, 452.799, -16.122, 1001.13, 0, 0, 0, 454.038, -16.0657, 1001.13, 0, 0, 88.1),
(14, 2206, '', 6, 0, 0, -1, 2, 439.901, -19.0292, 1000.01, 0, 0, 91.3, 439.901, -19.0292, 1000.01, 0, 0, 91.3),
(15, 11313, '', 0, 0, 0, -1, 2, -89.2018, -1213.52, 3.089, 0, 0, -14.5, -89.2018, -1213.52, 0.149001, 0, 0, -14.5),
(16, 11313, 'cheva', 0, 0, 0, -1, 2, -81.9923, -1202.42, 3.83377, 0, 0, 75.8, -81.9923, -1202.42, 0.063769, 0, 0, 75.8),
(17, 19912, '', 0, 0, 0, -1, 2, 1286.68, -612.405, 102.32, 0, 0, 23.4, 1286.68, -612.405, 98.9898, 0, 0, 23.4),
(18, 986, '', 0, 0, 4, -1, 2, -1713.37, 985.423, 17.2339, 0, 0, -87.3001, -1713.75, 993.445, 17.2339, 0, 0, -87.3001),
(19, 19906, '', 0, 0, 0, -1, 2, 1372.13, -1745.32, 15.5069, 0, 0, 89.5, 1372.13, -1745.32, 12.5569, 0, 0, 89.5),
(20, 19906, '', 0, 0, 0, -1, 2, 1368.18, -1758.19, 15.483, 0, 0, 0, 1368.18, -1758.19, 12.603, 0, 0, 0),
(21, 19912, '', 0, 0, 0, -1, 2, 2941.36, -1876.76, 8.78125, 0, 0, 0, 2941.36, -1876.76, 8.78125, 0, 0, 0),
(23, 19912, '', 0, 0, 3, -1, 2, 1381.69, 1519.99, -71.9173, 0, 0, 0, 1381.69, 1519.99, -76.9073, 0, 0, 0),
(25, 970, '007', 0, 0, 0, -1, 2, 1306.06, -802.544, 83.6506, 0, 0, 0, 1306.06, -802.544, 82.4906, 0, 0, 0),
(22, 980, '123', 0, 0, 0, -1, 2, 321.166, -1188.42, 77.0946, 0, 0, 38.3, 321.166, -1188.42, 72.5247, 0, 0, 38.3),
(26, 980, '', 0, 0, 0, -1, 2, 1516.73, 1514.37, -30.055, 0, 0, 0, 1506.25, 1514.37, -30.055, 0, 0, 0),
(24, 19912, '', 0, 0, 3, -1, 2, 1447.27, 1520.27, -71.9679, 0, 0, 0, 1447.27, 1520.27, -76.9379, 0, 0, 0),
(27, 19325, '', 0, 0, 3, -1, 2, 1365.68, 1589.81, -60.2375, 0, 0, 0, 1365.68, 1589.81, -63.6075, 0, 0, 0),
(28, 19325, '', 0, 0, 3, -1, 2, 1383.77, 1592.14, -63.2475, 0, 0, 89.6, 1383.77, 1592.14, -60.7575, 0, 0, 89.6),
(29, 19325, '', 0, 0, 3, -1, 2, 1400.13, 1616.67, -62.4275, 0, 0, 90.1, 1397.93, 1616.67, -62.4275, 0, 0, 90.1),
(30, 19325, '', 0, 0, 3, -1, 2, 1403.62, 1625.06, -60.4675, 0, 0, 0.900009, 1403.62, 1625.06, -63.5275, 0, 0, 0.900009),
(31, 986, '', 0, 0, 4, -1, 2, -1712.99, 1051.07, 17.4335, 0, 0, -92.6, -1712.62, 1059.22, 17.4335, 0, 0, -92.6),
(7, 1569, '', 0, 0, 1, -1, 2, 167.407, 2209.31, 342.892, 0, 0, 0, 165.817, 2209.23, 342.892, 0, 0, 0),
(33, 975, '12345', 0, 0, 0, -1, 2, 263.625, -1332.54, 53.8833, 0, -2.2, 36.9, 256.728, -1337.72, 53.552, 0, -2.2, 36.9),
(34, 5422, '', 0, 0, 0, -1, 2, 658.322, -610.397, 16.5359, 0, 0, -90.7, 658.322, -610.397, 13.4259, 0, 0, -90.7),
(32, 5422, '', 0, 0, 0, -1, 2, 671.554, -614.218, 16.5859, 0, 0, 0, 671.554, -614.218, 13.4059, 0, 0, 0),
(6, 1569, '', 0, 0, 1, -1, 2, 168.675, 2224.77, 342.862, 0, 0, 0, 167.085, 2224.77, 342.862, 0, 0, 0),
(36, 0, '', 0, 0, 1, -1, 2, 631.553, -597.936, 16.3359, 0, 0, 91.3, 631.553, -597.936, 12.4359, 0, 0, 91.3),
(38, 19870, '', 0, 0, 0, -1, 2, 2071.62, -1696.53, 13.7047, 0, 0, 88.7, 2071.62, -1696.53, 10.9047, 0, 0, 88.7),
(39, 11313, 'optimum', 0, 0, 0, -1, 2, 2358.05, -38.4039, 27.1864, 0, 0, 89.9, 2358.05, -38.4039, 23.5164, 0, 0, 89.9),
(40, 35, '123', 0, 0, 0, -1, 2, 2880.26, -1891.49, 6.86285, 0, 0, 0, 2880.26, -1891.49, 6.86285, 0, 0, 0),
(41, 40, '1234', 1, 0, 0, -1, 2, 2883.02, -1889.96, 6.29219, 0, 0, 0, 2883.02, -1889.96, 6.29219, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `gstations`
--

CREATE TABLE `gstations` (
  `id` int(11) NOT NULL DEFAULT 0,
  `stock` int(11) NOT NULL DEFAULT 10000,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `gstations`
--

INSERT INTO `gstations` (`id`, `stock`, `posx`, `posy`, `posz`) VALUES
(0, 6371, 1937.56, -1772.77, 13.3828),
(1, 7387, 1944.66, -1772.42, 13.3906),
(2, 6980, -96.0828, -1160.66, 2.18832),
(3, 7145, -93.6488, -1174.95, 2.26908),
(4, 6539, 1004.67, -940.464, 42.1797),
(5, 6795, 1004.12, -933.524, 42.1797),
(6, 8470, 652.516, -565.466, 16.3359),
(7, 9640, 1380.87, 456.826, 19.91),
(8, 7221, 2114.91, 920.07, 10.8203),
(9, 10000, -2029.7, 156.477, 28.4206),
(10, 7290, -2405.13, 978.62, 45.2969),
(11, 9360, 612.262, 1694.97, 6.99219),
(12, 9080, 605.164, 1705.05, 6.77943),
(13, 9690, 608.571, 1699.78, 6.78187),
(14, 9940, -1328.63, 2682.89, 49.824),
(15, 9930, 2109.35, 927.987, 10.5814),
(16, 7708, 2450.36, -1638.37, 13.4309),
(17, 7810, 1510.44, -2183.2, 13.5605),
(18, 6900, 658.07, -564.607, 16.3359);

-- --------------------------------------------------------

--
-- Struktur dari tabel `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL DEFAULT '-',
  `address` varchar(50) DEFAULT 'None',
  `price` int(11) NOT NULL DEFAULT 500000,
  `type` int(11) NOT NULL DEFAULT 1,
  `locked` int(11) NOT NULL DEFAULT 1,
  `money` int(11) NOT NULL DEFAULT 0,
  `houseint` int(11) NOT NULL DEFAULT 0,
  `extposx` float NOT NULL DEFAULT 0,
  `extposy` float NOT NULL DEFAULT 0,
  `extposz` float NOT NULL DEFAULT 0,
  `extposa` float NOT NULL DEFAULT 0,
  `intposx` float NOT NULL DEFAULT 0,
  `intposy` float NOT NULL DEFAULT 0,
  `intposz` float NOT NULL DEFAULT 0,
  `intposa` float NOT NULL DEFAULT 0,
  `visit` bigint(16) DEFAULT 0,
  `houseWeapon1` int(12) DEFAULT 0,
  `houseWeapon2` int(12) DEFAULT 0,
  `houseWeapon3` int(12) DEFAULT 0,
  `houseWeapon4` int(12) DEFAULT 0,
  `houseWeapon5` int(12) DEFAULT 0,
  `houseWeapon6` int(12) DEFAULT 0,
  `houseWeapon7` int(12) DEFAULT 0,
  `houseWeapon8` int(12) DEFAULT 0,
  `houseWeapon9` int(12) DEFAULT 0,
  `houseWeapon10` int(12) DEFAULT 0,
  `houseAmmo1` int(12) DEFAULT 0,
  `houseAmmo2` int(12) DEFAULT 0,
  `houseAmmo3` int(12) DEFAULT 0,
  `houseAmmo4` int(12) DEFAULT 0,
  `houseAmmo5` int(12) DEFAULT 0,
  `houseAmmo6` int(12) DEFAULT 0,
  `houseAmmo7` int(12) DEFAULT 0,
  `houseAmmo8` int(12) DEFAULT 0,
  `houseAmmo9` int(12) DEFAULT 0,
  `houseAmmo10` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `houses`
--

INSERT INTO `houses` (`ID`, `owner`, `address`, `price`, `type`, `locked`, `money`, `houseint`, `extposx`, `extposy`, `extposz`, `extposa`, `intposx`, `intposy`, `intposz`, `intposa`, `visit`, `houseWeapon1`, `houseWeapon2`, `houseWeapon3`, `houseWeapon4`, `houseWeapon5`, `houseWeapon6`, `houseWeapon7`, `houseWeapon8`, `houseWeapon9`, `houseWeapon10`, `houseAmmo1`, `houseAmmo2`, `houseAmmo3`, `houseAmmo4`, `houseAmmo5`, `houseAmmo6`, `houseAmmo7`, `houseAmmo8`, `houseAmmo9`, `houseAmmo10`) VALUES
(0, 'Matthew_Gigs', 'Richman', 10000000, 3, 1, 0, 1, 300.311, -1154.52, 81.3904, 315.763, 1855.38, -1709.12, 1720.06, 273.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 'Christopher_Jahir', 'Richman', 25000000, 3, 1, 0, 1, 265.565, -1287.89, 74.6325, 23.1334, 1224.34, -749.22, 1085.72, 265.59, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Sergei_Pudovkin', 'Mulholland', 25000000, 3, 0, 0, 1, 1298.49, -797.987, 84.1406, 7.59931, 1855.38, -1709.12, 1720.06, 273.58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'Morgan_Tsatsu', 'Mulholland Intersection', 1000, 2, 0, 0, 1, 1540.47, -851.31, 64.3361, 254.379, 351.59, 1669.31, 1002.17, 176.03, 1647670543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Ryuhentai', 'Mulholland Intersection', 1, 1, 0, 0, 1, 1535.03, -800.213, 72.8495, 272.8, 1430.33, -1221.18, 152.818, 259.879, 1648040735, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lockers`
--

CREATE TABLE `lockers` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `lockers`
--

INSERT INTO `lockers` (`id`, `type`, `posx`, `posy`, `posz`, `interior`) VALUES
(0, 1, 677.299, 2545.28, -89.4512, 0),
(1, 2, 1401.98, -17.6064, 1000.98, 1),
(2, 3, 1269.93, -1309.24, 1061.14, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `loglogin`
--

CREATE TABLE `loglogin` (
  `no` int(11) NOT NULL,
  `username` varchar(40) NOT NULL DEFAULT 'None',
  `reg_id` int(11) NOT NULL DEFAULT 0,
  `password` varchar(40) NOT NULL DEFAULT 'None',
  `time` varchar(40) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `loglogin`
--

INSERT INTO `loglogin` (`no`, `username`, `reg_id`, `password`, `time`) VALUES
(327, 'Babe', 0, 'hauagsy', '2022-03-12 13:09:57'),
(326, 'TwosiXxx', 0, 'huajahsu', '2022-03-12 12:44:28'),
(325, 'TwosiXxx', 0, 'memkkkak', '2022-03-12 12:30:26'),
(324, 'TwosiXxx', 0, 'zxzxzxzxz', '2022-03-12 12:28:15'),
(323, 'TwosiXxx', 0, 'zxzxzxzx', '2022-03-12 12:25:55'),
(322, 'Joker', 0, 'joker007', '2022-03-12 12:22:45'),
(321, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 12:21:32'),
(320, 'Babe', 0, 'keongracun', '2022-03-12 12:18:27'),
(319, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 11:47:44'),
(318, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 11:05:32'),
(317, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 10:42:40'),
(316, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 10:13:19'),
(315, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 10:10:52'),
(314, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 09:37:33'),
(313, 'Joker', 0, 'joker007', '2022-03-12 09:32:43'),
(312, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 08:20:12'),
(311, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 07:24:02'),
(310, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 07:21:30'),
(309, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 07:08:26'),
(308, 'Joker', 0, 'joker007', '2022-03-12 06:57:35'),
(307, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 06:20:09'),
(306, 'TwosiXxx', 0, 'zxzzzz', '2022-03-12 05:09:48'),
(305, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 05:08:06'),
(304, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 04:54:53'),
(303, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 02:11:49'),
(302, 'TwosiXxx', 0, 'zxzxzx', '2022-03-12 01:52:09'),
(301, 'Joker', 0, 'joker007', '2022-03-11 14:49:17'),
(300, 'TwosiXxx', 0, 'zxzxzx', '2022-03-11 13:41:38'),
(299, 'TwosiXxx', 0, 'zxzxzx', '2022-03-11 12:37:29'),
(298, 'TwosiXxx', 0, 'zxzxzx', '2022-03-11 12:24:15'),
(297, 'TwosiXxx', 0, 'zxzxzx', '2022-03-11 12:06:55'),
(296, 'TwosiXxx', 0, 'zxzxzx', '2022-03-11 11:02:00'),
(295, 'TwosiXxx', 0, 'zxzxzx', '2022-03-11 10:57:59'),
(294, 'Matthew', 0, 'FAREL1000', '2022-03-11 10:57:48'),
(328, 'Anjing', 0, 'akusuka', '2022-03-13 04:52:04'),
(329, 'Anjing', 0, 'akusuka', '2022-03-13 04:53:58'),
(330, 'Twosixxx', 0, 'akusuka', '2022-03-13 05:35:11'),
(331, 'Lonely', 0, 'Maul2006', '2022-03-13 05:35:25'),
(332, 'Lonely', 0, 'Maul2006', '2022-03-13 05:37:22'),
(333, 'Lonely', 0, 'Maul2006', '2022-03-13 06:06:52'),
(334, 'Joker', 0, 'joker007', '2022-03-13 06:15:28'),
(335, 'Joker', 0, 'joker007', '2022-03-13 06:20:36'),
(336, 'Twosixxx', 0, 'akusuka', '2022-03-13 06:27:46'),
(337, 'Twosixxx', 0, 'akusuka', '2022-03-13 06:43:33'),
(338, 'Twosixxx', 0, 'akusuka', '2022-03-13 07:22:55'),
(339, 'Twosixxx', 0, 'akusuka', '2022-03-13 07:47:31'),
(340, 'Twosixxx', 0, 'akusuka', '2022-03-13 08:22:50'),
(341, 'Twosixxx', 0, 'akusuka', '2022-03-13 08:51:39'),
(342, 'Twosixxx', 0, 'akusuka', '2022-03-13 08:57:37'),
(343, 'Twosixxx', 0, 'akusuka', '2022-03-13 09:33:22'),
(344, 'Lonely', 0, 'Maul2006', '2022-03-13 11:39:53'),
(345, 'Joker', 0, 'joker007', '2022-03-13 11:40:16'),
(346, 'Lonely', 0, 'Maul2006', '2022-03-13 11:44:11'),
(347, 'Joker', 0, 'joker007', '2022-03-13 11:54:00'),
(348, 'Matthew', 0, 'FAREL1000', '2022-03-13 12:30:02'),
(349, 'Matthew', 0, 'FAREL1000', '2022-03-13 12:32:52'),
(350, 'Joker', 0, 'joker007', '2022-03-13 15:08:03'),
(351, 'Lonely', 0, 'Maul2006', '2022-03-13 15:57:54'),
(352, 'Joker', 0, 'joker007', '2022-03-13 16:48:07'),
(353, 'Lonely', 0, 'Maul2006', '2022-03-13 23:03:19'),
(354, 'Twosixxx', 0, 'akusuka', '2022-03-14 01:52:43'),
(355, 'Twosixxx', 0, 'akusuka', '2022-03-14 02:04:22'),
(356, 'Tes', 0, 'zxzxzx', '2022-03-14 02:25:57'),
(357, 'Twosixxx', 0, 'akusuka', '2022-03-14 22:59:13'),
(358, 'Twosixxx', 0, 'akusuka', '2022-03-14 23:17:16'),
(359, 'Twosixxx', 0, 'akusuka', '2022-03-14 23:26:24'),
(360, 'Twosixxx', 0, 'akusuka', '2022-03-14 23:33:13'),
(361, 'Twosixxx', 0, 'akusuka', '2022-03-14 23:59:27'),
(362, 'Twosixxx', 0, 'akusuka', '2022-03-15 00:14:31'),
(363, 'Twosixxx', 0, 'akusuka', '2022-03-15 00:24:30'),
(364, 'Twosixxx', 0, 'akusuka', '2022-03-15 00:34:11'),
(365, 'Twosixxx', 0, 'akusuka', '2022-03-15 00:40:56'),
(366, 'Twosixxx', 0, 'akusuka', '2022-03-15 00:45:00'),
(367, 'Twosixxx', 0, 'akusuka', '2022-03-15 00:48:50'),
(368, 'Alie', 0, 'aliedan12345', '2022-03-15 00:50:27'),
(369, 'Twosixxx', 0, 'akusuka', '2022-03-15 00:52:48'),
(370, 'Alie', 0, 'aliedan12345', '2022-03-15 00:54:18'),
(371, 'Twosixxx', 0, 'akusuka', '2022-03-15 00:55:59'),
(372, 'Joker', 0, 'joker007', '2022-03-15 00:57:40'),
(373, 'Twosixxx', 0, 'akusuka', '2022-03-15 01:08:13'),
(374, 'Twosixxx', 0, 'akusuka', '2022-03-15 01:15:24'),
(375, 'Twosixxx', 0, 'akusuka', '2022-03-15 05:09:29'),
(376, 'Twosixxx', 0, 'akusuka', '2022-03-15 05:23:28'),
(377, 'Twosixxx', 0, 'akusuka', '2022-03-15 05:24:06'),
(378, 'Twosixxx', 0, 'akusuka', '2022-03-15 06:23:20'),
(379, 'Twosixxx', 0, 'akusuka', '2022-03-15 06:39:35'),
(380, 'Twosixxx', 0, 'akusuka', '2022-03-15 06:55:21'),
(381, 'Twosixxx', 0, 'akusuka', '2022-03-15 07:23:58'),
(382, 'Twosixxx', 0, 'akusuka', '2022-03-15 07:26:23'),
(383, 'Twosixxx', 0, 'akusuka', '2022-03-15 07:28:40'),
(384, 'Twosixxx', 0, 'akusuka', '2022-03-15 07:34:01'),
(385, 'Twosixxx', 0, 'akusuka', '2022-03-15 07:53:12'),
(386, 'Twosixxx', 0, 'akusuka', '2022-03-15 12:54:16'),
(387, 'Joker', 0, 'joker007', '2022-03-15 14:10:20'),
(388, 'Twosixxx', 0, 'akusuka', '2022-03-16 14:11:33'),
(389, 'Twosixxx', 0, 'akusuka', '2022-03-17 12:21:48'),
(390, 'Twosixxx', 0, 'akusuka', '2022-03-17 13:09:54'),
(391, 'Twosixxx', 0, 'akusuka', '2022-03-17 13:15:38'),
(392, 'Matthew', 0, 'FAREL1000', '2022-03-17 13:26:52'),
(393, 'Paul', 0, 'asadekon', '2022-03-17 13:46:34'),
(394, 'Twosixxx', 0, 'akusuka', '2022-03-17 13:47:28'),
(395, 'Paul', 0, 'asadekon', '2022-03-17 13:49:02'),
(396, 'Paul', 0, 'asadekon', '2022-03-17 13:54:05'),
(397, 'Paul', 0, 'asadekon', '2022-03-17 14:10:15'),
(398, 'Joker', 0, 'joker007', '2022-03-17 14:34:55'),
(399, 'Joker', 0, 'joker007', '2022-03-17 14:42:57'),
(400, 'Doyo', 0, 'keongracun', '2022-03-17 16:20:59'),
(401, 'Joker', 0, 'joker007', '2022-03-17 16:29:43'),
(402, 'Doyo', 0, 'keongracun', '2022-03-17 16:33:04'),
(403, 'Dedi', 0, 'Amar1001', '2022-03-17 16:42:28'),
(404, 'Paul', 0, 'asadekon', '2022-03-17 16:42:35'),
(405, 'Doyo', 0, 'keongracun', '2022-03-17 16:47:05'),
(406, 'Dedi', 0, 'Amar1001', '2022-03-17 16:47:43'),
(407, 'Paul', 0, 'asadekon', '2022-03-17 16:53:47'),
(408, 'Paul', 0, 'asadekon', '2022-03-17 16:55:21'),
(409, 'Dedi', 0, 'Amar1001', '2022-03-17 17:08:31'),
(410, 'Paul', 0, 'asadekon', '2022-03-17 17:10:16'),
(411, 'Paul', 0, 'asadekon', '2022-03-17 22:52:29'),
(412, 'Paul', 0, 'asadekon', '2022-03-17 23:04:00'),
(413, 'Paul', 0, 'asadekon', '2022-03-17 23:07:25'),
(414, 'Paul', 0, 'asadekon', '2022-03-17 23:24:02'),
(415, 'Doyo', 0, 'keongracun', '2022-03-17 23:54:18'),
(416, 'Doyo', 0, 'keongracun', '2022-03-17 23:58:26'),
(417, 'Doyo', 0, 'keongracun', '2022-03-17 23:59:16'),
(418, 'Doyo', 0, 'keongracun', '2022-03-18 00:20:51'),
(419, 'Paul', 0, 'asadekon', '2022-03-18 00:28:56'),
(420, 'Doyo', 0, 'keongracun', '2022-03-18 02:01:11'),
(421, 'Paul', 0, 'asadekon', '2022-03-18 02:15:49'),
(422, 'Doyo', 0, 'keongracun', '2022-03-18 04:22:38'),
(423, 'Doyo', 0, 'keongracun', '2022-03-18 06:25:18'),
(424, 'Doyo', 0, 'keongracun', '2022-03-18 06:30:53'),
(425, 'Paul', 0, 'asadekon', '2022-03-18 09:08:53'),
(426, 'Paul', 0, 'asadekon', '2022-03-18 09:31:06'),
(427, 'Paul', 0, 'asadekon', '2022-03-18 10:43:43'),
(428, 'Paul', 0, 'asadekon', '2022-03-18 11:28:05'),
(429, 'Twosixxx', 0, 'akusuka', '2022-03-18 12:06:18'),
(430, 'Doyo', 0, 'keongracun', '2022-03-18 12:06:21'),
(431, 'Doyo', 0, 'keongracun', '2022-03-18 13:01:12'),
(432, 'Doyo', 0, 'keongracun', '2022-03-18 13:11:41'),
(433, 'Twosixxx', 0, 'akusuka', '2022-03-18 13:25:36'),
(434, 'Joker', 0, 'joker007', '2022-03-18 13:37:33'),
(435, 'Twosixxx', 0, 'akusuka', '2022-03-18 13:58:25'),
(436, 'Paul', 0, 'asadekon', '2022-03-18 14:30:04'),
(437, 'Doyo', 0, 'keongracun', '2022-03-18 14:52:35'),
(438, 'Doyo', 0, 'keongracun', '2022-03-18 14:59:02'),
(439, 'Gustavo', 0, 'BUDIOSAM134', '2022-03-18 15:23:27'),
(440, 'Paul', 0, 'asadekon', '2022-03-18 15:32:23'),
(441, 'Doyo', 0, 'keongracun', '2022-03-18 23:22:10'),
(442, 'Doyo', 0, 'keongracun', '2022-03-18 23:23:46'),
(443, 'Doyo', 0, 'keongracun', '2022-03-18 23:35:07'),
(444, 'Doyo', 0, 'keongracun', '2022-03-19 00:29:48'),
(445, 'Doyo', 0, 'keongracun', '2022-03-19 00:39:58'),
(446, 'Doyo', 0, 'keongracun', '2022-03-19 00:54:27'),
(447, 'Twosixxx', 0, 'akusuka', '2022-03-19 02:11:07'),
(448, 'Doyo', 0, 'keongracun', '2022-03-19 02:11:33'),
(449, 'Joker', 0, 'joker007', '2022-03-19 02:12:16'),
(450, 'Joker', 0, 'joker007', '2022-03-19 02:14:05'),
(451, 'Joker', 0, 'joker007', '2022-03-19 02:15:17'),
(452, 'Doyo', 0, 'keongracun', '2022-03-19 02:30:57'),
(453, 'Twosixxx', 0, 'akusuka', '2022-03-19 02:36:57'),
(454, 'Matthew', 0, 'FAREL1000', '2022-03-19 02:45:42'),
(455, 'Matthew', 0, 'FAREL1000', '2022-03-19 02:46:20'),
(456, 'Matthew', 0, 'FAREL1000', '2022-03-19 02:47:11'),
(457, 'Twosixxx', 0, 'akusuka', '2022-03-19 02:53:03'),
(458, 'Twosixxx', 0, 'akusuka', '2022-03-19 03:03:54'),
(459, 'Twosixxx', 0, 'akusuka', '2022-03-19 03:06:14'),
(460, 'Twosixxx', 0, 'akusuka', '2022-03-19 03:15:27'),
(461, 'Twosixxx', 0, 'akusuka', '2022-03-19 03:19:03'),
(462, 'Lonely', 0, 'Maul2006', '2022-03-19 03:36:17'),
(463, 'Zyu', 0, 'repan37julianto', '2022-03-19 03:53:27'),
(464, 'Lonely', 0, 'Maul2006', '2022-03-19 03:59:17'),
(465, 'Lonely', 0, 'Maul2006', '2022-03-19 04:14:42'),
(466, 'Zyu', 0, 'repan37julianto', '2022-03-19 04:34:37'),
(467, 'Twosixxx', 0, 'akusuka', '2022-03-19 04:45:50'),
(468, 'Twosixxx', 0, 'akusuka', '2022-03-19 04:47:42'),
(469, 'Virjil', 0, 'aditdede', '2022-03-19 04:58:24'),
(470, 'Twosixxx', 0, 'akusuka', '2022-03-19 05:01:15'),
(471, 'Virjil', 0, 'aditdede', '2022-03-19 05:02:21'),
(472, 'Matthew', 0, 'FAREL1000', '2022-03-19 05:13:50'),
(473, 'Joker', 0, 'joker007', '2022-03-19 05:15:13'),
(474, 'Virjil', 0, 'aditdede', '2022-03-19 05:30:43'),
(475, 'Twosixxx', 0, 'akusuka', '2022-03-19 05:31:45'),
(476, 'Lonely', 0, 'Maul2006', '2022-03-19 05:54:42'),
(477, 'Lonely', 0, 'Maul2006', '2022-03-19 06:03:12'),
(478, 'Lonely', 0, 'Maul2006', '2022-03-19 06:10:24'),
(479, 'Joker', 0, 'joker007', '2022-03-19 06:12:59'),
(480, 'Twosixxx', 0, 'akusuka', '2022-03-19 06:16:01'),
(481, 'Virjil', 0, 'aditdede', '2022-03-19 06:26:07'),
(482, 'Zyu', 0, 'repan37julianto', '2022-03-19 06:34:11'),
(483, 'Twosixxx', 0, 'akusuka', '2022-03-19 09:13:51'),
(484, 'Donbose', 0, 'Maul2006', '2022-03-19 10:21:55'),
(485, 'Zyu', 0, 'repan37julianto', '2022-03-19 10:23:14'),
(486, 'Donbose', 0, 'Maul2006', '2022-03-19 10:24:11'),
(487, 'Lonely', 0, 'Maul2006', '2022-03-19 10:29:17'),
(488, 'Twosixxx', 0, 'akusuka', '2022-03-19 10:36:26'),
(489, 'Twosixxx', 0, 'akusuka', '2022-03-19 10:41:11'),
(490, 'Paul', 0, 'asadekon', '2022-03-19 12:39:05'),
(491, 'Paul', 0, 'asadekon', '2022-03-19 12:47:24'),
(492, 'Paul', 0, 'asadekon', '2022-03-19 12:49:02'),
(493, 'Twosixxx', 0, 'akusuka', '2022-03-19 12:58:31'),
(494, 'Twosixxx', 0, 'akusuka', '2022-03-19 13:01:24'),
(495, 'Paul', 0, 'asadekon', '2022-03-19 13:05:32'),
(496, 'Twosixxx', 0, 'akusuka', '2022-03-19 13:05:53'),
(497, 'Twosixxx', 0, 'akusuka', '2022-03-19 13:14:22'),
(498, 'Twosixxx', 0, 'akusuka', '2022-03-19 13:18:25'),
(499, 'Twosixxx', 0, 'akusuka', '2022-03-19 13:19:46'),
(500, 'Twosixxx', 0, 'akusuka', '2022-03-19 13:32:28'),
(501, 'Twosixxx', 0, 'akusuka', '2022-03-19 13:43:51'),
(502, 'Twosixxx', 0, 'akusuka', '2022-03-19 13:57:31'),
(503, 'Twosixxx', 0, 'akusuka', '2022-03-19 14:01:36'),
(504, 'Twosixxx', 0, 'akusuka', '2022-03-19 14:14:13'),
(505, 'Twosixxx', 0, 'akusuka', '2022-03-19 14:25:22'),
(506, 'Paul', 0, 'asadekon', '2022-03-19 15:49:50'),
(507, 'Clawz', 0, 'ppp123', '2022-03-19 22:05:58'),
(508, 'Doyo', 0, 'keongracun', '2022-03-20 00:04:21'),
(509, 'Lonely', 0, 'Maul2006', '2022-03-20 00:49:19'),
(510, 'Lonely', 0, 'Maul2006', '2022-03-20 01:01:14'),
(511, 'Twosixxx', 0, 'akusuka', '2022-03-20 01:31:02'),
(512, 'Twosixxx', 0, 'akusuka', '2022-03-20 01:52:20'),
(513, 'Twosixxx', 0, 'akusuka', '2022-03-20 02:00:01'),
(514, 'Zyu', 0, 'repan37julianto', '2022-03-20 02:01:11'),
(515, 'Twosixxx', 0, 'akusuka', '2022-03-20 02:02:03'),
(516, 'Joker', 0, 'joker007', '2022-03-20 02:07:31'),
(517, 'Matthew', 0, 'FAREL1000', '2022-03-20 03:40:35'),
(518, 'Twosixxx', 0, 'akusuka', '2022-03-20 03:55:19'),
(519, 'Twosixxx', 0, 'akusuka', '2022-03-20 03:58:00'),
(520, 'Twosixxx', 0, 'akusuka', '2022-03-20 04:00:01'),
(521, 'Twosixxx', 0, 'akusuka', '2022-03-20 04:05:58'),
(522, 'Joker', 0, 'joker007', '2022-03-20 05:15:51'),
(523, 'Twosixxx', 0, 'akusuka', '2022-03-20 06:22:03'),
(524, 'Joker', 0, 'joker007', '2022-03-20 06:37:17'),
(525, 'Twosixxx', 0, 'akusuka', '2022-03-20 07:10:50'),
(526, 'Twosixxx', 0, 'akusuka', '2022-03-20 07:13:57'),
(527, 'Twosixxx', 0, 'akusuka', '2022-03-20 07:16:54'),
(528, 'Paul', 0, 'asadekon', '2022-03-20 10:31:27'),
(529, 'Virjil', 0, 'aditdede', '2022-03-20 11:02:51'),
(530, 'Joker', 0, 'joker007', '2022-03-20 11:12:13'),
(531, 'Gustavo', 0, 'BUDIOSAM134', '2022-03-20 11:20:19'),
(532, 'Nikola', 0, 'ilham712', '2022-03-20 12:14:59'),
(533, 'Paul', 0, 'asadekon', '2022-03-20 18:06:00'),
(534, 'Aight', 0, 'Jordanturu', '2022-03-21 04:41:06'),
(535, 'Aight', 0, 'Jordanturu', '2022-03-21 05:19:01'),
(536, 'Aight', 0, 'Jordanturu', '2022-03-21 05:54:04'),
(537, 'Twosixxx', 0, 'akusuka', '2022-03-21 08:52:52'),
(538, 'Twosixxx', 0, 'akusuka', '2022-03-21 09:00:52'),
(539, 'Aight', 0, 'Jordanturu', '2022-03-21 09:07:08'),
(540, 'Twosixxx', 0, 'akusuka', '2022-03-21 09:15:55'),
(541, 'Matthew', 0, 'FAREL1000', '2022-03-21 10:36:40'),
(542, 'Twosixxx', 0, 'akusuka', '2022-03-21 11:26:40'),
(543, 'Matthew', 0, 'FAREL1000', '2022-03-21 11:29:03'),
(544, 'Paul', 0, 'asadekon', '2022-03-21 11:31:01'),
(545, 'Twosixxx', 0, 'akusuka', '2022-03-21 12:13:01'),
(546, 'Razor', 0, 'dikaalfauzi17', '2022-03-21 12:27:00'),
(547, 'Aight', 0, 'Jordanturu', '2022-03-21 14:11:30'),
(548, 'Paul', 0, 'asadekon', '2022-03-21 19:38:21'),
(549, 'Paul', 0, 'asadekon', '2022-03-21 20:29:25'),
(550, 'Lonely', 0, 'Maul2006', '2022-03-22 05:29:07'),
(551, 'Paul', 0, 'asadekon', '2022-03-22 06:33:29'),
(552, 'Lonely', 0, 'Maul2006', '2022-03-22 06:37:51'),
(553, 'Twosixxx', 0, 'akusuka', '2022-03-22 13:09:10'),
(554, 'Twosixxx', 0, 'akusuka', '2022-03-22 13:30:32'),
(555, 'Joker', 0, 'joker007', '2022-03-22 13:34:54'),
(556, 'Lonely', 0, 'Maul2006', '2022-03-22 13:36:52'),
(557, 'Twosixxx', 0, 'akusuka', '2022-03-22 13:43:11'),
(558, 'Lonely', 0, 'Maul2006', '2022-03-22 14:00:11'),
(559, 'Doyo', 0, 'keongracun', '2022-03-22 14:01:47'),
(560, 'Lonely', 0, 'Maul2006', '2022-03-22 14:04:32'),
(561, 'Lonely', 0, 'Maul2006', '2022-03-22 14:14:08'),
(562, 'Lonely', 0, 'Maul2006', '2022-03-22 14:24:16'),
(563, 'Twosixxx', 0, 'akusuka', '2022-03-22 14:27:18'),
(564, 'Aight', 0, 'Jordanturu', '2022-03-22 16:43:44'),
(565, 'Lonely', 0, 'Maul2006', '2022-03-22 22:57:43'),
(566, 'Paul', 0, 'asadekon', '2022-03-22 23:21:17'),
(567, 'Lonely', 0, 'Maul2006', '2022-03-23 04:22:02'),
(568, 'Matthew', 0, 'FAREL1000', '2022-03-23 05:00:32'),
(569, 'Bramz', 0, 'BUDIOSAM134', '2022-03-23 07:49:29'),
(570, 'Bramz', 0, 'BUDIOSAM134', '2022-03-23 07:50:56'),
(571, 'Lonely', 0, 'Maul2006', '2022-03-23 08:17:34'),
(572, 'Bramz', 0, 'BUDIOSAM134', '2022-03-23 09:33:41'),
(573, 'Twosixxx', 0, 'akusuka', '2022-03-23 10:43:41'),
(574, 'Bramz', 0, 'BUDIOSAM134', '2022-03-23 11:27:59'),
(575, 'Twosixxx', 0, 'akusuka', '2022-03-23 12:38:35'),
(576, 'Twosixxx', 0, 'akusuka', '2022-03-23 12:44:17'),
(577, 'Crime_Hunter', 0, 'rifal123', '2022-03-23 12:51:48'),
(578, 'Twosixxx', 0, 'akusuka', '2022-03-23 12:54:20'),
(579, 'Matthew', 0, 'FAREL1000', '2022-03-23 12:56:03'),
(580, 'Twosixxx', 0, 'akusuka', '2022-03-23 13:00:56'),
(581, 'Razor', 0, 'dikaalfauzi17', '2022-03-23 13:01:19'),
(582, 'Joker', 0, 'joker007', '2022-03-23 13:06:33'),
(583, 'Crime_Hunter', 0, 'rifal123', '2022-03-23 13:08:30'),
(584, 'Razor', 0, 'dikaalfauzi17', '2022-03-23 13:10:56'),
(585, 'Virjil', 0, 'aditdede', '2022-03-23 13:25:15'),
(586, 'Aight', 0, 'Jordanturu', '2022-03-23 14:36:42');

-- --------------------------------------------------------

--
-- Struktur dari tabel `logpay`
--

CREATE TABLE `logpay` (
  `player` varchar(40) NOT NULL DEFAULT 'None',
  `playerid` int(11) NOT NULL DEFAULT 0,
  `toplayer` varchar(40) NOT NULL DEFAULT 'None',
  `toplayerid` int(11) NOT NULL DEFAULT 0,
  `ammount` int(11) NOT NULL DEFAULT 0,
  `time` bigint(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `logstaff`
--

CREATE TABLE `logstaff` (
  `command` varchar(50) NOT NULL,
  `admin` varchar(50) NOT NULL,
  `adminid` int(11) NOT NULL,
  `player` varchar(50) NOT NULL DEFAULT '*',
  `playerid` int(11) NOT NULL DEFAULT -1,
  `str` varchar(50) NOT NULL DEFAULT '*',
  `time` bigint(15) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `logstaff`
--

INSERT INTO `logstaff` (`command`, `admin`, `adminid`, `player`, `playerid`, `str`, `time`) VALUES
('SETADMINLEVEL', 'Ameks_Clacius(Madison)', 0, 'Sergei_Pudovkin', 0, '6', 1642302858),
('SETFACTION', 'Sergei_Pudovkin(Joker)', 0, 'Sergei_Pudovkin', 0, '2(6 rank)', 1642302994),
('SETLEADER', 'Sergei_Pudovkin(Joker)', 0, 'Sergei_Pudovkin', 0, '2', 1642303009),
('SETLEVEL', 'Sergei_Pudovkin(Joker)', 0, 'Sergei_Pudovkin', 0, '6', 1642306549),
('GIVEMONEY', 'Sergei_Pudovkin(Joker)', 0, 'Sergei_Pudovkin', 0, '100', 1642314584),
('GIVEMONEY', 'Sergei_Pudovkin(Joker)', 0, 'Farr_Ocoonor', 0, '100', 1642314597),
('SETBANKMONEY', 'Sergei_Pudovkin(Joker)', 0, 'Sergei_Pudovkin', 0, '100', 1642314705),
('SETBANKMONEY', 'Sergei_Pudovkin(Joker)', 0, 'Sergei_Pudovkin', 0, '1005600', 1642314725),
('SETLEVEL', 'Zenn_Luxury(Zenn)', 178, 'Alexander_Alvaro', 189, '2', 1642321628),
('SETMONEY', 'Zenn_Luxury(Zenn)', 178, 'Alexander_Alvaro', 189, '3000000', 1642321657),
('SETADMINLEVEL', 'Zenn_Luxury(Zenn)', 1, 'Sergei_Pudovkin', 5, '6', 1642336798),
('SETADMINLEVEL', 'Zenn_Luxury(Zenn)', 1, 'Farr_Ocoonor', 6, '1', 1642336823),
('SETADMINLEVEL', 'Zenn_Luxury(Zenn)', 1, 'Farr_Ocoonor', 6, '0', 1642336848),
('SETFACTION', 'Sergei_Pudovkin(Joker)', 5, 'Sergei_Pudovkin', 5, '2(6 rank)', 1642337025),
('SETLEADER', 'Sergei_Pudovkin(Joker)', 5, 'Sergei_Pudovkin', 5, '2', 1642337036),
('GIVEMONEY', 'Sergei_Pudovkin(Joker)', 5, 'Sergei_Pudovkin', 5, '15000', 1642337717),
('GIVEMONEY', 'Sergei_Pudovkin(Joker)', 5, 'Sergei_Pudovkin', 5, '1500000', 1642337744),
('GIVEMONEY', 'Sergei_Pudovkin(Joker)', 5, 'Morgan_Nemesis', 2, '19000', 1642338770),
('GIVEMONEY', 'Sergei_Pudovkin(Joker)', 5, 'Morgan_Nemesis', 2, '19000', 1642338784),
('GIVEMONEY', 'Sergei_Pudovkin(Joker)', 5, 'Morgan_Nemesis', 2, '190000', 1642338818),
('GIVEBANKMONEY', 'Sergei_Pudovkin(Joker)', 5, 'Morgan_Nemesis', 2, '6000', 1642339212),
('GIVEBANKMONEY', 'Sergei_Pudovkin(Joker)', 5, 'Morgan_Nemesis', 2, '600000', 1642339218),
('SETLEVEL', 'Sergei_Pudovkin(Joker)', 5, 'Rexxy_Kaneddy', 7, '2', 1642339528),
('GIVEMONEY', 'Sergei_Pudovkin(Joker)', 5, 'Rexxy_Kaneddy', 7, '620000', 1642339549),
('SETLEVEL', 'Sergei_Pudovkin(Joker)', 5, 'Sergei_Pudovkin', 5, '6', 1642339708),
('SETADMINLEVEL', 'Zenn_Luxury(Zenn)', 1, 'Farel_Sonda', 3, '1', 1642418679),
('SETBANKMONEY', 'Zenn_Luxury(Zenn)', 1, 'Farel_Sonda', 3, '10000000', 1642418715),
('SETVIP', 'Zenn_Luxury(Zenn)', 1, 'Farel_Sonda', 3, '3(20 days)', 1642418817),
('SETVIP', 'Zenn_Luxury(Zenn)', 1, 'Morgan_Nemesis', 2, '1(14 days)', 1642418956),
('SETVIP', 'Zenn_Luxury(Zenn)', 1, 'Zenn_Luxury', 1, '3(0 days)', 1642419292),
('SETADMINLEVEL', 'Ameks_Clacius(None)', 9, 'Dedi_Saptadji', 4, '1', 1642425148),
('SETADMINLEVEL', 'Sergei_Pudovkin(Joker)', 5, 'Blitz_Jokz', 19, '6', 1642463655),
('SETFACTION', 'Blitz_Jokz(Jokerz)', 19, 'Blitz_Jokz', 19, '1(6 rank)', 1642464051),
('SETLEADER', 'Blitz_Jokz(Jokerz)', 19, 'Blitz_Jokz', 19, '1', 1642464066),
('GIVEMONEY', 'Blitz_Jokz(Jokerz)', 19, 'Blitz_Jokz', 19, '120000', 1642468706),
('SETLEVEL', 'Zenn_Luxury(Zenn)', 1, 'Zenn_Luxury', 1, '20', 1642513195),
('SETBOOSTER', 'Zenn_Luxury(Zenn)', 1, 'Zenn_Luxury', 1, '(0 days)', 1642513222),
('SETCOMPONENT', 'Zenn_Luxury(Zenn)', 1, 'Zenn_Luxury', 1, '5000', 1642513416),
('GIVEMONEY', 'Karem_Cytevus(M4DISON)', 9, 'Karem_Cytevus', 9, '20000', 1642852433),
('GIVEMONEY', 'Karem_Cytevus(M4DISON)', 9, 'Karem_Cytevus', 9, '200000', 1642852441),
('GIVEMONEY', 'Karem_Cytevus(M4DISON)', 9, 'Karem_Cytevus', 9, '2000000', 1642852444),
('SETLEVEL', 'Karem_Cytevus(M4DISON)', 9, 'Morgan_Nemesis', 2, '3', 1642852657),
('SETLEVEL', 'Karem_Cytevus(M4DISON)', 9, 'Morgan_Nemesis', 2, '5', 1642852823),
('SETCOMPONENT', 'Bob_Snow(Bob)', 32, 'Bob_Snow', 32, '20000', 1646805749),
('SETADMINLEVEL', 'Bob_Snow(Bob)', 32, 'Blitz_Alpart', 37, '6', 1646882027),
('SETADMINLEVEL', 'Frank_Lucaslo(Twosix)', 38, 'Sergei_Pudovkin', 42, '6', 1646913988),
('SETFACTION', 'Sergei_Pudovkin(JOKER)', 42, 'Sergei_Pudovkin', 42, '1(6 rank)', 1646914445),
('SETLEADER', 'Sergei_Pudovkin(JOKER)', 42, 'Sergei_Pudovkin', 42, '1', 1646914456),
('SETLEVEL', 'Sergei_Pudovkin(JOKER)', 42, 'Sergei_Pudovkin', 42, '6', 1646915104),
('SETFACTION', 'Sergei_Pudovkin(JOKER)', 42, 'Sergei_Pudovkin', 42, '2(6 rank)', 1646915774),
('SETCOMPONENT', 'Sergei_Pudovkin(JOKER)', 42, 'Sergei_Pudovkin', 42, '5000', 1646916128),
('SETCOMPONENT', 'Frank_Lucaslo(Twosix)', 38, 'Frank_Lucaslo', 38, '2000', 1646916665),
('SETADMINLEVEL', 'Frank_Lucaslo(Twosix)', 38, 'Matthew_Gigs', 44, '3', 1646973097),
('SETMONEY', 'Frank_Lucaslo(Twosix)', 38, 'Frank_Lucaslo', 38, '200000', 1646974077),
('GIVEMONEY', 'Frank_Lucaslo(Twosix)', 38, 'Frank_Lucaslo', 38, '4500', 1646976968),
('GIVEMONEY', 'Frank_Lucaslo(Twosix)', 38, 'Frank_Lucaslo', 38, '20937', 1646983157),
('SETVIP', 'Frank_Lucaslo(Twosix)', 38, 'Frank_Lucaslo', 38, '3(0 days)', 1646983282),
('SETLEVEL', 'Frank_Lucaslo(Twosix)', 45, 'Matthew_Gigs', 44, '6', 1646996673),
('SETADMINLEVEL', 'Frank_Lucaslo(Twosix)', 45, 'Ryuu_Tatsuya', 46, '1', 1646997310),
('SETLEVEL', 'Frank_Lucaslo(Twosix)', 45, 'Frank_Lucaslo', 45, '9', 1647050291),
('SETCOMPONENT', 'Frank_Lucaslo(Twosix)', 45, 'Frank_Lucaslo', 45, '20000', 1647086068),
('SETMATERIAL', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '200', 1647156266),
('SETCOMPONENT', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '200', 1647156286),
('SETADMINLEVEL', 'Sergei_Pudovkin(JOKER)', 52, 'Matthew_Gigs', 53, '3', 1647174720),
('GIVEMONEY', 'Sergei_Pudovkin(JOKER)', 52, 'Matthew_Gigs', 53, '100', 1647175026),
('GIVEMONEY', 'Sergei_Pudovkin(JOKER)', 52, 'Matthew_Gigs', 53, '35000000', 1647175038),
('SETVIP', 'Sergei_Pudovkin(JOKER)', 52, 'Matthew_Gigs', 53, '3(20 days)', 1647175068),
('SETLEVEL', 'Sergei_Pudovkin(JOKER)', 52, 'Matthew_Gigs', 53, '6', 1647175314),
('SETADMINLEVEL', 'Sergei_Pudovkin(JOKER)', 52, 'Dedi_Saptadji', 58, '3', 1647535735),
('GIVEMONEY', 'Sergei_Pudovkin(JOKER)', 52, 'Christopher_Jahir', 57, '50000', 1647535820),
('GIVEMONEY', 'Sergei_Pudovkin(JOKER)', 52, 'Christopher_Jahir', 57, '500000', 1647535832),
('SETFACTION', 'Sergei_Pudovkin(JOKER)', 52, 'Sergei_Pudovkin', 52, '1(6 rank)', 1647537035),
('SETLEADER', 'Sergei_Pudovkin(JOKER)', 52, 'Sergei_Pudovkin', 52, '1', 1647537060),
('SETFACTION', 'Sergei_Pudovkin(JOKER)', 52, 'Sergei_Pudovkin', 52, '2(6 rank)', 1647610721),
('SETLEVEL', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '12', 1647612128),
('SETVIP', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '3(0 days)', 1647612166),
('SETCOMPONENT', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '5', 1647655889),
('SETMONEY', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '10000', 1647657799),
('SETMONEY', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '100000', 1647657909),
('GIVEMONEY', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '100000', 1647659790),
('SETCOMPONENT', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '10', 1647659885),
('SETADMINLEVEL', 'Frank_Lucaslo(Twosix)', 50, 'James_Jhonson', 62, '3', 1647666160),
('GIVEMONEY', 'Frank_Lucaslo(Twosix)', 50, 'James_Jhonson', 62, '500000', 1647666338),
('GIVEMONEY', 'Sergei_Pudovkin(JOKER)', 52, 'Morgan_Tsatsu', 51, '300000', 1647670486),
('SETMONEY', 'Frank_Lucaslo(Twosix)', 50, 'Frank_Lucaslo', 50, '600000', 1647671119),
('SETLEVEL', 'Jhonatan_Garner(Twosix)', 50, 'Morgan_Tsatsu', 51, '5', 1647686279),
('SETCOMPONENT', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '40', 1647687557),
('SETMATERIAL', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '100', 1647687575),
('SETCOINT', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '200', 1647694723),
('SETCOINT', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '200', 1647695174),
('SETCOINT', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '20', 1647695927),
('SETCOINT', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '2000', 1647696766),
('SETCOINT', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '20', 1647697472),
('SETCOINT', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '300000', 1647698324),
('SETCOINT', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '200', 1647698357),
('SETCOMPONENT', 'Marquise_Anthony(None)', 65, 'Marquise_Anthony', 65, '500', 1647761278),
('SETCOMPONENT', 'Marquise_Anthony(None)', 65, 'Marquise_Anthony', 65, '7802', 1647761313),
('SETCOMPONENT', 'Marquise_Anthony(None)', 65, 'Marquise_Anthony', 65, '3762', 1647761338),
('SETMATERIAL', 'Marquise_Anthony(None)', 65, 'Marquise_Anthony', 65, '22625', 1647761361),
('SETMONEY', 'Marquise_Anthony(None)', 65, 'Marquise_Anthony', 65, '625789', 1647761392),
('SETMONEY', 'Marquise_Anthony(None)', 65, 'Marquise_Anthony', 65, '625789', 1647761462),
('GIVEMONEY', 'Blitz_Alpart(Jokers)', 60, 'Blitz_Alpart', 60, '100000', 1647775486),
('SETADMINLEVEL', 'Jhonatan_Garner(Twosix)', 50, 'Ryuu_Tatsuya', 68, '2', 1648040510),
('SETVIP', 'Jhonatan_Garner(Twosix)', 50, 'Ryuu_Tatsuya', 68, '1(5 days)', 1648040856),
('GIVEMONEY', 'Jhonatan_Garner(Twosix)', 50, 'Jhonatan_Garner', 50, '30000000', 1648041223),
('SETLEVEL', 'Jhonatan_Garner(Twosix)', 50, 'Ryuu_Tatsuya', 68, '5', 1648041272),
('SETFACTION', 'Sergei_Pudovkin(JOKER)', 52, 'Sergei_Pudovkin', 52, '1(6 rank)', 1648041882),
('SETADMINLEVEL', 'Jhonatan_Garner(Twosix)', 50, 'James_Jhonson', 62, '4', 1648042029),
('SETLEVEL', 'Sergei_Pudovkin(JOKER)', 52, 'Crime_Hunter', 69, '2', 1648042330);

-- --------------------------------------------------------

--
-- Struktur dari tabel `ores`
--

CREATE TABLE `ores` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0,
  `posrx` float DEFAULT 0,
  `posry` float DEFAULT 0,
  `posrz` float DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ores`
--

INSERT INTO `ores` (`id`, `type`, `posx`, `posy`, `posz`, `posrx`, `posry`, `posrz`) VALUES
(0, 0, 647.103, 856.014, -43.3934, 0, 0, 0),
(1, 0, 641.371, 859.606, -43.3978, 0, 0, 0),
(2, 0, 645.222, 862.151, -43.6763, 0, 0, 0),
(3, 1, 638.152, 862.577, -43.9609, 0, 0, 0),
(4, 1, 630.862, 860.219, -43.9609, 0, 0, 0),
(5, 1, 631.9, 854.171, -43.9609, 0, 0, 0),
(6, 1, 636.357, 847.64, -43.9609, 0, 0, 0),
(7, 1, 630.883, 840.381, -43.9609, 0, 0, 0),
(8, 0, 636.853, 834.52, -43.9609, 0, 0, 0),
(9, 0, 628.883, 831.129, -43.9609, 0, 0, 0),
(10, 0, 630.221, 825.405, -43.9609, 0, 0, 0),
(11, 0, 634.77, 822.776, -43.3634, 0, 0, 0),
(12, 0, 641.479, 819.856, -43.8635, 0, 0, 0),
(13, 0, 643.362, 822.669, -43.5062, 0, 0, 0),
(14, 0, 646.961, 827.178, -43.9609, 0, 0, 0),
(15, 0, 643.876, 831.343, -43.9609, 0, 0, 0),
(16, 0, 642.138, 849.987, -43.9609, 0, 0, 0),
(17, 0, 621.96, 846.19, -43.2633, 0, 0, 0),
(18, 0, 617.265, 836.341, -43.9726, 0, 0, 0),
(19, 0, 610.28, 835.824, -44.134, 0, 0, 0),
(20, 0, 613.948, 823.937, -43.9609, 0, 0, 0),
(21, 1, 614.129, 822.687, -43.8374, 0, 0, 0),
(22, 1, 619.435, 812.568, -43.8237, 0, 0, 0),
(23, 1, 613.985, 811.142, -43.9609, 0, 0, 0),
(24, 1, 604.72, 812.669, -43.9609, 0, 0, 0),
(25, 1, 598.927, 822.307, -44.1144, 0, 0, 0),
(26, 1, 594.807, 829.704, -44.0011, 0, 0, 0),
(27, 1, 591.412, 835.743, -43.8148, 0, 0, 0),
(28, 0, 586.138, 841.826, -43.5142, 0, 0, 0),
(29, 0, 587.76, 848.745, -43.6068, 0, 0, 0),
(30, 0, 599.396, 864.085, -43.9609, 0, 0, 0),
(31, 0, 600.804, 871.27, -43.9609, 0, 0, 0),
(32, 0, 606.875, 875.328, -43.9609, 0, 0, 0),
(33, 0, 613.392, 874.411, -43.9609, 0, 0, 0),
(34, 0, 610.986, 868.747, -43.8173, 0, 0, 0),
(35, 0, 615.848, 864.453, -43.9609, 0, 0, 0),
(36, 0, 592.02, 884.386, -45.2493, 0, 0, 0),
(37, 0, 587.243, 885.365, -45.1747, 0, 0, 0),
(38, 0, 581.221, 887.092, -45.2652, 0, 0, 0),
(39, 0, 577.65, 881.953, -44.8318, 0, 0, 0),
(40, 0, 573.603, 881.105, -44.497, 0, 0, 0),
(41, 0, 573.899, 876.409, -44.8188, 0, 0, 0),
(42, 0, 552.991, 880.297, -44.4295, 0, 0, 0),
(43, 0, 551.776, 885.161, -44.3146, 0, 0, 0),
(44, 0, 552.878, 873.243, -44.1121, 0, 0, 0),
(45, 0, 540.644, 840.687, -42.7609, 0, 0, 0),
(46, 0, 548.368, 840.116, -42.1878, 0, 0, 0),
(47, 0, 543.846, 836.816, -42.1503, 0, 0, 0),
(48, 0, 540.772, 830.19, -41.1376, 0, 0, 0),
(49, 1, 535.265, 833.897, -41.5043, 0, 0, 0),
(50, 1, 530.082, 841.122, -43.3509, 0, 0, 0),
(51, 1, 532.729, 843.69, -43.413, 0, 0, 0),
(52, 1, 517.551, 848.464, -43.9609, 0, 0, 0),
(53, 1, 524.484, 850.197, -43.9609, 0, 0, 0),
(54, 1, 515.268, 861.279, -43.0055, 0, 0, 0),
(55, 0, 517.363, 875.503, -40.9271, 0, 0, 0),
(56, 0, 523.038, 876.557, -40.596, 0, 0, 0),
(57, 0, 532.134, 877.37, -41.19, 0, 0, 0),
(58, 0, 545.116, 877.244, -42.983, 0, 0, 0),
(59, 0, 543.485, 888.973, -42.2747, 0, 0, 0),
(60, 0, 547.634, 908.779, -43.9609, 0, 0, 0),
(61, 0, 542.796, 907.64, -43.9609, 0, 0, 0),
(62, 0, 530.473, 910.01, -43.9609, 0, 0, 0),
(63, 0, 533.443, 916.244, -43.9609, 0, 0, 0),
(64, 0, 535.068, 911.745, -43.9609, 0, 0, 0),
(65, 0, 556.613, 912.642, -43.6831, 0, 0, 0),
(66, 0, 558.482, 919.279, -43.9462, 0, 0, 0),
(67, 0, 562.846, 922.292, -43.9609, 0, 0, 0),
(68, 0, 564.943, 929.505, -43.9609, 0, 0, 0),
(69, 0, 569.892, 925.587, -43.9609, 0, 0, 0),
(70, 0, 574.432, 933.491, -43.9382, 0, 0, 0),
(71, 1, 579.53, 937.05, -43.9609, 0, 0, 0),
(72, 1, 586.368, 937.587, -43.9609, 0, 0, 0),
(73, 1, 581.922, 930.714, -43.9174, 0, 0, 0),
(74, 1, 582.951, 924.717, -43.5763, 0, 0, 0),
(75, 1, 584.93, 918.627, -43.7273, 0, 0, 0),
(76, 1, 588.914, 914.227, -44.0486, 0, 0, 0),
(77, 1, 597.639, 912.266, -44.5886, 0, 0, 0),
(78, 1, 605.151, 919.97, -43.8185, 0, 0, 0),
(79, 1, 604.336, 931.577, -42.4005, 0, 0, 0),
(80, 0, 599.461, 936.328, -41.8551, 0, 0, 0),
(81, 0, 594.659, 938.428, -42.3512, 0, 0, 0),
(82, 0, 611.198, 938.6, -40.2519, 0, 0, 0),
(83, 0, 621.861, 942.307, -38.5344, 0, 0, 0),
(84, 0, 633.855, 918.034, -42.7052, 0, 0, 0),
(85, 0, 642.336, 917.226, -42.9849, 0, 0, 0),
(86, 0, 649.866, 919.497, -42.2548, 0, 0, 0),
(87, 1, 650.229, 913.485, -42.2591, 0, 0, 0),
(88, 1, 635.159, 896.597, -43.929, 0, 0, 0),
(89, 0, 633.469, 891.951, -43.9609, 0, 0, 0),
(90, 0, 631.903, 883.671, -43.9609, 0, 0, 0),
(91, 1, 646.003, 890.482, -43.7474, 0, 0, 0),
(92, 1, 653.764, 891.861, -42.8906, 0, 0, 0),
(93, 0, 660.943, 890.175, -41.8905, 0, 0, 0),
(94, 0, 660.235, 897.932, -41.748, 0, 0, 0),
(95, 0, 663.126, 892.264, -41.5969, 0, 0, 0),
(96, 0, 662.762, 898.81, -41.4107, 0, 0, 0),
(97, 0, 687.959, 897.18, -40.6909, 0, 0, 0),
(98, 0, 683.458, 894.567, -40.6991, 0, 0, 0),
(99, 0, 688.305, 893.597, -40.5905, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `parks`
--

CREATE TABLE `parks` (
  `id` int(11) DEFAULT 0,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0,
  `interior` int(11) DEFAULT 0,
  `world` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `parks`
--

INSERT INTO `parks` (`id`, `posx`, `posy`, `posz`, `interior`, `world`) VALUES
(0, 332.712, -1800.16, 4.67371, 0, 0),
(1, 1368.39, -1649.57, 13.3828, 0, 0),
(2, 1838.27, -1865.06, 13.3828, 0, 0),
(3, 1479.46, -1724.71, 13.5469, 0, 0),
(4, 1531.48, -813.409, 72.0567, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `plants`
--

CREATE TABLE `plants` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `players`
--

CREATE TABLE `players` (
  `reg_id` int(11) UNSIGNED NOT NULL,
  `ucp_id` int(11) NOT NULL,
  `username` varchar(24) NOT NULL DEFAULT '',
  `ucp` varchar(22) NOT NULL,
  `Password` varchar(65) NOT NULL,
  `salt` varchar(16) NOT NULL,
  `temppass` varchar(64) NOT NULL,
  `adminname` varchar(24) NOT NULL DEFAULT 'None',
  `ip` varchar(24) NOT NULL DEFAULT '',
  `email` varchar(40) NOT NULL DEFAULT 'None',
  `admin` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `helper` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `level` int(11) UNSIGNED NOT NULL DEFAULT 1,
  `levelup` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `vip` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `vip_time` bigint(16) UNSIGNED NOT NULL DEFAULT 0,
  `boost` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `boost_time` bigint(60) UNSIGNED NOT NULL DEFAULT 0,
  `gold` int(11) NOT NULL DEFAULT 0,
  `reg_date` varchar(30) NOT NULL DEFAULT '',
  `last_login` varchar(30) NOT NULL DEFAULT '',
  `money` int(11) NOT NULL DEFAULT 0,
  `bmoney` int(11) NOT NULL DEFAULT 0,
  `legcoint` int(11) NOT NULL DEFAULT 0,
  `brek` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `phone` mediumint(8) UNSIGNED NOT NULL,
  `phoneoff` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `phonecredit` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `phonebook` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `wt` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `hours` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `minutes` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `seconds` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `paycheck` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `skin` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `facskin` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `gender` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `age` varchar(30) NOT NULL DEFAULT '',
  `indoor` mediumint(8) NOT NULL DEFAULT -1,
  `inbiz` mediumint(8) NOT NULL DEFAULT -1,
  `inhouse` mediumint(8) NOT NULL DEFAULT -1,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `posa` float NOT NULL DEFAULT 0,
  `interior` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `world` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `health` float NOT NULL DEFAULT 100,
  `armour` float NOT NULL DEFAULT 0,
  `hunger` smallint(5) NOT NULL DEFAULT 100,
  `bladder` smallint(5) NOT NULL DEFAULT 100,
  `energy` smallint(5) NOT NULL DEFAULT 100,
  `sick` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `hospital` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `injured` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `duty` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `dutytime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `faction` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `factionrank` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `factionlead` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `farm` tinyint(3) NOT NULL DEFAULT -1,
  `farmrank` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `family` tinyint(3) NOT NULL DEFAULT -1,
  `familyrank` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `pegawai` tinyint(3) NOT NULL DEFAULT -1,
  `jail` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `jail_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `arrest` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `arrest_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `warn` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `job` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `job2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `sweepertime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `bustime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `pizzatime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `forklifttime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `jobtime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `sidejobtime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `exitjob` bigint(16) UNSIGNED NOT NULL DEFAULT 0,
  `taxitime` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `medicine` mediumint(8) NOT NULL DEFAULT 0,
  `medkit` mediumint(8) NOT NULL DEFAULT 0,
  `mask` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `fstyle` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `gvip` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `helmet` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `snack` mediumint(8) NOT NULL DEFAULT 0,
  `sprunk` mediumint(8) NOT NULL DEFAULT 0,
  `gas` mediumint(8) NOT NULL DEFAULT 0,
  `bandage` mediumint(8) NOT NULL DEFAULT 0,
  `gps` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `material` mediumint(8) NOT NULL DEFAULT 0,
  `component` mediumint(8) NOT NULL DEFAULT 0,
  `food` mediumint(8) NOT NULL DEFAULT 0,
  `seed` mediumint(8) NOT NULL DEFAULT 0,
  `potato` mediumint(8) NOT NULL DEFAULT 0,
  `wheat` mediumint(8) NOT NULL DEFAULT 0,
  `orange` mediumint(8) NOT NULL DEFAULT 0,
  `marjun` mediumint(8) NOT NULL DEFAULT 0,
  `price1` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `price2` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `price3` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `price4` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `marijuana` mediumint(8) NOT NULL DEFAULT 0,
  `armor` mediumint(9) NOT NULL DEFAULT 0,
  `plant` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `plant_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `fishtool` tinyint(3) NOT NULL DEFAULT 0,
  `fish` mediumint(8) NOT NULL DEFAULT 0,
  `worm` mediumint(8) NOT NULL DEFAULT 0,
  `idcard` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `idcard_time` bigint(16) UNSIGNED NOT NULL DEFAULT 0,
  `skck` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `skck_time` bigint(16) UNSIGNED NOT NULL DEFAULT 0,
  `penebang` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `penebang_time` bigint(16) UNSIGNED NOT NULL DEFAULT 0,
  `bpjs` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `bpjs_time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `starter` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `drivelic` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `drivelic_time` bigint(16) UNSIGNED NOT NULL DEFAULT 0,
  `boombox` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `hbemode` tinyint(3) UNSIGNED NOT NULL DEFAULT 2,
  `tdmode` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `togtweet` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `tnames` varchar(24) NOT NULL DEFAULT '',
  `akuntw` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `togpm` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `toglog` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `togads` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `togwt` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Gun1` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun2` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun3` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun4` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun5` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun6` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun7` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun8` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun9` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun10` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun11` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun12` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Gun13` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo1` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo2` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo3` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo4` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo5` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo6` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo7` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo8` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo9` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo10` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo11` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo12` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo13` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `WhiteList` int(11) NOT NULL DEFAULT 0,
  `MechSkill` int(11) NOT NULL DEFAULT 0,
  `trash` mediumint(8) NOT NULL DEFAULT 0,
  `berry` mediumint(8) NOT NULL DEFAULT 0,
  `frozenpizza` mediumint(8) NOT NULL DEFAULT 0,
  `licbiz` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `licbiz_time` bigint(16) UNSIGNED NOT NULL DEFAULT 0,
  `borax` mediumint(8) NOT NULL DEFAULT 0,
  `paketborax` int(11) NOT NULL DEFAULT 0,
  `redmoney` int(11) NOT NULL DEFAULT 0,
  `ayam` mediumint(9) NOT NULL DEFAULT 0,
  `burger` mediumint(9) NOT NULL DEFAULT 0,
  `airmineral` mediumint(9) NOT NULL DEFAULT 0,
  `nasbung` mediumint(9) NOT NULL DEFAULT 0,
  `blindfold` int(11) NOT NULL DEFAULT 0,
  `flight` tinyint(3) UNSIGNED DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `players`
--

INSERT INTO `players` (`reg_id`, `ucp_id`, `username`, `ucp`, `Password`, `salt`, `temppass`, `adminname`, `ip`, `email`, `admin`, `helper`, `level`, `levelup`, `vip`, `vip_time`, `boost`, `boost_time`, `gold`, `reg_date`, `last_login`, `money`, `bmoney`, `legcoint`, `brek`, `phone`, `phoneoff`, `phonecredit`, `phonebook`, `wt`, `hours`, `minutes`, `seconds`, `paycheck`, `skin`, `facskin`, `gender`, `age`, `indoor`, `inbiz`, `inhouse`, `posx`, `posy`, `posz`, `posa`, `interior`, `world`, `health`, `armour`, `hunger`, `bladder`, `energy`, `sick`, `hospital`, `injured`, `duty`, `dutytime`, `faction`, `factionrank`, `factionlead`, `farm`, `farmrank`, `family`, `familyrank`, `pegawai`, `jail`, `jail_time`, `arrest`, `arrest_time`, `warn`, `job`, `job2`, `sweepertime`, `bustime`, `pizzatime`, `forklifttime`, `jobtime`, `sidejobtime`, `exitjob`, `taxitime`, `medicine`, `medkit`, `mask`, `fstyle`, `gvip`, `helmet`, `snack`, `sprunk`, `gas`, `bandage`, `gps`, `material`, `component`, `food`, `seed`, `potato`, `wheat`, `orange`, `marjun`, `price1`, `price2`, `price3`, `price4`, `marijuana`, `armor`, `plant`, `plant_time`, `fishtool`, `fish`, `worm`, `idcard`, `idcard_time`, `skck`, `skck_time`, `penebang`, `penebang_time`, `bpjs`, `bpjs_time`, `starter`, `drivelic`, `drivelic_time`, `boombox`, `hbemode`, `tdmode`, `togtweet`, `tnames`, `akuntw`, `togpm`, `toglog`, `togads`, `togwt`, `Gun1`, `Gun2`, `Gun3`, `Gun4`, `Gun5`, `Gun6`, `Gun7`, `Gun8`, `Gun9`, `Gun10`, `Gun11`, `Gun12`, `Gun13`, `Ammo1`, `Ammo2`, `Ammo3`, `Ammo4`, `Ammo5`, `Ammo6`, `Ammo7`, `Ammo8`, `Ammo9`, `Ammo10`, `Ammo11`, `Ammo12`, `Ammo13`, `WhiteList`, `MechSkill`, `trash`, `berry`, `frozenpizza`, `licbiz`, `licbiz_time`, `borax`, `paketborax`, `redmoney`, `ayam`, `burger`, `airmineral`, `nasbung`, `blindfold`, `flight`) VALUES
(54, 0, 'Jack_Net', 'Tes', '', '', '', 'None', '140.213.51.92', 'None', 0, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-14 02:26:21', '2022-03-14 02:28:30', 25000, 5000, 0, 629203, 0, 0, 0, 0, 0, 0, 2, 9, 129, 22, 0, 1, '12/01/2000', -1, -1, -1, 1816.15, -2157.72, 13.8469, 288.409, 0, 0, 100, 0, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(53, 0, 'Matthew_Gigs', 'Matthew', '', '', '', 'Mattew', '125.162.247.182', 'None', 3, 0, 6, 1, 3, 1648903068, 0, 0, 0, '2022-03-13 12:30:37', '2022-03-23 13:14:30', 34004967, 5000, 0, 583145, 8964, 0, 0, 0, 0, 1, 55, 56, 6956, 23, 0, 1, '06/01/2000', -1, -1, -1, 688.106, -1578.66, 14.4505, 62.2375, 0, 0, 95, 0, 59, 100, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(52, 0, 'Sergei_Pudovkin', 'Joker', '', '', '', 'JOKER', '120.188.5.134', 'None', 6, 0, 12, 9, 0, 0, 0, 0, 0, '2022-03-13 06:15:47', '2022-03-23 14:01:15', 142307, 5000, 0, 123456, 1111, 0, 104, 0, 0, 9, 10, 17, 33017, 165, 286, 1, '10/11/2000', -1, -1, -1, 1453.31, -1743.13, 13.8469, 356.53, 0, 0, 221, 97, 61, 100, 52, 0, 0, 0, 0, 2575, 1, 6, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 447, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1653141693, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(51, 0, 'Morgan_Tsatsu', 'Lonely', '', '', '', 'Lonely', '140.213.22.77', 'None', 2, 0, 5, 3, 0, 0, 0, 0, 0, '2022-03-13 05:35:38', '2022-03-23 08:39:46', 2464, 190000, 0, 224438, 3498, 0, 4, 1, 1, 3, 54, 7, 14047, 250, 0, 1, '10/04/2000', -1, -1, -1, 1540.14, -836.832, 65.1494, 103.206, 0, 0, 100, 0, 54, 100, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 321, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1652397063, 0, 0, 0, 0, 0, 0, 0, 1, 1652396961, 0, 1, 1, 0, 'MORGANNNN', 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(50, 0, 'Jhonatan_Garner', 'Twosixxx', '', '', '', 'Twosix', '112.215.253.117', 'None', 6, 0, 12, 7, 3, 0, 0, 0, 0, '2022-03-13 05:35:21', '2022-03-23 13:47:50', 2011903, 5000, 0, 631725, 6193, 0, 5, 1, 0, 7, 8, 53, 25733, 296, 0, 1, '16/08/1999', -1, -1, -1, 1433.64, -881.242, 51.6376, 305.098, 0, 0, 100, 0, 30, 100, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 60, 20, 0, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 1652794117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 251, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0),
(55, 0, 'Alie_Brian', 'Alie', '', '', '', 'None', '114.5.217.56', 'None', 0, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-15 00:50:36', '2022-03-15 00:57:00', 25000, 5000, 0, 245381, 0, 0, 0, 0, 0, 0, 6, 3, 363, 2, 0, 1, '15/04/1999', -1, -1, -1, 1683.31, -2243.98, 13.8481, 23.8079, 0, 0, 100, 0, 98, 100, 98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(56, 0, 'Paul_Lakovsky', 'Paul', '', '', '', 'None', '36.74.44.116', 'paullakovsky@gmail.com', 0, 0, 1, 4, 0, 0, 0, 0, 0, '2022-03-17 13:46:45', '2022-03-22 23:30:45', 352770, 33440, 0, 741884, 8700, 0, 4, 0, 0, 4, 24, 4, 2493, 66, 0, 1, '14/03/2001', -1, -1, -1, 1694.5, -1493.71, 13.8469, 122.241, 0, 0, 44, 0, 67, 100, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 1146, 0, 0, 0, 0, 1647998606, 0, 0, 0, 1, 0, 0, 1, 9, 0, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 1, 0, 0, 1, 1652709311, 0, 0, 0, 0, 0, 0, 0, 1, 1652710472, 0, 1, 1, 0, 'P A U L', 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(57, 0, 'Christopher_Jahir', 'Doyo', '', '', '', 'None', '140.213.49.15', 'None', 0, 0, 1, 2, 0, 0, 0, 0, 0, '2022-03-17 16:21:57', '2022-03-22 14:11:01', 21462, 512449, 0, 112695, 8920, 0, 10, 1, 0, 2, 45, 26, 165, 292, 0, 1, '08/09/2001', -1, -1, -1, 1837.87, -1871.98, 13.2583, 269.405, 0, 0, 100, 90, 60, 100, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 1, 0, 0, 0, 2, 0, 1, 0, 0, 0, 39, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 1, 1652746158, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58, 0, 'Dedi_Saptadji', 'Dedi', '', '', '', 'Deds', '180.244.135.43', 'None', 3, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-17 16:42:42', '2022-03-17 17:20:37', 23500, 5000, 0, 400050, 5892, 0, 5, 1, 0, 0, 35, 3, 2103, 270, 0, 1, '10/10/1997', -1, -1, -1, 1827.98, -1738.26, 13.8469, 65.0074, 0, 0, 100, 0, 88, 100, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(59, 0, 'Burhan_Ortuz', 'Gustavo', '', '', '', 'None', '114.122.101.32', 'None', 0, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-18 15:24:12', '2022-03-20 11:20:58', 25000, 5000, 0, 811360, 0, 0, 0, 0, 0, 0, 6, 23, 383, 81, 0, 1, '14/08/1999', -1, -1, -1, 1670.57, -2256.46, 13.595, 270.032, 0, 0, 90, 0, 98, 100, 98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(60, 0, 'Blitz_Alpart', 'Joker', '', '', '', 'Jokers', '114.4.82.208', 'None', 6, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-19 02:12:38', '2022-03-20 11:25:48', 102300, 5000, 0, 123456, 5555, 0, 4, 1, 0, 0, 18, 19, 1099, 25, 0, 1, '10/11/2000', -1, -1, -1, 1545.23, -1672.27, 13.8589, 245.307, 0, 0, 100, 0, 95, 100, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 'Blitz', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(61, 0, 'Ryuji_Lorenzo', 'Zyu', '', '', '', 'None', '202.67.43.45', 'None', 0, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-19 03:53:43', '2022-03-20 02:22:44', 14944, 5000, 0, 510181, 4942, 0, 5, 1, 0, 0, 35, 18, 2118, 193, 0, 2, '15/03/2001', -1, -1, -1, 1629.68, -1796.39, 13.8066, 193.689, 0, 0, 95, 0, 88, 100, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1652856088, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(62, 0, 'James_Jhonson', 'Virjil', '', '', '', 'Vijril', '180.243.38.239', 'None', 4, 0, 1, 1, 0, 0, 0, 0, 0, '2022-03-19 04:59:00', '2022-03-23 13:47:57', 525000, 5000, 0, 538117, 0, 0, 0, 0, 0, 1, 12, 38, 4358, 21, 0, 1, '2/02/2002', -1, -1, -1, 1432.99, -871.809, 51.541, 311.559, 0, 0, 100, 0, 75, 100, 68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 4, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500, 453, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(63, 0, 'Donbo_Raymond', 'Donbose', '', '', '', 'None', '140.213.47.190', 'None', 0, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-19 10:22:20', '2022-03-19 10:25:37', 25000, 5000, 0, 299805, 0, 0, 0, 0, 0, 0, 2, 35, 155, 46, 0, 1, '12/12/2000', -1, -1, -1, 1684.6, -2313.4, 13.8469, 6.62179, 0, 0, 100, 0, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(64, 0, 'Mazecraze_Delazcano', 'Clawz', '', '', '', 'None', '114.5.242.238', 'None', 0, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-19 22:06:23', '2022-03-19 22:07:37', 25000, 5000, 0, 792911, 0, 0, 0, 0, 0, 0, 1, 14, 74, 23, 0, 1, '8/07/2002', -1, -1, -1, 1676.72, -2301.05, 14.8156, 86.2586, 0, 0, 100, 0, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(65, 0, 'Marquise_Anthony', 'Twosixxx', '', '', '', 'bobi', '140.213.39.34', 'None', 6, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-20 07:11:20', '2022-03-21 12:16:53', 625789, 5000, 0, 982061, 0, 0, 0, 0, 0, 0, 49, 30, 2970, 144, 0, 1, '23/07/1999', -1, -1, -1, 2309.49, -1255.73, 24.2856, 200.17, 0, 0, 95, 0, 83, 100, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(67, 0, 'Jordan_Corleone', 'Aight', '', '', '', 'None', '114.5.245.180', 'None', 0, 0, 1, 1, 0, 0, 0, 0, 0, '2022-03-21 05:19:16', '2022-03-23 14:42:43', 7764, 0, 0, 462380, 3354, 0, 5, 1, 1, 1, 29, 2, 1738, 22, 0, 1, '23/02/1999', -1, -1, -1, 1693.21, -1868.23, 13.3921, 90, 0, 0, 100, 0, 68, 100, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 744, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(66, 0, 'Nikola_Smith', 'Nikola', '', '', '', 'None', '255.255.255.255', 'None', 0, 0, 1, 0, 0, 0, 0, 0, 0, '2022-03-20 12:15:12', '2022-03-20 12:21:38', 19957, 5000, 0, 897715, 4268, 0, 5, 0, 0, 0, 6, 26, 386, 2, 0, 1, '15/09/1999', -1, -1, -1, 1830.65, -1873.51, 13.675, 172.466, 0, 0, 100, 0, 98, 100, 97, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(68, 0, 'Ryuu_Tatsuya', 'Razor', '', '', '', 'Ryuhentai', '37.19.201.207', 'None', 2, 0, 5, 0, 1, 1648472856, 0, 0, 0, '2022-03-21 12:27:09', '2022-03-23 13:15:52', 28024900, 5000, 0, 776403, 0, 0, 0, 0, 0, 0, 18, 36, 1116, 240, 0, 1, '07/05/1999', -1, -1, -1, 1525.88, -808.928, 72.2597, 40.4102, 0, 0, 47, 0, 95, 100, 92, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(69, 0, 'Crime_Hunter', 'Crime_Hunter', '', '', '', 'None', '255.255.255.255', 'None', 0, 0, 2, 1, 0, 0, 0, 0, 0, '2022-03-23 12:52:10', '2022-03-23 14:01:00', 108800, 5000, 0, 133517, 5439, 0, 5, 1, 0, 1, 1, 35, 3695, 59, 300, 1, '05/11/2000', -1, -1, -1, 1292.29, -1859.9, 13.5136, 325.283, 0, 0, 100, 97, 77, 100, 70, 0, 0, 0, 0, 1838, 1, 2, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1653225200, 0, 0, 0, 0, 0, 0, 0, 1, 1653225401, 0, 1, 1, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `playerucp`
--

CREATE TABLE `playerucp` (
  `ID` int(11) NOT NULL,
  `Password` varchar(64) NOT NULL,
  `salt` varchar(16) NOT NULL,
  `UCP` varchar(22) NOT NULL,
  `extrac` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `playerucp`
--

INSERT INTO `playerucp` (`ID`, `Password`, `salt`, `UCP`, `extrac`) VALUES
(153, '05CCC312D58BD87043315DCAF5F0212A89C12BE06D41A3EA41EE0824D86F46E7', ',ujsE3h&q\\<BqIGP', 'Twosixxx', 0),
(154, '6F1A7CEE0A276CBAAFC662A8040E94CC7E9690B912DB07820CD17A46877552B2', 'E9LsQ8YgU[|/vL5]', 'Lonely', 0),
(155, '3868C8FBA9302189D35DA4288DDA3DCC6DF5CF55AC53F3D1011E9316AF8C5CCD', '_WD~?<z.8)Yl55Yk', 'Joker', 0),
(156, '68787A2F006E79CD96813F79B80B06F78FADF5821EA7F7ECC673E4CE8702741D', 'Zv6}u6BcSD1=Mzqx', 'Matthew', 0),
(157, 'EB13AAD059827124F6D62007589702F54C975A0B47755576E7E97BB1B2D437E9', '0?Dmj67t2i#hPy=}', 'Tes', 0),
(158, '32183C19F0502551534D6F64C2B3E3F9CDB66A1DD24F8CF9CDB76836035D9233', 'f\"-9V+E!o+7mOHsc', 'Alie', 0),
(159, '655F0958AB06BC710D58FA1F79571A7B3452221CB13149A0014ADFA53BF80E7D', '>CQJzf\\jPN=JdVde', 'Dedi', 0),
(160, '5D604CE2093463CCD8A30E4546082A8F0E7D4E1D9ED3BC516B867B60E28B7E6B', 'TsqGS[IT8lNyM1~=', 'Paul', 0),
(161, 'B49C5DB47C4FE0F32E9B4F1615552856811C02790AB9A04AC131C27C1671AC50', 'iF=S%ZgcNkta+))O', 'Doyo', 0),
(162, '2A218CB7AB02A65D6EC8610CC5B89F4256A5A1858693B432EDB03C49AD889F1B', '&kAW%@ZR,B<L)~Qv', 'Gustavo', 0),
(163, '830C26997FFC5D55AA200967180099F2D294EE1BCED7AC1C91CD9432770A71AE', 'C(TU5yL_dw_*DsN.', 'Zyu', 0),
(164, 'AD1A115F744A2D95DEF9E925AE6FF950B130E9CB292E6AD89C60FB9769EF7E2A', '(za`j__Z*@Pz,su2', 'Virjil', 0),
(165, '6C79FD60DF1AE593B9AC06E878F3B85C0364FDE2673D18C3ECB1066FC4080FE0', 'FHUHCbzIV98-eYam', 'Donbose', 0),
(166, '13A066BE9FE45474E95B766E086A9DDE215E282DDE680509A22F444FC13E0682', '`pkr\']Gl^90c+9tp', 'Clawz', 0),
(167, 'DBB3E70119692B4D25B95354D249F22CA1611754853479F1BFEA236F51DBC60E', 'soxi4;J\\HNgk]deG', 'Nikola', 0),
(168, '7F0FDACECEA29B2E34827E70C1A0FE938BA53629D039B36779AED04F6D854A83', 'd6&WYgF2q_^[5!Lc', 'Aight', 0),
(169, '9608F631CA7926F66FFD114F315A3EC2AE22E869771563055C2FEF801580094A', 'a}>BFcry2$^t145+', 'Razor', 0),
(170, 'D36D4D2DE821F90A488325968AAA472C7A22BA6432009BE1F015E3E26B176363', 'ZXn7g.`EW%Yy\"nK\"', 'Bramz', 0),
(171, '08477A77865042D778196DCAB3AFD083822E207AE3D3448ECDE4CE6CA282CEF9', '>C{SC-(G9czH*_z}', 'Crime_Hunter', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `salary`
--

CREATE TABLE `salary` (
  `id` bigint(20) NOT NULL,
  `owner` int(11) DEFAULT 0,
  `info` varchar(46) DEFAULT '',
  `money` int(11) NOT NULL DEFAULT 0,
  `date` varchar(36) DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `salary`
--

INSERT INTO `salary` (`id`, `owner`, `info`, `money`, `date`) VALUES
(40, 25, 'Sidejob(Pizza)', 20000, '2022-01-23 00:55:26'),
(39, 25, 'Sidejob(Sweeper)', 20000, '2022-01-23 00:49:41'),
(38, 25, 'Sidejob(Bus Route C)', 20000, '2022-01-23 00:44:13'),
(41, 2, 'Sidejob(Pizza)', 20000, '2022-01-23 08:42:26'),
(36, 20, 'Sidejob(Pizza)', 20000, '2022-01-22 14:28:15'),
(35, 20, 'Sidejob(Bus Route C)', 20000, '2022-01-22 14:25:31'),
(34, 6, 'Lumberjack(Jobs)', 3000, '2022-01-19 23:24:48'),
(33, 6, 'Lumberjack(Jobs)', 3000, '2022-01-19 23:24:02'),
(32, 6, 'Lumberjack(Jobs)', 3000, '2022-01-19 23:23:29'),
(31, 6, 'Lumberjack(Jobs)', 3000, '2022-01-19 23:22:57'),
(30, 6, 'Lumberjack(Jobs)', 3000, '2022-01-19 23:22:23'),
(29, 22, 'Sidejob(Sweeper)', 10000, '2022-01-19 03:45:31'),
(28, 13, 'Sidejob(Sweeper)', 10000, '2022-01-17 22:21:20'),
(42, 32, 'Sidejob(Sweeper)', 4500, '2022-03-09 03:17:36'),
(43, 41, 'Sidejob(Bus Route C)', 13600, '2022-03-10 12:06:09'),
(44, 38, 'Job(Hauling Meat Cargo)', 35, '2022-03-11 07:34:14'),
(45, 38, 'Job(Hauling Meat Cargo)', 35, '2022-03-11 07:34:32'),
(46, 45, 'Sidejob(Bus Route A)', 9800, '2022-03-12 02:20:27'),
(60, 67, 'Sidejob(Sweeper)', 4500, '2022-03-23 14:40:07'),
(58, 56, 'Sidejob(Bus Route A)', 9800, '2022-03-22 23:29:51'),
(51, 50, 'Farmers(Jobs)', 200, '2022-03-19 03:17:40'),
(52, 61, 'Sidejob(Bus Route B)', 13600, '2022-03-20 02:05:40'),
(59, 51, 'Sidejob(Bus Route A)', 9800, '2022-03-23 08:25:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `server`
--

CREATE TABLE `server` (
  `id` int(11) NOT NULL DEFAULT 0,
  `servermoney` int(11) NOT NULL DEFAULT 0,
  `material` int(11) NOT NULL DEFAULT 500,
  `materialprice` int(11) NOT NULL DEFAULT 10,
  `lumberprice` int(11) NOT NULL DEFAULT 500,
  `component` int(11) NOT NULL DEFAULT 500,
  `componentprice` int(11) NOT NULL DEFAULT 20,
  `metalprice` int(11) NOT NULL DEFAULT 500,
  `gasoil` int(11) NOT NULL DEFAULT 1000,
  `gasoilprice` int(11) NOT NULL DEFAULT 10,
  `coalprice` int(11) NOT NULL DEFAULT 500,
  `product` int(11) NOT NULL DEFAULT 500,
  `productprice` int(11) NOT NULL DEFAULT 20,
  `apotek` int(11) NOT NULL DEFAULT 500,
  `pedagang` mediumint(9) NOT NULL DEFAULT 5000,
  `medicineprice` int(11) NOT NULL DEFAULT 300,
  `medkitprice` int(11) NOT NULL DEFAULT 500,
  `food` int(11) NOT NULL DEFAULT 500,
  `foodprice` int(11) NOT NULL DEFAULT 100,
  `seedprice` int(11) NOT NULL DEFAULT 10,
  `potatoprice` int(11) NOT NULL DEFAULT 10,
  `wheatprice` int(11) NOT NULL DEFAULT 10,
  `orangeprice` int(11) NOT NULL DEFAULT 10,
  `meat` int(11) NOT NULL DEFAULT 500,
  `marijuana` int(11) NOT NULL DEFAULT 500,
  `marijuanaprice` int(11) NOT NULL DEFAULT 10,
  `fishprice` int(11) NOT NULL DEFAULT 100,
  `gstationprice` int(11) NOT NULL DEFAULT 100,
  `cargomeat` int(11) NOT NULL DEFAULT 500,
  `cargoseed` int(11) NOT NULL DEFAULT 500
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `server`
--

INSERT INTO `server` (`id`, `servermoney`, `material`, `materialprice`, `lumberprice`, `component`, `componentprice`, `metalprice`, `gasoil`, `gasoilprice`, `coalprice`, `product`, `productprice`, `apotek`, `pedagang`, `medicineprice`, `medkitprice`, `food`, `foodprice`, `seedprice`, `potatoprice`, `wheatprice`, `orangeprice`, `meat`, `marijuana`, `marijuanaprice`, `fishprice`, `gstationprice`, `cargomeat`, `cargoseed`) VALUES
(0, 878270918, 200, 50, 3000, 4500, 30, 3500, 5000, 50, 3000, 5400, 50, 5000, 5000, 50, 300, 1555, 15, 5, 10, 50, 30, 479, 10007, 100, 500, 20, 4998, 5000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `toys`
--

CREATE TABLE `toys` (
  `Id` int(10) NOT NULL,
  `Owner` varchar(40) NOT NULL DEFAULT '',
  `Slot0_Model` int(8) NOT NULL DEFAULT 0,
  `Slot0_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot0_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_Model` int(8) NOT NULL DEFAULT 0,
  `Slot1_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot1_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_Model` int(8) NOT NULL DEFAULT 0,
  `Slot2_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot2_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_Model` int(8) NOT NULL DEFAULT 0,
  `Slot3_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot3_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_Model` int(8) NOT NULL DEFAULT 0,
  `Slot4_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot4_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_Model` int(8) NOT NULL DEFAULT 0,
  `Slot5_Bone` int(8) NOT NULL DEFAULT 0,
  `Slot5_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZScale` float(20,3) NOT NULL DEFAULT 0.000
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `toys`
--

INSERT INTO `toys` (`Id`, `Owner`, `Slot0_Model`, `Slot0_Bone`, `Slot0_XPos`, `Slot0_YPos`, `Slot0_ZPos`, `Slot0_XRot`, `Slot0_YRot`, `Slot0_ZRot`, `Slot0_XScale`, `Slot0_YScale`, `Slot0_ZScale`, `Slot1_Model`, `Slot1_Bone`, `Slot1_XPos`, `Slot1_YPos`, `Slot1_ZPos`, `Slot1_XRot`, `Slot1_YRot`, `Slot1_ZRot`, `Slot1_XScale`, `Slot1_YScale`, `Slot1_ZScale`, `Slot2_Model`, `Slot2_Bone`, `Slot2_XPos`, `Slot2_YPos`, `Slot2_ZPos`, `Slot2_XRot`, `Slot2_YRot`, `Slot2_ZRot`, `Slot2_XScale`, `Slot2_YScale`, `Slot2_ZScale`, `Slot3_Model`, `Slot3_Bone`, `Slot3_XPos`, `Slot3_YPos`, `Slot3_ZPos`, `Slot3_XRot`, `Slot3_YRot`, `Slot3_ZRot`, `Slot3_XScale`, `Slot3_YScale`, `Slot3_ZScale`, `Slot4_Model`, `Slot4_Bone`, `Slot4_XPos`, `Slot4_YPos`, `Slot4_ZPos`, `Slot4_XRot`, `Slot4_YRot`, `Slot4_ZRot`, `Slot4_XScale`, `Slot4_YScale`, `Slot4_ZScale`, `Slot5_Model`, `Slot5_Bone`, `Slot5_XPos`, `Slot5_YPos`, `Slot5_ZPos`, `Slot5_XRot`, `Slot5_YRot`, `Slot5_ZRot`, `Slot5_XScale`, `Slot5_YScale`, `Slot5_ZScale`) VALUES
(1, 'Morgan_Nemesis', 0, 2, 0.125, 0.000, 0.000, -0.600, 0.000, 0.000, 1.000, 1.000, 1.000, 19141, 2, 0.125, 0.000, 0.000, -0.600, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 1, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 1, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000),
(4, 'Christopher_Jahir', 0, 2, 0.130, 0.020, 0.000, 0.000, 90.000, 90.000, 1.000, 1.000, 1.000, 0, 2, 0.090, 0.000, 90.000, 0.000, 90.000, 90.000, 1.000, 1.000, 1.000, 0, 1, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 1, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000),
(5, 'Jhonatan_Garner', 19010, 2, 0.110, 0.030, 0.000, 10.000, 88.000, 88.000, 1.000, 1.000, 1.000, 0, 1, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 1, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 1, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `trees`
--

CREATE TABLE `trees` (
  `id` int(11) NOT NULL,
  `posx` float DEFAULT NULL,
  `posy` float DEFAULT NULL,
  `posz` float DEFAULT NULL,
  `posrx` float DEFAULT NULL,
  `posry` float DEFAULT NULL,
  `posrz` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `trees`
--

INSERT INTO `trees` (`id`, `posx`, `posy`, `posz`, `posrx`, `posry`, `posrz`) VALUES
(0, -523.63, -2247.73, 34.5218, 0, 0, 0),
(1, -623.954, -2261.36, 23.9413, 0, 0, 0),
(2, -628.714, -2394, 29.5843, 0, 0, 0),
(3, -735.625, -2254.4, 27.5423, 0, 0, 0),
(4, -657.756, -2140.98, 24.2563, 0, 0, 0),
(5, -654.44, -2074.7, 25.9842, 0, 0, 0),
(6, -546.637, -1999.71, 48.0892, 0, 0, 0),
(7, -731.541, -2189.38, 34.526, 0, 0, 0),
(8, -732.679, -2200.2, 34.5699, 0, 0, 0),
(9, -739.308, -2193.72, 34.6548, 0, 0, 0),
(10, -865.874, -2199.14, 29.0169, 0, 0, 0),
(11, -814.336, -2247.82, 37.77, 0, 0, 0),
(12, -878.67, -2367.51, 68.2969, 0, 0, 0),
(13, -861.714, -2381.68, 69.0388, 0, 0, 0),
(14, -972.936, -2322.47, 62.7628, 0, 0, 0),
(15, -1043.86, -2303.47, 55.4699, 0, 0, 0),
(16, -979.795, -2391.9, 70.2428, 0, 0, 0),
(17, -928.635, -2531.78, 114.824, 0, 0, 0),
(18, -928.943, -2555.48, 114.897, 0, 0, 0),
(19, -889.914, -2502.48, 110.088, 0, 0, 0),
(20, -874.672, -2612.06, 95.074, 0, 0, 0),
(21, -622.4, -2263.39, 23.9615, 0, 0, 0),
(22, -552.445, -2272.94, 28.3696, 0, 0, 0),
(23, -1065.08, -2548.24, 68.1407, 0, 0, 0),
(24, -744.504, -2441.61, 65.1923, 0, 0, 0),
(25, -818.597, -2657.71, 91.0869, 0, 0, 0),
(26, -734.419, -2690.28, 86.7166, 0, 0, 0),
(27, -686.676, -2630.36, 82.9661, 0, 0, 0),
(28, -707.708, -2695.28, 91.3966, 0, 0, 0),
(29, -757.89, -2538.72, 90.0414, 0, 0, 0),
(30, -748.443, -2509.77, 81.1096, 0, 0, 0),
(31, -574.876, -2265.34, 25.6459, 0, 0, 0),
(32, -259.564, -2288.6, 28.3319, 0, 0, 0),
(33, -265.612, -2283.08, 28.7017, 0, 0, 0),
(34, -265.073, -2289.61, 28.9291, 0, 0, 0),
(35, -261.272, -2298.3, 29.2332, 0, 0, 0),
(36, -254.905, -2293.05, 28.7204, 0, 0, 0),
(37, -255.359, -2300.16, 28.7449, 0, 0, 0),
(38, -246.557, -2297.72, 28.21, 0, 0, 0),
(39, -253.683, -2281.12, 27.6976, 0, 0, 0),
(40, -261.055, -2276.42, 28.0052, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `trunk`
--

CREATE TABLE `trunk` (
  `ID` int(10) NOT NULL,
  `Owner` int(11) NOT NULL DEFAULT 0,
  `money` int(11) DEFAULT 0,
  `component` int(11) NOT NULL DEFAULT 0,
  `material` int(11) NOT NULL DEFAULT 0,
  `marijuana` int(12) DEFAULT 0,
  `weapon1` int(12) DEFAULT 0,
  `ammo1` int(12) DEFAULT 0,
  `weapon2` int(12) DEFAULT 0,
  `ammo2` int(12) DEFAULT 0,
  `weapon3` int(12) DEFAULT 0,
  `ammo3` int(12) DEFAULT 0,
  `weapon4` int(12) DEFAULT 0,
  `ammo4` int(12) DEFAULT 0,
  `weapon5` int(12) DEFAULT 0,
  `ammo5` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `trunk`
--

INSERT INTO `trunk` (`ID`, `Owner`, `money`, `component`, `material`, `marijuana`, `weapon1`, `ammo1`, `weapon2`, `ammo2`, `weapon3`, `ammo3`, `weapon4`, `ammo4`, `weapon5`, `ammo5`) VALUES
(1, 1, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 1, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 59, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 66, 0, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `vehicle`
--

CREATE TABLE `vehicle` (
  `id` int(11) UNSIGNED NOT NULL,
  `owner` int(11) NOT NULL,
  `model` int(11) NOT NULL DEFAULT 0,
  `color1` int(11) NOT NULL DEFAULT 0,
  `color2` int(11) NOT NULL DEFAULT 0,
  `paintjob` int(11) NOT NULL DEFAULT -1,
  `neon` int(11) NOT NULL DEFAULT 0,
  `locked` int(11) NOT NULL DEFAULT 0,
  `insu` int(11) NOT NULL DEFAULT 1,
  `claim` int(11) NOT NULL DEFAULT 0,
  `claim_time` bigint(15) NOT NULL DEFAULT 0,
  `plate` varchar(50) NOT NULL DEFAULT 'None',
  `plate_time` bigint(16) NOT NULL DEFAULT 0,
  `ticket` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 200000,
  `health` float NOT NULL DEFAULT 1000,
  `fuel` int(11) NOT NULL DEFAULT 1000,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `a` float NOT NULL DEFAULT 0,
  `int` int(11) NOT NULL DEFAULT 0,
  `vw` int(11) NOT NULL DEFAULT 0,
  `damage0` int(11) NOT NULL DEFAULT 0,
  `damage1` int(11) NOT NULL DEFAULT 0,
  `damage2` int(11) NOT NULL DEFAULT 0,
  `damage3` int(11) NOT NULL DEFAULT 0,
  `mod0` int(11) NOT NULL DEFAULT 0,
  `mod1` int(11) NOT NULL DEFAULT 0,
  `mod2` int(11) NOT NULL DEFAULT 0,
  `mod3` int(11) NOT NULL DEFAULT 0,
  `mod4` int(11) NOT NULL DEFAULT 0,
  `mod5` int(11) NOT NULL DEFAULT 0,
  `mod6` int(11) NOT NULL DEFAULT 0,
  `mod7` int(11) NOT NULL DEFAULT 0,
  `mod8` int(11) NOT NULL DEFAULT 0,
  `mod9` int(11) NOT NULL DEFAULT 0,
  `mod10` int(11) NOT NULL DEFAULT 0,
  `mod11` int(11) NOT NULL DEFAULT 0,
  `mod12` int(11) NOT NULL DEFAULT 0,
  `mod13` int(11) NOT NULL DEFAULT 0,
  `mod14` int(11) NOT NULL DEFAULT 0,
  `mod15` int(11) NOT NULL DEFAULT 0,
  `mod16` int(11) NOT NULL DEFAULT 0,
  `lumber` int(11) NOT NULL DEFAULT -1,
  `metal` int(11) NOT NULL DEFAULT 0,
  `coal` int(11) NOT NULL DEFAULT 0,
  `product` int(11) NOT NULL DEFAULT 0,
  `gasoil` int(11) NOT NULL DEFAULT 0,
  `money` int(11) DEFAULT 0,
  `weapon1` int(12) DEFAULT 0,
  `ammo1` int(12) DEFAULT 0,
  `weapon2` int(12) DEFAULT 0,
  `ammo2` int(12) DEFAULT 0,
  `weapon3` int(12) DEFAULT 0,
  `ammo3` int(12) DEFAULT 0,
  `weapon4` int(12) DEFAULT 0,
  `ammo4` int(12) DEFAULT 0,
  `weapon5` int(12) DEFAULT 0,
  `ammo5` int(12) DEFAULT 0,
  `weapon6` int(12) DEFAULT 0,
  `ammo6` int(12) DEFAULT 0,
  `weapon7` int(12) DEFAULT 0,
  `ammo7` int(12) DEFAULT 0,
  `weapon8` int(12) DEFAULT 0,
  `ammo8` int(12) DEFAULT 0,
  `weapon9` int(12) DEFAULT 0,
  `ammo9` int(12) DEFAULT 0,
  `weapon10` int(12) DEFAULT 0,
  `ammo10` int(12) DEFAULT 0,
  `rental` bigint(16) NOT NULL DEFAULT 0,
  `depositor` int(11) NOT NULL DEFAULT 0,
  `park` int(11) NOT NULL DEFAULT 0,
  `death` int(11) NOT NULL DEFAULT 0,
  `garage` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `vehicle`
--

INSERT INTO `vehicle` (`id`, `owner`, `model`, `color1`, `color2`, `paintjob`, `neon`, `locked`, `insu`, `claim`, `claim_time`, `plate`, `plate_time`, `ticket`, `price`, `health`, `fuel`, `x`, `y`, `z`, `a`, `int`, `vw`, `damage0`, `damage1`, `damage2`, `damage3`, `mod0`, `mod1`, `mod2`, `mod3`, `mod4`, `mod5`, `mod6`, `mod7`, `mod8`, `mod9`, `mod10`, `mod11`, `mod12`, `mod13`, `mod14`, `mod15`, `mod16`, `lumber`, `metal`, `coal`, `product`, `gasoil`, `money`, `weapon1`, `ammo1`, `weapon2`, `ammo2`, `weapon3`, `ammo3`, `weapon4`, `ammo4`, `weapon5`, `ammo5`, `weapon6`, `ammo6`, `weapon7`, `ammo7`, `weapon8`, `ammo8`, `weapon9`, `ammo9`, `weapon10`, `ammo10`, `rental`, `depositor`, `park`, `death`, `garage`) VALUES
(61, 46, 481, 3, 3, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 3000, 2000, 1000, 1050.52, -945.117, 42.4929, 88.2097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(60, 45, 560, 2, 2, -1, 0, 1, 3, 0, 0, 'NoHave', 0, 0, 1700000, 1000, 325, 833.239, -2054.72, 13.6672, 273.975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(62, 50, 445, 0, 0, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 400000, 960.485, 145, 2076.44, -1710.5, 14.3346, 3.00243, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(63, 51, 562, 5, 5, -1, 0, 1, 3, 0, 0, 'NoHave', 0, 0, 1750000, 999.193, 865, 1538.42, -839.44, 64.3476, 272.514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(64, 51, 602, 251, 1, -1, 0, 1, 2, 0, 0, 'NoHave', 0, 0, 1000000, 972.291, 865, 1530.19, -843.041, 65.6713, 270.375, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(65, 53, 451, 1, 1, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2300000, 1474.78, 610, 295.063, -1165.03, 80.921, 39.3888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(66, 53, 560, 0, 1, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 1700000, 1788.49, 850, 305.701, -1186.21, 80.66, 214.627, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(67, 53, 502, 1, 1, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2200000, 1910.45, 955, 298.614, -1181.72, 80.9067, 137.189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(68, 53, 522, 1, 1, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 1000000, 1687.19, 655, 296.871, -1189.8, 80.7677, 112.6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(69, 50, 521, 6, 0, -1, 0, 0, 2, 1, 0, 'NoHave', 0, 0, 100000, 1652.76, 940, 845.68, -26.744, 64.5332, 323.445, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(70, 57, 522, 0, 0, -1, 0, 0, 3, 0, 0, 'A-6024', 1648901365, 0, 1000000, 1749.21, 675, 1837.87, -1871.98, 13.0583, 348.432, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(71, 58, 411, 0, 0, -1, 0, 0, 2, 1, 1647622607, 'NoHave', 0, 0, 3500000, 2000, 1000, 244.001, -1275.21, 74.104, 118.075, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(72, 56, 463, 1, 1, -1, 0, 1, 3, 0, 0, 'NoHave', 0, 0, 30000, 537.672, 505, 1693.22, -1494.3, 13.2053, 178.981, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(73, 61, 468, 1, 1, -1, 0, 1, 3, 0, 0, 'NoHave', 0, 0, 280000, 2000, 895, 1628.24, -1884.84, 13.3116, 118.678, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(74, 53, 602, 1, 1, -1, 0, 1, 3, 0, 0, 'NoHave', 0, 0, 1000000, 1000, 985, 2119.02, -1135.06, 25.5919, 95.1439, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(75, 65, 475, 2, 0, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 525000, 1848.29, 865, 2307.19, -1253.12, 23.742, 358.932, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(76, 60, 468, 5, 5, -1, 0, 0, 3, 0, 0, 'A-1641', 1649071460, 0, 280000, 1982.3, 970, 1544.85, -1673.04, 13.327, 245.307, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(77, 67, 481, 1, 1, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 5000, 978.125, 1000, 2058.25, -1910.28, 13.4578, 339.228, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(78, 67, 463, 1, 1, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 30000, 1000, 610, 1693.21, -1868.23, 13.1921, 281.072, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(79, 68, 463, 2, 6, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 30000, 2000, 1000, 1531.6, -800.706, 72.897, 144.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(80, 68, 560, 0, 0, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 1700000, 2000, 1000, 1523.45, -798.659, 73.6321, 72.8678, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0),
(81, 68, 558, 6, 6, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 1450000, 2000, 1000, 1529.94, -813.386, 71.6677, 81.4056, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0),
(82, 69, 468, 0, 0, -1, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 280000, 1996.34, 805, 1292.29, -1859.9, 13.3136, 269.171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `vending`
--

CREATE TABLE `vending` (
  `ID` int(11) NOT NULL,
  `owner` varchar(40) CHARACTER SET latin1 NOT NULL DEFAULT '-',
  `name` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT 'Vending Machine',
  `price` int(11) NOT NULL DEFAULT 1,
  `type` int(11) NOT NULL DEFAULT 2,
  `locked` int(11) NOT NULL DEFAULT 0,
  `money` int(11) NOT NULL DEFAULT 0,
  `stock` int(11) NOT NULL DEFAULT 100,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `posa` float NOT NULL DEFAULT 0,
  `posrx` float NOT NULL DEFAULT 0,
  `posry` float NOT NULL DEFAULT 0,
  `posrz` float NOT NULL DEFAULT 0,
  `restock` tinyint(2) NOT NULL DEFAULT 0,
  `vprice0` int(111) NOT NULL DEFAULT 0,
  `vprice1` int(11) NOT NULL DEFAULT 0,
  `vprice2` int(11) NOT NULL DEFAULT 0,
  `vprice3` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `vouchers`
--

CREATE TABLE `vouchers` (
  `id` int(11) NOT NULL,
  `code` int(11) NOT NULL DEFAULT 0,
  `vip` int(11) NOT NULL DEFAULT 0,
  `vip_time` int(11) NOT NULL DEFAULT 0,
  `gold` int(11) NOT NULL DEFAULT 0,
  `admin` varchar(16) NOT NULL DEFAULT 'None',
  `donature` varchar(16) NOT NULL DEFAULT 'None',
  `claim` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `vtoys`
--

CREATE TABLE `vtoys` (
  `id` int(10) NOT NULL,
  `Owner` int(11) NOT NULL DEFAULT 0,
  `Slot0_Modelid` int(8) NOT NULL DEFAULT 0,
  `Slot0_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZRot` float(20,3) NOT NULL,
  `Slot1_Modelid` int(8) NOT NULL DEFAULT 0,
  `Slot1_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_Modelid` int(8) NOT NULL DEFAULT 0,
  `Slot2_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZRot` float(20,3) NOT NULL,
  `Slot3_Modelid` int(8) NOT NULL DEFAULT 0,
  `Slot3_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZRot` float(20,3) NOT NULL DEFAULT 0.000
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `vtoys`
--

INSERT INTO `vtoys` (`id`, `Owner`, `Slot0_Modelid`, `Slot0_XPos`, `Slot0_YPos`, `Slot0_ZPos`, `Slot0_XRot`, `Slot0_YRot`, `Slot0_ZRot`, `Slot1_Modelid`, `Slot1_XPos`, `Slot1_YPos`, `Slot1_ZPos`, `Slot1_XRot`, `Slot1_YRot`, `Slot1_ZRot`, `Slot2_Modelid`, `Slot2_XPos`, `Slot2_YPos`, `Slot2_ZPos`, `Slot2_XRot`, `Slot2_YRot`, `Slot2_ZRot`, `Slot3_Modelid`, `Slot3_XPos`, `Slot3_YPos`, `Slot3_ZPos`, `Slot3_XRot`, `Slot3_YRot`, `Slot3_ZRot`) VALUES
(1, 3, 1041, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000),
(2, 1, 0, 8.250, -0.550, 0.600, 16.000, -0.350, -0.150, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `weaponsettings`
--

CREATE TABLE `weaponsettings` (
  `Owner` int(11) NOT NULL,
  `WeaponID` tinyint(4) NOT NULL,
  `PosX` float DEFAULT -0.116,
  `PosY` float DEFAULT 0.189,
  `PosZ` float DEFAULT 0.088,
  `RotX` float DEFAULT 0,
  `RotY` float DEFAULT 44.5,
  `RotZ` float DEFAULT 0,
  `Bone` tinyint(4) NOT NULL DEFAULT 1,
  `Hidden` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `weaponsettings`
--

INSERT INTO `weaponsettings` (`Owner`, `WeaponID`, `PosX`, `PosY`, `PosZ`, `RotX`, `RotY`, `RotZ`, `Bone`, `Hidden`) VALUES
(45, 30, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1),
(45, 28, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1),
(50, 24, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1),
(50, 25, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1),
(50, 29, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1),
(65, 29, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1),
(50, 30, -0.116, 0.189, 0.088, 0, 44.5, 0, 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `workshop`
--

CREATE TABLE `workshop` (
  `id` int(11) NOT NULL,
  `owner` varchar(25) NOT NULL DEFAULT '-',
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `component` int(11) NOT NULL DEFAULT 0,
  `material` int(11) NOT NULL DEFAULT 0,
  `money` int(11) NOT NULL DEFAULT 0,
  `name` varchar(26) NOT NULL DEFAULT '-',
  `status` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `employe0` varchar(25) NOT NULL DEFAULT '-',
  `employe1` varchar(25) NOT NULL DEFAULT '-',
  `employe2` varchar(25) NOT NULL DEFAULT '-'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `workshop`
--

INSERT INTO `workshop` (`id`, `owner`, `posx`, `posy`, `posz`, `component`, `material`, `money`, `name`, `status`, `price`, `employe0`, `employe1`, `employe2`) VALUES
(0, 'Frank_Lucaslo', 2302.32, -1927.53, 13.5871, 0, 0, 0, 'Frank', 1, 20, '-', '-', '-'),
(1, 'Matthew_Gigs', 300.279, -1201.89, 80.9141, 0, 0, 0, '-', 0, 1, '-', '-', '-');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `atms`
--
ALTER TABLE `atms`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `banneds`
--
ALTER TABLE `banneds`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `berry`
--
ALTER TABLE `berry`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bisnis`
--
ALTER TABLE `bisnis`
  ADD PRIMARY KEY (`ID`);

--
-- Indeks untuk tabel `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contactID`);

--
-- Indeks untuk tabel `doors`
--
ALTER TABLE `doors`
  ADD PRIMARY KEY (`ID`);

--
-- Indeks untuk tabel `familys`
--
ALTER TABLE `familys`
  ADD PRIMARY KEY (`ID`);

--
-- Indeks untuk tabel `gstations`
--
ALTER TABLE `gstations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`);

--
-- Indeks untuk tabel `lockers`
--
ALTER TABLE `lockers`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `loglogin`
--
ALTER TABLE `loglogin`
  ADD PRIMARY KEY (`no`);

--
-- Indeks untuk tabel `ores`
--
ALTER TABLE `ores`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `plants`
--
ALTER TABLE `plants`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`reg_id`);

--
-- Indeks untuk tabel `playerucp`
--
ALTER TABLE `playerucp`
  ADD PRIMARY KEY (`ID`);

--
-- Indeks untuk tabel `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `toys`
--
ALTER TABLE `toys`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `id` (`Owner`);

--
-- Indeks untuk tabel `trees`
--
ALTER TABLE `trees`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `trunk`
--
ALTER TABLE `trunk`
  ADD PRIMARY KEY (`ID`);

--
-- Indeks untuk tabel `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `vending`
--
ALTER TABLE `vending`
  ADD PRIMARY KEY (`ID`);

--
-- Indeks untuk tabel `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `vtoys`
--
ALTER TABLE `vtoys`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `weaponsettings`
--
ALTER TABLE `weaponsettings`
  ADD PRIMARY KEY (`Owner`,`WeaponID`),
  ADD UNIQUE KEY `Owner` (`Owner`,`WeaponID`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `banneds`
--
ALTER TABLE `banneds`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contactID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `loglogin`
--
ALTER TABLE `loglogin`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=587;

--
-- AUTO_INCREMENT untuk tabel `players`
--
ALTER TABLE `players`
  MODIFY `reg_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT untuk tabel `playerucp`
--
ALTER TABLE `playerucp`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT untuk tabel `salary`
--
ALTER TABLE `salary`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT untuk tabel `toys`
--
ALTER TABLE `toys`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `trunk`
--
ALTER TABLE `trunk`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT untuk tabel `vtoys`
--
ALTER TABLE `vtoys`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
