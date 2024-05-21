
################################# C - Conceptos Preliminares ###################################
/*Creación de una base de datos
Para crear una base de datos (por ejemplo, con el nombre
ComercioIT), la instrucción SQL a ejecutar será:*/
CREATE DATABASE ComercioIT;

show databases;

/*Creación de una tabla
La sentencia CREATE TABLE creará una tabla
con las columnas (campos) que indiquemos.
En el ejemplo de la diapositiva siguiente,
podemos ver una instrucción SQL para generar
una tabla, con el nombre Productos. Dentro de la
misma, se definen 7 campos con sus tipos de
datos y modificadores correspondientes.*/

Use ComercioIT;

CREATE TABLE Productos(
idProducto INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL,
Precio DOUBLE,
Marca VARCHAR(30) NOT NULL,
Categoria VARCHAR(30) NOT NULL,
Stock INT(6) NOT NULL,
Disponible BOOLEAN DEFAULT false
);

/*Eliminar una tabla
Para eliminar una tabla (por ejemplo, con el nombre
Productos) de una base de datos, la instrucción SQL a
ejecutar será:*/
DROP TABLE Productos;
## o 
DROP TABLE IF EXISTS Productos;

/*Otros comandos MySQL
A continuación, se detallan comandos necesarios para la navegación dentro del motor MySQL.
La sintaxis de cada uno se muestra a la derecha de su definición.
● Comando SHOW DATABASES: muestra el
catálogo de base de datos del servidor.*/
SHOW DATABASES;

/*Comando USE: pone en uso una base de
datos del servidor. Todos los comandos SQL
que se ejecuten, se llevarán a cabo sobre la
base de datos en uso.*/
USE NombredeBaseDeDatos;

/*Comando SHOW TABLES: muestra el
catálogo o listado de tablas de la base
de datos activa.*/
SHOW TABLES;

/*Comentarios: permiten escribir texto que no
será interpretado como parte de sentencias
SQL, útiles para documentar y comentar
acciones realizadas por las sentencias. Se
pueden utilizar las siguientes formas de
escribir comentarios:
*/
# Esto es un comentario de 1 línea (Propia de MySQL)
/* Esto es un comentario de 1 o más líneas  (Soportada en MySQL y otros motores)*/

-- Esto es un comentario de 1 línea (Soportada en MySQL y otros motores)

/*Comando DESCRIBE: devuelve la descripción
de campos y detalles de una tabla
(estructura física).*/
DESCRIBE NombreDeTabla;

/*Comando SHOW CHARSET: muestra los
CHARSET (juegos de caracteres).*/
SHOW CHARSET;

/*Comando SHOW COLLATION: Muestra los
COLLATIONS instalados.*/
SHOW COLLATION;

/*              Conceptos avanzados
ENUM
Existe un tipo de dato denominado ENUM, que presenta las siguientes características:
● Sólo puede contener un valor.
● Se puede definir una lista de hasta 65.535 valores distintos.
● Si se permiten valores null, éste será el valor predeterminado; si no se define un valor
predeterminado con DEFAULT, será el primer valor de la lista.
● Cada valor de la lista es numerado con un índice (comenzando en 1).
Ejemplo:
*/
CREATE TABLE Medida (
	medida ENUM('pequeño', 'mediano', 'grande') NOT NULL DEFAULT 'mediano');

/*
SET
Otro tipo de dato es SET, el cual posee las siguientes características:
● 0, 1 ó varios valores.
● Se puede definir una lista de hasta 64 valores distintos.
● Los valores no pueden contener comas, ya que los valores asignados en la lista están
separados por ese carácter.
● Cada valor de la lista representa un bit de la cadena de bits del campo.
● El valor decimal del campo determina los bits, al marcar los valores que contiene el
campo. De manera que, si todos los bits están a 1, significa que ese campo contiene
todos los valores.
*/
CREATE TABLE Letra (letra SET('a', 'b', 'c', 'd'));


-------------------------- D - MODIFICAR ESTRUCTURAS -----------------------------
/*Este comando permite modificar la estructura de una tabla. Se utiliza para agregar o eliminar
columnas, modificar el tipo de datos de una columna existente o renombrar una columna
o una tabla. 
En el ejemplo debajo, se agrega una nueva columna con el nombre Observaciones,
a una tabla con el nombre articulos:
*/
ALTER TABLE articulos ADD COLUMN Observaciones VARCHAR(50) NULL;

/*Agregar columnas a una tabla 
En el siguiente ejemplo, se agrega una nueva columna con el nombre Primera, a una tabla 
con el nombre clientes. Y se la ubica al comienzo de la tabla:
*/
ALTER TABLE clientes ADD COLUMN Primera VARCHAR(50) NULL FIRST;

/*Y en el siguiente ejemplo, se agrega una nueva columna
con el nombre Siguiente a una tabla cuyo nombre es
clientes, entre las columnas Nombre y Apellido.
*/
ALTER TABLE clientes ADD COLUMN Siguiente VARCHAR(50) NULL AFTER Nombre;

/*Cambiar el nombre de una columna
En el siguiente ejemplo, se modifica el nombre de la
columna observaciones por comentarios, en la tabla
articulos:
*/
ALTER TABLE articulos
CHANGE observaciones comentarios VARCHAR(40) NULL;

