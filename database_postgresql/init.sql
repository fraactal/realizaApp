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

CREATE TABLE FUENTE(
ID_FUENTE int,
NOMBRE varchar(150) not null, -- Viajes de negocios - Terrestre - Vehículo particular - gasolina
--ID_FACTOR_EMISION	int, -- No va idFactorEmision. Se debe pasar a la tabla FACTOR_DE_EMISION el idFuente
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
        REFERENCES UNIDAD_FUENTE(ID_UNIDAD_FUENTE)
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
ID_FUENTE int, --Caldera - Gas licuado de petróleo
PRIMARY KEY(ID_FACTOR_EMISION),
    CONSTRAINT fk_fe_unidad_fe
      FOREIGN KEY(ID_UNIDAD_FACTOR_EMISION) 
        REFERENCES UNIDAD_FACTOR_EMISION(ID_UNIDAD_FACTOR_EMISION),
    CONSTRAINT fk_fe_Fuente
      FOREIGN KEY(ID_FUENTE) 
        REFERENCES FUENTE(ID_FUENTE)
);
-- Camnbian año a año (agregar año)

-- Valor de unida gas GEI x factos de emision
CREATE TABLE VALOR_UNIDAD_X_FACTOR_EMISION(
ID_FACTOR_EMISION int,
ID_GAS_GEI int,
VALOR numeric(30,10),
PRIMARY KEY(ID_FACTOR_EMISION, ID_GAS_GEI),
    CONSTRAINT fk_valor_fe
      FOREIGN KEY(ID_FACTOR_EMISION) 
        REFERENCES FACTOR_DE_EMISION(ID_FACTOR_EMISION),
    CONSTRAINT fk_valor_gei
      FOREIGN KEY(ID_GAS_GEI) 
        REFERENCES TIPOS_GAS_GEI(ID_GAS_GEI)
);


CREATE TABLE CONSUMOS(	
ID_CONSUMO varchar(50),  -- validar el tipo de dato UUID 
ID_FUENTE int,
CANTIDAD_FUENTE	numeric(30,5),
FECHA DATE NOT NULL DEFAULT CURRENT_DATE,
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
-- Agregar fecha de consumo

-- Inserts Iniciales

-- #####################################
-- Tabla Proyectos
INSERT INTO proyectos (id_proyecto, nombre, descripcion) VALUES(1, 'Proyecto 1', 'Proyecto de Prueba 1');
INSERT INTO proyectos (id_proyecto, nombre, descripcion) VALUES(2, 'Proyecto 2', 'Proyecto de Prueba 2');

-- Tabla Campus
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(1,1, 'TALCA', 0, 0, 0);
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(2,1, 'CURICÓ', 0, 0, 0);
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(3,1, 'SANTIAGO', 0, 0, 0);
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(4,1, 'LINARES', 0, 0, 0);
INSERT INTO campus(id_campus, id_proyecto, nombre, huella_de_carbono, huella_hidrica, huella_financiera) VALUES(5,1, 'COLCHAGUA', 0, 0, 0);

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


-- Tabla FUENTES
-- INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES(0, '', 0, 0, 0, 0, 0);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 1, 'Traslado diario de personal - Vehículo particular - gasolina' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 2, 'Sistema Eléctrico Nacional - Sistema Eléctrico Nacional' , 2, 2, 2, 2);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 3, 'Viajes de negocios - Aéreo - Avión trayecto internacional (promedio)' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 4, 'Traslado diario de personal - Vehículo particular - diesel' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 5, 'Traslado diario de personal - Bus interurbano (aprox. 45 pers.)' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 6, 'R410A - R410A' , 3, 3, 3, 3);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 7, 'Caldera - Gas licuado de petróleo' , 4, 3, 4, 4);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 8, 'Viajes de negocios - Terrestre - Vehículo particular - gasolina' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 9, 'Traslado diario de personal - Bus transantiago' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 10, 'Traslado diario de personal - Bus local (aprox. 25 pers.)' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 11, 'Relleno sanitario - Residuos municipales' , 5, 1, 5, 6);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 12, 'Servicios adquiridos - Agua potable: Suministro y tratamiento' , 4, 1, 5, 7);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 13, 'Montreal - HCFC-22/R22' , 3, 3, 3, 3);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 14, 'General - Gas licuado de petróleo' , 4, 3, 4, 4);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 15, 'Medio terrestre - Petróleo 2 (Diesel)' , 4, 3, 4, 5);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 16, 'Traslado diario de personal - Colectivo' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 17, 'Traslado diario de personal - Metro' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 18, 'Bienes adquiridos - Gas licuado de petróleo' , 6, 1, 5, 7);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 19, 'Generador - Petróleo 2 (Diesel)' , 4, 3, 4, 4);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 20, 'Bienes adquiridos - Papel' , 5, 1, 5, 7);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 21, 'Bienes adquiridos - Petróleo 2 (Diesel)' , 6, 1, 5, 7);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 22, 'Traslado diario de personal - Motocicleta' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 23, 'Traslado diario de personal - Taxi' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 24, 'Medio terrestre - Gasolina' , 4, 3, 4, 5);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 25, 'Viajes de negocios - Terrestre - Bus interurbano (aprox. 45 pers.)' , 1, 1, 1, 1);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 26, 'Bienes adquiridos - Gasolina' , 6, 1, 5, 7);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 27, 'Reciclaje - Papel y cartón' , 5, 1, 5, 6);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 28, 'Reciclaje - Agregados (Escombros)' , 5, 1, 5, 6);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 29, 'Reciclaje - Plásticos: Promedio de plásticos' , 5, 1, 5, 6);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 30, 'Reciclaje - Vidrio' , 5, 1, 5, 6);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 31, 'Reciclaje - Metal: latas de aluminio y papel de aluminio' , 5, 1, 5, 6);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 32, 'Traslado diario de personal - Bicicleta/A pie' , 1, 1, 1, 1);
--- Validar Datos de Unidad Fuente, Alcances y Categorías
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 33, 'Bienes adquiridos - Gas natural' , 4, 1, 4, 4);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 34, 'Caldera - Gas natural' , 4, 1, 4, 4);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 35, 'General - Biomasa' , 3, 1, 4, 4);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 36, 'Reciclaje - Plásticos: PET' , 5, 1, 4, 4);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 37, 'Viajes de negocios - Aéreo - Avión trayecto doméstico (Chile continental)' , 1, 1, 4, 4);
INSERT INTO fuente (id_fuente, nombre, id_unidad_fuente, id_alcances, id_categoria, id_subcategoria) VALUES( 38, 'Viajes de negocios - Terrestre - Taxi' , 1, 1, 4, 4);
-----

