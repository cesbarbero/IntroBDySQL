--------------------- Modulo 5 - Subconsultas --------------------

/*Una subconsulta es una consulta, es decir, un
SELECT dentro de otra consulta (otro SELECT).
Su objetivo es obtener un resultado y utilizarlo
como criterio de búsqueda para obtener un
determinado listado de registros.
El siguiente ejemplo utiliza una subconsulta para
conocer todos los registros de la tabla articulos
cuyo valor de campo articuloID se encuentra en
el campo articuloID de la tabla facturas.*/

SELECT * FROM articulos WHERE articuloID IN
(SELECT articuloID FROM facturas)
GO N

-- Subconsulta escalar
/*Se denomina subconsulta escalar a aquella
subconsulta que devuelve un único resultado
(como puede ser una suma, un promedio, un
valor máximo, un valor mínimo, etc.). En el
ejemplo a la derecha, se define una consulta que
devuelve de la tabla alumnos a todos aquellos
alumnos cuya edad supera la edad promedio.
Dado que no se conoce cuál es la edad promedio
de todos los alumnos, la subconsulta calcula
dicho promedio y la consulta principal toma ese
resultado como criterio de búsqueda, mostrando
en pantalla todos los registros de la tabla
alumnos que cumplan con el criterio establecido.*/

SELECT *, (SELECT AVG(edad) FROM alumnos) 
FROM alumnos 
WHERE edad > 24;

select distinct top 5 ProductID from Sales.SalesOrderDetail order by ProductID

-- en select
select top 6 ProductID Codigo, Name Producto, ListPrice Precio,  
(select AVG(ListPrice) from Production.Product) [Precio Promedio],
(select AVG(UnitPrice) from Sales.SalesOrderDetail) [Precio Promedio de Venta],
(select AVG(ListPrice) from Production.Product) - ListPrice [Diferencia de precio],
(select AVG(ListPrice) from Production.Product)/ListPrice*100 [% Diferencia de precio]
from Production.Product where ListPrice <> 0 

-- en from
select top 6 p.ProductID Codigo, Name Producto, ListPrice Precio, 
[Precio Promedio de Venta], [Precio Promedio de Venta] - listprice [Diferencia de Precio]
from Production.Product p join
(select ProductID, AVG(UnitPrice) [Precio Promedio de Venta] from Sales.SalesOrderDetail group by ProductID) as ventas on p.ProductID = ventas.ProductID
where ListPrice <> 0

-- caso anterior resuelto con vista
--create view ResumenVentasProductos as
--select ProductID, AVG(UnitPrice) [Precio Promedio de Venta], Max(UnitPrice) [Precio Maximo de Venta], Min(UnitPrice) [Precio Minimo de Venta], sum(UnitPrice) [Monto Ventido], SUM(OrderQty) [Unidades vendidas] from Sales.SalesOrderDetail group by ProductID

--select * from resumenventasproductos

select top 6 p.ProductID Codigo, Name Producto, ListPrice Precio, 
[Precio Promedio de Venta], [Precio Promedio de Venta] - listprice [Diferencia de Precio]
from Production.Product p join ResumenVentas.Product rvp on p.ProductID = rvp.productid

--subconsultas correlacionadas
select ProductSubcategoryID Subcategoria, Name Producto, ListPrice Precio 
from Production.Product p 
where ListPrice = 
(
	select MIN(p1.ListPrice) from Production.Product p1 
	where p.ProductSubcategoryID = p1.ProductSubcategoryID
	)


select distinct P.ProductSubcategoryID Subcategoria, P.Name Producto, P.ListPrice Precio 
from Production.Product p , Production.Product p1 
where  p.ProductSubcategoryID = p1.ProductSubcategoryID

--ListPrice = 4.58

--equivalente a hacerlo en el from

select p.ProductSubcategoryID Subcategoria, Name Producto, ListPrice Precio from Production.Product p join
(select ProductSubcategoryID, MIN(ListPrice) [Precio Promedio] from Production.Product group by ProductSubcategoryID) as p1 on p.ProductSubcategoryID = p1.ProductSubcategoryID and [Precio Promedio]= ListPrice

