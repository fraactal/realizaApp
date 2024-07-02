DROP TABLE IF EXISTS PROYECTOS;
DROP TABLE IF EXISTS CAMPUS;
DROP TABLE IF EXISTS USUARIO;
DROP TABLE IF EXISTS CATEGORIAS;
DROP TABLE IF EXISTS SUBCATEGORIAS;
DROP TABLE IF EXISTS ALCANCES;
DROP TABLE IF EXISTS UNIDAD_FUENTE; 
DROP TABLE IF EXISTS UNIDAD_FACTOR_EMISION; 
DROP TABLE IF EXISTS TIPOS_GAS_GEI; 

DROP TABLE IF EXISTS VALOR_UNIDAD_X_FACTOR_EMISION; 
DROP TABLE IF EXISTS FACTOR_DE_EMISION; 

DROP TABLE IF EXISTS FUENTE; 
DROP TABLE IF EXISTS CONSUMOS; 


CREATE TABLE PROYECTOS(
ID_PROYECTO int,
NOMBRE varchar(100),
DESCRIPCION text,
PRIMARY KEY(ID_PROYECTO)
);

CREATE TABLE CAMPUS(
ID_CAMPUS int,
ID_PROYECTO int not null,
NOMBRE varchar(100),
HUELLA_DE_CARBONO numeric(30,10),
HUELLA_HIDRICA numeric(30,10),
HUELLA_FINANCIERA numeric(30,10),
PRIMARY KEY(ID_CAMPUS),
   CONSTRAINT fk_c_proyecto
      FOREIGN KEY(ID_PROYECTO) 
        REFERENCES PROYECTOS(ID_PROYECTO)
);

CREATE TABLE USUARIO(
ID_USUARIO varchar(100),
ID_PROYECTO int not null,
ID_CAMPUS int not null,
PASS text not null,
NOMBRE varchar(100) not null,
CORREO varchar(100),
TIPO_USUARIO char(1),  -- Admin (A) --> crear, modificar, eliminar, ver - USER(U)  --> Crear, Ver
ACTIVO boolean not null,
PRIMARY KEY(ID_USUARIO),
   CONSTRAINT fk_u_campus
      FOREIGN KEY(ID_CAMPUS) 
        REFERENCES CAMPUS(ID_CAMPUS)
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
);


CREATE TABLE UNIDAD_FUENTE(
ID_UNIDAD_FUENTE int,
NOMBRE varchar(100) not null,
SIGLA	varchar(15) not null,
PRIMARY KEY(ID_UNIDAD_FUENTE)
);

CREATE TABLE UNIDAD_FACTOR_EMISION(
ID_UNIDAD_FACTOR_EMISION int,
NOMBRE varchar(100) not null,  -- kgCO2eq/litros
PRIMARY KEY(ID_UNIDAD_FACTOR_EMISION)
);

CREATE TABLE TIPOS_GAS_GEI(
ID_GAS_GEI int,
NOMBRE varchar(100) not null, -- dioxido de carbono
SIGLA varchar(15), -- CO2
PRIMARY KEY(ID_GAS_GEI)
);

CREATE TABLE FACTOR_DE_EMISION(
ID_FACTOR_EMISION int,
FUENTE_EMISION varchar(150) not null, --Caldera - Gas licuado de petróleo
COMBUSTIBLE varchar(100),
ORIGEN_DEL_FE varchar(100),	
INCERTIDUMBRE varchar(10), -- Alta, Media, Baja
ID_UNIDAD_FACTOR_EMISION int,
PRIMARY KEY(ID_FACTOR_EMISION),
    CONSTRAINT fk_fe_unidad_fe
      FOREIGN KEY(ID_UNIDAD_FACTOR_EMISION) 
        REFERENCES UNIDAD_FACTOR_EMISION(ID_UNIDAD_FACTOR_EMISION)
);

-- Valor de unida gas GEI x factos de emision
CREATE TABLE VALOR_UNIDAD_X_FACTOR_EMISION(
ID_FACTOR_EMISION int,
ID_GAS_GEI int,
VALOR numeric(30,10),
    CONSTRAINT fk_valor_fe
      FOREIGN KEY(ID_FACTOR_EMISION) 
        REFERENCES FACTOR_DE_EMISION(ID_FACTOR_EMISION),
    CONSTRAINT fk_valor_gei
      FOREIGN KEY(ID_GAS_GEI) 
        REFERENCES TIPOS_GAS_GEI(ID_GAS_GEI)
);


CREATE TABLE FUENTE(
ID_FUENTE int,
NOMBRE varchar(150) not null, -- Viajes de negocios - Terrestre - Vehículo particular - gasolina
ID_FACTOR_EMISION	int,
ID_UNIDAD_FUENTE	int,
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
        REFERENCES SUBCATEGORIAS(ID_SUBCATEGORIA),
    CONSTRAINT fk_f_unidad_fuente
      FOREIGN KEY(ID_UNIDAD_FUENTE) 
        REFERENCES UNIDAD_FUENTE(ID_UNIDAD_FUENTE),
    CONSTRAINT fk_f_factor_emision
      FOREIGN KEY(ID_FACTOR_EMISION) 
        REFERENCES FACTOR_DE_EMISION(ID_FACTOR_EMISION)
);

