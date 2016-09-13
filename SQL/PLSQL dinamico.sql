SET SERVEROUTPUT ON;

DECLARE
	ret VARCHAR2(25 BYTE);
	codi TEI_EXPEDIENT.CODI%TYPE;

FUNCTION fn_execute (id NUMBER) RETURN VARCHAR2 IS
    sql_str VARCHAR2(1000);
	BEGIN
		sql_str := 'SELECT CODI FROM TEI_EXPEDIENT WHERE ID = :id';    
		EXECUTE IMMEDIATE sql_str INTO codi USING id;   
		dbms_output.put_line('La consulta ha afectado a ' || SQL%ROWCOUNT || ' filas.');
		RETURN codi; 
	END fn_execute ;

BEGIN
     ret := fn_execute(1);
     dbms_output.put_line(TO_CHAR(ret));
END;