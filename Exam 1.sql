#UNIVERSITY EXAM PASSED WITH 10/10

/*Ej 1*/
select a.*, count(e.cuit_artista) cantidad
from artista a
left join espectaculo e on a.cuit = e.cuit_artista
group by a.cuit;


/*Ej 2*/
select pa.dni_persona, p.nombre, p.apellido, count(pa.puesto) 'Cantidad de veces'
from participante pa
inner join persona p on pa.dni_persona = p.dni
where pa.puesto = 1 or pa.puesto = 2 or pa.puesto = 3
group by pa.dni_persona
having count(pa.puesto) >= 1;


/*Ej 3*/
drop temporary table if exists tc18;
create temporary table tc18
select distinct(codigo_tipo_competencia) ctc
from competencia
where year(fecha_hora_ini) = '2018';

select tc18.ctc, tc.descripcion
from tc18
inner join tipo_competencia tc on tc18.ctc = tc.codigo
where tc18.ctc not in (
	select distinct(codigo_tipo_competencia) ctc
	from competencia
	where year(fecha_hora_ini) = '2019'
);


/*Ej 4*/
drop temporary table if exists maxFechas;
create temporary table maxFechas
select codigo_recurso, max(fecha_desde) mFecha
from valor_diario
group by codigo_recurso;

drop temporary table if exists valAct;
create temporary table valAct
select vd.codigo_recurso, vd.valor
from valor_diario vd
inner join maxFechas mf on vd.codigo_recurso = mf.codigo_recurso and vd.fecha_desde = mf.mFecha;

select avg(valor) into @avgVal from valAct;

select r.codigo, r.descripcion, va.valor, va.valor - @avgVal 'Diferencia'
from recurso r
inner join valAct va on r.codigo = va.codigo_recurso
where va.valor > @avgVal;


/*Ej 5*/
start transaction;

select max(nro)+1 into @num from evento;
insert into evento
	select @num, descripcion, adddate(fecha_hora_ini, interval 1 year), adddate(fecha_hora_fin, interval 1 year)
	from evento 
    where descripcion = 'torneo asado y show de guasones';
    
insert into espectaculo
	select @num, es.nro_espectaculo, es.nombre, 
			adddate(es.fecha_hora_ini, interval 1 year), adddate(es.fecha_hora_fin, interval 1 year),
			es.costo_cont, es.cuit_artista, es.codigo_lugar
		from espectaculo es
		inner join evento e on es.nro_evento = e.nro
		where e.descripcion = 'torneo asado y show de guasones';

commit;


/*Ej 6*/
CREATE DEFINER=`root`@`localhost` FUNCTION `cantLug`(codLug int(10), fecha varchar(4)) RETURNS int(11)
BEGIN
	select count(e.codigo_lugar) into @cant
	from lugar l
	inner join espectaculo e on l.codigo = e.codigo_lugar
	where l.codigo = codLug and year(e.fecha_hora_ini) = fecha;
	RETURN @cant; 
END

select codigo, nombre, cantLug(codigo,'2019') from lugar;

