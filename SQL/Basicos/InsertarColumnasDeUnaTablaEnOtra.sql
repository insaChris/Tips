SELECT INTO
Selecciona un conjunto de filas de una tabla y las inserta en una nueva tabla

SELECT column_name(s)
INTO newtable [IN externaldb]
FROM table1;


INSERT INTO SELECT
Selecciona datos de una tabla y los inserta en una tabla existente

INSERT INTO table2
SELECT * FROM table1;

INSERT INTO table2
(column_name(s))
SELECT column_name(s)
FROM table1;
