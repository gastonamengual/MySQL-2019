use agencia_personal;

/*INNER JOIN*/
/*EJ 1*/
select contratos.dni, personas.nombre, personas.apellido, contratos.sueldo 
	from contratos 
	inner join personas on contratos.dni = personas.dni where contratos.nro_contrato = 5;

/*EJ 2*/
select contratos.dni, contratos.nro_contrato, contratos.fecha_incorporacion, contratos.fecha_solicitud, ifnull(contratos.fecha_caducidad,'Sin Fecha') as fecha_caducidad 
	from contratos 
	inner join empresas on contratos.cuit = empresas.cuit where empresas.razon_social = 'Viejos Amigos' || empresas.razon_social = 'Tráigame Eso' order by contratos.fecha_incorporacion, empresas.razon_social;

/*EJ 3*/
select empresas.razon_social, empresas.direccion, empresas.e_mail, cargos.desc_cargo, solicitudes_empresas.anios_experiencia 
	from empresas 
	inner join solicitudes_empresas on empresas.cuit = solicitudes_empresas.cuit 
	inner join cargos on solicitudes_empresas.cod_cargo = cargos.cod_cargo 
	order by solicitudes_empresas.fecha_solicitud, cargos.desc_cargo;

/*EJ 4*/
select personas.apellido, personas.nombre, personas.dni, titulos.desc_titulo 
	from personas_titulos 
	inner join personas on personas_titulos.dni = personas.dni 
	inner join titulos on personas_titulos.cod_titulo = titulos.cod_titulo 
	where titulos.tipo_titulo = 'Educacion no formal' or titulos.desc_titulo = 'Bachiller';

/*EJ 5*/
select personas.apellido, personas.nombre, titulos.desc_titulo 
	from personas_titulos 
	inner join personas on personas_titulos.dni = personas.dni
	inner join titulos on personas_titulos.cod_titulo = titulos.cod_titulo;

/*EJ 6*/
/* Referencias?? */

/*EJ 7*/
select solicitudes_empresas.fecha_solicitud as 'Fecha Solicitud', cargos.desc_cargo as 'Cargo', solicitudes_empresas.edad_minima as 'Edad Mín', solicitudes_empresas.edad_maxima as 'Máx' 
	from solicitudes_empresas 
	inner join empresas on solicitudes_empresas.cuit = empresas.cuit
	inner join cargos on solicitudes_empresas.cod_cargo = cargos.cod_cargo 
    where empresas.razon_social = 'Viejos amigos';

/*EJ 8*/
select concat(personas.nombre,' ',personas.apellido) as Postulante, cargos.desc_cargo 
	from antecedentes 
	inner join personas on antecedentes.dni = personas.dni
	inner join cargos antecedentes.cod_cargo = cargos.cod_cargo;

/*EJ 9*/
/* ??? */


/*LEFT/RIGHT JOIN*/
/*EJ 10*/
select empresas.cuit, empresas.razon_social, ifnull(solicitudes_empresas.fecha_solicitud, 'Sin solicitud'), ifnull(cargos.desc_cargo, 'Sin solicitud') 
	from solicitudes_empresas 
	right join empresas on empresas.cuit = solicitudes_empresas.cuit 
	left join cargos on solicitudes_empresas.cod_cargo = cargos.cod_cargo;

/*EJ 11*/
select se.cuit, empr.razon_social, cargos.desc_cargo, ifnull(contr.dni,'Sin contrato') as DNI, ifnull(pers.apellido,'Sin contrato') as Apellido, ifnull(pers.nombre,'Sin contrato') as Nombre
	from solicitudes_empresas se
    inner join empresas empr on se.cuit = empr.cuit
    inner join cargos on se.cod_cargo = cargos.cod_cargo
    left join contratos contr on se.fecha_solicitud = contr.fecha_solicitud
    left join personas pers on contr.dni = pers.dni;

/*EJ 12*/
select se.cuit, empr.razon_social, cargos.desc_cargo
	from solicitudes_empresas se
    inner join empresas empr on se.cuit = empr.cuit
    left join contratos contr on se.fecha_solicitud = contr.fecha_solicitud
    inner join cargos on se.cod_cargo = cargos.cod_cargo
    where contr.fecha_solicitud is null;
    
/*EJ 13*/
select cargos.desc_cargo, contr.dni, pers.apellido, empr.razon_social
	from cargos
	left join contratos contr on cargos.cod_cargo = contr.cod_cargo
    left join empresas empr on contr.cuit = empr.cuit
    left join personas pers on contr.dni = pers.dni;