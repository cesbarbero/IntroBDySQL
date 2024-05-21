----------------------------- MODULO 3 ------------------------
-- Funciones Integradas de Texto
Use comercioit;
-- CONCAT:
/*devuelve NULL si cualquiera de sus argumentos es NULL.*/
select CONCAT( 'hola ', 'buen dia', @arg )


-- CONCAT_WS:
/*no omite cadenas vacías. Sin embargo, omite cualquier valor NULL después del argumento del separador.
CONCAT_WS ( separator, argument1, argument2 [, argumentN]... )
*/

-- UPPER, LOWER:
/*
LOWER-UPPER
Devuelve una expresión de caracteres después
de convertir en minúsculas los datos de
caracteres en mayúsculas y viceversa.
*/
-- Sintaxis
SELECT LOWER('AABB');

SELECT UPPER('aabb');


-- LEFT:
/*
LEFT
Devuelve la parte izquierda de una cadena
de caracteres con el número de caracteres
especificado.
*/
-- Sintaxis
SELECT LastName, LEFT(LastName,2)
FROM Person.Person
WHERE BusinessEntityID=1;


SELECT 'Hola Buen dia', LEFT('Hola buen dia',2);

Declare @var char(MAX)
Set @var = 'Hola buen dia'



Select @var, RIGHT(LEFT(@var,8), 4);
-- RIGHT:
/*
RIGHT
Devuelve la parte derecha de una cadena de
caracteres con el número de caracteres especificado.
*/

--Sintaxis
SELECT LastName, RIGHT(LastName,2)
FROM Person.Person
WHERE BusinessEntityID=1;

-- SUBSTRING:
/*
SUBSTRING
Devuelve parte de una expresión de caracteres.
El siguiente ejemplo se posiciona en el tercer
carácter y extrae los dos caracteres siguientes
*/
-- Sintaxis
SELECT SUBSTRING('Hola buen dia',6, );

-- LOCATE:
/*Busca un valor (prim parámetro) en la cadena (seg parámetro) y devuelve la posición:
*/
-- LOCATE(substring, string, start)
Declaran @cadena varchar(100),
	@busco varchar(20)
Set @cadena = 'Hola buen dia, como estás?'
Set @busco = 'buen'

Select Substring('Hola buen dia',Locate('buen', 'Hola buen dia'), CHAR_LENGTH('Hola buen dia') - Locate('buen', 'Hola buen dia') +1), 
'Hola buen dia' As 'Cadena total',
Locate('buen', 'Hola buen dia') As 'Donde empieza lo que necesito',
CHAR_LENGTH('Hola buen dia') AS 'Long Total Cadena',
CHAR_LENGTH('Hola buen dia') - Locate('buen', 'Hola buen dia') As 'Long de lo que quiero';





select CHAR_LENGTH('Hola buen dia');
- Locate('buen', 'Hola buen dia');
-- REPLACE:
/*
REPLACE
Reemplaza todas las instancias de un valor de
cadena especificado por otro valor de cadena. El
siguiente ejemplo reemplaza las letras B por Z
*/
-- Sintaxis
SELECT REPLACE('AABB','B','3');

Select REPLACE(' A A BB ',' ','');

Select Replace(campo1, ' ', '')
From tabla



Select ' AA BB ',LTRIM(' AA BB ', ' ', '');


-- Funciones Integradas de Fecha:

-- YEAR, MONTH, DAY:
/*
DAY-MONTH-YEAR
Devuelve un entero que representa el datepart del argumento especificado.
*/
-- Sintaxis
SELECT YEAR('1995-08-19'), MONTH('1995-08-19'), DAY('1995-08-19'); 


-- CURDATE:
/*Devuelva la fecha actual en el formato "YYY-MM-DD" o "YYYYMMDD" con el comando CURDATE OR CURRENT_DATE.
*/
SELECT CURDATE();

-- DATEDIFF:
/*Devuelve el número de días entre dos expresiones de fecha con la DATEDIFF función.
*/
-- Sintaxis básica:
Select DATEDIFF(date1,date2);

-- Ejemplo:
SELECT DATEDIFF('2023-01-23','2021-01-14');

-- TIMESTAMPDIFF:
/*Para calcular la diferencia entre dos expresiones de fecha/fechahora. La función resta un valor de fecha y hora del otro en la unidad especificada.
*/
-- Sintaxis:
-- TIMESTAMPDIFF(unit,datetime1,datetime2);

-- Por ejemplo, para calcular la diferencia entre las siguientes dos fechas en días:
SELECT TIMESTAMPDIFF(DAY,'2021-01-18','2022-01-18');
SELECT TIMESTAMPDIFF(YEAR,'2021-01-18','2022-01-18');

-- DAYNAME:
/*Devuelve el nombre del día de la semana a partir de una expresión de fecha/fechahora especificada mediante la DAYNAMEfunción.
*/
-- 
SELECT DAYNAME('2021-01-26 12:32:00');

-- DAYOFWEEK:
/*Devuelve el día de la semana en valor numérico de la expresión de fecha/fechahora especificada usando DAYOFWEEK.
*/
SELECT DAYOFWEEK('2021-01-26 12:32:00');

