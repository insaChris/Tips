-- Ejecutar como script
SET SERVEROUTPUT ON;
DECLARE
  valor_A_Buscar VARCHAR2(100) := 'Sales';
type array_t
IS
  TABLE OF VARCHAR2(32767);
  registres array_t;
  taula_impresa BOOLEAN := false;
  trovat        BOOLEAN := false;
BEGIN
  FOR t IN
  (
    SELECT
      TABLE_NAME
    FROM
      USER_TABLES
  )
  LOOP
    FOR c IN
    (
      SELECT
        COLUMN_NAME
      FROM
        USER_TAB_COLUMNS
      WHERE
        DATA_TYPE LIKE '%CHAR%'
      AND TABLE_NAME = t.table_name
    )
    LOOP
      EXECUTE IMMEDIATE 'SELECT ' || c.column_name || ' FROM ' || t.table_name
      || ' WHERE '||c.column_name||' LIKE ''%' || valor_A_Buscar ||'%''' BULK
      COLLECT INTO registres;
      IF registres.count > 0 THEN
        trovat          := true;
        IF (NOT taula_impresa) THEN
          DBMS_OUTPUT.PUT_LINE('Tabla: '||t.table_name);
        END IF;
        DBMS_OUTPUT.PUT_LINE('Columna: '||c.column_name);
        FOR col IN 1..registres.count
        LOOP
          DBMS_OUTPUT.PUT_LINE('Valor: '||registres(col));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(
        '-----------------------------------------------------');
      END IF;
    END LOOP;
  END LOOP;
  IF (NOT trovat) THEN
    DBMS_OUTPUT.PUT_LINE('Valor no trovat');
  END IF;
END;
