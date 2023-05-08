-- Sentencia Select 
--Obtener todos los registros y todos los campos de la tabla de productos
SELECT * FROM public.products;
-- Obtener una consulta con Productid, productname, supplierid, categoryId, UnistsinStock, UnitPrice
SELECT product_id, product_name, supplier_id, category_id, units_in_stock, unit_price FROM public.products;
--Crear una consulta para obtener el IdOrden, IdCustomer, Fecha de la orden de la tabla de ordenes.
SELECT order_id,customer_id,order_date FROM public.orders;
--Crear una consulta para obtener el OrderId, EmployeeId, Fecha de la orden.
SELECT order_id,customer_id,order_date FROM public.orders;

--Columnas calculadas 

--Obtener una consulta con Productid, productname y valor del inventario, valor inventario (UnitsinStock * UnitPrice)
SELECT product_id,product_name,(units_in_stock*unit_price) AS valor_inventario FROM public.products;
-- Cuanto vale el punto de reorden (precio_unitario*order_level)
SELECT (unit_price*reorder_level) AS punto_reorden FROM public.products;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe estar en mayuscula 
SELECT product_id,UPPER(product_name) AS product_name, unit_price FROM public.products;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres */
SELECT product_id,LEFT(product_name,10) AS product_name, unit_price FROM public.products;
--Obtener una consulta que muestre la longitud del nombre del producto
SELECT product_name, LENGTH(product_name) AS longitud FROM public.products;
--Obtener una consulta de la tabla de productos que muestre el nombre en minúscula
SELECT LOWER (product_name) FROM public.products WHERE product_id=1;
-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres y se deben mostrar en mayúscula */
SELECT product_id, UPPER(LEFT(product_name, 10)) AS product_name, unit_price FROM public.products;


--Filtros
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais Obtener los clientes cuyo pais sea Spain
SELECT customer_id,contact_name,company_name,country FROM public.customers WHERE country='Spain';
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U
SELECT customer_id,contact_name,company_name,country FROM public.customers WHERE country LIKE ('U%');
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U,S,A
SELECT customer_id,contact_name,company_name,country FROM public.customers WHERE country LIKE ('U%') OR country LIKE ('S%') OR country LIKE ('A%');
--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice cuyos precios esten entre 50 y 150
SELECT product_id,product_name,unit_price FROM public.products WHERE unit_price>=50 AND unit_price<=150 ORDER BY unit_price;
--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice, UnitsInStock cuyas existencias esten entre 50 y 100
SELECT product_id,product_name,unit_price,units_in_stock FROM public.products WHERE units_in_stock>=50 AND units_in_stock <=100;
--Obtener las columnas OrderId, CustomerId, employeeid de la tabla de ordenes cuyos empleados sean 1, 4, 9
SELECT order_id,customer_id,employee_id FROM public.orders WHERE employee_id=1 OR employee_id IN (1,4,9);
-- ORDENAR EL RESULTADO DE LA QUERY POR ALGUNA COLUMNA Obtener la información de la tabla de Products, Ordenarlos por Nombre del Producto de forma ascendente
SELECT * FROM public.products ORDER BY product_name ASC;
-- Obtener la información de la tabla de Products, Ordenarlos por Categoria de forma ascendente y por precio unitario de forma descendente
SELECT * FROM public.products ORDER BY category_id ASC, unit_price DESC;
-- Obtener la información de la tabla de Clientes, Customerid, CompanyName, city, country ordenar por pais, ciudad de forma ascendente
SELECT customer_id,company_name,city,country FROM public.customers ORDER BY country ASC,city ASC
-- Obtener los productos productid, productname, categoryid, supplierid ordenar por categoryid y supplier únicamente mostrar aquellos cuyo precio esté entre 25 y 200
SELECT product_id,product_name,category_id,supplier_id FROM public.products WHERE unit_price BETWEEN 25 AND 200 ORDER BY category_id,supplier_id;

--Funciones agregación