--exists
select ProductID, Name, ListPrice from Production.Product p where exists 
(select * from Sales.SalesOrderDetail sod where p.ProductID = sod.ProductID)
--Exists (

select ProductID, Name, ListPrice from Production.Product p where exists 
(select 1 from Sales.SalesOrderDetail sod where p.ProductID = sod.ProductID)

select ProductID, Name, ListPrice from Production.Product p where exists 
(select UnitPrice from Sales.SalesOrderDetail sod where p.ProductID = sod.ProductID)

--equivalente
select ProductID, Name, ListPrice from Production.Product where ProductID in (select ProductID from Sales.SalesOrderDetail)
--equivalente
select distinct p.ProductID, Name, ListPrice from Production.Product p join Sales.SalesOrderDetail sod on p.ProductID = sod.ProductID
--equivalente
select ProductID from Production.Product
intersect
select ProductID from Sales.SalesOrderDetail

--en where
select AVG(ListPrice) from Production.Product

select ProductID, Name, ListPrice from Production.Product where ListPrice > (select AVG(ListPrice) from Production.Product) order by ListPrice

select ProductID, Name, ListPrice from Production.Product where ListPrice < (select AVG(ListPrice) from Production.Product) order by ListPrice desc




------------------- Condicional CASE
/*El condicional CASE permite asignar un valor a
una columna tomando como referencia otro
valor de la tabla.
Por cada valor o grupo de valores existe un
WHEN y un THEN; si encuentra un valor
coincidente en algún WHEN, ejecuta el THEN
correspondiente a ese WHEN; caso contrario,
se ejecuta el ELSE.
Este condicional se debe cerrar con la palabra
END para indicar que el CASE ha finalizado.*/

-- CASE WHEN precio < 20 THEN 'BARATO'

/*El siguiente ejemplo asigna un posible valor (CARO /
BARATO / EQUILIBRADO) en una columna con el nombre
Categoria, tomando como referencia los valores de la
columna precio de una tabla con el nombre articulos.*/

SELECT nombre, precio,
	CASE WHEN precio < 20 THEN 'BARATO'
	WHEN precio BETWEEN 20 AND 40 
		THEN 'EQUILIBRADO'
	WHEN precio > 40 
		THEN 'CARO'
--	ELSE 'CARO'
	END as Categoria
FROM articulos;

select Name, Color, Tono = 
case Color 
	when 'Black' then 'Color oscuro'
	when 'Blue' then 'Color oscuro'
	when 'Red' then 'Color oscuro'
    when 'Grey' then 'Color claro'
	when 'Multi' then 'Color claro'
	when 'Silver' then 'Color claro'
	when 'Silver/Black' then 'Color claro'
	when 'White' then 'Color claro'
	when 'Yellow' then 'Color claro'
	else 'Sin color'
end
from Production.Product
Where color IN ('Black', 'Red', 'Gre')

Select *
From Production.Product
Where Not In (
)
select Name, Color, 
case Color 
	when 'Black' then 'Color oscuro'
	when 'Blue' then 'Color oscuro'
	when 'Red' then 'Color oscuro'
    when 'Grey' then 'Color claro'
	when 'Multi' then 'Color claro'
	when 'Silver' then 'Color claro'
	when 'Silver/Black' then 'Color claro'
	when 'White' then 'Color claro'
	when 'Yellow' then 'Color claro'
	else 'Sin color'
end Tono
from Production.Product

--------------------- Combinación de consultas: UNION
/*Para comparar los resultados de varias
consultas y combinarlos en un nuevo resultado
basado en esa comparación existe (entre otros)
el operador UNION.
Dado que se compararán varias consultas, es
necesario que:
● en cada resultado exista la misma cantidad
de campos y
● los campos a comparar tengan tipos de datos
compatibles (no es necesario que tengan el
mismo nombre).
Debemos diferenciar la comparación de los
resultados de varias consultas y su combinación
y, por otro, la combinación de datos de varias
tablas en una consulta: para esto último usamos
el operador JOIN, que establece una relación por
uno o varios campos con otras tablas*/

/*Las dos consultas se pueden hacer sobre la
misma tabla, pero podría ser cualquier consulta
siempre y cuando se respete que la salida
contenga la misma cantidad de campos y que los
tipos de datos de los campos sean compatibles
para la comparación; en general, esto implica
campos numéricos con campos numéricos y
campos de texto con campos de texto.*/

-- UNION - UNION ALL
/*La sintaxis para combinar dos consultas
mediante la cláusula UNION es:
Esta sintaxis agrega el resultado de la consulta2
al resultado de la consulta1. Los registros que
quedan duplicados, se eliminan (no se muestran
en el resultado). Para conservar los registros
duplicados, se utiliza la cláusula UNION ALL en
lugar de UNION.*/


Select column1, column2, column3, 0, column8
From TablaDeArriba
Union
Select Column1, Column5, column4, column7, ''
From TablaDeAbajo

Select Max(Length(column8))
From TablaDeArriba

Select column1, column2, column3, Cast(column8 As Varchar(32))
From TablaDeArriba
Union All
Select Column1, Column5, column4, column7
From TablaDeAbajo;


-- Sintaxis:
-- consulta1 UNION [ALL] consulta2;

/*La primera consulta que interviene se escribe
sin el punto y coma (;) al final ya que la consulta
completa está formada por las consultas que
intervienen y el operador UNION, finalizando
después de la segunda consulta. Esto es así
para todas las combinaciones de consultas.*/

-- Ejemplos de combinación de consultas
/*Veremos a continuación, algunos ejemplos donde
se suponen 2 tablas:
● Una tabla con el nombre nenes que contiene
todos los nacimientos de bebés de sexo
masculino, ocurridos durante el año 2020
en la República Argentina.
● Otra tabla con el nombre nenas que contiene
todos los nacimientos de bebés de sexo
femenino, ocurridos durante el año 2020
en la República Argentina.

Ejemplo 1
Se necesita obtener una lista completa de todos
los bebés nacidos en el año 2020 en la
República Argentina. La sentencia SQL sería la
siguiente:
*/

SELECT * FROM nenes
UNION
SELECT * FROM nenas;

-- Ejemplo 2
/*En el siguiente ejemplo, se suponen las mismas tablas
que en el caso anterior. Y se necesita obtener una lista
completa de todos los bebés nacidos en el año 2020
en la República Argentina, en la provincia de Córdoba.
La sentencia SQL sería la siguiente:*/

SELECT * FROM nenes WHERE provincia = 'Córdoba'
UNION
SELECT * FROM nenas WHERE provincia = 'Córdoba';

-- Ejemplo 3
/*Ahora, se suponen las mismas tablas que en el caso
anterior. Y se necesita obtener una lista completa de
todos los bebés nacidos en el año 2020 en la República
Argentina: bebés de sexo masculino nacidos en la
provincia de Córdoba y bebas de sexo femenino nacidas
en la provincia de La Pampa. La sentencia SQL sería:*/

SELECT * FROM nenes WHERE provincia = ‘Córdoba’
UNION
SELECT * FROM nenas WHERE provincia = ‘La Pampa’;

-- Ejemplo 4
/*En este último ejemplo, se suponen las mismas tablas que
en el caso anterior. Y se necesita obtener una lista
completa de todos los bebés nacidos durante el mes de
agosto del año 2020 en la República Argentina. La
sentencia SQL sería la siguiente:*/

SELECT * FROM nenes WHERE MONTH(fecha_nacimiento) = 8
UNION
SELECT * FROM nenas WHERE MONTH(fecha_nacimiento) = 8;

/*La cláusula UNION anula automáticamente los
registros duplicados entre las tablas. En el caso
de querer mostrar los registros duplicados, la
cláusula que deberás utilizar es UNION ALL.
Esta es una forma de verificar si existen registros
duplicados entre tablas; es decir, si al utilizar la
cláusula UNION se obtiene la misma cantidad
de registros resultantes que al utilizar la cláusula
UNION ALL, esto mostraría que no existen
registros duplicados entre las tablas consultadas*/

select ProductID from Production.Product
union All
select ProductID from Sales.SalesOrderDetail
order by ProductID Desc

/*
Mostrar todos los productos vendidos y ordenados
Tablas: Sales.SalesOrderDetail, Production.WorkOrder
Campos: ProductID
*/
select ProductID from Sales.SalesOrderDetail
union all
select ProductID from Production.WorkOrder order by ProductID

/*
Mostrar los diferentes productos vendidos y ordenados
Tablas: Sales.SalesOrderDetail, Production.WorkOrder
Campos: ProductID
*/

select ProductID from Sales.SalesOrderDetail
union
select ProductID from Production.WorkOrder 
order by ProductID


SELECT * FROM Productos p, Marcas pn
where p.idproducto = pn.idproducto
	 

SELECT * FROM Productos, Marcas 
where Productos.idproducto = Marcas.idproducto


SELECT * 
FROM Productos p 
Left Join Marcas pn
	ON p.idproducto = pn.idproducto


SELECT * 
FROM Productos p 
Right Join Marcas pn
	ON p.idproducto = pn.idproducto

id  desc id marca
Null Null id marca


Select dateadd(mm, -2, Cast(Getdate() as date))

select Cast(Getdate() as date)