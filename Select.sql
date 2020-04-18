use agencia_personal;

/*EJ 1*/
desc empresas;
select * from empresas;

/*EJ 2*/
desc personas;
select apellido, nombre, fecha_registro_agencia from personas;

/*EJ 3*/
select cod_titulo, desc_titulo, tipo_titulo from titulos order by desc_titulo;

/*EJ 4*/
select apellido, nombre, fecha_nacimiento, telefono, direccion from personas where dni = 28675888;

/*EJ 5*/
select apellido, nombre, fecha_nacimiento, telefono, direccion from personas where dni = 28675888 or dni = 29345777 or dni = 31345778 order by fecha_nacimiento; 

/*EJ 6*/
select apellido, nombre, fecha_nacimiento, telefono, direccion, fecha_registro_agencia from personas where apellido like 'g%';

/*EJ 7*/
select apellido, nombre, fecha_nacimiento from personas where fecha_nacimiento between '1980-01-01' and '2000-12-31';

/*EJ 8*/
select * from solicitudes_empresas order by fecha_solicitud;

/*EJ 9*/
select * from antecedentes where fecha_hasta is null order by fecha_desde;

/*EJ 10*/
select * from antecedentes where fecha_hasta is not null and fecha_desde not between '2013-06-01' and '2013-12-31';

/*EJ 11*/
select * from contratos where sueldo > 2000 and (cuit = '30-10504876-5' or cuit = '30-21098732-4');

/*EJ 12*/
select * from titulos where desc_titulo like '%tecnico%';

/*EJ 13*/
select * from solicitudes_empresas where (fecha_solicitud > '2013-09-21' and cod_cargo = 6) or sexo = 'femenino';

/*EJ 14*/
select * from contratos where sueldo > 2000 and fecha_caducidad is null;