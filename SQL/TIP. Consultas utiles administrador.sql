select * from v$system_parameter;

select value 
from v$system_parameter 
where name = 'db_name';

-- Propietarios de objetos y número de objetos por propietario
select owner, count(owner) Numero 
  from dba_objects 
  group by owner 
  order by Numero desc;
  
-- Muestra los datos de una tabla especificada 
select * 
from ALL_ALL_TABLES 
where upper(table_name) like '%SGJ_DOCUMENT%';

-- Tablas propiedad del usuario actual
select * from user_tables;

-- Todos los objetos propiedad del usuario conectado a Oracle:
select * from user_catalog;

-- Consulta SQL para el DBA de Oracle que muestra los tablespaces, el espacio utilizado, el espacio libre y los ficheros de datos de los mismos
Select t.tablespace_name  "Tablespace",  t.status "Estado",  
    ROUND(MAX(d.bytes)/1024/1024,2) "MB Tamaño",
    ROUND((MAX(d.bytes)/1024/1024) - 
    (SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024),2) "MB Usados",   
    ROUND(SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024,2) "MB Libres", 
    t.pct_increase "% incremento", 
    SUBSTR(d.file_name,1,80) "Fichero de datos"  
FROM DBA_FREE_SPACE f, DBA_DATA_FILES d,  DBA_TABLESPACES t  
WHERE t.tablespace_name = d.tablespace_name  AND 
    f.tablespace_name(+) = d.tablespace_name    
    AND f.file_id(+) = d.file_id GROUP BY t.tablespace_name,   
    d.file_name,   t.pct_increase, t.status ORDER BY 1,3 DESC;
	
-- Reglas de integridad y columna a la que afectan
select constraint_name, column_name from sys.all_cons_columns;

--Tablas de las que es propietario un usuario, en este caso "HR":
SELECT table_owner, table_name 
from sys.all_synonyms 
where table_owner like 'JOVTITUS_ADM';

SELECT DISTINCT TABLE_NAME 
FROM ALL_ALL_TABLES 
WHERE OWNER LIKE 'JOVTITUS_ADM'; 

--Usuarios de Oracle y todos sus datos (fecha de creación, estado, id, nombre, tablespace temporal,...):
Select  * FROM dba_users;

--Tablespaces y propietarios de los mismos:
select owner, decode(partition_name, null, segment_name, 
   segment_name || ':' || partition_name) name, 
   segment_type, tablespace_name,bytes,initial_extent, 
   next_extent, PCT_INCREASE, extents, max_extents 
from dba_segments 
Where 1=1 And extents > 1 order by 9 desc, 3;

--Últimas consultas SQL ejecutadas en Oracle y usuario que las ejecutó:
select distinct vs.sql_text, vs.sharable_mem, 
  vs.persistent_mem, vs.runtime_mem,  vs.sorts,
  vs.executions, vs.parse_calls, vs.module,  
  vs.buffer_gets, vs.disk_reads, vs.version_count, 
  vs.users_opening, vs.loads,  
  to_char(to_date(vs.first_load_time,
  'YYYY-MM-DD/HH24:MI:SS'),'MM/DD  HH24:MI:SS') first_load_time,  
  rawtohex(vs.address) address, vs.hash_value hash_value , 
  rows_processed  , vs.command_type, vs.parsing_user_id  , 
  OPTIMIZER_MODE  , au.USERNAME parseuser  
from v$sqlarea vs , all_users au   
where (parsing_user_id != 0)  AND 
(au.user_id(+)=vs.parsing_user_id)  
and (executions >= 1) order by   buffer_gets/executions desc;

--Todos los ficheros de datos y su ubicación:
select * from V$DATAFILE;

--Tablespaces:
select * from V$TABLESPACE;

--Otras vistas muy interesantes:
select * from V$BACKUP;
select * from V$ARCHIVE;   
select * from V$LOG;   
select * from V$LOGFILE;    
select * from V$LOGHIST;         
select * from V$ARCHIVED_LOG;    
select * from V$DATABASE;

--Cursores abiertos por usuario:
select b.sid, a.username, b.value Cursores_Abiertos
      from v$session a,
           v$sesstat b,
           v$statname c
      where c.name in ('opened cursors current')
      and   b.statistic# = c.statistic#
      and   a.sid = b.sid 
      and   a.username is not null
      and   b.value >0
      order by 3;
	  
--Tamaño ocupado por la base de datos
select sum(BYTES)/1024/1024 MB from DBA_EXTENTS;  --XE

--Tamaño de los ficheros de datos de la base de datos:
select sum(bytes)/1024/1024 MB from dba_data_files;

--Tamaño ocupado por una tabla concreta sin incluir los índices de la misma
select sum(bytes)/1024/1024 MB 
from user_segments
where segment_type='TABLE' and segment_name='NOMBRETABLA'

--Tamaño ocupado por una tabla concreta incluyendo los índices de la misma
select sum(bytes)/1024/1024 Table_Allocation_MB 
from user_segments
where segment_type in ('TABLE','INDEX') and
  (segment_name='NOMBRETABLA' or segment_name in
    (select index_name 
     from user_indexes 
     where table_name='NOMBRETABLA'))

--Tamaño ocupado por una columna de una tabla:
select sum(vsize('NOMBRECOLUMNA'))/1024/1024 MB from NOMBRETABLA;

--Obtener todas las funciones de Oracle: NVL, ABS, LTRIM, ...:
SELECT distinct object_name 
FROM all_arguments 
WHERE package_name = 'STANDARD'
order by object_name;

--Obtener los roles existentes en Oracle Database:
select * from DBA_ROLES;

--Obtener los privilegios otorgados a un rol de Oracle:
select privilege 
from dba_sys_privs 
where grantee = 'NOMBRE_ROL';

--Obtener la IP del servidor de la base de datos Oracle Database:
select utl_inaddr.get_host_address IP from dual 