CREATE TABLE CONSUMOS(	
ID_CONSUMO varchar(50),  -- validar el tipo de dato UUID 
ID_FUENTE int,
CANTIDAD_FUENTE	numeric(30,5),
LINK_RESPALDO	text,
COMENTARIOS	text,
HUELLACHILE	boolean,
ID_CAMPUS	int, -- Campus corresponde a proyecto
PRIMARY KEY(ID_CONSUMO),
    CONSTRAINT fk_c_fuente
      FOREIGN KEY(ID_FUENTE) 
        REFERENCES FUENTE(ID_FUENTE),
    CONSTRAINT fk_c_campus
      FOREIGN KEY(ID_CAMPUS) 
        REFERENCES CAMPUS(ID_CAMPUS)
);


-- Inserts Iniciales

-- #####################################
-- Tabla Proyectos
INSERT INTO proyectos (id_proyecto, nombre, descripcion) VALUES(1, 'Proyecto 1', 'Proyecto de Prueba 1');
INSERT INTO proyectos (id_proyecto, nombre, descripcion) VALUES(2, 'Proyecto 2', 'Proyecto de Prueba 2');

-- Tabla Campus
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(1,1, 'Campus 1', 0, 0, 0);
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(2,1, 'Campus 2', 0, 0, 0);
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(3,2, 'Campus 3', 0, 0, 0);
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(4,2, 'Campus 4', 0, 0, 0);

-- Tabla Usuarios
INSERT INTO usuario (id_usuario, id_proyecto, id_campus, pass, nombre, correo, activo, tipo_usuario) VALUES('User_1', 1, 1, 'saintseya', 'Usuario 1', 'user_1@campus1.cl', true,'A');
INSERT INTO usuario (id_usuario, id_proyecto, id_campus, pass, nombre, correo, activo, tipo_usuario) VALUES('User_2', 1, 2, 'shyru', 'Usuario 2', 'user_2@campus2.cl', true,'U');
INSERT INTO usuario (id_usuario, id_proyecto, id_campus, pass, nombre, correo, activo, tipo_usuario) VALUES('User_3', 1, 2, 'yoga', 'Usuario 3', 'user_3@campus2.cl', true,'U');
INSERT INTO usuario (id_usuario, id_proyecto, id_campus, pass, nombre, correo, activo, tipo_usuario) VALUES('User_4', 2, 3, 'andromeda', 'Usuario 4', 'user_4@campus3.cl', true,'A');
INSERT INTO usuario (id_usuario, id_proyecto, id_campus, pass, nombre, correo, activo, tipo_usuario) VALUES('User_5', 2, 3, 'ikki', 'Usuario 5', 'user_1@campus3.cl', true,'U');

-- #####################################
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

-- Tabla Unidad_Fuente
INSERT INTO unidad_fuente(id_unidad_fuente, nombre, sigla) VALUES(1, 'personas x kilómetros', 'PxK');
INSERT INTO unidad_fuente(id_unidad_fuente, nombre, sigla) VALUES(2, 'mega watts x Hora', 'MWh');
INSERT INTO unidad_fuente(id_unidad_fuente, nombre, sigla) VALUES(3, 'kilogramos', 'kg');
INSERT INTO unidad_fuente(id_unidad_fuente, nombre, sigla) VALUES(4, 'metros cúbico', 'mt3');
INSERT INTO unidad_fuente(id_unidad_fuente, nombre, sigla) VALUES(5, 'toneladas', 'tons');
INSERT INTO unidad_fuente(id_unidad_fuente, nombre, sigla) VALUES(6, 'litros', 'lts');

-- Tabla UNIDAD_FACTOR_EMISION
INSERT INTO unidad_factor_emision (id_unidad_factor_emision, nombre) VALUES(1, 'kgCO2eq/litros');
INSERT INTO unidad_factor_emision (id_unidad_factor_emision, nombre) VALUES(2, 'kgCO2eq/metros cúbicos');
INSERT INTO unidad_factor_emision (id_unidad_factor_emision, nombre) VALUES(3, 'kgCO2eq/toneladas');
INSERT INTO unidad_factor_emision (id_unidad_factor_emision, nombre) VALUES(4, 'kgCO2eq/kilogramos');
INSERT INTO unidad_factor_emision (id_unidad_factor_emision, nombre) VALUES(5, 'kgCO2eq/MWh');
INSERT INTO unidad_factor_emision (id_unidad_factor_emision, nombre) VALUES(6, 'kgCO2eq/personas x kilómetros');
INSERT INTO unidad_factor_emision (id_unidad_factor_emision, nombre) VALUES(7, 'kgCO2e/personas x kilómetros');

-- Tabla TIPOS_GAS_GEI
INSERT INTO tipos_gas_gei (id_gas_gei, nombre, sigla) VALUES(1, 'dioxido de carbono', 'CO2');
INSERT INTO tipos_gas_gei (id_gas_gei, nombre, sigla) VALUES(2, 'oxido nitroso', 'N2O');
INSERT INTO tipos_gas_gei (id_gas_gei, nombre, sigla) VALUES(3, 'metano', 'CH4');
INSERT INTO tipos_gas_gei (id_gas_gei, nombre, sigla) VALUES(4, 'hidrofluorocarbonos', 'HFC');


-- Tabla FACTOR_DE_EMISION
-- Tabla VALOR_UNIDAD_X_FACTOR_EMISION
-- Tabla FUENTES
-- Tabla CONSUMOS 