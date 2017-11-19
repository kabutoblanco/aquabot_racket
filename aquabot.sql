-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 19, 2017 at 02:02 AM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aquabot`
--

-- --------------------------------------------------------

--
-- Table structure for table `ACTIVIDADES`
--

CREATE TABLE `ACTIVIDADES` (
  `actiId` int(5) NOT NULL,
  `actiNombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `BARRIOS`
--

CREATE TABLE `BARRIOS` (
  `barrId` int(5) NOT NULL,
  `barrNombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `BARRIOS`
--

INSERT INTO `BARRIOS` (`barrId`, `barrNombre`) VALUES
(2, 'Bello Horizonte'),
(7, 'Bosques de Pomona'),
(8, 'El Centro'),
(6, 'La Arboleda'),
(10, 'La Esmeralda'),
(1, 'La Paz'),
(4, 'Lomas de Granda'),
(9, 'Los Sauces'),
(3, 'Tomas Cipriano'),
(5, 'Villa del Norte');

-- --------------------------------------------------------

--
-- Table structure for table `CASAS`
--

CREATE TABLE `CASAS` (
  `casaId` int(5) NOT NULL,
  `barrId` int(5) DEFAULT NULL,
  `ciudId` int(5) DEFAULT NULL,
  `casaEstrato` int(1) NOT NULL,
  `casaDireccion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CASAS`
--

INSERT INTO `CASAS` (`casaId`, `barrId`, `ciudId`, `casaEstrato`, `casaDireccion`) VALUES
(1, 5, 1, 3, 'calle 73 cn # 1-57');

-- --------------------------------------------------------

--
-- Table structure for table `CIUDADES`
--

CREATE TABLE `CIUDADES` (
  `ciudId` int(5) NOT NULL,
  `ciudNombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CIUDADES`
--

INSERT INTO `CIUDADES` (`ciudId`, `ciudNombre`) VALUES
(1, 'Popayan');

-- --------------------------------------------------------

--
-- Table structure for table `CONTADORES`
--

CREATE TABLE `CONTADORES` (
  `contId` int(5) NOT NULL,
  `casaId` int(5) DEFAULT NULL,
  `contRegistro` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CONTADORES`
--

INSERT INTO `CONTADORES` (`contId`, `casaId`, `contRegistro`) VALUES
(1, 1, '12.00');

-- --------------------------------------------------------

--
-- Table structure for table `DETALLE_SENSORES`
--

CREATE TABLE `DETALLE_SENSORES` (
  `usuaId` int(5) NOT NULL,
  `sensId` int(5) NOT NULL,
  `actiId` int(5) NOT NULL,
  `sensLimite` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `HISTORIALES`
--

CREATE TABLE `HISTORIALES` (
  `histId` int(5) NOT NULL,
  `contId` int(5) DEFAULT NULL,
  `histRegistro` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `HISTORIALES`
--

INSERT INTO `HISTORIALES` (`histId`, `contId`, `histRegistro`) VALUES
(1, 1, '13.00'),
(2, 1, '14.00'),
(3, 1, '13.00'),
(4, 1, '16.00'),
(5, 1, '17.00'),
(6, 1, '20.00'),
(7, 1, '10.00');

-- --------------------------------------------------------

--
-- Table structure for table `SENSORES`
--

CREATE TABLE `SENSORES` (
  `sensId` int(5) NOT NULL,
  `contId` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `USUARIOS`
--

CREATE TABLE `USUARIOS` (
  `usuaId` int(5) NOT NULL,
  `ciudId` int(5) DEFAULT NULL,
  `usuaIdentidad` int(10) NOT NULL,
  `usuaNombres` varchar(20) NOT NULL,
  `usuaApellido1` varchar(10) NOT NULL,
  `usuaApellido2` varchar(10) NOT NULL,
  `usuaTelefono` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USUARIOS`
--

INSERT INTO `USUARIOS` (`usuaId`, `ciudId`, `usuaIdentidad`, `usuaNombres`, `usuaApellido1`, `usuaApellido2`, `usuaTelefono`) VALUES
(1, 1, 12345, 'Miller Daniel', 'Quilindo', 'Velasco', '3226082649');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ACTIVIDADES`
--
ALTER TABLE `ACTIVIDADES`
  ADD PRIMARY KEY (`actiId`),
  ADD UNIQUE KEY `actiNombre` (`actiNombre`);

--
-- Indexes for table `BARRIOS`
--
ALTER TABLE `BARRIOS`
  ADD PRIMARY KEY (`barrId`),
  ADD UNIQUE KEY `barrNombre` (`barrNombre`);

--
-- Indexes for table `CASAS`
--
ALTER TABLE `CASAS`
  ADD PRIMARY KEY (`casaId`),
  ADD UNIQUE KEY `casaDireccion` (`casaDireccion`),
  ADD KEY `fkCasaBarrio` (`barrId`),
  ADD KEY `fkCasaCiudad` (`ciudId`);

--
-- Indexes for table `CIUDADES`
--
ALTER TABLE `CIUDADES`
  ADD PRIMARY KEY (`ciudId`),
  ADD UNIQUE KEY `ciudNombre` (`ciudNombre`);

--
-- Indexes for table `CONTADORES`
--
ALTER TABLE `CONTADORES`
  ADD PRIMARY KEY (`contId`),
  ADD KEY `fkContadorCasa` (`casaId`);

--
-- Indexes for table `DETALLE_SENSORES`
--
ALTER TABLE `DETALLE_SENSORES`
  ADD PRIMARY KEY (`usuaId`,`sensId`,`actiId`),
  ADD KEY `fkSensorSensor` (`sensId`),
  ADD KEY `fkSensorActividad` (`actiId`);

--
-- Indexes for table `HISTORIALES`
--
ALTER TABLE `HISTORIALES`
  ADD PRIMARY KEY (`histId`),
  ADD KEY `fkHistorialContador` (`contId`);

--
-- Indexes for table `SENSORES`
--
ALTER TABLE `SENSORES`
  ADD PRIMARY KEY (`sensId`),
  ADD KEY `fkSensorContador` (`contId`);

--
-- Indexes for table `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD PRIMARY KEY (`usuaId`),
  ADD UNIQUE KEY `usuaIdentidad` (`usuaIdentidad`),
  ADD UNIQUE KEY `usuaTelefono` (`usuaTelefono`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ACTIVIDADES`
--
ALTER TABLE `ACTIVIDADES`
  MODIFY `actiId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `BARRIOS`
--
ALTER TABLE `BARRIOS`
  MODIFY `barrId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `CASAS`
--
ALTER TABLE `CASAS`
  MODIFY `casaId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `CIUDADES`
--
ALTER TABLE `CIUDADES`
  MODIFY `ciudId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `CONTADORES`
--
ALTER TABLE `CONTADORES`
  MODIFY `contId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `HISTORIALES`
--
ALTER TABLE `HISTORIALES`
  MODIFY `histId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `SENSORES`
--
ALTER TABLE `SENSORES`
  MODIFY `sensId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `USUARIOS`
--
ALTER TABLE `USUARIOS`
  MODIFY `usuaId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CASAS`
--
ALTER TABLE `CASAS`
  ADD CONSTRAINT `fkCasaBarrio` FOREIGN KEY (`barrId`) REFERENCES `BARRIOS` (`barrId`),
  ADD CONSTRAINT `fkCasaCiudad` FOREIGN KEY (`ciudId`) REFERENCES `CIUDADES` (`ciudId`);

--
-- Constraints for table `CONTADORES`
--
ALTER TABLE `CONTADORES`
  ADD CONSTRAINT `fkContadorCasa` FOREIGN KEY (`casaId`) REFERENCES `CASAS` (`casaId`);

--
-- Constraints for table `DETALLE_SENSORES`
--
ALTER TABLE `DETALLE_SENSORES`
  ADD CONSTRAINT `fkSensorActividad` FOREIGN KEY (`actiId`) REFERENCES `ACTIVIDADES` (`actiId`),
  ADD CONSTRAINT `fkSensorSensor` FOREIGN KEY (`sensId`) REFERENCES `SENSORES` (`sensId`),
  ADD CONSTRAINT `fkSensorUsuario` FOREIGN KEY (`usuaId`) REFERENCES `USUARIOS` (`usuaId`);

--
-- Constraints for table `HISTORIALES`
--
ALTER TABLE `HISTORIALES`
  ADD CONSTRAINT `fkHistorialContador` FOREIGN KEY (`contId`) REFERENCES `CONTADORES` (`contId`);

--
-- Constraints for table `SENSORES`
--
ALTER TABLE `SENSORES`
  ADD CONSTRAINT `fkSensorContador` FOREIGN KEY (`contId`) REFERENCES `CONTADORES` (`contId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
