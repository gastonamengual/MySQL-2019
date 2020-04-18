use agencia_personal;

/*EJ 1*/
select nro_contrato, fecha_incorporacion, fecha_finalizacion_contrato, adddate(fecha_solicitud, interval 30 day) as 'Fecha Caducidad' 
	from contratos 
    where fecha_caducidad is null;

/*EJ 2*/
select contr.nro_contrato, empr.razon_social, pers.apellido, pers.nombre, contr.fecha_incorporacion, ifnull(contr.fecha_caducidad,'Contrato Vigente') as 'Fin Contrato'
	from contratos contr
    inner join empresas empr on contr.cuit = empr.cuit
    inner join personas pers on contr.dni = pers.dni;

/*EJ 3*/
select *, datediff(fecha_finalizacion_contrato,fecha_caducidad) 
	from contratos 
    where datediff(fecha_finalizacion_contrato,fecha_caducidad) >= 0;

/*EJ 4*/
select contr.cuit, empr.razon_social, empr.direccion, com.anio_contrato, com.mes_contrato, com.importe_comision, adddate(current_date(), interval 2 month)  as 'Fecha Vencimiento'
	from comisiones com 
    inner join contratos contr on com.nro_contrato = contr.nro_contrato
    inner join empresas empr on contr.cuit = empr.cuit
    where com.fecha_pago is null;
    
/*EJ 5*/
select concat(nombre,' ',apellido) 'Nombre y Apellido', day(fecha_nacimiento) 'Día', month(fecha_nacimiento) 'Mes', year(fecha_nacimiento) 'Año' 
    from personas;