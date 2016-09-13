grant all privileges to [1] identified by [2]; 
	[ 1 -> Nuevousuario -> JOVTERRI_ADM][ 2 -> PassWord -> JOVTERRI_ADM ]

create tablespace [1] datafile '[2]' size 10M extent management local;
	[ 1-> NombreTablespace -> JOVTERRI_ADM]
	[ 2-> url donde se creará el tablespace -> C:\Programas\oraclexe\app\oracle\oradata\XE\JOVTERRI_ADM.dbf ] (cada máquina puede ser diferente)

Ejemplos:
create tablespace JOVTERRI_ADM datafile 'C:\Programas\oraclexe\app\oracle\oradata\XE\JOVTERRI_ADM.dbf' size 10M extent management local;
create tablespace JOVTERRI_WEB datafile 'C:\Programas\oraclexe\app\oracle\oradata\XE\JOVTERRI_WEB.dbf' size 10M extent management local;


select * from dba_directories where directory_name ='DATA_PUMP_DIR'; --(SYS	DATA_PUMP_DIR	C:\programas\oraclexe\app\oracle\admin\xe\dpdump\)
--Copiar el fichero dump en el directorio de la consulta


-- Desde el directorio anterior ejecutar -> imp System/Oracle@xe full=y file=[nombreFicheroDump] touser=[nombreUsuario]
Ejemplo: imp System/Oracle@xe full=y log=log.log show=y file=NOTIS_WEB touser=jovnotis_web

-- Alternativas
imp scott/tiger@example file=<file>.dmp fromuser=<source> touser=<dest>

-- Todos los posibles parametros
- file - The name of the export file to import. Multiple files can be listed, separated by commas. When export reaches the filesize it will begin writing to the next file in the list. 
- filesize - The maximum file size, specified in bytes. 
- fromuser - A comma delimited list of schemas from which to import. If the export file contains many users or even the entire database, the fromuser option enables only a subset of those objects (and data) to be imported. 
- full - The entire export file is imported. 
- grants - [Y] Specifies to import object grants. 
- help - Shows command line options for import. 
- ignore - [N] Specifies how object creation errors should be handled. If a table already exists and ignore=y, then the rows are imported to the existing tables, otherwise errors will be reported and no rows are loaded into the table. 
- indexes - [Y] Determines whether indexes are imported. 
- indexfile - Specifies a filename that contains index creation statements. This file can be used to build the indexes after the import has completed. 
- log - The filename used by import to write messages. 
- parfile - The name of the file that contains the import parameter options. This file can be used instead of specifying all the options on the command line. 
- recordlength - Specifies the length of the file record in bytes. This parameter is only used when transferring export files between operating systems that use different default values. 
- resumable - [N] Enables and disables resumable space allocation. When -Y-, the parameters resumable_name and resumable_timeout are utilized. 
- resumable_name - User defined string that helps identify a resumable statement that has been suspended. This parameter is ignored unless resumable = Y. 
- resumable_timeout - [7200 seconds] The time period in which an error must be fixed. This parameter is ignored unless resumable=Y. 
- rows - [Y] Indicates whether or not the table rows should be imported. 
- show - [N] When show=y, the DDL within the export file is displayed. 
- skip_unusable_indexes - [N] Determines whether import skips the building of indexes that are in an unusable state. 
- statistics - [ALWAYS] Determines the level of optimizer statistics that are generated on import. The options include ALWAYS, NONE, SAFE and RECALCULATE. ALWAYS imports statistics regardless of their validity. NONE does not import or recalculate any optimizer statistics. SAFE will import the statistics if they appear to be valid, otherwise they will be recomputed after import. RECALCULATE always generates new statistics after import. 
- streams_configuration - [Y] Determines whether or not any streams metadata present in the export file will be imported. 
- streams_instantiation - [N] Specifies whether or not to import streams instantiation metadata present in the export file. 
- tables - Indicates that the type of export is table-mode and lists the tables to be exported. Table partitions and sub partitions can also be specified. 
- tablespaces - When transport_tablespace=y, this parameter provides a list of tablespaces.
- toid_novalidate - Specifies whether or not type validation should occur on import. Import compares the type-s unique ID (TOID) with the ID stored in the export file. No table rows will be imported if the TOIDs do not match. This parameter can be used to specify types to exclude from TOID comparison. 
- to_user - Specifies a list of user schemas that will be targets for imports. 
- transport_tablespace - [N] When Y, transportable tablespace metadata will be imported from the export file. 
- tts_owners - When transport_tablespace=Y, this parameter lists the users who own the data in the transportable tablespace set. 
- userid - Specifies the userid/password of the user performing the import. 
- volsize - Specifies the maximum number of bytes in an export file on each tape volume. 

To check which options are available in any release of import use:

imp help=y

--Crear la conexion y listo!!!
