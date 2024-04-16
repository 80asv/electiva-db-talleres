DROP DATABASE IF EXISTS perreteria;
CREATE DATABASE perreteria CHARACTER SET utf8mb4;
USE perreteria;


CREATE TABLE raza(
	id_raza VARCHAR(10),
	nombre_raza VARCHAR(30),

	PRIMARY KEY (id_raza)
);

CREATE TABLE vacunas(
	id_vacuna VARCHAR(10) NOT NULL,
	nombre_vacuna VARCHAR(30) NOT NULL,

	PRIMARY KEY (id_vacuna)
);

CREATE TABLE perros(
	id_perro VARCHAR(10) NOT NULL,
	nombre_perro VARCHAR(30) NOT NULL,
	peso_perro VARCHAR(10) NOT NULL,
	genero_perro CHAR(1) NOT NULL,
	edad_perro INT(3) NOT NULL,
	tamanio_perro VARCHAR(30) NOT NULL,
	id_raza VARCHAR(10) NOT NULL,
	estado CHAR(1) NOT NULL,

	CONSTRAINT  gen_perro CHECK(genero_perro in ('M', 'H')),
	CONSTRAINT edad_ad CHECK(estado in ('A', 'P')),

	PRIMARY KEY (id_perro),
	FOREIGN KEY (id_raza) REFERENCES raza(id_raza)
);

CREATE TABLE clientes(
	id_cliente VARCHAR(10) NOT NULL,
	nombre_cliente VARCHAR(50) NOT NULL,
	telefono_cliente VARCHAR(15) NOT NULL,
	correo_cliente	VARCHAR(50) NOT NULL,
	direccion_cliente VARCHAR(100) NOT NULL,
	ocupacion_cliente VARCHAR(30) NOT NULL,
	edad_cliente INT NOT NULL,
    observacion VARCHAR(100),

	PRIMARY KEY (id_cliente),
	CONSTRAINT edad_cliente CHECK(edad_cliente >= 18)
);

CREATE TABLE vacunas_perros(
	id_perro VARCHAR(10),
	id_vacuna VARCHAR(10),
	fecha_vacuna DATE NOT NULL,

	PRIMARY KEY (id_perro, id_vacuna, fecha_vacuna),
	FOREIGN KEY (id_perro) REFERENCES perros(id_perro),
	FOREIGN KEY (id_vacuna) REFERENCES vacunas(id_vacuna)
);

CREATE TABLE registro(
	id_registro VARCHAR(10) NOT NULL,
	id_cliente  VARCHAR(10) NOT NULL,
	id_perro VARCHAR(10),
	fecha_adopcion DATE,

	PRIMARY KEY (id_registro),
	FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
	FOREIGN KEY (id_perro) REFERENCES perros(id_perro)
);

# Asignacion de usuarios

# Crear user
CREATE USER 'veterinario'@'localhost' IDENTIFIED  BY '123456';

# Asignar privilegios en la tabla clientes
GRANT INSERT ON perreteria.clientes TO 'veterinario'@'localhost';

# Prueba de privilegios para veterinario
INSERT INTO
    clientes (id_cliente, nombre_cliente, telefono_cliente, correo_cliente, direccion_cliente, ocupacion_cliente, edad_cliente, observacion)
VALUES
    ('U013', 'Andres Perez', '+1234567890', 'andres@example.com', 'Cll Principal 123', 'Estudiante', 25, 'Cliente habitual');

# DATA

INSERT INTO
    raza (id_raza, nombre_raza)
VALUES
    ('R001', 'Labrador Retriever'),
    ('R002', 'Bulldog'),
    ('R003', 'Golden Retriever'),
    ('R004', 'Beagle'),
    ('R005', 'Poodle'),
    ('R006', 'German Shepherd'),
    ('R007', 'Dachshund'),
    ('R008', 'Boxer'),
    ('R009', 'Siberian Husky'),
    ('R010', 'Yorkshire Terrier');


INSERT INTO
    perros (id_perro, nombre_perro, peso_perro, genero_perro, edad_perro, tamanio_perro, id_raza, estado)
