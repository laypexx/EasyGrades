-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 19. Dez 2022 um 13:19
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
-- Datenbank: `dbnotenbuch`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mathe`
--

CREATE TABLE `mathe` (
  `S_ID` text NOT NULL,
  `Klausur_1` int(11) NOT NULL,
  `Klausur_2` int(11) NOT NULL,
  `Note1` int(11) NOT NULL,
  `Note2` int(11) NOT NULL,
  `Note3` int(11) NOT NULL,
  `Note4` int(11) NOT NULL,
  `Note5` int(11) NOT NULL,
  `Durchschnitt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schueler`
--

CREATE TABLE `schueler` (
  `S_ID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Vorname` text NOT NULL,
  `LK_1` text NOT NULL,
  `Klasse` int(11) NOT NULL,
  `LK_2` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `schueler`
--

INSERT INTO `schueler` (`S_ID`, `Name`, `Vorname`, `LK_1`, `Klasse`, `LK_2`) VALUES
(1, 'Sprenger', 'Dominic', 'Englisch', 13, 'Informatiksysteme');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `mathe`
--
ALTER TABLE `mathe`
  ADD PRIMARY KEY (`S_ID`(32));

--
-- Indizes für die Tabelle `schueler`
--
ALTER TABLE `schueler`
  ADD PRIMARY KEY (`S_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
