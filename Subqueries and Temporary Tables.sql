use agencia_personal;

/*EJ 1*/
select @dni := dni from personas where nombre = 'Stefania' and apellido = 'Lopez';
    
create temporary table tEmpresas
select cuit from contratos where dni = @dni group by cuit;

select contr.dni, pers.nombre, pers.apellido
	from contratos contr
    inner join tEmpresas on contr.cuit = tEmpresas.cuit
    inner join personas pers on contr.dni = pers.dni
    group by contr.dni;
    
drop temporary table tempresas;

/*EJ 2*/
select @empresa := cuit from empresas where razon_social = 'Viejos Amigos';
select @maxSueldo := max(sueldo) from contratos where cuit = @emcontratospresa;

select contr.dni, concat(pers.apellido,' ',pers.nombre), contr.sueldo
	from contratos contr
    inner join personas pers on contr.dni = pers.dni
    where contr.sueldo < @maxSueldo;

/*EJ 3*/
select @cuit := cuit from empresas where razon_social = 'Traigame eso';

select @avgImp := avg(importe_comision) from comisiones com inner join contratos contr on com.nro_contrato = contr.nro_contrato where contr.cuit = @cuit; 

select contr.cuit, empr.razon_social, avg(importe_comision) 
	from comisiones com 
    inner join contratos contr on com.nro_contrato = contr.nro_contrato 
    inner join empresas empr on contr.cuit = empr.cuit
    group by empr.cuit
    having avg(importe_comision)  > @avgImp; 

/*EJ 4*/
select @avgCom := avg(importe_comision) from comisiones;

select empr.razon_social, pers.nombre, pers.apellido, contr.nro_contrato, com.mes_contrato, com.anio_contrato, com.importe_comision
	from comisiones com
    inner join contratos contr on com.nro_contrato = contr.nro_contrato
    inner join empresas empr on contr.cuit = empr.cuit
    inner join personas pers on contr.dni = pers.dni
    where com.fecha_pago is not null and com.importe_comision < @avgCom;

/*EJ 5*/
create temporary table avgComisiones
select empr.razon_social, avg(com.importe_comision) avgCom
	from comisiones com
    inner join contratos contr on com.nro_contrato = contr.nro_contrato
    inner join empresas empr on contr.cuit = empr.cuit
    group by empr.cuit;
    
select razon_social, max(avgCom) from avgComisiones;

drop temporary table avgComisiones;

/*EJ 6*/
create temporary table titulosNew
select cod_titulo, tipo_titulo from titulos where tipo_titulo != 'Educacion no formal' and tipo_titulo != 'Terciario';

select pers.apellido, pers.nombre, titulosNew.tipo_titulo
	from personas_titulos persTit
    inner join titulosNew on persTit.cod_titulo = titulosNew.cod_titulo
    inner join contratos contr on persTit.dni = contr.dni
    inner join personas pers on contr.dni = pers.dni
    group by pers.dni;

drop temporary table titulosNew;

/*EJ 7*/
create temporary table avgSueldos
select cuit, avg(sueldo) avgs
	from contratos
    group by cuit;
    
select contr.cuit, contr.dni, contr.sueldo, avgSueldos.avgs
	from contratos contr
    inner join avgSueldos on contr.cuit = avgSueldos.cuit
    where contr.sueldo > avgSueldos.avgs;
    
drop temporary table avgSueldos;

use afatse;

/*EJ 9*/
select @dniAnton := dni from alumnos where nombre = 'Antoine de' and apellido = 'Saint-Exupery';
select @num := count(*) from inscripciones where dni = @dniAnton;

select alu.*, count(*), count(*) - @num
	from inscripciones ins
    inner join alumnos alu on ins.dni = alu.dni
    group by alu.dni
    having count(*) > @num;

/*EJ 10*/
create temporary table planCount
select ins.nom_plan, count(*) cant
	from  plan_capacitacion plan
    inner join inscripciones ins on plan.nom_plan = ins.nom_plan
    group by plan.nom_plan;
    
    select * from planCount;
    
select ins.nom_plan , count(ins.nom_plan), (count(ins.nom_plan) * planCount.cant) / 100 Total
	from inscripciones ins
    inner join planCount on ins.nom_plan = planCount.nom_plan
    where ins.fecha_inscripcion > '2014-01-01' and ins.fecha_inscripcion < '2014-12-31'
    group by ins.nom_plan;

drop temporary table planCount;

/*EJ 11*/
create temporary table maxFecha
select max(fecha_desde_plan) mFecha
	from valores_plan
    group by nom_plan;

select * 
	from valores_plan
	inner join maxFecha on valores_plan.fecha_desde_plan = maxFecha.mFecha
    group by nom_plan;
    
drop temporary table maxFecha;

/*EJ 12 ----------------------------------------?*/
create temporary table maxFecha
select max(fecha_desde_plan) mFecha
	from valores_plan
    group by nom_plan;

create temporary table cursos
select * 
	from valores_plan
	inner join maxFecha on valores_plan.fecha_desde_plan = maxFecha.mFecha
    group by nom_plan;
    
select nom_plan, fecha_desde_plan, max(valor_plan) from cursos group by valor_plan;