/*Cambiar el tipo de dato de una columna
En el siguiente ejemplo, se modifica el tipo de dato
de la columna comentarios en la tabla articulos:
*/
ALTER TABLE articulos
MODIFY comentarios TEXT NULL;

/*Eliminar una columna
En el siguiente ejemplo, se elimina la columna
comentarios de la tabla articulos:
*/
ALTER TABLE articulos DROP COLUMN comentarios;

/*Y en el siguiente ejemplo, se eliminan las columnas
Primera y Siguiente de la tabla clientes, en una sola
sentencia:
*/
ALTER TABLE clientes DROP COLUMN Primera, DROP COLUMN Siguiente;

/*Renombrar una tabla
En el siguiente ejemplo, se modifica el nombre de
la tabla Articulos por Productos:*/
ALTER TABLE Articulos RENAME Productos;

/*Otra forma de cambiar el nombre de una tabla es:*/
RENAME TABLE Articulos TO Productos;

/*Agregar y eliminar restricciones
En el siguiente ejemplo, se elimina la restricción Primary
Key de la tabla Articulos:*/
ALTER TABLE Articulos DROP Primary Key;

/*En el siguiente ejemplo, se agrega la restricción Primary
Key al campo ArticuloID, en la tabla Articulos:*/
ALTER TABLE Articulos ADD Primary Key(ArticuloID);

/*En el siguiente ejemplo, se elimina la restricción FOREIGN
KEY del campo fk_articulo, de la tabla facturas:*/
ALTER TABLE facturas DROP FOREIGN KEY fk_articulo;

/*Y en el ejemplo siguiente, se agrega la restricción
FOREIGN KEY al campo fk_articulo de la tabla facturas:*/
ALTER TABLE facturas ADD CONSTRAINT fk_articulo
FOREIGN KEY(ArticuloID) REFERENCES Articulos(ArticuloID);

################################# E - Inserción de datos ###################################
/*
Insertar registros en una tabla
Para insertar datos en una tabla utilizamos la
sentencia INSERT. Con ella, podemos añadir
registros uno a uno, o añadir tantos registros
como deseemos, en una sola sentencia.
Existen distintas formas de ingresar registros en
una tabla. Dichas formas son reconocidas con los
siguientes nombres:
● Manera completa
● Manera SQL
● Manera simplificada
*/
-- COMPLETA:
INSERT INTO PRODUCTOS (Nombre, Precio, Marca, Categoria, Stock, Disponible)
VALUES ('iPhone 7', 889.99, 'Apple', 'Smartphone', 600, false);

Select * from PRODUCTOS;
-- SQL:
INSERT INTO PRODUCTOS
SET Nombre = 'iPhone 5', Precio = 499.99, Marca = 'Apple', Categoria =
'Smartphone', Stock = 500, Disponible = false;
/*
En este caso, los datos a cargar o insertar en cada uno
de los campos se definen junto a su nombre. Es sólo una
manera distinta de insertar el registro en la tabla
PRODUCTOS.*/
-- Manera simplificada
INSERT INTO Productos
VALUES (6,'iPhone 4', 499.99, 'Apple', 'Smartphone', 500, false);

/*En este caso, sólo se especifican los valores a
cargar en cada uno de los campos. Se la denomina
manera simplificada, dado que no se
especifican los nombres de los campos luego
del nombre de la tabla. Sólo se detallan los datos a cargar en cada
campo de la tabla. Es muy importante respetar
el orden; los datos se deben especificar en el
mismo orden en que figuran las columnas en
la tabla.*/

 
## Valores nulos: NULL
/*La expresión NULL significa "dato desconocido"
o "valor inexistente". No es lo mismo que un
valor 0 en un campo numérico, o una cadena
vacía, o una cadena de texto con la palabra
NULL literal en un campo de tipo texto.
A veces, puede desconocerse o no existir el
dato correspondiente a algún campo de un
registro. En estos casos, se dice que el campo
puede contener valores nulos.
Por ejemplo, en una tabla con el nombre Productos, se
puede tener valores nulos en el campo precio, en el caso
de que, para algunos productos, no se haya establecido
el precio para la venta. En contraposición, una tabla puede contener
campos que no pueden quedar vacíos, como los
campos que identifican cada registro (códigos de
identificación), que son clave primaria.
-- Nota: Por defecto (si no lo aclaramos en la creación de
la tabla) los campos permiten valores nulos.
*/
CREATE TABLE ProductosNuevos(
idProducto INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL,
Precio DOUBLE NULL,
Marca VARCHAR(30) NOT NULL,
Categoria VARCHAR(30) NOT NULL,
Presentacion VARCHAR(30) NULL,
Stock INT(6) NOT NULL
);

INSERT INTO ProductosNuevos (Nombre, Precio, Marca, Categoria, Presentacion, Stock)
VALUES ('iPhone 7S', NULL, 'Apple', 'Smartphone', '16GB', 500);

select * from ProductosNuevos;
/*
Aclaraciones:
● Nótese que para el campo Precio, el valor
NULL no es una cadena de caracteres, por lo
que no se coloca entre comillas. Si un campo
acepta valores nulos, podemos ingresar NULL
cuando no conocemos el valor.
● Además, si una columna fue definida como
no obligatoria en la sentencia CREATE TABLE,
puede no incluirse en el listado de campos
(puede entenderse como que el campo "no
es obligatorio" de asignar un valor).*/

