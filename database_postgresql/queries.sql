
select * from proyectos 
select * from usuario;
select * from categorias
select * from subcategorias;
select * from alcances;
select * from fuente;
select * from Consumos;

-- Subcategoria
select s.id_subcategoria, c.nombre as Categoria, s.nombre, s.descripcion 
from subcategorias s inner join Categorias c on s.id_categoria = c.id_categoria 

-- Proyectos
SELECT id_proyecto, nombre, descripcion FROM proyectos;

-- Campus x proyecto
SELECT c.id_campus, c.nombre as nombreCampus, c.id_proyecto, p.nombre as nombreProyecto, c.huella_de_carbono, c.huella_hidrica, c.huella_financiera
FROM campus c inner join proyectos p on c.id_proyecto = p.id_proyecto;

-- Usuario x proyecto y campus
SELECT u.id_usuario, u.id_proyecto, u.id_campus, u.nombre, u.correo, u.tipo_usuario, u.activo, 
c.nombre as nombreCampus, p.nombre as nombreProyecto
FROM usuario u INNER JOIN campus c on u.id_campus = c.id_campus 
INNER JOIN proyectos p ON c.id_proyecto = p.id_proyecto;

-- Unidad Fuente
SELECT id_unidad_fuente, nombre, sigla FROM unidad_fuente;

-- Unidad Factor Emision
SELECT id_unidad_factor_emision, nombre from unidad_factor_emision;

-- Tipos gas GEI
SELECT id_gas_gei, nombre, sigla FROM tipos_gas_gei;