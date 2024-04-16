DROP DATABASE IF EXISTS procedimientosAlmacenadosDB;
CREATE DATABASE procedimientosAlmacenadosDB CHARACTER SET utf8mb4;
USE procedimientosAlmacenadosDB;

create table seccion(
    cod_seccion char(1) not null,
    nom_seccion varchar(25) not null,
    primary key(cod_seccion)
);

create table productos(
    cod_prod varchar(5) not null,
    nom_prod varchar(25) not null,
    seccion char(1),
    precio int(5) not null,
    cantidad int(6) not null,
    primary key(cod_prod),
    foreign key(seccion) references seccion(cod_seccion)
);

# Procedimientos almacendados
DELIMITER //
CREATE PROCEDURE obtener_cantidad_productos_por_seccion(
    OUT cod_seccion CHAR(1),
    OUT cantidad_productos INT
)
BEGIN
    SELECT seccion, COUNT(*) AS total_productos
    INTO cod_seccion, cantidad_productos
    FROM productos
    GROUP BY seccion;
END //
;
DELIMITER ;

drop procedure obtener_cantidad_productos_por_seccion;

CALL obtener_cantidad_productos_por_seccion(@cod_seccion, @cantidad_productos);
SELECT @cod_seccion, @cantidad_productos;

# Procedimiento usando GROUP BY para obtener el precio promedio de los productos por sección:
DELIMITER $$
CREATE PROCEDURE obtener_precio_promedio_por_seccion(
    OUT cod_seccion CHAR(1),
    OUT precio_promedio DECIMAL(10, 2)
)
BEGIN
    SELECT seccion, AVG(precio) AS precio_promedio
    INTO cod_seccion, precio_promedio
    FROM productos;
#     GROUP BY seccion;
END $$
DELIMITER ;

drop procedure obtener_precio_promedio_por_seccion;

CALL obtener_precio_promedio_por_seccion(@cod_seccion, @precio_promedio);
SELECT @cod_seccion AS cod_seccion, @precio_promedio AS precio_promedio;


# HAVING
# Procedimiento usando HAVING para obtener las secciones con una cantidad de productos menor a un valor especificado:
DELIMITER $$
CREATE PROCEDURE obtener_secciones_con_pocos_productos(
    IN cantidad_limite INT,
    OUT cod_seccion CHAR(1),
    OUT cantidad_productos INT
)
BEGIN
    SELECT seccion, COUNT(*) AS total_productos
    INTO cod_seccion, cantidad_productos
    FROM productos
    GROUP BY seccion
    HAVING cantidad_productos < cantidad_limite;
END $$
DELIMITER ;

CALL obtener_secciones_con_pocos_productos(20, @cod_seccion, @cantidad_productos);
SELECT @cod_seccion AS cod_seccion, @cantidad_productos AS cantidad_productos;

# ELABORAR

# Identifica las secciones donde todos los productos están agotados (cantidad igual a cero),
# mostrando el nombre de la sección y la cantidad total de productos agotados.

DELIMITER $$
CREATE PROCEDURE indetificar_secciones_de_productos_agotados(
    OUT cod_seccion CHAR(1),
    OUT cantidad_productos INT
)
BEGIN
    SELECT seccion, COUNT(*) AS total_productos
    INTO cod_seccion, cantidad_productos
    FROM productos
    GROUP BY seccion
    HAVING cantidad_productos = 0;
END $$
DELIMITER ;

CALL indetificar_secciones_de_productos_agotados( @cod_seccion, @cantidad_productos);
SELECT @cod_seccion AS cod_seccion, @cantidad_productos AS cantidad_productos_agodatos;


# Encuentra las secciones donde el precio promedio de los productos es mayor que
# el precio promedio general de todos los productos,
# mostrando el nombre de la sección y el precio promedio de los productos en esa sección.

DELIMITER $$
CREATE PROCEDURE indetificar_secciones_de_productos_agotados(
    OUT cod_seccion CHAR(1),
    OUT cantidad_productos INT
)
BEGIN
    SELECT seccion, COUNT(*) AS total_productos
    INTO cod_seccion, cantidad_productos
    FROM productos
    GROUP BY seccion
    HAVING cantidad_productos = 0;
END $$
DELIMITER ;



# DATA

INSERT INTO seccion  VALUES ('A', 'Electrónica');
INSERT INTO seccion  VALUES ('B', 'Ropa');
INSERT INTO seccion  VALUES ('C', 'Hogar');
INSERT INTO seccion  VALUES ('D', 'Deportes');
INSERT INTO seccion  VALUES ('E', 'Juguetes');

INSERT INTO productos  VALUES ('P001', 'Televisor LED', 'A', 500, 0);
INSERT INTO productos  VALUES ('P002', 'Camiseta', 'B', 20, 50);
INSERT INTO productos  VALUES ('P003', 'Cafetera', 'C', 30, 20);
INSERT INTO productos  VALUES ('P004', 'Balón de fútbol', 'D', 15, 0);
INSERT INTO productos VALUES ('P005', 'Muñeca', 'E', 10, 40);
INSERT INTO productos VALUES ('P006', 'Consola de videojuegos', 'A', 300, 20);
INSERT INTO productos VALUES ('P007', 'Pantalón vaquero', 'B', 25, 60);
INSERT INTO productos VALUES ('P008', 'Juego de sábanas', 'C', 40, 0);
INSERT INTO productos VALUES ('P009', 'Raqueta de tenis', 'D', 50, 25);
INSERT INTO productos VALUES ('P010', 'Rompecabezas', 'E', 15, 35);
INSERT INTO productos VALUES ('P011', 'Smartphone', 'A', 700, 30);
INSERT INTO productos VALUES ('P012', 'Zapatillas deportivas', 'B', 50, 45);
INSERT INTO productos VALUES ('P013', 'Aspiradora', 'C', 80, 10);
INSERT INTO productos VALUES ('P014', 'Pelota de baloncesto', 'D', 20, 40);
INSERT INTO productos VALUES ('P015', 'Muñeco de acción', 'E', 12, 50);
