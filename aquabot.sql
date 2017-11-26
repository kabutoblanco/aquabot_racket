-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 26-11-2017 a las 02:59:34
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

DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `crearUsuario` (`ciudad` VARCHAR(35), `barrio` VARCHAR(35), `identidad` INT(5), `clave` VARCHAR(25), `nombres` VARCHAR(35), `apellido1` VARCHAR(15), `apellido2` VARCHAR(15), `telefono` INT(15), `direccion` VARCHAR(35)) RETURNS INT(11) BEGIN
    DECLARE usuarios INT(5);
    DECLARE casas INT(5);
    DECLARE idBarrio INT (5);
    DECLARE idCasa INT(5);
    DECLARE idContador INT(5);
    DECLARE numContador INT(15);
    DECLARE estrato INT(5);
    SELECT count(*) INTO usuarios FROM USUARIOS WHERE usuaIdentidad = identidad;
    IF usuarios = 0 THEN
      SELECT count(*) INTO casas FROM CASAS WHERE casaDireccion = direccion;
      IF casas = 0 THEN
        SET estrato = (SELECT FLOOR(1 + (RAND() * 5)));
        SET numContador = (SELECT FLOOR(1 + (RAND() * 9998)));
        SELECT barrId INTO idBarrio FROM BARRIOS INNER JOIN CIUDADES ON BARRIOS.ciudId = CIUDADES.ciudId WHERE barrNombre = barrio AND ciudNombre = ciudad;
        INSERT INTO CASAS VALUES (null, idBarrio, estrato, direccion);
        SELECT casaId INTO idCasa FROM CASAS WHERE casaDireccion = direccion;
        INSERT INTO CONTADORES VALUES (null, idCasa, numContador, 0);
        SELECT contId INTO idContador FROM CONTADORES WHERE contNumero = numContador;
        INSERT INTO SENSORES VALUES (null, 1, idContador, (SELECT FLOOR(1 + (RAND() * 9998))));
        INSERT INTO USUARIOS VALUES(null, idCasa, identidad, clave, nombres, apellido1, apellido2, telefono);
        RETURN 1;
      ELSE
        SELECT casaId INTO idCasa FROM CASAS WHERE casaDireccion = direccion;
        INSERT INTO USUARIOS VALUES(null, idCasa, identidad, clave, nombres, apellido1, apellido2, telefono);
        RETURN 0;
      END IF;
    ELSE
      RETURN 0;
    END IF;
  END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ACTIVIDADES`
--

CREATE TABLE `ACTIVIDADES` (
  `actiId` int(5) NOT NULL,
  `actiNombre` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ACTIVIDADES`
--

