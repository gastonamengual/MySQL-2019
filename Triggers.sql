/*----------1----------*/
DROP TRIGGER IF EXISTS `afatse`.`inscripciones_AFTER_INSERT`;
DELIMITER $$
USE `afatse`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `alumnos_historico_AFTER_INSERT` AFTER INSERT ON `alumnos_historico` FOR EACH ROW BEGIN
	insert into alumnos_historico values (new.dni, current_timestamp(), new.nombre, new.apellido, new.tel, new.email, new.direccion, current_user());
END$$
DELIMITER ;

/*----------3----------*/
DROP TRIGGER IF EXISTS `afatse`.`inscripciones_AFTER_INSERT`;

DELIMITER $$
USE `afatse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `afatse`.`inscripciones_AFTER_INSERT` AFTER INSERT ON `inscripciones` FOR EACH ROW
BEGIN
	update cursos
    set cant_inscriptos = cant_inscriptos + 1
    where nom_plan = new.nom_plan and nro_curso = new.nro_curso;
END$$
DELIMITER ;

DELIMITER $$
USE `afatse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `afatse`.`inscripciones_AFTER_DELETE` AFTER DELETE ON `inscripciones` FOR EACH ROW
BEGIN
	update cursos
    set cant_inscriptos = cant_inscriptos -1
    where nom_plan = old.nom_plan and nro_curso = old.nro_curso;
END$$
DELIMITER ;


/*----------4----------*/
DROP TRIGGER IF EXISTS `afatse`.`valores_plan_BEFORE_UPDATE`;

DELIMITER $$
USE `afatse`$$
CREATE DEFINER = CURRENT_USER TRIGGER `afatse`.`valores_plan_BEFORE_UPDATE` BEFORE UPDATE ON `valores_plan` FOR EACH ROW
BEGIN
	set new.usuario_alta = current_user();
END$$
DELIMITER ;