VALUES
    ('P001', 'Max', 25.5, 'M', 3, 'Mediano', 'R001', 'A'),
    ('P002', 'Luna', 12.3, 'H', 5, 'Pequeño', 'R002', 'P'),
    ('P003', 'Rocky', 30.8, 'M', 2, 'Grande', 'R003', 'A'),
    ('P004', 'Bella', 8.7, 'H', 7, 'Pequeño', 'R004', 'A'),
    ('P005', 'Thor', 18.6, 'M', 4, 'Mediano', 'R005', 'P'),
    ('P006', 'Coco', 6.2, 'H', 1, 'Pequeño', 'R006', 'A'),
    ('P007', 'Rocko', 22.4, 'M', 6, 'Grande', 'R007', 'P'),
    ('P008', 'Daisy', 14.9, 'H', 9, 'Mediano', 'R008', 'A'),
    ('P009', 'Rex', 28.1, 'M', 8, 'Grande', 'R009', 'A'),
    ('P010', 'Lola', 10.5, 'H', 2, 'Pequeño', 'R010', 'A');

INSERT INTO
    vacunas (id_vacuna, nombre_vacuna)
VALUES
    ('V001', 'Parvovirus Canino'),
    ('V002', 'Moquillo Canino'),
    ('V003', 'Hepatitis Canina'),
    ('V004', 'Leptospirosis Canina'),
    ('V005', 'Rabia Canina'),
    ('V006', 'Bordetella Canina'),
    ('V007', 'Coronavirus Canino'),
    ('V008', 'Parainfluenza Canina'),
    ('V009', 'Lyme Canina'),
    ('V010', 'Giardia Canina');

INSERT INTO
    vacunas_perros (id_perro, id_vacuna, fecha_vacuna)
VALUES
    ('P001', 'V001', '2023-01-15'),
    ('P002', 'V002', '2023-02-20'),
    ('P003', 'V003', '2023-03-10'),
    ('P004', 'V001', '2023-04-05'),
    ('P005', 'V002', '2023-05-12'),
    ('P006', 'V003', '2023-06-18'),
    ('P007', 'V001', '2023-07-22'),
    ('P008', 'V002', '2023-08-30'),
    ('P009', 'V003', '2023-09-14'),
    ('P010', 'V001', '2023-10-25');

INSERT INTO
    clientes (id_cliente, nombre_cliente, telefono_cliente, correo_cliente, direccion_cliente, ocupacion_cliente, edad_cliente, observacion)
VALUES
    ('U001', 'Juan Perez', '+1234567890', 'juan@example.com', 'Calle Principal 123', 'Estudiante', 25, 'Cliente habitual'),
    ('U002', 'Maria Lopez', '+1987654321', 'maria@example.com', 'Avenida Central 456', 'Ingeniero', 35, 'Requiere atención especial'),
    ('U003', 'Carlos Martinez', '+1122334455', 'carlos@example.com', 'Calle Secundaria 789', 'Abogado', 40, 'Nuevo cliente'),
    ('U004', 'Ana Garcia', '+1555666777', 'ana@example.com', 'Paseo Peatonal 321', 'Médico', 30, 'Cliente preferencial'),
    ('U005', 'Pedro Rodriguez', '+1444333222', 'pedro@example.com', 'Plaza Central 987', 'Empresario', 45, 'Cliente potencial'),
    ('U006', 'Laura Sanchez', '+1888777666', 'laura@example.com', 'Carrera Principal 654', 'Diseñadora', 28, 'Cliente regular'),
    ('U007', 'Diego Ramirez', '+1999444555', 'diego@example.com', 'Avenida Secundaria 852', 'Profesor', 50, 'Cliente con mascota'),
    ('U008', 'Sofia Hernandez', '+1666777888', 'sofia@example.com', 'Avenida Peatonal 147', 'Estudiante', 22, 'Cliente puntual'),
    ('U009', 'Jorge Gonzalez', '+1333444555', 'jorge@example.com', 'Callejón Principal 369', 'Arquitecto', 32, 'Cliente de alto valor'),
    ('U010', 'Natalia Torres', '+1888999000', 'natalia@example.com', 'Avenida Principal 753', 'Chef', 38, 'Cliente internacional');