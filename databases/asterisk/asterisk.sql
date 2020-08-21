-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 19, 2020 at 06:54 AM
-- Server version: 5.7.31-0ubuntu0.16.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `asterisk`
--

-- --------------------------------------------------------

--
-- Table structure for table `cdr`
--

CREATE TABLE `cdr` (
  `calldate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `clid` varchar(80) NOT NULL DEFAULT '',
  `src` varchar(80) NOT NULL DEFAULT '',
  `dst` varchar(80) NOT NULL DEFAULT '',
  `dcontext` varchar(80) NOT NULL DEFAULT '',
  `channel` varchar(80) NOT NULL DEFAULT '',
  `dstchannel` varchar(80) NOT NULL DEFAULT '',
  `lastapp` varchar(80) NOT NULL DEFAULT '',
  `lastdata` varchar(80) NOT NULL DEFAULT '',
  `duration` int(11) NOT NULL DEFAULT '0',
  `billsec` int(11) NOT NULL DEFAULT '0',
  `disposition` varchar(45) NOT NULL DEFAULT '',
  `amaflags` int(11) NOT NULL DEFAULT '0',
  `accountcode` varchar(20) NOT NULL DEFAULT '',
  `uniqueid` varchar(32) NOT NULL DEFAULT '',
  `userfield` varchar(255) NOT NULL DEFAULT '',
  `peeraccount` varchar(20) NOT NULL DEFAULT '',
  `linkedid` varchar(32) NOT NULL DEFAULT '',
  `sequence` int(11) NOT NULL DEFAULT '0',
  `verified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `code`
--

CREATE TABLE `code` (
  `idCode` int(11) NOT NULL,
  `code` varchar(80) NOT NULL,
  `typeCode` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `code`
--

INSERT INTO `code` (`idCode`, `code`, `typeCode`) VALUES
(1, '#999*5000#', 'demandeOffre'),
(2, '#999*5000*2#', 'demandeOffre'),
(3, '#111*5000#', 'consultationOffre'),
(4, '#111*5000*2#', 'consultationOffre'),
(5, '#123#', 'consultationSolde');

-- --------------------------------------------------------

--
-- Table structure for table `devise`
--

CREATE TABLE `devise` (
  `idDevise` int(11) NOT NULL,
  `designation` varchar(80) NOT NULL,
  `abbreviation` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devise`
--

INSERT INTO `devise` (`idDevise`, `designation`, `abbreviation`) VALUES
(1, 'Ariary', 'Ar'),
(2, 'Euro', '€'),
(3, 'Dollard', '$');

-- --------------------------------------------------------

--
-- Table structure for table `langue`
--

CREATE TABLE `langue` (
  `idLangue` int(11) NOT NULL,
  `designation` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `langue`
--

INSERT INTO `langue` (`idLangue`, `designation`) VALUES
(4, 'de'),
(1, 'en'),
(6, 'es'),
(2, 'fr'),
(5, 'hi'),
(7, 'it'),
(3, 'mg'),
(8, 'ru');

-- --------------------------------------------------------

--
-- Table structure for table `numero`
--

CREATE TABLE `numero` (
  `idNumero` int(11) NOT NULL,
  `extension` varchar(80) NOT NULL,
  `idTypeNumero` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `numero`
--

INSERT INTO `numero` (`idNumero`, `extension`, `idTypeNumero`, `idUtilisateur`) VALUES
(1, '+261343380527', 1, 1),
(2, '+261343308234', 1, 2),
(3, '5000', 2, 1),
(4, '5001', 2, 2),
(5, '+261345343018', 1, 3),
(6, '+261347694114', 1, 4),
(7, '5002', 2, 3),
(8, '5003', 2, 4),
(9, '+261349950430', 1, 5),
(10, '5004', 2, 5),
(11, '+261348458538', 1, 5),
(13, '+261342820071', 1, 3),
(14, '+261345367530', 1, 1),
(15, '+261345831463', 1, 1),
(16, '+261344172321', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `offre`
--

CREATE TABLE `offre` (
  `idOffre` int(11) NOT NULL,
  `designation` varchar(80) NOT NULL,
  `montant` double NOT NULL,
  `validite` int(11) NOT NULL,
  `24h` tinyint(1) NOT NULL DEFAULT '0',
  `limite` int(3) NOT NULL,
  `priorite` int(3) NOT NULL,
  `idCodeDemande` int(11) NOT NULL,
  `idCodeConsultation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `offre`
--

INSERT INTO `offre` (`idOffre`, `designation`, `montant`, `validite`, `24h`, `limite`, `priorite`, `idCodeDemande`, `idCodeConsultation`) VALUES
(1, 'Cheap', 5000, 1, 0, 3, 1, 1, 3),
(2, '2 Days Cheap', 5000, 2, 0, 3, 2, 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `offreUtilisateur`
--

CREATE TABLE `offreUtilisateur` (
  `idOffreUtilisateur` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  `idOffre` int(11) NOT NULL,
  `resteCredit` int(11) NOT NULL,
  `dateEtHeure` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateEtHeureLimite` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `offreUtilisateur`
--

INSERT INTO `offreUtilisateur` (`idOffreUtilisateur`, `idUtilisateur`, `idOffre`, `resteCredit`, `dateEtHeure`, `dateEtHeureLimite`) VALUES
(50, 1, 1, 4955, '2020-02-28 05:13:02', '2020-02-29 21:00:00'),
(51, 1, 1, 9910, '2020-02-28 05:15:42', '2020-02-29 21:00:00'),
(52, 1, 2, 5000, '2020-02-28 05:19:26', '2020-02-29 21:00:00'),
(53, 1, 2, 5000, '2020-02-28 05:24:58', '2020-02-29 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `sms`
--

CREATE TABLE `sms` (
  `idSms` int(11) NOT NULL,
  `numero` varchar(13) NOT NULL,
  `text` text NOT NULL,
  `dateDeReception` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sms`
--

INSERT INTO `sms` (`idSms`, `numero`, `text`, `dateDeReception`) VALUES
(2, '261343308234', 'Ggggg', '2020-01-16 14:51:25'),
(3, '500', '', '2020-01-16 15:07:05'),
(4, '500', '', '2020-01-16 15:08:36'),
(5, '261340812071', 'Manahoana! Ny nomerao +261340812071 dia mangataka ny mba antsoinao. Ity dia hafatra nomen ny Telma anao.', '2020-01-17 19:49:08'),
(6, '261343380527', 'Manahoana! Ny nomerao +261343380527 dia mangataka ny mba antsoinao. Ity dia hafatra nomen ny Telma anao.', '2020-01-18 04:28:07'),
(7, '261343380527', 'Ny 261343380527 dia mangataka anao mba handefa fahana 6000 Ar.', '2020-01-18 05:12:01'),
(8, '261343380527', 'Ny 261343380527 dia mangataka anao mba handefa fahana 2300 Ar.', '2020-01-18 05:20:33'),
(9, '261343380527', 'Manahoana! Ny nomerao +261343380527 dia mangataka ny mba antsoinao. Ity dia hafatra nomen ny Telma anao.', '2020-01-18 05:37:00'),
(10, '261343380527', 'Manahoana! Ny nomerao +261343380527 dia mangataka ny mba antsoinao. Ity dia hafatra nomen ny Telma anao.', '2020-01-18 05:38:38'),
(11, '261343380527', 'Manahoana! Ny nomerao +261343380527 dia mangataka ny mba antsoinao. Ity dia hafatra nomen ny Telma anao.', '2020-01-18 05:40:38'),
(12, '261343380527', 'Ny 261343380527 dia mangataka anao mba handefa fahana 5000 Ar.', '2020-01-18 05:47:13'),
(13, '261345866331', 'Manahoana! Ny nomerao +261345866331 dia mangataka ny mba antsoinao. Ity dia hafatra nomen ny Telma anao.', '2020-01-18 16:54:21'),
(14, '261345367530', '#999*5000#', '2020-01-27 12:01:04'),
(15, '261345367530', '#999*5000#', '2020-01-27 12:02:44'),
(16, '261345367530', '#999*5000#', '2020-01-27 12:09:05'),
(17, '261345367530', '#999*5000#', '2020-01-27 12:18:27'),
(18, '261345367530', '#999*5000#', '2020-01-27 12:57:06'),
(19, '261345367530', '#999*5000#', '2020-01-27 13:04:25'),
(20, '261345367530', '#999*5000#', '2020-01-27 13:28:16'),
(21, '+261343380527', '#999*5000#', '2020-01-31 19:21:58'),
(22, '+261343380527', '#999*5000#', '2020-01-31 19:25:24'),
(23, '+261343380527', '#999*5000*2#', '2020-01-31 19:27:12'),
(24, '+261343380527', '#999*5000*2#', '2020-01-31 19:29:51'),
(25, '+261343380527', '#999*5000#', '2020-02-03 01:23:05'),
(26, '+261343380527', '#999*5000#', '2020-02-03 01:24:36'),
(27, '+261343380527', '#999*5000#', '2020-02-03 03:30:31'),
(28, '+261343380527', '#999*5000*2#', '2020-02-03 13:33:10'),
(29, '+261347694114', '#999*500#', '2020-02-03 13:33:31'),
(30, '+261343380527', '#999*5000*2#', '2020-02-03 13:35:22'),
(31, '+261343380527', '#999*5000*2#', '2020-02-03 13:35:39'),
(32, '+261343380527', '#999*5000#', '2020-02-03 13:35:39'),
(33, '+261343380527', '#999*5000*2#', '2020-02-03 13:35:39'),
(34, '+261347694114', '#999*5000#', '2020-02-03 13:41:43'),
(35, '+261347694114', '#999*5000#', '2020-02-03 15:02:39'),
(36, '+261345831463', '#999*5000#', '2020-02-11 11:12:08'),
(37, '+261343380527', '#555*300#', '2020-02-21 02:46:07'),
(38, '+261343380527', '#555*300#', '2020-02-21 02:46:07'),
(39, '+261343380527', '#555*300#', '2020-02-21 02:52:52'),
(40, '+261343380527', '#555*300#', '2020-02-21 02:55:37'),
(41, '+261343380527', '#555*300#', '2020-02-21 02:55:37'),
(42, '+261343380527', '#999*5000#', '2020-02-21 02:55:38'),
(43, '+261343380527', '#999*5000#', '2020-02-21 02:55:38'),
(44, '+261343380527', '#999*5000#', '2020-02-21 03:31:22'),
(45, '+261343380527', '#999*5000#', '2020-02-21 03:31:22'),
(46, '+261343380527', '#999*5000#', '2020-02-21 03:32:07'),
(47, '+261343380527', '#999*5000#', '2020-02-21 03:34:07'),
(48, '+261343380527', '#999*5000#', '2020-02-21 03:36:52'),
(49, '+261343380527', '#999*5000#', '2020-02-21 03:36:52');

-- --------------------------------------------------------

--
-- Table structure for table `tarif`
--

CREATE TABLE `tarif` (
  `idTarif` int(11) NOT NULL,
  `idOffre` int(11) NOT NULL,
  `idTypeNumeroSrc` int(11) NOT NULL,
  `idTypeNumeroDst` int(11) NOT NULL,
  `prixParSec` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tarif`
--

INSERT INTO `tarif` (`idTarif`, `idOffre`, `idTypeNumeroSrc`, `idTypeNumeroDst`, `prixParSec`) VALUES
(1, 1, 1, 5, 1),
(2, 1, 1, 2, 3),
(3, 1, 2, 1, 3),
(4, 1, 2, 2, 1),
(6, 2, 1, 2, 4),
(7, 2, 2, 1, 4),
(8, 2, 2, 2, 1),
(9, 1, 1, 3, 10),
(10, 1, 1, 4, 5),
(11, 1, 2, 3, 5),
(12, 1, 2, 4, 3),
(13, 2, 1, 3, 10),
(14, 2, 1, 4, 5),
(15, 2, 2, 3, 5),
(16, 2, 2, 4, 3),
(17, 1, 1, 1, 1),
(18, 2, 1, 1, 1),
(19, 1, 1, 6, 10),
(20, 1, 2, 6, 5),
(21, 2, 1, 6, 10),
(22, 2, 2, 6, 5);

-- --------------------------------------------------------

--
-- Table structure for table `typeNumero`
--

CREATE TABLE `typeNumero` (
  `idTypeNumero` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `channel` varchar(50) NOT NULL,
  `prefix` varchar(12) NOT NULL,
  `nombre` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `typeNumero`
--

INSERT INTO `typeNumero` (`idTypeNumero`, `type`, `channel`, `prefix`, `nombre`) VALUES
(1, 'cell', 'Dongle/dongle0', '+26134', 13),
(2, 'sip', 'SIP', '5', 4),
(3, 'cell', 'IAX2/server2', '+00134', 13),
(4, 'sip', 'IAX2/server2', '8', 4),
(5, 'cell', 'Dongle/dongle0', '034', 10),
(6, 'cell', 'IAX2/server2', '134', 10);

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUtilisateur` int(11) NOT NULL,
  `nomDUtilisateur` varchar(80) NOT NULL,
  `motDePasse` varchar(80) NOT NULL,
  `prePaye` tinyint(1) NOT NULL DEFAULT '1',
  `solde` int(11) NOT NULL DEFAULT '0',
  `montantAPayer` int(11) NOT NULL DEFAULT '0',
  `nomEtPrenom` varchar(100) NOT NULL,
  `adresse` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `nomDUtilisateur`, `motDePasse`, `prePaye`, `solde`, `montantAPayer`, `nomEtPrenom`, `adresse`) VALUES
(1, 'yvan', 'yvanPassword', 1, 4970, 0, 'RAMAHERY Yvan Emiliau', ''),
(2, 'jico', 'jicoPassword', 1, 80000, 0, 'Jico', ''),
(3, 'jerry', 'jerryPassword', 1, 100000, 0, 'Jerry', ''),
(4, 'tojo', 'tojoPassword', 1, 80000, 0, 'Tojo', ''),
(5, 'rado', 'radoPassword', 1, 95000, 0, 'ANDRIANEKENA Rado Marius', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `code`
--
ALTER TABLE `code`
  ADD PRIMARY KEY (`idCode`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `devise`
--
ALTER TABLE `devise`
  ADD PRIMARY KEY (`idDevise`),
  ADD UNIQUE KEY `designation` (`designation`),
  ADD UNIQUE KEY `abbreviation` (`abbreviation`);

--
-- Indexes for table `langue`
--
ALTER TABLE `langue`
  ADD PRIMARY KEY (`idLangue`),
  ADD UNIQUE KEY `designation` (`designation`);

--
-- Indexes for table `numero`
--
ALTER TABLE `numero`
  ADD PRIMARY KEY (`idNumero`),
  ADD UNIQUE KEY `exten` (`extension`);

--
-- Indexes for table `offre`
--
ALTER TABLE `offre`
  ADD PRIMARY KEY (`idOffre`);

--
-- Indexes for table `offreUtilisateur`
--
ALTER TABLE `offreUtilisateur`
  ADD PRIMARY KEY (`idOffreUtilisateur`);

--
-- Indexes for table `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`idSms`);

--
-- Indexes for table `tarif`
--
ALTER TABLE `tarif`
  ADD PRIMARY KEY (`idTarif`),
  ADD UNIQUE KEY `idOffre` (`idOffre`,`idTypeNumeroSrc`,`idTypeNumeroDst`);

--
-- Indexes for table `typeNumero`
--
ALTER TABLE `typeNumero`
  ADD PRIMARY KEY (`idTypeNumero`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`idUtilisateur`),
  ADD UNIQUE KEY `nomDUtilisateur` (`nomDUtilisateur`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `code`
--
ALTER TABLE `code`
  MODIFY `idCode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `devise`
--
ALTER TABLE `devise`
  MODIFY `idDevise` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `langue`
--
ALTER TABLE `langue`
  MODIFY `idLangue` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `numero`
--
ALTER TABLE `numero`
  MODIFY `idNumero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `offre`
--
ALTER TABLE `offre`
  MODIFY `idOffre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `offreUtilisateur`
--
ALTER TABLE `offreUtilisateur`
  MODIFY `idOffreUtilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;
--
-- AUTO_INCREMENT for table `sms`
--
ALTER TABLE `sms`
  MODIFY `idSms` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;
--
-- AUTO_INCREMENT for table `tarif`
--
ALTER TABLE `tarif`
  MODIFY `idTarif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `typeNumero`
--
ALTER TABLE `typeNumero`
  MODIFY `idTypeNumero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `idUtilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
