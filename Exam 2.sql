#UNIVERSITY EXAM PASSED WITH 8/10


/*----------DDL----------*/
ALTER TABLE `va_alquileres`.`contrata` 
CHANGE COLUMN `cuil` `cuil` VARCHAR(20) NULL ,
ADD PRIMARY KEY (`NroEvento`, `CodInstalacion`, `fechadesde`, `horadesde`, `CodServicio`),
ADD INDEX `fk1_idx` (`CodServicio` ASC) VISIBLE,
ADD INDEX `fk3_idx` (`cuil` ASC) VISIBLE;
;
ALTER TABLE `va_alquileres`.`contrata` 
ADD CONSTRAINT `fk1`
  FOREIGN KEY (`CodServicio`)
  REFERENCES `va_alquileres`.`servicios` (`CodServicio`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk2`
  FOREIGN KEY (`NroEvento` , `CodInstalacion` , `fechadesde` , `horadesde`)
  REFERENCES `va_alquileres`.`instalaciones_eventos` (`NroEvento` , `CodInstalacion` , `fechadesde` , `horadesde`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk3`
  FOREIGN KEY (`cuil`)
  REFERENCES `va_alquileres`.`empleados` (`cuil`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


/*----------1----------*/
select count(*) into @cantTotal
from contrata;

select s.CodServicio, s.DescServicio, count(*) Cantidad, count(*) / @cantTotal Porcentaje
from servicios s
inner join contrata c on s.CodServicio = c.CodServicio
group by 1,2
order by 4 desc;


/*----------2----------*/
select o.cuit, o.razon_social, ifnull(count(*), 0) CantidadEventos
from organizadores o
left join eventos e on o.cuit = e.CuitOrganizador
where e.fechacontrato between '2016-01-01' and '2016-12-31'
group by 1;


/*----------3----------*/
drop temporary table if exists mfechas;
create temporary table mfechas
select CodServicio, max(fechadesde) mf
from valores_servicios
group by 1;

select ins.CodInstalacion, ins.CodServicio, s.DescServicio, vs.valor
from instalaciones_servicios ins
inner join servicios s on ins.CodServicio = s.CodServicio
inner join valores_servicios vs on ins.CodServicio = vs.CodServicio
inner join mfechas mf on vs.CodServicio = mf.CodServicio and vs.fechadesde = mf.mf;


/*----------4----------*/
select te.CodTipoEvento, te.DescTipoEvento, ifnull(e.NroEvento, 'Sin evento asociado') Evento, ifnull(e.fechacontrato, 'Sin evento asociado') FechaContrato
from tipos_evento te
left join  eventos e on te.CodTipoEvento = e.CodTipoEvento;


/*----------5----------*/
select fechacontrato into @fechaEvento
from eventos
where NroEvento = 5;

drop temporary table if exists mfechas;
create temporary table mfechas
select CodServicio, max(fechadesde) mf
from valores_servicios
where fechadesde <= @fechaEvento
group by 1;

select sum(vs.valor * c.cantidad) into @totalServicios
from contrata c
inner join valores_servicios vs on c.CodServicio = vs.CodServicio
inner join mfechas mf on vs.CodServicio = mf.CodServicio and vs.fechadesde = mf.mf
where c.NroEvento = 5;

update instalaciones_eventos
set valorpactado = valorpactado + (@totalServicios * 8) / 100
where NroEvento = 5;


/*----------6----------*/

USE `va_alquileres`;
DROP procedure IF EXISTS `sp_registrarEvento`;

DELIMITER $$
USE `va_alquileres`$$
CREATE PROCEDURE `sp_registrarEvento` (in descripcion varchar(20), in representante varchar(50), in telrepresentante varchar(20), in CuitOrganizador varchar(20), in CuilEmpleado varchar(20))
BEGIN
	start transaction;
    
	select max(NroEvento) + 1 into @nroEvento from eventos;
	select CodTipoEvento into @codTipoEvento from tipos_evento where DescTipoEvento = descripcion;

	insert into eventos
	values (@nroEvento, curdate(), representante, telrepresentante, @codTipoEvento, CuitOrganizador, CuilEmpleado);
    
	commit;

END$$

DELIMITER ;

call sp_registrarEvento('Recital', 'Gastón', 123, '66-66666666-6', '11-11111111-1');
