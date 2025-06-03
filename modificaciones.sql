/* 
 * Ajustes realizados a la tabla Personal, de momento esta tabla no tiene mayor cantidad de registros y no tiene aun relacion con otra tabla por tanto es 
 * una buena practica ordenar la información previo a crear relaciones. Se realizaran los siguientes ajustes, se recreara la tabla, agregando llave primaria
 * al campo per_codigo y se dejara como autoincremental, para evitar que se pierdan códigos, adicinalmente se agregara un constraint unique sobre la columma usuario
 * ya que la misma es recomendable que maneje valores unicos, se agrego constraint not null a nombre1 y apellido1, porque una persona almenos tiene un nombre
 * y un apellido
 * 
 * */

-- 1 Cambio de nombre temporal a la tabla existente
RENAME TABLE Personal TO Personal_old;

-- 2 Recreación de la tabla con los ajustes propuestos
CREATE TABLE `Personal` (
	`per_codigo` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`per_usuario` VARCHAR(20) NOT NULL UNIQUE COLLATE 'latin1_spanish_ci',
	`per_apellido1` VARCHAR(25) NOT NULL COLLATE 'latin1_spanish_ci',
	`per_apellido2` VARCHAR(35) NULL DEFAULT '' COLLATE 'latin1_spanish_ci',
	`per_nombre1` VARCHAR(35) NOT NULL COLLATE 'latin1_spanish_ci',
	`per_nombre2` VARCHAR(35) NULL DEFAULT '' COLLATE 'latin1_spanish_ci',
	`per_estado` INT(10) NOT NULL DEFAULT '1'
);

-- 3 Se agregan los registros que se tenian en la tabla anterior
INSERT INTO Personal(per_usuario, per_apellido1, per_apellido2, per_nombre1, per_nombre2, per_estado)
SELECT per_usuario,  per_apellido1, per_apellido2, per_nombre1, per_nombre2, per_estado
FROM Personal_old;

-- 4 Se borra la tabla que se uso como pivote, este paso puede ser opcinal, podria quedar guardada por si necesita más adelante, para el ejercicio se borrara
DROP TABLE Personal_old;


/*
 * Sobre la tabla Programas existe una situacion similar, no tiene llave primaria, es neceario agragarla, se convertira el campo
 * pro_codigo en un autoincremental la decripción debe ser not null para evitar que el futuro existan campos vacios, se realizaran 
 * las siguientes acciones como mejoras a la tabla
 * */


-- 1 Cambiar nombre a la tabla existente para no perder la información

RENAME TABLE Programas TO Programas_old;

-- 2 Se recrea la tabla con los ajustes propuestos
CREATE TABLE `Programas` (
	`pro_codigo` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`pro_descripcion` VARCHAR(100) NOT NULL COLLATE 'latin1_spanish_ci'
);

-- 3 Se agregan los campos respaldados a la nueva tabla
INSERT INTO Programas(pro_descripcion)
SELECT pro_descripcion FROM Programas_old;

-- 4 Al igual que en el ejercicio anterior se borrara la tabla pivote, pero la misma podria dejarse en caso de que sea necesario conservar
-- la informacion
DROP TABLE Programas_old;

/*
 * La tabla Accesos de recreara ya que de momento esta vacia entonces se puede realizar de esta manera. Se realizaran algunos ajustes
 * necesarios como agregar llaves foraneas para crear relaciones con las otras tablas, se ajustaran las columnas seg_usuario para que guarde
 * datos enteros ya que esta es la columna que servira para crear la relación con la tabla Personal se cambiara también el nombre para que tenga 
 * más claridad ahora se llamara seg_per_codigo, la columna seg_programa se renombrara a seg_pro_codigo ya que es la columan que servira para la relación
 * con la tabla Programa las otras columnas se cambiaran a not null para cerrar las opciones y que sea unicamente tiene o no acceso ya que el ejercicio
 * indica que un usuario tendra o no permiso para ese acceso.
 * 
 * */

-- 1 Borrar la tabla anterior que esta vacia
DROP TABLE Accesos;

-- 2 Se crea nuevamente la tabla con los ajustes necesarios
CREATE TABLE `Accesos` (
	`seg_per_codigo` INT(11) NOT NULL,
	`seg_pro_codigo` INT(11) NOT NULL,
	`seg_insertar` CHAR(2) NULL COLLATE 'latin1_spanish_ci',
	`seg_editar` CHAR(2) NULL COLLATE 'latin1_spanish_ci',
	`seg_borrar` CHAR(2) NULL COLLATE 'latin1_spanish_ci',
	`seg_buscar` CHAR(2) NULL COLLATE 'latin1_spanish_ci',
	FOREIGN KEY (`seg_per_codigo`) REFERENCES Personal(`per_codigo`),
	FOREIGN KEY (`seg_pro_codigo`) REFERENCES Programas(`pro_codigo`)
);

/*
 * NOTA Estos ajustes se pudieron realizar por las condiciones en que se encuetra la base de datos, en base de datos productivas no es siempre viable
 * realizar este tipo de cambios, es necesario realiar otros procedimientos y no siempre todo es viable por las dependencias que pueda haber y los errores que puedan generarse
 * por ello es importante realizar un buen diseño inicial, Para el ejercicio
 * tambien se pudo haber dejado los nombres de la tabla en singular esto como buena practicas, pero aca se opto por dejarlos asi.
 * */




