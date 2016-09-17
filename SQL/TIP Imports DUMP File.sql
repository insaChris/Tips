------------------------------------------------
-- Sentencias tablespaces
------------------------------------------------
create tablespace JOVGEIJ_ADM datafile 'C:\Programas\oraclexe\app\oracle\oradata\XE\JOVGEIJ_ADM.dbf' size 40M extent management local;
create tablespace JOVGEIJ_WEB datafile 'C:\Programas\oraclexe\app\oracle\oradata\XE\JOVGEIJ_ADM.dbf' size 20M extent management local;

--ALERTA: El tablespace no crece automáticamente al hacer un import

DROP tablespace JOVGEIJ_ADM INCLUDING CONTENTS and DATAFILES CASCADE CONSTRAINTS;
DROP tablespace JOVGEIJ_WEB INCLUDING CONTENTS and DATAFILES CASCADE CONSTRAINTS;

ALTER DATABASE DATAFILE 'C:\PROGRAMAS\ORACLEXE\APP\ORACLE\ORADATA\XE\JOVNOTIS.DBF' RESIZE 50M; commit;

select tablespace_name, status from dba_tablespaces;

------------------------------------------------
-- Sentencias users
------------------------------------------------
CREATE USER JOVGEIJ_ADM IDENTIFIED BY JOVGEIJ_ADM DEFAULT TABLESPACE JOVGEIJ_ADM;
CREATE USER JOVGEIJ_WEB IDENTIFIED BY JOVGEIJ_WEB DEFAULT TABLESPACE JOVGEIJ_WEB;

DROP USER JOVGEIJ_ADM CASCADE;
DROP USER JOVGEIJ_WEB CASCADE; 

GRANT ALL PRIVILEGES TO JOVGEIJ_ADM IDENTIFIED BY JOVGEIJ_ADM;
GRANT ALL PRIVILEGES TO JOVGEIJ_WEB;

commit;

------------------------------------------------
-- Sentencia para hacer un import de un DUMP
------------------------------------------------
imp System/Oracle@xe full=y file=GEIJ_WEB touser=JOVGEIJ_WEB

------------------------------------------------
-- información de los tablespaces (2 selects similares)
------------------------------------------------
SELECT NVL(b.tablespace_name, 
       NVL(a.tablespace_name,'UNKOWN')) name, 
       round(kbytes_alloc/1024,2) Mbytes, 
       round((kbytes_alloc-NVL(kbytes_free,0))/1024,2) used, 
       round(NVL(kbytes_free,0)/1024,2) free, 
       round(((kbytes_alloc-NVL(kbytes_free,0))/kbytes_alloc)*100,2) pct_used
FROM ( SELECT SUM(bytes)/1024 Kbytes_free, 
              tablespace_name 
       FROM  sys.dba_free_space 
       GROUP BY tablespace_name ) a, 
     ( SELECT SUM(bytes)/1024 Kbytes_alloc, 
                          SUM(maxbytes)/1024 kbytes_max, 
              tablespace_name 
       FROM sys.dba_data_files 
       GROUP BY tablespace_name )b 
WHERE a.tablespace_name (+) = b.tablespace_name 
ORDER BY PCT_USED;


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

------------------------------------------------
-- Ruta en el disco duro de los tablespaces
------------------------------------------------
SELECT TABLESPACE_NAME, FILE_NAME, BLOCKS FROM DBA_DATA_FILES;
SELECT * FROM DBA_DATA_FILES;