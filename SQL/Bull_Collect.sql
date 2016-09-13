-- BULK COLLECT es alternativa a un cursor, que ejecuta todas las acciones de una sóla vez, 
-- es más rápido a costa de usar más memoria. Esto se puede subsanar usando la clausula limit
-- de manera que sólo se manejan a la vez el número de registros que le indicas en la clausula.

DECLARE   
   
	TYPE expediente IS TABLE OF TEI_EXPEDIENT%ROWTYPE;       
	itab expediente;   
   
BEGIN   

	-- Cargamos los registros en la colección itab con ayuda de BULK COLLECT
	SELECT *
	BULK COLLECT INTO itab
	FROM TEI_EXPEDIENT
	WHERE rownum < 10;
	  
	-- Iteremos sobre la colección itab para mostrar su contenido
	FOR i IN itab.FIRST .. itab.LAST LOOP     
		dbms_output.put_line('ID: ' || itab(i).id || '-> CODI: ' || itab(i).codi);         
	END LOOP;
	  
 END;
     
	 
-- El mismo ejemplo usando SQl dinámico

DECLARE   
   
	TYPE expediente IS TABLE OF TEI_EXPEDIENT%ROWTYPE;
	itab expediente; 
	v_sql varchar2(256);
   
BEGIN
   
	v_sql := '
    SELECT *      
    FROM TEI_EXPEDIENT
    WHERE rownum < 10';
      
    execute immediate v_sql BULK COLLECT INTO itab;
        
    FOR i IN itab.FIRST .. itab.LAST LOOP     
		dbms_output.put_line('ID: ' || itab(i).id || '-> CODI: ' || itab(i).codi);         
    END LOOP;
 END;