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
Ejemplo: imp System/Oracle@xe full=y file=NOTIS_WEB touser=jovnotis_web

--Crear la conexion y listo!!!
