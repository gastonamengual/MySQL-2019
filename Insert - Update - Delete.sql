/*EJ 1*/
INSERT INTO instructores VALUES ('44-44444444-4','Daniel','Tapia','444-444444','dotapia@gmail.com','Ayacucho 4444',null);

/*EJ 2*/
INSERT INTO plan_capacitacion VALUES 
('Administrador de BD','Instalación y configuración MySQL. Lenguaje SQL. Usuarios y permisos',300,'Presencial');

INSERT INTO plan_temas VALUES
('Administrador de BD','1- Instalación MySQL','Distintas configuraciones de instalación'),
('Administrador de BD','2- Configuración DBMS','Variables de entorno, su uso y configuración'),
('Administrador de BD','3- Lenguaje SQL','DML, DDL y TCL'),
('Administrador de BD','4- Usuarios y Permisos','Permisos de usuarios y DCL');

INSERT INTO examenes VALUES
('Administrador de BD',1),
('Administrador de BD',2),
('Administrador de BD',3),
('Administrador de BD',4);

INSERT INTO examenes_temas VALUES
('Administrador de BD','1- Instalación MySQL',1),
('Administrador de BD','2- Configuración DBMS',2),
('Administrador de BD','3- Lenguaje SQL',3),
('Administrador de BD','4- Usuarios y Permisos',4);

/*EJ 3*/
drop temporary table if exists cursosPres;

create temporary table cursosPres
select distinct(c.nro_curso)
from cursos c inner join plan_capacitacion pc on c.nom_plan = pc.nom_plan
where pc.modalidad = 'presencial' or pc.modalidad = 'semipresencial';

update cursos  c
inner join plan_capacitacion pc on c.nom_plan = pc.nom_plan
set cupo = cupo* 1.5
where (pc.modalidad = 'presencial' or pc.modalidad = 'semipresencial') and c.cupo < 20;

update cursos  c
inner join plan_capacitacion pc on c.nom_plan = pc.nom_plan
set cupo = cupo* 1.25
where (pc.modalidad = 'presencial' or pc.modalidad = 'semipresencial') and c.cupo >= 20;

/*EJ 4 ????*/

/*EJ 5*/
select cuil from instructores  where nombre = 'Henri' and apellido = 'Amiel' into @cuil1; 
select cuil from instructores  where nombre = 'Franz' and apellido = 'Kafka' into @cuil2; 
select cuil from instructores  where nombre = 'Daniel' and apellido = 'Tapia' into @cuil3; 

update instructores 
set cuil_supervisor = @cuil3
where cuil = @cuil1 or cuil = @cuil2;

select @cuil1;
select @cuil2;
select @cuil3;

/*EJ 6*/
select dni from alumnos  where nombre = 'Victor' and apellido = 'Hugo' into @dni1; 

update alumnos
set direccion = 'Italia 2121', tel = '65565'
where dni = @dni1;