-- Tabla FACTOR_DE_EMISION

INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 1, 'Bienes adquiridos - Gas licuado de petróleo' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 1 , 18);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 2, 'Bienes adquiridos - Gas natural' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 2 , 33);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 3, 'Bienes adquiridos - Gasolina' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 1 , 26);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 4, 'Bienes adquiridos - Papel' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 3 , 20);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 5, 'Bienes adquiridos - Petróleo 2 (Diesel)' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 1 , 21);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 6, 'Caldera - Gas licuado de petróleo' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 2 , 7);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 7, 'Caldera - Gas natural' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 2 , 34);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 8, 'Generador - Petróleo 2 (Diesel)' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 2 , 19);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 9, 'General - Biomasa' , '', 'Factor propio - kg CO2e - Verificado', 'Baja', 4 , 35);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 10, 'General - Gas licuado de petróleo' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 2 , 14);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 11, 'Medio terrestre - Gasolina' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 2 , 24);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 12, 'Medio terrestre - Petróleo 2 (Diesel)' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 2 , 15);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 13, 'Montreal - HCFC-22/R22' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 4 , 13);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 14, 'R410A - R410A' , '', 'IPCC 2013 5th Assessment Report', 'Baja', 4 , 6);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 15, 'Reciclaje - Agregados (Escombros)' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 3 , 28);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 16, 'Reciclaje - Metal: latas de aluminio y papel de aluminio' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 3 , 31);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 17, 'Reciclaje - Papel y cartón' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 3 , 27);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 18, 'Reciclaje - Plásticos: PET' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 3 , 36);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 19, 'Reciclaje - Plásticos: Promedio de plásticos' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 3 , 29);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 20, 'Reciclaje - Vidrio' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 3 , 30);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 21, 'Relleno sanitario - Residuos municipales' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 3 , 11);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 22, 'Servicios adquiridos - Agua potable: Suministro y tratamiento' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 2 , 12);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 23, 'Sistema Eléctrico Nacional - Sistema Eléctrico Nacional' , '', 'Ministerio de Energía 2022', 'Media', 5 , 2);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 24, 'Traslado diario de personal - Bus interurbano (aprox. 45 pers.)' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 5);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 25, 'Traslado diario de personal - Bus local (aprox. 25 pers.)' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 10);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 26, 'Traslado diario de personal - Bus transantiago' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 9);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 27, 'Traslado diario de personal - Colectivo' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 16);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 28, 'Traslado diario de personal - Metro' , '', 'METRO 2020 Reporte de sustentabilidad', 'Media', 6 , 17);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 29, 'Traslado diario de personal - Motocicleta' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 22);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 30, 'Traslado diario de personal - Taxi' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 23);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 31, 'Traslado diario de personal - Vehículo particular - gasolina' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 1);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 32, 'Viajes de negocios - Aéreo - Avión trayecto doméstico (Chile continental)' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 6 , 37);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 33, 'Viajes de negocios - Aéreo - Avión trayecto internacional (promedio)' , '', 'DEFRA 2022 4th Assessment Report', 'Alta', 6 , 3);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 34, 'Viajes de negocios - Terrestre - Bus interurbano (aprox. 45 pers.)' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 25);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 35, 'Viajes de negocios - Terrestre - Taxi' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 38);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 36, 'Viajes de negocios - Terrestre - Vehículo particular - gasolina' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 7 , 8);
INSERT INTO factor_de_emision (id_factor_emision, fuente_emision, combustible, origen_del_fe, incertidumbre, id_unidad_factor_emision, id_fuente) VALUES( 37, 'Traslado diario de personal - Vehículo particular - diesel' , '', 'IPCC 2006 Guidelines for National Greenhouse Gas Inventories en base al Balance Nacional de Energía', 'Baja', 6 , 4);


