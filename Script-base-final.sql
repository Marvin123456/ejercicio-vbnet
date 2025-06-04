CREATE DATABASE pruebatecnica;

USE pruebatecnica;

-- pruebatecnica.personal definition

CREATE TABLE `personal` (
  `per_codigo` int NOT NULL AUTO_INCREMENT,
  `per_usuario` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `per_apellido1` varchar(25) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `per_apellido2` varchar(35) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT '',
  `per_nombre1` varchar(35) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `per_nombre2` varchar(35) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT '',
  `per_estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`per_codigo`),
  UNIQUE KEY `per_usuario` (`per_usuario`)
);

INSERT INTO pruebatecnica.personal (per_usuario,per_apellido1,per_apellido2,per_nombre1,per_nombre2,per_estado) VALUES
	 ('sergio.deleon','De León','','Sergio','',0),
	 ('smazariegos','mazariegos','','Susana','',0),
	 ('evela','Vela','','Emilio','',1);

-- pruebatecnica.programas definition

CREATE TABLE `programas` (
  `pro_codigo` int NOT NULL AUTO_INCREMENT,
  `pro_descripcion` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`pro_codigo`)
);

INSERT INTO pruebatecnica.programas (pro_descripcion) VALUES
	 ('Nomenclatura'),
	 ('Tipos de Polizas'),
	 ('Proveedores'),
	 ('Clientes'),
	 ('Activos Fijos'),
	 ('Transferencia'),
	 ('Depreciación'),
	 ('Confirmación de Embarque'),
	 ('Facturación'),
	 ('Departamentos');
INSERT INTO pruebatecnica.programas (pro_descripcion) VALUES
	 ('Usuarios'),
	 ('Puestos'),
	 ('Ayuda en Linea'),
	 ('Accesos y Privilegios'),
	 ('Pedidos de Clientes'),
	 ('Libro de Exportaciones'),
	 ('Pedido de Cliente (Proforma)'),
	 ('Parámetros'),
	 ('Póliza de Importación');


-- pruebatecnica.accesos definition

CREATE TABLE `accesos` (
  `seg_per_codigo` int NOT NULL,
  `seg_pro_codigo` int NOT NULL,
  `seg_insertar` char(2) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `seg_editar` char(2) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `seg_borrar` char(2) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `seg_buscar` char(2) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  KEY `seg_per_codigo` (`seg_per_codigo`),
  KEY `seg_pro_codigo` (`seg_pro_codigo`),
  CONSTRAINT `accesos_ibfk_1` FOREIGN KEY (`seg_per_codigo`) REFERENCES `personal` (`per_codigo`),
  CONSTRAINT `accesos_ibfk_2` FOREIGN KEY (`seg_pro_codigo`) REFERENCES `programas` (`pro_codigo`)
);

INSERT INTO pruebatecnica.accesos (seg_per_codigo,seg_pro_codigo,seg_insertar,seg_editar,seg_borrar,seg_buscar) VALUES
	 (3,2,'1','0','0','0'),
	 (3,6,'0','0','0','1');