--Cuantos productos hay en la tabla de productos
SELECT COUNT (product_id) as nºproductos FROM public.products; 
--De la tabla de productos Sumar las cantidades en existencia 
SELECT SUM (units_in_stock) as cantidades_existencia FROM public.products;
--Promedio de los precios de la tabla de productos
SELECT AVG (unit_price) AS promedio_precios FROM public.products;

--Ordenar
--Obtener los datos de productos ordenados descendentemente por precio unitario de la categoría 1
SELECT * FROM public.products WHERE category_id=1 ORDER BY unit_price DESC;
--Obtener los datos de los clientes(Customers) ordenados descendentemente por nombre(CompanyName) que se encuentren en la ciudad(city) de barcelona, Lisboa
SELECT * FROM public.customers WHERE city='Barcelona' OR city='Lisboa' ORDER BY company_name DESC;
--Obtener los datos de las ordenes, ordenados descendentemente por la fecha de la orden cuyo cliente(CustomerId) sea ALFKI
SELECT * FROM public.orders WHERE customer_id='ALFKI' ORDER BY required_date DESC;
--Obtener los datos del detalle de ordenes, ordenados ascendentemente por precio cuyo producto sea 1, 5 o 20
SELECT * FROM public.order_details WHERE product_id=1 OR product_id=5 OR product_id=20 ORDER BY unit_price ASC;
--Obtener los datos de las ordenes ordenados ascendentemente por la fecha de la orden cuyo empleado sea 2 o 4
SELECT * FROM public.orders WHERE employee_id=2 OR employee_id=4 ORDER BY required_date ASC;
--Obtener los productos cuyo precio están entre 30 y 60 ordenado por nombre
SELECT * FROM public.products WHERE unit_price BETWEEN 30 AND 60 ORDER BY product_name;

--funciones de agrupacion
--OBTENER EL MAXIMO, MINIMO Y PROMEDIO DE PRECIO UNITARIO DE LA TABLA DE PRODUCTOS UTILIZANDO ALIAS
SELECT MAX(unit_price) AS PRECIO_MAX, MIN(unit_price) AS PRECIO_MIN, AVG(unit_price) AS PROMEDIO FROM public.products;
--Agrupacion
--Numero de productos por categoria
SELECT category_id AS categoria, COUNT (product_id) AS nªproductos FROM public.products GROUP BY category_id;
--Obtener el precio promedio por proveedor de la tabla de productos
SELECT supplier_id AS proveedor, AVG (unit_price) AS promedio_precio FROM public.products GROUP BY supplier_id;
--Obtener la suma de inventario (UnitsInStock) por SupplierID De la tabla de productos (Products)
SELECT supplier_id AS id_supplier, SUM (units_in_stock) AS suma_inventario FROM public.products GROUP BY supplier_id
--Contar las ordenes por cliente de la tabla de orders
SELECT customer_id AS cliente, COUNT (order_id) AS nºordenes FROM public.orders GROUP BY customer_id;
--Contar las ordenes por empleado de la tabla de ordenes unicamente del empleado 1,3,5,6
SELECT employee_id AS empleado, COUNT (order_id) AS nºordenes FROM public.orders WHERE employee_id=1 OR employee_id=3 OR employee_id=5 OR employee_id=6 GROUP BY employee_id;
--Obtener la suma del envío (freight) por cliente
SELECT customer_id AS cliente, SUM (order_id) AS suma_envios FROM public.orders GROUP BY customer_id;
--De la tabla de ordenes únicamente de los registros cuya ShipCity sea Madrid, Sevilla, Barcelona, Lisboa, LondonOrdenado por el campo de suma del envío
SELECT order_id, customer_id, employee_id, order_date, ship_city, freight FROM public.orders WHERE ship_city IN ('Madrid', 'Sevilla', 'Barcelona', 'Lisboa', 'London') ORDER BY freight DESC;
--obtener el precio promedio de los productos por categoria sin contar con los productos descontinuados (Discontinued)
SELECT category_id, AVG(unit_price) AS avg_price FROM public.products WHERE discontinued = 0 GROUP BY category_id;
--Obtener la cantidad de productos por categoria,  aquellos cuyo precio se encuentre entre 10 y 60 que tengan más de 12 productos
SELECT category_id, COUNT(*) AS cantidad_productos FROM public.products WHERE unit_price BETWEEN 10 AND 60 AND units_in_stock > 12 AND discontinued = 0
GROUP BY category_id;
--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16.
SELECT category_id, SUM(units_in_stock) as total_units FROM public.products WHERE supplier_id IN (17, 19, 16) AND discontinued = 0 AND unit_price BETWEEN 10 AND 60
GROUP BY category_id;
--cuya categoria tenga menos de 100 unidades ordenado por unidades
SELECT category_id, SUM(units_in_stock) AS total_units FROM products WHERE units_in_stock < 100 GROUP BY category_id
ORDER BY total_units;