-- Tabla VALOR_UNIDAD_X_FACTOR_EMISION
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 1, 1, 0.184);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 2, 1, 0.343);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 3, 1, 0.633);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 4, 1, 919.396);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 5, 1, 0.629);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 6, 1, 1582.349);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 6, 2, 0.665);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 6, 3, 0.702);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 7, 1, 1.975);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 7, 2, 0.001);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 7, 3, 0.001);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 8, 1, 2698.546);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 8, 2, 5.79);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 8, 3, 3.059);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 9, 1, 0.5055);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 10, 1, 1582.349);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 10, 2, 0.665);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 10, 3, 0.702);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 11, 1, 2253.616);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 11, 2, 49.121);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 11, 3, 3.46);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 12, 1, 2698.546);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 12, 2, 37.638);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 12, 3, 3.977);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 13, 1, 1810);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 14, 4, 1923.5);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 15, 1, 0.985);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 16, 1, 21.28);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 17, 1, 21.28);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 18, 1, 21.28);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 19, 1, 21.28);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 20, 1, 21.28);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 21, 1, 446.204);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 22, 1, 0.421);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 23, 1, 300.6);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 24, 1, 0.022);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 25, 1, 0.031);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 26, 1, 0.013);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 27, 1, 0.083);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 28, 1, 0.055);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 29, 1, 0.058);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 30, 1, 0.116);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 31, 1, 0.192);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 32, 1, 0.246);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 33, 1, 0.184);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 34, 1, 0.022);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 35, 1, 0.116);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 36, 1, 0.192);
INSERT INTO valor_unidad_x_factor_emision (id_factor_emision, id_gas_gei, valor) VALUES( 37, 1, 0.204);



