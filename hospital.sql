-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 23-04-2025 a las 23:35:20
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hospital`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `citas`
--

CREATE TABLE `citas` (
  `ID_Cita` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `ID_Medico` int(11) DEFAULT NULL,
  `Fecha_Cita` date DEFAULT NULL,
  `Hora_Cita` time DEFAULT NULL,
  `Motivo_Cita` text DEFAULT NULL,
  `Estado_Cita` enum('Pendiente','Confirmada','Cancelada') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacion`
--

CREATE TABLE `facturacion` (
  `ID_Factura` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `ID_Medico` int(11) DEFAULT NULL,
  `ID_Cita` int(11) DEFAULT NULL,
  `Fecha_Factura` date DEFAULT NULL,
  `pago_Total` decimal(10,2) DEFAULT NULL,
  `Descripción` text DEFAULT NULL,
  `Metodo_Pago` enum('Efectivo','Tarjeta','Transferencia') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formulas_medicas`
--

CREATE TABLE `formulas_medicas` (
  `ID_Formula` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `ID_Medico` int(11) DEFAULT NULL,
  `ID_Medicamento` int(11) DEFAULT NULL,
  `Fecha_Formula` date DEFAULT NULL,
  `Indicaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `ID_Habitacion` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `Numero_Habitacion` varchar(10) DEFAULT NULL,
  `Tipo_Habitacion` enum('Individual','Doble','Suite') DEFAULT NULL,
  `Estado_Habitacion` enum('Disponible','Ocupada','Mantenimiento') DEFAULT NULL,
  `Costo_Habitacion` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_auditoria`
--

CREATE TABLE `historial_auditoria` (
  `id` int(11) NOT NULL,
  `accion` varchar(50) DEFAULT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_clinico`
--

CREATE TABLE `historial_clinico` (
  `ID_Historial` int(11) NOT NULL,
  `ID_Paciente` int(11) DEFAULT NULL,
  `Fecha_Historial` date DEFAULT NULL,
  `Descripción_Historial` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `historial_clinico`
--
DELIMITER $$
CREATE TRIGGER `tr_log_historial_clinico` AFTER INSERT ON `historial_clinico` FOR EACH ROW BEGIN
    INSERT INTO historial_auditoria (accion, id_paciente, fecha)
    VALUES ('Insertó historial', NEW.ID_Paciente, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios_medicos`
--

CREATE TABLE `horarios_medicos` (
  `ID_Horario` int(11) NOT NULL,
  `ID_Medico` int(11) DEFAULT NULL,
  `Día` enum('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo') DEFAULT NULL,
  `Hora_Inicio` time DEFAULT NULL,
  `Hora_Fin` time DEFAULT NULL,
  `Disponibilidad` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `ID_Medicamento` int(11) NOT NULL,
  `Nombre_Medicamento` varchar(100) DEFAULT NULL,
  `Descripción_Medicamento` text DEFAULT NULL,
  `Dosis` varchar(50) DEFAULT NULL,
  `Frecuencia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `ID_Medico` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `Especialidad` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Numero_Licencia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `ID_Paciente` int(11) NOT NULL,
  `Nombre` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Fecha_Nacimiento` date DEFAULT NULL,
  `barrio` varchar(100) DEFAULT NULL,
  `Ciudad` varchar(50) DEFAULT NULL,
  `Teléfono` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `tipo_sangre` varchar(5) DEFAULT NULL,
  `eps` varchar(100) DEFAULT NULL,
  `Genero` enum('Masculino','Femenino','Otro') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sede`
--

CREATE TABLE `sede` (
  `id_sede` int(11) NOT NULL,
  `nombre_sede` varchar(100) NOT NULL,
  `ubicacion` text NOT NULL,
  `capacidad` int(11) NOT NULL,
  `imagen` longblob DEFAULT NULL,
  `id_admin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sede`
--

INSERT INTO `sede` (`id_sede`, `nombre_sede`, `ubicacion`, `capacidad`, `imagen`, `id_admin`) VALUES
(1, 'Sede Central', 'Av. Siempre Viva 742, Ciudad Principal', 150, NULL, 1),
(2, 'Sucursal Norte', 'Calle Ficticia 123, Zona Norte', 80, NULL, 2),
(3, 'Sucursal Sur', 'Boulevard del Sol 456, Zona Sur', 100, NULL, 3),
(4, 'Sede de Apoyo', 'Ruta Nacional 9, Km 12, Zona Rural', 50, NULL, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

CREATE TABLE `tratamientos` (
  `ID_Tratamiento` int(11) NOT NULL,
  `ID_Historial` int(11) DEFAULT NULL,
  `Nombre_Tratamiento` varchar(100) DEFAULT NULL,
  `Descripción_Tratamiento` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `intentos_login` int(11) DEFAULT 0,
  `bloqueado` tinyint(1) DEFAULT 0,
  `ultimo_intento` datetime DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `contraseña`, `intentos_login`, `bloqueado`, `ultimo_intento`, `fecha_registro`) VALUES
(1, 'Ana Martínez', 'ana.martinez@gmail.com', '298372621', 0, 0, NULL, '2025-04-23 20:35:33'),
(2, 'Luis Gómez', 'luis.gomez@gmail.com', '3663335526', 2, 0, '2025-04-22 19:45:00', '2025-04-23 20:35:33'),
(3, 'María Torres', 'maria.torres@gmail.com', '73662658', 5, 1, '2025-04-23 08:30:00', '2025-04-23 20:35:33'),
(4, 'Carlos Ruiz', 'carlos.ruiz@gmail.com', '77378263', 1, 0, '2025-04-23 10:15:00', '2025-04-23 20:35:33');

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `controlar_intentos_login` BEFORE UPDATE ON `usuarios` FOR EACH ROW BEGIN
    IF NEW.intentos_login >= 3 THEN
        SET NEW.bloqueado = TRUE;
        SET NEW.ultimo_intento = NOW();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_sedes_con_admin`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_sedes_con_admin` (
`id_sede` int(11)
,`nombre_sede` varchar(100)
,`ubicacion` text
,`capacidad` int(11)
,`nombre_administrador` varchar(100)
,`email_administrador` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_usuarios_activos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_usuarios_activos` (
`id` int(11)
,`nombre` varchar(100)
,`email` varchar(100)
,`fecha_registro` timestamp
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_sedes_con_admin`
--
DROP TABLE IF EXISTS `vista_sedes_con_admin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_sedes_con_admin`  AS SELECT `s`.`id_sede` AS `id_sede`, `s`.`nombre_sede` AS `nombre_sede`, `s`.`ubicacion` AS `ubicacion`, `s`.`capacidad` AS `capacidad`, `u`.`nombre` AS `nombre_administrador`, `u`.`email` AS `email_administrador` FROM (`sede` `s` join `usuarios` `u` on(`s`.`id_admin` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_usuarios_activos`
--
DROP TABLE IF EXISTS `vista_usuarios_activos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_usuarios_activos`  AS SELECT `usuarios`.`id` AS `id`, `usuarios`.`nombre` AS `nombre`, `usuarios`.`email` AS `email`, `usuarios`.`fecha_registro` AS `fecha_registro` FROM `usuarios` WHERE `usuarios`.`bloqueado` = 0 ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `citas`
--
ALTER TABLE `citas`
  ADD PRIMARY KEY (`ID_Cita`),
  ADD KEY `citas_ibfk_1` (`ID_Paciente`),
  ADD KEY `citas_ibfk_2` (`ID_Medico`);

--
-- Indices de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD PRIMARY KEY (`ID_Factura`),
  ADD KEY `facturacion_ibfk_1` (`ID_Paciente`),
  ADD KEY `facturacion_ibfk_2` (`ID_Medico`),
  ADD KEY `facturacion_ibfk_3` (`ID_Cita`);

--
-- Indices de la tabla `formulas_medicas`
--
ALTER TABLE `formulas_medicas`
  ADD PRIMARY KEY (`ID_Formula`),
  ADD KEY `formulas_medicas_ibfk_1` (`ID_Paciente`),
  ADD KEY `formulas_medicas_ibfk_2` (`ID_Medico`),
  ADD KEY `formulas_medicas_ibfk_3` (`ID_Medicamento`);

--
-- Indices de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD PRIMARY KEY (`ID_Habitacion`),
  ADD KEY `habitaciones_ibfk_1` (`ID_Paciente`);

--
-- Indices de la tabla `historial_auditoria`
--
ALTER TABLE `historial_auditoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD PRIMARY KEY (`ID_Historial`),
  ADD KEY `historial_clinico_ibfk_1` (`ID_Paciente`);

--
-- Indices de la tabla `horarios_medicos`
--
ALTER TABLE `horarios_medicos`
  ADD PRIMARY KEY (`ID_Horario`),
  ADD KEY `horarios_medicos_ibfk_1` (`ID_Medico`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`ID_Medicamento`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`ID_Medico`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`ID_Paciente`);

--
-- Indices de la tabla `sede`
--
ALTER TABLE `sede`
  ADD PRIMARY KEY (`id_sede`),
  ADD KEY `id_admin` (`id_admin`);

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`ID_Tratamiento`),
  ADD KEY `tratamientos_ibfk_1` (`ID_Historial`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `historial_auditoria`
--
ALTER TABLE `historial_auditoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sede`
--
ALTER TABLE `sede`
  MODIFY `id_sede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `citas`
--
ALTER TABLE `citas`
  ADD CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`),
  ADD CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`ID_Medico`) REFERENCES `medicos` (`ID_Medico`);

--
-- Filtros para la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD CONSTRAINT `facturacion_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`),
  ADD CONSTRAINT `facturacion_ibfk_2` FOREIGN KEY (`ID_Medico`) REFERENCES `medicos` (`ID_Medico`),
  ADD CONSTRAINT `facturacion_ibfk_3` FOREIGN KEY (`ID_Cita`) REFERENCES `citas` (`ID_Cita`);

--
-- Filtros para la tabla `formulas_medicas`
--
ALTER TABLE `formulas_medicas`
  ADD CONSTRAINT `formulas_medicas_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`),
  ADD CONSTRAINT `formulas_medicas_ibfk_2` FOREIGN KEY (`ID_Medico`) REFERENCES `medicos` (`ID_Medico`),
  ADD CONSTRAINT `formulas_medicas_ibfk_3` FOREIGN KEY (`ID_Medicamento`) REFERENCES `medicamentos` (`ID_Medicamento`);

--
-- Filtros para la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD CONSTRAINT `habitaciones_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`) ON DELETE SET NULL;

--
-- Filtros para la tabla `historial_clinico`
--
ALTER TABLE `historial_clinico`
  ADD CONSTRAINT `historial_clinico_ibfk_1` FOREIGN KEY (`ID_Paciente`) REFERENCES `pacientes` (`ID_Paciente`);

--
-- Filtros para la tabla `horarios_medicos`
--
ALTER TABLE `horarios_medicos`
  ADD CONSTRAINT `horarios_medicos_ibfk_1` FOREIGN KEY (`ID_Medico`) REFERENCES `medicos` (`ID_Medico`);

--
-- Filtros para la tabla `sede`
--
ALTER TABLE `sede`
  ADD CONSTRAINT `sede_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`ID_Historial`) REFERENCES `historial_clinico` (`ID_Historial`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
