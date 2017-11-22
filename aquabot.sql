-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 22-11-2017 a las 15:45:30
-- Versión del servidor: 10.1.28-MariaDB
-- Versión de PHP: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `aquabot`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ACTIVIDADES`
--

CREATE TABLE `ACTIVIDADES` (
  `actiId` int(5) NOT NULL,
  `actiNombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `BARRIOS`
--

CREATE TABLE `BARRIOS` (
  `barrId` int(5) NOT NULL,
  `barrNombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CASAS`
--

CREATE TABLE `CASAS` (
  `casaId` int(5) NOT NULL,
  `barrId` int(5) DEFAULT NULL,
  `ciudId` int(5) DEFAULT NULL,
  `casaEstrato` int(1) NOT NULL,
  `casaDireccion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CIUDADES`
--

CREATE TABLE `CIUDADES` (
  `ciudId` int(5) NOT NULL,
  `ciudNombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CONTADORES`
--

CREATE TABLE `CONTADORES` (
  `contId` int(5) NOT NULL,
  `casaId` int(5) DEFAULT NULL,
  `contRegistro` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DETALLE_SENSORES`
--

CREATE TABLE `DETALLE_SENSORES` (
  `usuaId` int(5) NOT NULL,
  `sensId` int(5) NOT NULL,
  `actiId` int(5) NOT NULL,
  `sensLimite` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HISTORIALES`
--

CREATE TABLE `HISTORIALES` (
  `histId` int(5) NOT NULL,
  `contId` int(5) DEFAULT NULL,
  `histRegistro` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SENSORES`
--

CREATE TABLE `SENSORES` (
  `sensId` int(5) NOT NULL,
  `contId` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USUARIOS`
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
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ACTIVIDADES`
--
ALTER TABLE `ACTIVIDADES`
  ADD PRIMARY KEY (`actiId`),
  ADD UNIQUE KEY `actiNombre` (`actiNombre`);

--
-- Indices de la tabla `BARRIOS`
--
ALTER TABLE `BARRIOS`
  ADD PRIMARY KEY (`barrId`),
  ADD UNIQUE KEY `barrNombre` (`barrNombre`);

--
-- Indices de la tabla `CASAS`
--
ALTER TABLE `CASAS`
  ADD PRIMARY KEY (`casaId`),
  ADD UNIQUE KEY `casaDireccion` (`casaDireccion`),
  ADD KEY `fkCasaBarrio` (`barrId`),
  ADD KEY `fkCasaCiudad` (`ciudId`);

--
-- Indices de la tabla `CIUDADES`
--
ALTER TABLE `CIUDADES`
  ADD PRIMARY KEY (`ciudId`),
  ADD UNIQUE KEY `ciudNombre` (`ciudNombre`);

--
-- Indices de la tabla `CONTADORES`
--
ALTER TABLE `CONTADORES`
  ADD PRIMARY KEY (`contId`),
  ADD KEY `fkContadorCasa` (`casaId`);

--
-- Indices de la tabla `DETALLE_SENSORES`
--
ALTER TABLE `DETALLE_SENSORES`
  ADD PRIMARY KEY (`usuaId`,`sensId`,`actiId`),
  ADD KEY `fkSensorSensor` (`sensId`),
  ADD KEY `fkSensorActividad` (`actiId`);

--
-- Indices de la tabla `HISTORIALES`
--
ALTER TABLE `HISTORIALES`
  ADD PRIMARY KEY (`histId`),
  ADD KEY `fkHistorialContador` (`contId`);

--
-- Indices de la tabla `SENSORES`
--
ALTER TABLE `SENSORES`
  ADD PRIMARY KEY (`sensId`),
  ADD KEY `fkSensorContador` (`contId`);

--
-- Indices de la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD PRIMARY KEY (`usuaId`),
  ADD UNIQUE KEY `usuaIdentidad` (`usuaIdentidad`),
  ADD UNIQUE KEY `usuaTelefono` (`usuaTelefono`),
  ADD KEY `fkUsuarioCiudad` (`ciudId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ACTIVIDADES`
--
ALTER TABLE `ACTIVIDADES`
  MODIFY `actiId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `BARRIOS`
--
ALTER TABLE `BARRIOS`
  MODIFY `barrId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `CASAS`
--
ALTER TABLE `CASAS`
  MODIFY `casaId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `CIUDADES`
--
ALTER TABLE `CIUDADES`
  MODIFY `ciudId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `CONTADORES`
--
ALTER TABLE `CONTADORES`
  MODIFY `contId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `HISTORIALES`
--
ALTER TABLE `HISTORIALES`
  MODIFY `histId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `SENSORES`
--
ALTER TABLE `SENSORES`
  MODIFY `sensId` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  MODIFY `usuaId` int(5) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `CASAS`
--
ALTER TABLE `CASAS`
  ADD CONSTRAINT `fkCasaBarrio` FOREIGN KEY (`barrId`) REFERENCES `BARRIOS` (`barrId`),
  ADD CONSTRAINT `fkCasaCiudad` FOREIGN KEY (`ciudId`) REFERENCES `CIUDADES` (`ciudId`);

--
-- Filtros para la tabla `CONTADORES`
--
ALTER TABLE `CONTADORES`
  ADD CONSTRAINT `fkContadorCasa` FOREIGN KEY (`casaId`) REFERENCES `CASAS` (`casaId`);

--
-- Filtros para la tabla `DETALLE_SENSORES`
--
ALTER TABLE `DETALLE_SENSORES`
  ADD CONSTRAINT `fkSensorActividad` FOREIGN KEY (`actiId`) REFERENCES `ACTIVIDADES` (`actiId`),
  ADD CONSTRAINT `fkSensorSensor` FOREIGN KEY (`sensId`) REFERENCES `SENSORES` (`sensId`),
  ADD CONSTRAINT `fkSensorUsuario` FOREIGN KEY (`usuaId`) REFERENCES `USUARIOS` (`usuaId`);

--
-- Filtros para la tabla `HISTORIALES`
--
ALTER TABLE `HISTORIALES`
  ADD CONSTRAINT `fkHistorialContador` FOREIGN KEY (`contId`) REFERENCES `CONTADORES` (`contId`);

--
-- Filtros para la tabla `SENSORES`
--
ALTER TABLE `SENSORES`
  ADD CONSTRAINT `fkSensorContador` FOREIGN KEY (`contId`) REFERENCES `CONTADORES` (`contId`);

--
-- Filtros para la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD CONSTRAINT `fkUsuarioCiudad` FOREIGN KEY (`ciudId`) REFERENCES `CIUDADES` (`ciudId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