--distinct

-- Se quiere saber a qué paises se les vende usar la tabla de clientes
SELECT DISTINCT country FROM public.costumers;
-- Se quiere saber a qué ciudades se les vende usar la tabla de clientes
SELECT DISTINCT city FROM public.customers;
-- Se quiere saber a qué ciudades se les ha enviado una orden
SELECT DISTINCT ship_city FROM public.orders;
--Se quiere saber a qué ciudades se les vende en el pais USA usar la tabla de clientes
SELECT DISTINCT city FROM public.customers WHERE country = 'USA';


--Agrupacion

-- Se quiere saber a qué paises se les vende usar la tabla de clientes nota hacerla usando group by
SELECT country FROM customers GROUP BY country;

--Cuantos clientes hay por pais
SELECT country, COUNT(costumer_id) AS cantidad_clientes FROM public.customers GROUP BY country ORDER BY cantidad_clientes DESC;
--Cuantos clientes hay por ciudad en el pais USA
SELECT city, COUNT(customer_id) as total_customers FROM public.customers WHERE country = 'USA' GROUP BY city ORDER BY total_customers DESC;
--Cuantos productos hay por proveedor de la categoria 1
SELECT supplier_id, COUNT(product_id) AS num_products FROM products WHERE category_id = 1 GROUP BY supplier_id;


--Filtro con having

-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos
SELECT supplier_id, COUNT(product_id) as num_products FROM products GROUP BY supplier_id HAVING COUNT (product_id) > 1;
-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos, pero únicamente de la categoria 1
SELECT supplier_id, COUNT(product_id) AS num_products FROM products WHERE category_id = 1 GROUP BY supplier_id HAVING COUNT(product_id) > 1;
--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES USA, CANADA, SPAIN (ShipCountry) MOSTRAR UNICAMENTE LOS EMPLEADOS CUYO CONTADOR DE ORDENES SEA MAYOR A 20
SELECT employee_id, COUNT(order_id) as num_orders FROM orders WHERE ship_country IN ('USA', 'Canada', 'Spain') GROUP BY employee_id HAVING COUNT(order_id) > 20;

--OBTENER EL PRECIO PROMEDIO DE LOS PRODUCTOS POR PROVEEDOR UNICAMENTE DE AQUELLOS CUYO PROMEDIO SEA MAYOR A 20
SELECT supplier_id, AVG(unit_price) AS avg_price FROM public.products GROUP BY supplier_id HAVING AVG(unit_price) > 20;
--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16 ADICIONALMENTE CUYA SUMA POR CATEGORIA SEA MAYOR A 300--
SELECT category_id, SUM(units_in_stock) AS total_units_in_stock FROM public.products WHERE supplier_id IN (17, 19, 16)
GROUP BY category_id HAVING SUM(units_in_stock) > 300;
--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES (ShipCountry) SA, CANADA, SPAIN cuYO CONTADOR SEA MAYOR A 25
SELECT employee_id, COUNT(order_id) as num_orders FROM public.orders WHERE ship_country IN ('USA', 'Canada', 'Spain')
GROUP BY employee_id HAVING COUNT(order_id) > 25;
----OBTENER LAS VENTAS (Quantity * UnitPrice) AGRUPADAS POR PRODUCTO (Orders details) Y CUYA SUMA DE VENTAS SEA MAYOR A 50.000
SELECT product_id, SUM(quantity * unit_price) AS total_sales FROM public.order_details
GROUP BY product_id HAVING SUM(quantity * unit_price) > 50000;

