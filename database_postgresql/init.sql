DROP TABLE IF EXISTS PROYECTOS;
DROP TABLE IF EXISTS USUARIO;
DROP TABLE IF EXISTS CATEGORIAS;
DROP TABLE IF EXISTS SUBCATEGORIAS;
DROP TABLE IF EXISTS ALCANCES;
DROP TABLE IF EXISTS FUENTE; 
DROP TABLE IF EXISTS CONSUMOS; 

CREATE TABLE PROYECTOS(
ID_PROYECTO int,
NOMBRE varchar(100),
HUELLA_DE_CARBONO numeric(30,5),
HUELLA_HIDRICA numeric(30,5),
HUELLA_FINANCIERA numeric(30,5),
PRIMARY KEY(ID_PROYECTO)
);

CREATE TABLE USUARIO(
ID_USUARIO varchar(100),
ID_PROYECTO int not null,
PASS text not null,
NOMBRE varchar(100) not null,
CORREO varchar(100),
ACTIVO boolean not null,
PRIMARY KEY(ID_USUARIO),
   CONSTRAINT fk_u_proyecto
      FOREIGN KEY(ID_PROYECTO) 
        REFERENCES PROYECTOS(ID_PROYECTO)
);

CREATE TABLE CATEGORIAS(	
ID_CATEGORIA int,
NOMBRE varchar(150) not null,
DESCRIPCION	text,
PRIMARY KEY(ID_CATEGORIA)
);

CREATE TABLE SUBCATEGORIAS(	
ID_SUBCATEGORIA	int,
ID_CATEGORIA int,
NOMBRE	varchar(100) not null,
DESCRIPCION	text,
PRIMARY KEY(ID_SUBCATEGORIA),
   CONSTRAINT fk_categoria
      FOREIGN KEY(ID_CATEGORIA) 
        REFERENCES CATEGORIAS(ID_CATEGORIA)
);

CREATE TABLE ALCANCES(
ID_ALCANCES	int,
NOMBRE varchar(100) not null,
DESCRIPCION	text,
PRIMARY KEY(ID_ALCANCES)
--fk categorias
);

--CREATE TABLE TIPOS_DE_ALCANCES(
--ID_TIPO_ALCANCE	int,
--ID_ALCANCES	int,
--DESCRIPCION	text,
--PRIMARY KEY(ID_TIPO_ALCANCE),
--   CONSTRAINT fk_alcance
--      FOREIGN KEY(ID_ALCANCES) 
--        REFERENCES ALCANCES(ID_ALCANCES)
--);

CREATE TABLE FUENTE(
ID_FUENTE int,
NOMBRE varchar(150) not null,
DESCRIPCION	text,
TIPO varchar(100),
COMBUSTIBLE	varchar(100),
UNIDAD_FUENTE	varchar(50),
FACTOR_EMISION	numeric(30,5),
ID_ALCANCES int,
ID_CATEGORIA int,
ID_SUBCATEGORIA int,
PRIMARY KEY(ID_FUENTE),
    CONSTRAINT fk_f_alcance
      FOREIGN KEY(ID_ALCANCES) 
        REFERENCES ALCANCES(ID_ALCANCES),
    CONSTRAINT fk_f_categoria
      FOREIGN KEY(ID_CATEGORIA) 
        REFERENCES CATEGORIAS(ID_CATEGORIA),
    CONSTRAINT fk_f_subcategoria
      FOREIGN KEY(ID_SUBCATEGORIA) 
        REFERENCES SUBCATEGORIAS(ID_SUBCATEGORIA)
        
);

CREATE TABLE UNIDAD_FUENTE(
ID_UNIDAD_FUENTE int,
NOMBRE varchar(100) not null,
SIGLA	varchar(15) not null,
ID_FUENTE int,
PRIMARY KEY(ID_UNIDAD_FUENTE),
    CONSTRAINT fk_f_unidad
      FOREIGN KEY(ID_FUENTE) 
        REFERENCES FUENTE(ID_FUENTE)
);

CREATE TABLE CONSUMOS(	
ID_CONSUMO varchar(50),  -- validar el tipo de dato UUID 
ID_FUENTE int,
ID_PROYECTO int,
CANTIDAD_FUENTE	numeric(30,5),
CAMPUS	varchar(150), -- Campus corresponde a proyecto?
LINK_RESPALDO	text,
COMENTARIOS	text,
HUELLACHILE	boolean,
PRIMARY KEY(ID_CONSUMO),
    CONSTRAINT fk_c_fuente
      FOREIGN KEY(ID_FUENTE) 
        REFERENCES FUENTE(ID_FUENTE),
    CONSTRAINT fk_c_proyecto
      FOREIGN KEY(ID_PROYECTO) 
        REFERENCES PROYECTOS(ID_PROYECTO)
);


-- Inserts Iniciales

-- Tabla Categorias
INSERT INTO categorias ( id_categoria, nombre, descripcion) VALUES(1, 'Transporte', 'Transporte');
INSERT INTO categorias ( id_categoria, nombre, descripcion) VALUES(2, 'Emisiones indirectas de GEI por electricidad importada', 'Emisiones indirectas de GEI por electricidad importada');
INSERT INTO categorias ( id_categoria, nombre, descripcion) VALUES(3, 'Emisiones fugitivas', 'Emisiones fugitivas');
INSERT INTO categorias ( id_categoria, nombre, descripcion) VALUES(4, 'Emisiones directas de GEI', 'Emisiones directas de GEI');
INSERT INTO categorias ( id_categoria, nombre, descripcion) VALUES(5, 'Productos que utiliza la organización', 'Productos que utiliza la organización');

-- Tabla SubCategorias
INSERT INTO subcategorias (id_subcategoria, id_categoria, nombre, descripcion) VALUES(1, 1, 'Movilización de personas', 'Movilización de personas');
INSERT INTO subcategorias (id_subcategoria, id_categoria, nombre, descripcion) VALUES(2, 2, 'Adquisición de electricidad', 'Adquisición de electricidad');
INSERT INTO subcategorias (id_subcategoria, id_categoria, nombre, descripcion) VALUES(3, 3, 'Refrigerante', 'Refrigerante');
INSERT INTO subcategorias (id_subcategoria, id_categoria, nombre, descripcion) VALUES(4, 4, 'Combustión Estacionaria', 'Combustión Estacionaria');
INSERT INTO subcategorias (id_subcategoria, id_categoria, nombre, descripcion) VALUES(5, 4, 'Combustión Móvil', 'Combustión Móvil');
INSERT INTO subcategorias (id_subcategoria, id_categoria, nombre, descripcion) VALUES(6, 5, 'Tratamiento y/o disposición de residuos', 'Tratamiento y/o disposición de residuos');
INSERT INTO subcategorias (id_subcategoria, id_categoria, nombre, descripcion) VALUES(7, 5, 'Bienes y servicios adquiridos', 'Bienes y servicios adquiridos');

-- Tabla Alcances
INSERT INTO alcances (id_alcances, nombre, descripcion) VALUES(1, 'OTRAS EMISIONES INDIRECTAS DE GEI', 'OTRAS EMISIONES INDIRECTAS DE GEI');
INSERT INTO alcances (id_alcances, nombre, descripcion) VALUES(2, 'EMISIONES INDIRECTAS POR CONSUMO Y DISTRIBUCIÓN DE ENERGÍA', 'EMISIONES INDIRECTAS POR CONSUMO Y DISTRIBUCIÓN DE ENERGÍA');
INSERT INTO alcances (id_alcances, nombre, descripcion) VALUES(3, 'EMISIONES DIRECTAS', 'EMISIONES DIRECTAS');