INSERT INTO `ACTIVIDADES` (`actiId`, `actiNombre`) VALUES
(1, 'losa grasa'),
(2, 'losa rapida'),
(3, 'banio rapido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `BARRIOS`
--

CREATE TABLE `BARRIOS` (
  `barrId` int(5) NOT NULL,
  `ciudId` int(5) NOT NULL,
  `barrNombre` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `BARRIOS`
--

INSERT INTO `BARRIOS` (`barrId`, `ciudId`, `barrNombre`) VALUES
(1, 1, 'la paz'),
(2, 1, 'villa del norte'),
(3, 1, 'la esmeralda');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CASAS`
--

CREATE TABLE `CASAS` (
  `casaId` int(5) NOT NULL,
  `barrId` int(5) NOT NULL,
  `casaEstrato` int(1) DEFAULT NULL,
  `casaDireccion` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `CASAS`
--

INSERT INTO `CASAS` (`casaId`, `barrId`, `casaEstrato`, `casaDireccion`) VALUES
(1, 1, 3, 'calle 73 cn # 1 - 57'),
(2, 3, 3, 'carrera 64 b # 1 - 43'),
(6, 1, 4, 'calle 72 cn # 1 - 24'),
(8, 1, 3, 'calle 72 cn # 1 - 14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CIUDADES`
--

CREATE TABLE `CIUDADES` (
  `ciudId` int(5) NOT NULL,
  `ciudNombre` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `CIUDADES`
--

INSERT INTO `CIUDADES` (`ciudId`, `ciudNombre`) VALUES
(1, 'popayan'),
(2, 'cali'),
(3, 'barranquilla'),
(4, 'leticia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CONTADORES`
--

CREATE TABLE `CONTADORES` (
  `contId` int(5) NOT NULL,
  `casaId` int(5) NOT NULL,
  `contNumero` int(15) NOT NULL,
  `contRegistro` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `CONTADORES`
--

INSERT INTO `CONTADORES` (`contId`, `casaId`, `contNumero`, `contRegistro`) VALUES
(1, 1, 1432, '244.14'),
(2, 6, 1588, '27.69'),
(4, 8, 1806, '0.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DETALLE_ACTIVIDADES`
--

CREATE TABLE `DETALLE_ACTIVIDADES` (
  `actiIdD` int(5) NOT NULL,
  `usuaId` int(5) NOT NULL,
  `actiId` int(5) NOT NULL,
  `sensId` int(5) NOT NULL,
  `detaLimiteA` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `DETALLE_ACTIVIDADES`
--

INSERT INTO `DETALLE_ACTIVIDADES` (`actiIdD`, `usuaId`, `actiId`, `sensId`, `detaLimiteA`) VALUES
(1, 1, 1, 1, '5.00'),
(2, 1, 2, 1, '11.00'),
(3, 1, 3, 3, '13.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HISTORIAL_CONSUMOS`
--

CREATE TABLE `HISTORIAL_CONSUMOS` (
  `consIdH` int(5) NOT NULL,
  `usuaId` int(5) NOT NULL,
  `sensId` int(5) NOT NULL,
  `consRegistroH` decimal(10,2) NOT NULL,
  `consFechaH` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `HISTORIAL_CONSUMOS`
--

INSERT INTO `HISTORIAL_CONSUMOS` (`consIdH`, `usuaId`, `sensId`, `consRegistroH`, `consFechaH`) VALUES
(1, 1, 2, '9.27', '2017-11-23'),
(2, 1, 2, '15.24', '2017-11-23'),
(3, 1, 1, '11.90', '2017-11-23'),
(4, 1, 1, '19.73', '2017-11-23'),
(5, 1, 2, '45.34', '2017-11-23'),
(6, 1, 1, '24.43', '2017-11-23'),
(7, 1, 2, '52.53', '2017-11-23'),
(8, 1, 1, '19.85', '2017-11-23'),
(9, 1, 2, '14.32', '2017-11-23'),
(10, 1, 2, '17.91', '2017-11-23'),
(11, 1, 1, '34.01', '2017-11-23'),
(12, 1, 1, '16.71', '2017-11-23'),
(13, 1, 2, '20.10', '2017-11-23'),
(14, 2, 2, '18.43', '2017-11-23'),
(15, 2, 3, '26.58', '2017-11-23'),
(16, 2, 4, '9.48', '2017-11-23'),
(17, 2, 1, '24.04', '2017-11-23'),
(18, 2, 2, '20.86', '2017-11-23'),
(19, 2, 1, '10.86', '2017-11-23'),
(20, 2, 1, '8.05', '2017-11-23'),
(21, 2, 1, '8.77', '2017-11-23'),
(22, 2, 1, '6.49', '2017-11-23'),
(23, 2, 1, '45.09', '2017-11-23'),
(24, 2, 1, '45.09', '2017-11-23'),
(25, 2, 1, '6.54', '2017-11-23'),
(26, 2, 1, '48.53', '2017-11-23'),
(27, 2, 1, '8.69', '2017-11-23'),
(28, 2, 2, '46.11', '2017-11-23'),
(29, 2, 4, '47.56', '2017-11-23'),
(30, 2, 1, '10.30', '2017-11-23'),
(31, 2, 1, '7.27', '2017-11-23'),
(32, 1, 3, '12.41', '2017-11-23'),
(33, 1, 1, '45.88', '2017-11-23'),
(34, 1, 1, '35.65', '2017-11-23'),
(35, 1, 1, '45.70', '2017-11-23'),
(36, 1, 1, '8.28', '2017-11-23'),
(37, 1, 1, '15.38', '2017-11-23'),
(38, 1, 1, '21.51', '2017-11-23'),
(39, 1, 2, '9.00', '2017-11-23'),
(40, 1, 1, '48.04', '2017-11-23'),
(41, 1, 2, '44.32', '2017-11-23'),
(42, 1, 4, '14.74', '2017-11-23'),
(43, 1, 2, '17.78', '2017-11-23'),
(44, 1, 2, '12.69', '2017-11-23'),
(45, 1, 2, '26.57', '2017-11-23'),
(46, 1, 1, '6.01', '2017-11-23'),
(47, 1, 1, '7.17', '2017-11-23'),
(48, 1, 1, '12.66', '2017-11-23'),
(49, 1, 1, '13.15', '2017-11-23'),
(50, 1, 1, '12.82', '2017-11-23'),
(51, 1, 4, '10.39', '2017-11-23'),
(52, 2, 2, '5.70', '2017-11-24'),
(53, 1, 1, '11.82', '2017-11-24'),
(54, 1, 1, '6.75', '2017-11-24'),
(55, 1, 1, '5.64', '2017-11-24'),
(56, 1, 3, '13.10', '2017-11-24'),
(57, 6, 5, '27.69', '2017-11-25'),
(59, 1, 2, '34.00', '2017-10-19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HISTORIAL_CONTADORES`
--

CREATE TABLE `HISTORIAL_CONTADORES` (
  `histIdC` int(5) NOT NULL,
  `contId` int(5) NOT NULL,
  `histRegistroC` decimal(10,2) NOT NULL,
  `histFechaC` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `HISTORIAL_CONTADORES`
--

INSERT INTO `HISTORIAL_CONTADORES` (`histIdC`, `contId`, `histRegistroC`, `histFechaC`) VALUES
(2, 1, '45.00', '2017-10-23'),
(3, 1, '95.57', '2017-11-23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `LOCACIONES`
--

CREATE TABLE `LOCACIONES` (
  `locaId` int(5) NOT NULL,
  `locaNombre` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `LOCACIONES`
--

INSERT INTO `LOCACIONES` (`locaId`, `locaNombre`) VALUES
(1, 'tina'),
(2, 'lava platos'),
(3, 'lava manos'),
(4, 'inodoro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SENSORES`
--

CREATE TABLE `SENSORES` (
  `sensId` int(5) NOT NULL,
  `locaId` int(5) NOT NULL,
  `contId` int(5) NOT NULL,
  `sensNumero` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `SENSORES`
--

INSERT INTO `SENSORES` (`sensId`, `locaId`, `contId`, `sensNumero`) VALUES
(1, 2, 1, 4234),
(2, 3, 1, 4321),
(3, 1, 1, 4312),
(4, 4, 1, 4317),
(5, 1, 2, 6634),
(7, 1, 4, 1674);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USUARIOS`
--

CREATE TABLE `USUARIOS` (
  `usuaId` int(5) NOT NULL,
  `casaId` int(5) NOT NULL,
  `usuaIdentidad` int(25) NOT NULL,
  `usuaClave` varchar(25) NOT NULL,
  `usuaNombres` varchar(35) NOT NULL,
  `usuaApellido1` varchar(15) NOT NULL,
  `usuaApellido2` varchar(15) NOT NULL,
  `usuaTelefono` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `USUARIOS`
--

INSERT INTO `USUARIOS` (`usuaId`, `casaId`, `usuaIdentidad`, `usuaClave`, `usuaNombres`, `usuaApellido1`, `usuaApellido2`, `usuaTelefono`) VALUES
(1, 1, 122, 'oracle', 'miller daniel', 'quilindo', 'velasco', 8234838),
(2, 1, 133, 'oracle', 'yaneth', 'velasco', 'velasco', 8493929),
(6, 6, 144, 'oracle', 'daniel', 'velasco', 'velasco', 83283838),
(9, 8, 155, 'oracle', 'daniel', 'velasco', 'velasco', 83283838);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ACTIVIDADES`
--
ALTER TABLE `ACTIVIDADES`
  ADD PRIMARY KEY (`actiId`);

--
-- Indices de la tabla `BARRIOS`
--
ALTER TABLE `BARRIOS`
  ADD PRIMARY KEY (`barrId`),
  ADD KEY `ciudId` (`ciudId`);

--
-- Indices de la tabla `CASAS`
--
ALTER TABLE `CASAS`
  ADD PRIMARY KEY (`casaId`),
  ADD KEY `barrId` (`barrId`);

--
-- Indices de la tabla `CIUDADES`
--
ALTER TABLE `CIUDADES`
  ADD PRIMARY KEY (`ciudId`);

--
-- Indices de la tabla `CONTADORES`
--
ALTER TABLE `CONTADORES`
  ADD PRIMARY KEY (`contId`),
  ADD KEY `casaId` (`casaId`);

--
-- Indices de la tabla `DETALLE_ACTIVIDADES`
--
ALTER TABLE `DETALLE_ACTIVIDADES`
  ADD PRIMARY KEY (`actiIdD`),
  ADD UNIQUE KEY `usuaId` (`usuaId`,`actiId`,`sensId`),
  ADD KEY `actiId` (`actiId`),
  ADD KEY `sensId` (`sensId`);

--
-- Indices de la tabla `HISTORIAL_CONSUMOS`
--
ALTER TABLE `HISTORIAL_CONSUMOS`
  ADD PRIMARY KEY (`consIdH`),
  ADD KEY `usuaId` (`usuaId`),
  ADD KEY `sensId` (`sensId`);

--
-- Indices de la tabla `HISTORIAL_CONTADORES`
--
ALTER TABLE `HISTORIAL_CONTADORES`
  ADD PRIMARY KEY (`histIdC`),
  ADD KEY `contId` (`contId`);

--
-- Indices de la tabla `LOCACIONES`
--
ALTER TABLE `LOCACIONES`
  ADD PRIMARY KEY (`locaId`);

--
-- Indices de la tabla `SENSORES`
--
ALTER TABLE `SENSORES`
  ADD PRIMARY KEY (`sensId`),
  ADD KEY `locaId` (`locaId`),
  ADD KEY `contId` (`contId`);

--
-- Indices de la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD PRIMARY KEY (`usuaId`),
  ADD UNIQUE KEY `usuaIdentidad` (`usuaIdentidad`),
  ADD KEY `casaId` (`casaId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ACTIVIDADES`
--
ALTER TABLE `ACTIVIDADES`
  MODIFY `actiId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `BARRIOS`
--
ALTER TABLE `BARRIOS`
  MODIFY `barrId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `CASAS`
--
ALTER TABLE `CASAS`
  MODIFY `casaId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `CIUDADES`
--
ALTER TABLE `CIUDADES`
  MODIFY `ciudId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `CONTADORES`
--
ALTER TABLE `CONTADORES`
  MODIFY `contId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `DETALLE_ACTIVIDADES`
--
ALTER TABLE `DETALLE_ACTIVIDADES`
  MODIFY `actiIdD` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `HISTORIAL_CONSUMOS`
--
ALTER TABLE `HISTORIAL_CONSUMOS`
  MODIFY `consIdH` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `HISTORIAL_CONTADORES`
--
ALTER TABLE `HISTORIAL_CONTADORES`
  MODIFY `histIdC` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `LOCACIONES`
--
ALTER TABLE `LOCACIONES`
  MODIFY `locaId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `SENSORES`
--
ALTER TABLE `SENSORES`
  MODIFY `sensId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  MODIFY `usuaId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `BARRIOS`
--
ALTER TABLE `BARRIOS`
  ADD CONSTRAINT `BARRIOS_ibfk_1` FOREIGN KEY (`ciudId`) REFERENCES `CIUDADES` (`ciudId`) ON DELETE CASCADE;

--
-- Filtros para la tabla `CASAS`
--
ALTER TABLE `CASAS`
  ADD CONSTRAINT `CASAS_ibfk_1` FOREIGN KEY (`barrId`) REFERENCES `BARRIOS` (`barrId`) ON DELETE CASCADE;

--
-- Filtros para la tabla `CONTADORES`
--
ALTER TABLE `CONTADORES`
  ADD CONSTRAINT `CONTADORES_ibfk_1` FOREIGN KEY (`casaId`) REFERENCES `CASAS` (`casaId`) ON DELETE CASCADE;

--
-- Filtros para la tabla `DETALLE_ACTIVIDADES`
--
ALTER TABLE `DETALLE_ACTIVIDADES`
  ADD CONSTRAINT `DETALLE_ACTIVIDADES_ibfk_1` FOREIGN KEY (`usuaId`) REFERENCES `USUARIOS` (`usuaId`) ON DELETE CASCADE,
  ADD CONSTRAINT `DETALLE_ACTIVIDADES_ibfk_2` FOREIGN KEY (`actiId`) REFERENCES `ACTIVIDADES` (`actiId`) ON DELETE CASCADE,
  ADD CONSTRAINT `DETALLE_ACTIVIDADES_ibfk_3` FOREIGN KEY (`sensId`) REFERENCES `SENSORES` (`sensId`) ON DELETE CASCADE;

--
-- Filtros para la tabla `HISTORIAL_CONSUMOS`
--
ALTER TABLE `HISTORIAL_CONSUMOS`
  ADD CONSTRAINT `HISTORIAL_CONSUMOS_ibfk_1` FOREIGN KEY (`usuaId`) REFERENCES `USUARIOS` (`usuaId`) ON DELETE CASCADE,
  ADD CONSTRAINT `HISTORIAL_CONSUMOS_ibfk_2` FOREIGN KEY (`sensId`) REFERENCES `SENSORES` (`sensId`) ON DELETE CASCADE;

--
-- Filtros para la tabla `HISTORIAL_CONTADORES`
--
ALTER TABLE `HISTORIAL_CONTADORES`
  ADD CONSTRAINT `HISTORIAL_CONTADORES_ibfk_1` FOREIGN KEY (`contId`) REFERENCES `CONTADORES` (`contId`) ON DELETE CASCADE;

--
-- Filtros para la tabla `SENSORES`
--
ALTER TABLE `SENSORES`
  ADD CONSTRAINT `SENSORES_ibfk_1` FOREIGN KEY (`locaId`) REFERENCES `LOCACIONES` (`locaId`) ON DELETE CASCADE,
  ADD CONSTRAINT `SENSORES_ibfk_2` FOREIGN KEY (`contId`) REFERENCES `CONTADORES` (`contId`) ON DELETE CASCADE;

--
-- Filtros para la tabla `USUARIOS`
--
ALTER TABLE `USUARIOS`
  ADD CONSTRAINT `USUARIOS_ibfk_1` FOREIGN KEY (`casaId`) REFERENCES `CASAS` (`casaId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