--Mas de una tabla 

--OBTENER EL NUMERO DE ORDEN, EL ID EMPLEADO, NOMBRE Y APELLIDO DE LAS TABLAS DE ORDENES Y EMPLEADOS
SELECT orders.order_id, employees.employee_id, employees.first_name, employees.last_name
FROM public.orders
INNER JOIN public.employees ON orders.employee_id = employees.employee_id;

--OBTENER EL PRODUCTID, PRODUCTNAME, SUPPLIERID, COMPANYNAME DE LAS TABLAS DE PRODUCTOS Y PROVEEDORES (SUPPLIERS
SELECT products.product_id, products.product_name, products.supplier_id, suppliers.company_name
FROM public.products
INNER JOIN public.suppliers ON products.supplier_id = suppliers.supplier_id;

--OBTENER LOS DATOS DEL DETALLE DE ORDENES CON EL NOMBRE DEL PRODUCTO DE LAS TABLAS DE DETALLE DE ORDENES Y DE PRODUCTOS
SELECT order_details.order_id, order_details.product_id, products.product_name, order_details.unit_price, order_details.quantity, order_details.discount
FROM public.order_details
INNER JOIN public.products ON order_details.product_id = products.product_id;

--OBTENER DE LAS ORDENES EL ID, SHIPPERID, NOMBRE DE LA COMPAÑÍA DE ENVIO (SHIPPERS)
SELECT orders.order_id, orders.ship_via AS shipper_id, shippers.company_name FROM public.orders
INNER JOIN shippers ON orders.ship_via = shippers.shipper_id;

--Obtener el número de orden, país de envío (shipCountry) y el nombre del empleado de la tabla ordenes y empleados Queremos que salga el Nombre y Apellido del Empleado en una sola columna.
SELECT o.order_id, o.ship_country, CONCAT(e.first_name, ' ', e.last_name) as employee_name
FROM public.orders o
INNER JOIN public.employees e ON o.employee_id = e.employee_id;

--Combinando la mayoría de conceptos

--CONTAR EL NUMERO DE ORDENES POR EMPLEADO OBTENIENDO EL ID EMPLEADO Y EL NOMBRE COMPLETO DE LAS TABLAS DE ORDENES Y DE EMPLEADOS join y group by / columna calculada
SELECT employees.employee_id, CONCAT(employees.first_name, ' ', employees.last_name) as nombre_completo, COUNT(orders.order_id) as num_orders
FROM public.employees
INNER JOIN public.orders ON employees.employee_id = orders.employee_id
GROUP BY employees.employee_id, nombre_completo

--OBTENER LA SUMA DE LA CANTIDAD VENDIDA Y EL PRECIO PROMEDIO POR NOMBRE DE PRODUCTO DE LA TABLA DE ORDERS DETAILS Y PRODUCTS
SELECT p.product_name, SUM(od.quantity) as cantidad_total, AVG(od.unit_price) as promedio_precio
FROM public.order_details od
INNER JOIN public.products p ON od.product_id = p.product_id
GROUP BY p.product_name;


--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR CLIENTE DE LAS TABLAS ORDER DETAILS, ORDERS
SELECT o.customer_id, SUM(od.unit_price * od.quantity) as total_ventas
FROM public.orders o
INNER JOIN public.order_details od
ON o.order_id = od.order_id
GROUP BY o.customer_id;

--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR EMPLEADO MOSTRANDO EL APELLIDO (LASTNAME)DE LAS TABLAS EMPLEADOS, ORDENES, DETALLE DE ORDENES
SELECT e.last_name, SUM(od.unit_price * od.quantity) AS total_ventas
FROM public.employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id, e.last_name;

