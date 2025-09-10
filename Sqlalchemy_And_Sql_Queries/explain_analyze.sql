-- TODO: use explain / analyze, create an index


--1. Drop an existing index
drop index if exists athlete_event_name_idx;


--2. Write a simple query
select event, year, height, 
	lag(height, 1, null) over (partition by event order by  year)
	from medal_event
	where medal like 'Gold' and event ilike '%pole vault%' and height is not null
	order by event, year;


-- 3. using EXPLAIN ANALYZE
explain analyze
select * 
	from athlete_event 
	where name like 'Michael Fred Phelps, II';

/*"Gather  (cost=1000.00..8252.36 rows=3 width=136) (actual time=15.283..21.258 rows=30 loops=1)"
"  Workers Planned: 2"
"  Workers Launched: 2"
"  ->  Parallel Seq Scan on athlete_event  (cost=0.00..7252.06 rows=1 width=136) (actual time=15.037..16.407 rows=10 loops=3)"
"        Filter: (name ~~ 'Michael Fred Phelps, II'::text)"
"        Rows Removed by Filter: 90362"
"Planning Time: 0.094 ms"
"Execution Time: 21.281 ms"*/

-- 4. Add an index:
create index athlete_event_name_idx on athlete_event (name);

--5.Verifying improved performance:

explain analyze
select * 
	from  athlete_event
	where name like 'Michael Fred Phelps, II';

/*"Bitmap Heap Scan on athlete_event  (cost=4.45..16.28 rows=3 width=136) (actual time=0.039..0.045 rows=30 loops=1)"
"  Filter: (name ~~ 'Michael Fred Phelps, II'::text)"
"  Heap Blocks: exact=1"
"  ->  Bitmap Index Scan on athlete_event_name_idx  (cost=0.00..4.45 rows=3 width=0) (actual time=0.024..0.024 rows=30 loops=1)"
"        Index Cond: (name = 'Michael Fred Phelps, II'::text)"
"Planning Time: 0.321 ms"
"Execution Time: 0.060 ms"*/


-- 6. Ignoring and index

explain analyze
select * 
	from  athlete_event
	where name like 'Michael Fred Phelps, II' or noc = 'SGP';
/*"Gather  (cost=1000.00..8565.58 rows=311 width=136) (actual time=0.525..24.713 rows=379 loops=1)"
"  Workers Planned: 2"
"  Workers Launched: 2"
"  ->  Parallel Seq Scan on athlete_event  (cost=0.00..7534.48 rows=130 width=136) (actual time=0.706..20.108 rows=126 loops=3)"
"        Filter: ((name ~~ 'Michael Fred Phelps, II'::text) OR ((noc)::text = 'SGP'::text))"
"        Rows Removed by Filter: 90246"
"Planning Time: 0.199 ms"
"Execution Time: 24.760 ms"*/
