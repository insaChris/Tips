-- Ver todas las consstraints
SELECT * FROM all_constraints;

--Tablas desde las que hay una FK que apunta a esta tabla
select table_name
from all_constraints
where constraint_type='R'
and r_constraint_name in 
  (select constraint_name
  from all_constraints
  where constraint_type in ('P','U')
  and table_name='EMPLOYEES');
  

-- Desactivar claves foraneas
select  'ALTER TABLE ' || TABLE_NAME || ' DISABLE CONSTRAINT ' || CONSTRAINT_NAME || ';'
from all_constraints
where constraint_type='R'
and r_constraint_name in 
  (select constraint_name
  from all_constraints
  where constraint_type in ('P','U')
  and table_name='EMPLOYEES');
  
  --FOREING KEYS DE UNA TABLA
  SELECT a.table_name, a.column_name, a.constraint_name, c.owner, 
       -- referenced pk
       c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
 WHERE c.constraint_type = 'R'
   AND a.table_name = :TableName;
   
--TODAS LAS RESTICCIONES de una o varias tablas
   SELECT
    CONS.TABLE_NAME as "En la tabla",
    COLS.COLUMN_NAME as "En la columna",
    CONS.CONSTRAINT_NAME as "Nombre de la restricción",
    CONS_R.TABLE_NAME as "Hacia la tabla",
    COLS_R.COLUMN_NAME as "Hacia la columna",
    CONS.R_CONSTRAINT_NAME as "Nombre de la restricción",
    DECODE (CONS.CONSTRAINT_TYPE,
        'C','Check',
        'P','Primary key',
        'R','Foreing key', 
        'U','Unique',
        'V','V',
        'O','O'
        )as "Tipo de restriccion", CONS.STATUS as "Activa", CONS.GENERATED as "Nombre automatico o usuario", CONS.OWNER as "Propieatario"

FROM USER_CONSTRAINTS CONS  --DBA_CONSTRAINTS describes all constraint definitions in the database -- USER_CONSTRAINTS describes constraint definitions on tables in the current user's schema.
    LEFT JOIN USER_CONS_COLUMNS COLS ON COLS.CONSTRAINT_NAME = CONS.CONSTRAINT_NAME
    LEFT JOIN USER_CONSTRAINTS CONS_R ON CONS_R.CONSTRAINT_NAME = CONS.R_CONSTRAINT_NAME
    LEFT JOIN USER_CONS_COLUMNS COLS_R ON COLS_R.CONSTRAINT_NAME = CONS.R_CONSTRAINT_NAME

-- returns only foreign key constraints
WHERE CONS.CONSTRAINT_TYPE IN ('P', 'U', 'R', 'C')
-- C CHECK
-- O READ ONLY IN A VIEW
-- P PRIMARY KEY
-- R REFERENCIAL (FOREING KEY)
-- U UNIKE KEY
-- V CHECK OPTION ON A VIEW
AND CONS.TABLE_NAME = :TableName
ORDER BY CONS.CONSTRAINT_TYPE, CONS.TABLE_NAME, COLS.COLUMN_NAME;
