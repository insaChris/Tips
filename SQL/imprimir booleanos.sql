-- OPCION 1
DECLARE
l_test BOOLEAN:=TRUE;
BEGIN
dbms_output.put_line(
   case
      when l_test then 'TRUE'
      when l_test is null then 'NULL'
      else 'FALSE'
   end
);
END;


-- OPCION 2
	--Funcion 
FUNCTION BOOLEAN_TO_CHAR(FLAG IN BOOLEAN)
RETURN VARCHAR2 IS
BEGIN
  RETURN
   CASE FLAG
	 WHEN TRUE THEN 'TRUE'
	 WHEN FALSE THEN 'FALSE'
	 ELSE 'NULL'
   END;
END;

	--Llamada
BOOLEAN_TO_CHAR(commitFinal)