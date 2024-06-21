
select * from proyectos 
select * from usuario;
select * from categorias
select * from subcategorias;
select * from alcances;
select * from fuente;
select * from Consumos;

select s.id_subcategoria, c.nombre as Categoria, s.nombre, s.descripcion 
from subcategorias s inner join Categorias c on s.id_categoria = c.id_categoria 

