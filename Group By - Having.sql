use agencia_personal;

/*EJ 1*/
select empr.razon_social, sum(com.importe_comision ) as 'Importe Total'
	from comisiones com 
    inner join contratos contr on com.nro_contrato = contr.nro_contrato
    inner join empresas empr on contr.cuit = empr.cuit
    where empr.razon_social = "Traigame eso"
    group by empr.razon_social;

/*EJ 2*/
select empr.razon_social, sum(com.importe_comision ) as 'Importe Total'
	from comisiones com 
    inner join contratos contr on com.nro_contrato = contr.nro_contrato
    inner join empresas empr on contr.cuit = empr.cuit
    group by empr.razon_social;

/*EJ 3*/
select entr.nombre_entrevistador, entrEval.cod_evaluacion, avg(entrEval.resultado) as 'Promedio', std(entrEval.resultado) as 'Desvío'
	from entrevistas_evaluaciones entrEval
    inner join entrevistas entr on entrEval.nro_entrevista = entr.nro_entrevista
    group by entr.nombre_entrevistador, entrEval.cod_evaluacion
    order by avg(entrEval.resultado), std(entrEval.resultado);

/*EJ 4*/
select entr.nombre_entrevistador, entrEval.cod_evaluacion, avg(entrEval.resultado) as 'Promedio', std(entrEval.resultado) as 'Desvío'
	from entrevistas_evaluaciones entrEval
    inner join entrevistas entr on entrEval.nro_entrevista = entr.nro_entrevista
    group by entr.nombre_entrevistador, entrEval.cod_evaluacion
    having entr.nombre_entrevistador = 'Angelica Doria' and avg(entrEval.resultado) > 71
    order by avg(entrEval.resultado), std(entrEval.resultado);
    
/*EJ 5*/
select entr.nombre_entrevistador, count(entr.nro_entrevista) / 3 as 'Cantidad de entrevistas'
	from entrevistas entr
    inner join entrevistas_evaluaciones entrEval on entrEval.nro_entrevista = entr.nro_entrevista
    group by entr.nombre_entrevistador;

/*EJ 6*/
select entr.nombre_entrevistador, count(entr.nro_entrevista) as 'Cantidad de Entrevistas', entrEval.cod_evaluacion, avg(entrEval.resultado) as 'Promedio', std(entrEval.resultado) as 'Desvío'
	from entrevistas_evaluaciones entrEval
    inner join entrevistas entr on entrEval.nro_entrevista = entr.nro_entrevista
    group by entr.nombre_entrevistador, entrEval.cod_evaluacion
    having avg(entrEval.resultado) > 71
    order by avg(entrEval.resultado), std(entrEval.resultado);

/*EJ 7*/
select entr.nombre_entrevistador, count(entr.nro_entrevista) as 'Cantidad de Entrevistas', entrEval.cod_evaluacion, avg(entrEval.resultado) as 'Promedio', std(entrEval.resultado) as 'Desvío'
	from entrevistas_evaluaciones entrEval
    inner join entrevistas entr on entrEval.nro_entrevista = entr.nro_entrevista
    group by entr.nombre_entrevistador, entrEval.cod_evaluacion
    having count(entr.nro_entrevista) > 1
    order by avg(entrEval.resultado), std(entrEval.resultado);

/*EJ 8*/
select contr.nro_contrato, count(com.nro_contrato) as 'Total', count(com.fecha_pago) as 'Pagadas', sum(isnull(com.fecha_pago)) as 'No pagadas' 
	from comisiones com
    inner join contratos contr on com.nro_contrato = contr.nro_contrato
    group by contr.nro_contrato;
    
/*EJ 9*/
select contr.nro_contrato, count(com.nro_contrato) as 'Total', 
truncate(count(com.fecha_pago) * 100 / (sum(isnull(com.fecha_pago)) + count(com.fecha_pago) ), 0) as 'Pagadas', 
truncate(sum(isnull(com.fecha_pago)) * 100 / (sum(isnull(com.fecha_pago)) + count(com.fecha_pago) ), 0)as 'No pagadas' 
	from comisiones com
    inner join contratos contr on com.nro_contrato = contr.nro_contrato
    group by contr.nro_contrato;
    
/*EJ 10*/
SELECT count(distinct se.cuit) into @cantcuit
FROM solicitudes_empresas se;

select count(*) , count(*) - @cantcuit
from solicitudes_empresas se;

/*EJ 11*/
select se.cuit, empr.razon_social, count(*) as 'Cantidad de solicitudes'
	from	solicitudes_empresas se
	inner join empresas empr on se.cuit = empr.cuit
    group by empr.razon_social;
    
/*EJ 12*/
select se.cuit, empr.razon_social, cargos.desc_cargo, count(*) as 'Cantidad de solicitudes'
	from	solicitudes_empresas se
	inner join empresas empr on se.cuit = empr.cuit
    inner join cargos on se.cod_cargo = cargos.cod_cargo
    group by empr.razon_social, cargos.desc_cargo;

/*EJ 13*/
select empr.cuit, empr.razon_social, ifNull(count(empr.cuit),0) as 'Cantidad de personas'
	from empresas empr
    left join antecedentes on empr.cuit = antecedentes.cuit
    group by empr.razon_social;

/*EJ 14*/
select cargos.cod_cargo, cargos.desc_cargo, ifnull(count(se.cod_cargo), 0) as 'Cantidad de solicitudes'
	from cargos
    left join solicitudes_empresas se on cargos.cod_cargo = se.cod_cargo
    group by cargos.desc_cargo;
    
/*EJ 15*/
select cargos.cod_cargo, cargos.desc_cargo, ifnull(count(se.cod_cargo), 0) as 'Cantidad de solicitudes'
	from cargos
    left join solicitudes_empresas se on cargos.cod_cargo = se.cod_cargo
    group by cargos.desc_cargo
    having count(se.cod_cargo) < 2;