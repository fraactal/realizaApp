
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


-- Factores de Emision
SELECT fde.id_factor_emision, fde.id_Fuente, f.nombre as fuente_emision, fde.origen_del_fe, fde.incertidumbre,
ufe.nombre as unidad_fuente,  -- unidad_factor_emision
vfe.valor, -- valor_unidad_x_factor_emision
tgg.sigla as gei, tgg.nombre as nombre_gei -- tipos_gas_gei
-- fde.combustible, fde.id_unidad_factor_emision, ufe.id_unidad_factor_emision, vfe.id_factor_emision, vfe.id_gas_gei, 
from factor_de_emision fde 
inner join unidad_factor_emision ufe on fde.id_unidad_factor_emision = ufe.id_unidad_factor_emision
inner join valor_unidad_x_factor_emision vfe on fde.id_factor_emision = vfe.id_factor_emision
inner join tipos_gas_gei tgg on vfe.id_gas_gei = tgg.id_gas_gei 
inner join fuente f on fde.id_fuente = f.id_fuente;


--- Fuente
select id_fuente, f.nombre as Fuente, uf.nombre as Unidad, uf.sigla as Sigla_unidad, a.nombre as Alcance, c.nombre as Categoria, s.nombre as SubCategoria
from fuente f
inner join unidad_fuente uf on f.id_unidad_fuente = uf.id_unidad_fuente 
inner join alcances a on a.id_alcances = f.id_alcances 
inner join categorias c on f.id_categoria = c.id_categoria 
inner join subcategorias s on s.id_subcategoria = f.id_subcategoria 

-- Consumos

select c.id_consumo, f.nombre as fuente, c.cantidad_fuente, c.link_respaldo ,
c.comentarios, c.huellachile, camp.nombre as campus
-- , p.nombre as Proyecto
from consumos c 
inner join fuente f on f.id_fuente = c.id_fuente 
inner join campus camp on c.id_campus = camp.id_campus;
--inner join proyectos p on p.id_proyecto = camp.id_proyecto;


-- Consumos x Sede
-- Al sumar los factores, se multiplica por cantidad consumo
select sum(vfe.valor) as sumaFactorEmision, (sum(vfe.valor)*c.cantidad_fuente) as emision, ufe.nombre as unidadFactor, uf.nombre as Unidadfuente, -- uf.sigla ,
f.nombre as fuente_emision,c.cantidad_fuente, camp.nombre as campus, c.id_consumo, a.nombre as alcance, c2.nombre as categoria
-- select vfe.valor, f.nombre as fuente_emision, c.cantidad_fuente, c.id_consumo, camp.nombre, tgg.nombre
from factor_de_emision fde 
inner join unidad_factor_emision ufe on fde.id_unidad_factor_emision = ufe.id_unidad_factor_emision
inner join valor_unidad_x_factor_emision vfe on fde.id_factor_emision = vfe.id_factor_emision
inner join tipos_gas_gei tgg on vfe.id_gas_gei = tgg.id_gas_gei 
inner join fuente f on fde.id_fuente = f.id_fuente
inner join unidad_fuente uf  on uf.id_unidad_fuente = f.id_unidad_fuente 
inner join consumos c on c.id_fuente = f.id_fuente 
inner join campus camp on camp.id_campus  = c.id_campus
inner join alcances a on a.id_alcances = f.id_alcances 
inner join categorias c2 on c2.id_categoria = f.id_categoria 
-- where fuente_emision = 'Bienes adquiridos - Gas licuado de petróleo'
-- fuente_emision = 'General - Gas licuado de petróleo' 
where camp.nombre = 'TALCA'
group by f.nombre,  c.cantidad_fuente, camp.nombre, 
c.id_consumo, unidadFactor, uf.nombre, uf.sigla, a.nombre, c2.nombre
 order by c.id_consumo asc;
