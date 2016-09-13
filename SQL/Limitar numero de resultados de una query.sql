--Limitar el numero de resultados
select *
from (
	select * 
	from emp 
	order by sal desc 
	) 
where ROWNUM <= 5;

-- Limitar el numero de resultados en un rango
select * 
from ( 
	select a.*, ROWNUM rnum 
	from 
	( <your_query_goes_here, with order by> ) a 
	where ROWNUM <= :MAX_ROW_TO_FETCH 
	)
where rnum  >= :MIN_ROW_TO_FETCH;

-- -> Mi modificación sobre la query anteriorn (devuelve las 10 primeras)
select b.id 
from( 
	select a.id, ROWNUM rnum 
	from ( 
		SELECT id 
		from TEI_DADES_DOCUMENT 
		order by id ) a 
    where ROWNUM <= 10 ) b  --:MAX_ROW_TO_FETCH
where rnum  >= 0;       --:MIN_ROW_TO_FETCH