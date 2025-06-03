CREATE DATABASE pruebatecnica;

USE pruebatecnica;
CREATE TABLE `Accesos` (
	`seg_usuario` VARCHAR(20) NOT NULL DEFAULT '' COLLATE 'latin1_spanish_ci',
	`seg_programa` INT(11) NOT NULL DEFAULT '0',
	`seg_insertar` CHAR(2) NULL DEFAULT NULL COLLATE 'latin1_spanish_ci',
	`seg_editar` CHAR(2) NULL DEFAULT NULL COLLATE 'latin1_spanish_ci',
	`seg_borrar` CHAR(2) NULL DEFAULT NULL COLLATE 'latin1_spanish_ci',
	`seg_buscar` CHAR(2) NULL DEFAULT NULL COLLATE 'latin1_spanish_ci'
);

CREATE TABLE `Personal` (
	`per_codigo` INT(11) NOT NULL DEFAULT '0',
	`per_usuario` VARCHAR(20) NOT NULL DEFAULT '' COLLATE 'latin1_spanish_ci',
	`per_apellido1` VARCHAR(25) NULL DEFAULT '' COLLATE 'latin1_spanish_ci',
	`per_apellido2` VARCHAR(35) NULL DEFAULT '' COLLATE 'latin1_spanish_ci',
	`per_nombre1` VARCHAR(35) NULL DEFAULT '' COLLATE 'latin1_spanish_ci',
	`per_nombre2` VARCHAR(35) NULL DEFAULT '' COLLATE 'latin1_spanish_ci',
	`per_estado` INT(10) NOT NULL DEFAULT '1'
);

INSERT INTO `Personal` (`per_codigo`, `per_usuario`, `per_apellido1`, `per_apellido2`, `per_nombre1`, `per_nombre2`, `per_estado`) VALUES (3, 'sergio.deleon', 'De León', '', 'Sergio', '', 0);
INSERT INTO `Personal` (`per_codigo`, `per_usuario`, `per_apellido1`, `per_apellido2`, `per_nombre1`, `per_nombre2`, `per_estado`) VALUES (9, 'smazariegos', 'mazariegos', '', 'Susana', '', 0);
INSERT INTO `Personal` (`per_codigo`, `per_usuario`, `per_apellido1`, `per_apellido2`, `per_nombre1`, `per_nombre2`, `per_estado`) VALUES (12, 'evela', 'Vela', '', 'Emilio', '', 1);
INS


CREATE TABLE `Programas` (
	`pro_codigo` INT(11) NOT NULL DEFAULT '0',
	`pro_descripcion` VARCHAR(100) NULL DEFAULT NULL COLLATE 'latin1_spanish_ci'
)
;

INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Nomenclatura');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Tipos de Polizas');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Proveedores');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Clientes');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Activos Fijos');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Transferencia');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Depreciación');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Confirmación de Embarque');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Facturación');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Departamentos');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Usuarios');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Puestos');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Ayuda en Linea');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Accesos y Privilegios');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Pedidos de Clientes');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Libro de Exportaciones');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Pedido de Cliente (Proforma)');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Parámetros');
INSERT INTO `Programas` (`pro_descripcion`) VALUES ('Póliza de Importación');

