create user 'gaston' @'localhost' identified by 'gaston';

set password for  'gaston' @'localhost' = 'gaston2';

grant select on afatse.* to  'gaston' @'localhost';

grant insert on afatse.alumnos to  'gaston' @'localhost';
grant update on afatse.alumnos to  'gaston' @'localhost';
grant delete on afatse.alumnos to  'gaston' @'localhost';

revoke select on afatse.alumnos from 'gaston' @'localhost';
revoke all privileges, grant option from 'gaston' @'localhost';

grant insert on afatse.vw_alumnos to  'gaston' @'localhost';
grant update on afatse.vw_alumnos to  'gaston' @'localhost';
grant delete on afatse.vw_alumnos to  'gaston' @'localhost';