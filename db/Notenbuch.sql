-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 13. Mrz 2023 um 11:55
-- Server-Version: 10.1.36-MariaDB
-- PHP-Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `notenbuch`
--
CREATE DATABASE IF NOT EXISTS `notenbuch` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `notenbuch`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `admin`
--

CREATE TABLE `admin` (
  `P_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fach`
--

CREATE TABLE `fach` (
  `F_ID` int(11) NOT NULL,
  `BZ_kurz` varchar(3) NOT NULL,
  `Bezeichnung` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `fach`
--

INSERT INTO `fach` (`F_ID`, `BZ_kurz`, `Bezeichnung`) VALUES
(1, 'AT', 'Agrartechnik'),
(2, 'BT', 'Biotechnik'),
(3, 'EL', 'Ernährungslehre'),
(4, 'IS', 'Informatiksysteme'),
(5, 'GS', 'Gesundheit&Soziales'),
(6, 'MT', '(Maschinen-)Bautechnik'),
(7, 'WR', 'Volks- und Betriebwirtschaftslehre mit Rechnungswesen');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `klasse`
--

CREATE TABLE `klasse` (
  `KL_ID` int(11) NOT NULL,
  `Bezeichnung` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `klasse`
--

INSERT INTO `klasse` (`KL_ID`, `Bezeichnung`) VALUES
(1, 'Klasse 11'),
(2, 'Klasse 12'),
(3, 'Klasse 13');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `kurs`
--

CREATE TABLE `kurs` (
  `K_ID` int(11) NOT NULL,
  `KL_ID` int(11) NOT NULL,
  `F_ID` int(11) NOT NULL,
  `P_ID` int(11) NOT NULL,
  `Jahr` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `kurs`
--

INSERT INTO `kurs` (`K_ID`, `KL_ID`, `F_ID`, `P_ID`, `Jahr`) VALUES
(1, 3, 4, 1, 2023);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `noten`
--

CREATE TABLE `noten` (
  `N_ID` int(11) NOT NULL,
  `S_ID` int(11) NOT NULL,
  `K_ID` int(11) NOT NULL,
  `Note` int(11) NOT NULL,
  `Kursnote` int(11) DEFAULT NULL,
  `Gewichtung` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `noten`
--

INSERT INTO `noten` (`N_ID`, `S_ID`, `K_ID`, `Note`, `Kursnote`, `Gewichtung`) VALUES
(1, 1, 1, 15, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `personen`
--

CREATE TABLE `personen` (
  `P_ID` int(11) NOT NULL,
  `Name` varchar(35) NOT NULL,
  `Vorname` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `personen`
--

INSERT INTO `personen` (`P_ID`, `Name`, `Vorname`) VALUES
(1, 'Sprenger', 'Dominic');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schueler`
--

CREATE TABLE `schueler` (
  `S_ID` int(11) NOT NULL,
  `P_ID` int(11) NOT NULL,
  `K_ID` int(11) NOT NULL,
  `ZeugnisNote` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `schueler`
--

INSERT INTO `schueler` (`S_ID`, `P_ID`, `K_ID`, `ZeugnisNote`) VALUES
(1, 1, 1, NULL);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`P_ID`);

--
-- Indizes für die Tabelle `fach`
--
ALTER TABLE `fach`
  ADD PRIMARY KEY (`F_ID`);

--
-- Indizes für die Tabelle `klasse`
--
ALTER TABLE `klasse`
  ADD PRIMARY KEY (`KL_ID`);

--
-- Indizes für die Tabelle `kurs`
--
ALTER TABLE `kurs`
  ADD PRIMARY KEY (`K_ID`);

--
-- Indizes für die Tabelle `noten`
--
ALTER TABLE `noten`
  ADD PRIMARY KEY (`N_ID`);

--
-- Indizes für die Tabelle `personen`
--
ALTER TABLE `personen`
  ADD PRIMARY KEY (`P_ID`);

--
-- Indizes für die Tabelle `schueler`
--
ALTER TABLE `schueler`
  ADD PRIMARY KEY (`S_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