-- DAYOYEAR:
/*Devuelve el día del año a partir de la expresión de fecha/fechahora especificada mediante la función DAYOFYEAR.
*/
-- Sintaxis:
-- DAYOFYEAR(datetime);
SELECT DAYOFYEAR('2021-02-26 12:32:00');

-- MONTHNAME:
/*Devuelve el nombre del mes de una fecha/fechahora especificada con la MONTHNAMEfunción.
*/
-- La sintaxis básica:
-- MONTHNAME(date);
SELECT MONTH('2021-01-26');

-- ADDDATE:
/*Agrega un valor de hora/fecha a una expresión de fecha.
La  unidad  puede ser:

SEGUNDO
MINUTO
HORA
DÍA
SEMANA
MES
CUARTO
AÑO
SEGUNDO_MICROSEGUNDO
MINUTO_MICROSEGUNDO
MINUTO_SEGUNDO
HORA_MICROSEGUNDO
HORA_SEGUNDO
HORA_MINUTO
DÍA_MICROSEGUNDO
DÍA_SEGUNDO
DÍA_MINUTO
DIA_HORA
AÑO MES
Por ejemplo, si ejecuta:
*/
SELECT DATE_ADD('2021-01-17 07:14:21', INTERVAL 20 MINUTE);

SELECT DATE_ADD('2021-01-17 07:14:21', INTERVAL -20 DAY);
-- Sintaxis:

-- Select DATE_ADD(date, INTERVAL value unit);


---------------- Funciones Matematicas Integradas:
-- ROUND:
/*
ROUND
Devuelve un valor numérico,
redondeado a la longitud o precisión
especificadas.
*/
-- Sintaxis
SELECT ROUND(4.55,1), ROUND(4.54,1);

-- MOD:
/*MOD(N,M) , N % M, N MOD M

Operación de módulo. Retorna el resto de N dividido por M.
*/
SELECT MOD(234, 10);
--        -> 4
-- SELECT 253 % 7;
--        -> 1

-- POW:
/*POW(X,Y) , POWER(X,Y)
Retorna el valor de X a la potencia de Y.
*/
-- SELECT POW(2,2);
--        -> 4
-- SELECT POW(2,-2);
--        -> 0.25

-- CEIL:
/*CEILING(X), CEIL(X)
Retorna el entero más pequeño no menor a X.
*/
-- SELECT CEILING(1.23);
--        -> 2
-- SELECT CEIL(-1.23);
--        -> -1

-- FLOOR:
/*
FLOOR
Devuelve el entero más grande que
sea menor o igual que la expresión
numérica especificada.
*/
-- Sintaxis
SELECT FLOOR(123.45), FLOOR(-123.45); 

----- Funciones de Agregado / Agrupamientos:
-- COUNT:
	SELECT COUNT(*) FROM Productos;
	SELECT COUNT(*) FROM Productos WHERE Nombre LIKE "%iPhone%";

-- SUM:
	SELECT SUM(Stock) FROM Productos;

-- MIN:
	SELECT MIN(Precio) FROM Productos Where fecha_alta >= '20230301';

-- MAX:
	SELECT MAX(Precio) FROM Productos Where color = 'blanco';

-- AVG:
	SELECT AVG(Precio) FROM Productos;


Tabla_Stock

ID		NombreProd		Desc					  stock	
1		Lata Pint		Lata pin roja			   16
2		Lata pin		Lata pin verde 1		    0
3		Lata pin		Lata pin blanc			    8
4		Lata pin		Lata pin verde 2		    7

Select sum(stock)
From tabla_stock
where desc like '%verde%'

Select count(*)
From tabla_stock
where desc like '%verde%'

31
27
---------------------------------------------------------------------------------------

Tabla_Stock

ID		TipoProd	NombreProd		Desc					  stock	
1		Pint		Lata Pint		Lata pin roja			   16
2		Pint		Lata pin		Lata pin verde 1		    0
3		Pint		Lata pin		Lata pin blanc			    8
4		Pint		Lata pin		Lata pin verde 2		    7
5		Pinc		Pincel			Pinc brocha gorda		   23	
6		Pinc		Pincel			Rodillo						4


Select TipoProd, sum(stock)
From tabla_stock
Group by TipoProd

Pint		31
Pinc		27

Select TipoProd, count(*)
From tabla_stock
Group by TipoProd
Having count(*) < 30


----- CLAUSULA GROUP BY
/*La agrupación es un concepto básico de Bases de Datos. La
cláusula GROUP BY, como su traducción lo indica (agrupar
por) tiene como propósito agrupar información de acuerdo
a un criterio en común.
	● Por lo general se utiliza con funciones de agrupación
o de agregación (COUNT, MIN, MAX, AVG, SUM).
	● El comportamiento de la cláusula GROUP BY dependerá
de la función de agrupación que se esté utilizando.
*/ 
SELECT Categoria, SUM(Stock) FROM Productos GROUP BY Categoria;

------ CLAUSULA HAVING
/*La cláusula HAVING permite hacer selecciones (filtrar)
en situaciones en las que no es posible usar la cláusula
WHERE, dado que se establece un criterio sobre un valor
dado por una función de agrupamiento y no por valores
de registros.*/
-- Ejemplo:
SELECT Categoria, SUM(Stock) FROM Productos GROUP BY Categoria
HAVING SUM(Stock) > 250;