-- Tabla CONSUMOS 
--INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES('', 0, 0, '', '', false, 0);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0109' , 1 , 15754373, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0020' , 2 , 5784.31, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0039' , 3 , 4009698.27, 'cometidos internacionales.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0095' , 4 , 3271664, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0096' , 5 , 23258608, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0019' , 6 , 209, 'cifras energía y comunidad.xlsx', '', FALSE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0074' , 4 , 1920595, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0086' , 1 , 1813080, 'Resultados Encuesta de movilidad 2022.xlsx', '', FALSE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0080' , 5 , 15063164, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0038' , 3 , 1772056, 'internacionalizacion viajes estud extranjero.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0021' , 2 , 901.69, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0203' , 1 , 889640, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0001' , 7 , 101.84, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0033' , 8 , 797962, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0098' , 9 , 10570261, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0097' , 10 , 4431654, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0040' , 3 , 612864.45, 'cometidos internacionales.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0094' , 1 , 500775, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0049' , 11 , 172.48, 'Estimación Residuos UTAL 2022', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0035' , 3 , 402876, 'internacionalizacion viajes estud extranjero.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0044' , 12 , 160682, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0024' , 2 , 223.2, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0037' , 3 , 362896, 'internacionalizacion viajes estud extranjero.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0022' , 2 , 219.75, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0002' , 7 , 38.01, 'cifras energía y comunidad.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0018' , 13 , 32, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0041' , 3 , 312952.1, 'cometidos internacionales.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0089' , 5 , 2259450, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0042' , 3 , 247753.7, 'cometidos internacionales.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0014' , 14 , 28.56, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0011' , 15 , 13.81, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0079' , 1 , 196265, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0099' , 16 , 347855, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0045' , 12 , 66809, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0036' , 3 , 148610, 'internacionalizacion viajes estud extranjero.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0091' , 10 , 813650, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0050' , 11 , 55.94, 'Estimación Residuos UTAL 2022', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0090' , 17 , 421942, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0023' , 2 , 63.63, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0076' , 10 , 616398, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0030' , 8 , 97961, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0071' , 18 , 101840, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0034' , 3 , 87340, 'internacionalizacion viajes estud extranjero.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0015' , 14 , 8.82, 'cifras energía y comunidad.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0016' , 14 , 7.62, 'cifras energía y comunidad.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0003' , 7 , 7.42, 'cifras energía y comunidad.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0083' , 5 , 450758, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0013' , 19 , 3.5, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0057' , 20 , 9.68, 'resmas_cuenta anual 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0051' , 11 , 19.94, 'Estimación Residuos UTAL 2022', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0064' , 21 , 13808, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0106' , 22 , 141933, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0084' , 9 , 541355, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0072' , 18 , 38007, 'cifras energía y comunidad.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0202' , 4 , 34156, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0105' , 10 , 218999, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0010' , 15 , 2.23, 'cifras energía y comunidad.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0100' , 23 , 52261, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0077' , 9 , 444018, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0103' , 5 , 256548, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0067' , 18 , 28560, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0093' , 9 , 390874, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0087' , 4 , 23183, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0029' , 8 , 23556, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0052' , 11 , 9.18, 'Estimación Residuos UTAL 2022', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0031' , 8 , 20721, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0081' , 23 , 31341, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0043' , 3 , 19559.5, 'cometidos internacionales.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0085' , 16 , 40698, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0046' , 12 , 7203, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0012' , 24 , 1.31, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0017' , 14 , 1.86, 'cifras energía y comunidad.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0078' , 22 , 48760, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0032' , 8 , 13794, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0053' , 11 , 5.07, 'Estimación Residuos UTAL 2022', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0066' , 21 , 3504, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0058' , 20 , 2.37, 'resmas_cuenta anual 2022.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0107' , 9 , 152914, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0101' , 22 , 30317, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0068' , 18 , 8821, 'cifras energía y comunidad.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0063' , 21 , 2232, 'cifras energía y comunidad.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0069' , 18 , 7617, 'cifras energía y comunidad.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0073' , 18 , 7423, 'cifras energía y comunidad.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0028' , 25 , 55941, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0092' , 23 , 10470, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0009' , 15 , 0.44, 'cifras energía y comunidad.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0104' , 23 , 9724, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0048' , 12 , 2382, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0065' , 26 , 1308, 'cifras energía y comunidad.xlsx', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0059' , 20 , 0.87, 'resmas_cuenta anual 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0102' , 16 , 6320, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0047' , 12 , 1076, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0070' , 18 , 1862, 'cifras energía y comunidad.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0060' , 20 , 0.37, 'resmas_cuenta anual 2022.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0062' , 21 , 442, 'cifras energía y comunidad.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0061' , 20 , 0.21, 'resmas_cuenta anual 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0056' , 27 , 8.9, 'Estimación Residuos UTAL 2022', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0027' , 25 , 3713, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0026' , 25 , 2879, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0004' , 28 , 42.5, 'Estimación Residuos UTAL 2022', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0005' , 29 , 1.72, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0025' , 25 , 941, 'Reporte cometidos nacionales 2022.XLSX', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0054' , 30 , 0.8, 'Estimación Residuos UTAL 2022', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0007' , 29 , 0.61, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0008' , 29 , 0.54, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0006' , 29 , 0.48, 'consumos energ¡a, agua y residuos reciclaje.docx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0055' , 31 , 0.2, 'Estimación Residuos UTAL 2022', '', TRUE, 1);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0108' , 32 , 9363, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 5);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0075' , 32 , 653240, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 2);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0082' , 32 , 0, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 4);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0088' , 32 , 0, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 3);
INSERT INTO consumos (id_consumo, id_fuente, cantidad_fuente, link_respaldo, comentarios, huellachile, id_campus) VALUES( 'HDC0204' , 32 , 228063, 'Resultados Encuesta de movilidad 2022.xlsx', '', TRUE, 1);

