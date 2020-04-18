/*EJ 4*/
update instructores i
inner join cursos_instructores ci on i.cuil = ci.cuil
set i.cuil_supervisor = '66-66666666-6'
where ci.nom_plan = 'Reparac PC Avanzada';

select * from instructores;

/*EJ 5*/
update cursos_horarios ch
inner join cursos_instructores ci on ch.nom_plan = ci.nom_plan and ch.nro_curso = ci.nro_curso
inner join instructores i on ci.cuil = i.cuil
set ch.hora_inicio = date_sub(ch.hora_inicio, interval 1 hour) and ch.hora_fin = date_sub(ch.hora_fin, interval 1 hour)
where i.cuil = '66-66666666-6';