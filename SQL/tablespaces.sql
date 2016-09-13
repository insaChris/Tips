------------------------
--Ejecutar como System--
------------------------

-- Todos los datatables
select * from dba_data_files;
select file_name, file_id, relative_fno from dba_data_files;

-- Informacion de todos los tablespaces de la base de datos
SELECT tablespace_name,
   SUM (mbtotal) / 1024 / 1024 mbtotal,
   SUM ( mbtotal - mblibre) / 1024 / 1024 mbusado,
   SUM (mblibre) / 1024 / 1024 mblibre, 
   round(((SUM ( mbtotal - mblibre) / 1024 / 1024) * 100) / (SUM (mbtotal) / 1024 / 1024), 2) Porc_ocu,
   round(((SUM (mblibre) / 1024 / 1024) *100) / (SUM (mbtotal) / 1024 / 1024),2) Porc_libre
 FROM (SELECT tablespace_name, bytes mbtotal, 0 mblibre
         FROM dba_data_files
        UNION ALL
       SELECT tablespace_name, 0 mbtotal, bytes mblibre
         FROM dba_free_space)
 GROUP BY tablespace_name
 order by 6;
 
 -- Crear tablespace
 create tablespace [Nombre_Tablespace] datafile '/users/oradata/orcl/test01.dbf' size 100M;
 
 -- Aumentar el tamaño de un tablespace
 alter datafile '/users/oradata/orcl/test01.dbf' resize 150M; (miamo fihero de la creación);
 
 -- Aumentar el tamño de un tablespace añadiendo mas datafiles
 alter tablespace TEST add datafile '/users/oradata/orcl/test02.dbf' size 50M;
 
 -- Borrar tablespace
 DROP TABLESPACE tbs_a_borrar INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
 
 -- Redimensionar un tablespace
 ALTER DATABASE DATAFILE '/PROD/oradata01/temp_02_PROD.dbf' RESIZE 3G;
 
 --Un tablespace puede estar online u offline, esto indica si se puede operar con él o no. Para conocer el estado de un tablespace se puede consultar con la siguiente sentencia:
 select tablespace_name, status from dba_tablespaces;
