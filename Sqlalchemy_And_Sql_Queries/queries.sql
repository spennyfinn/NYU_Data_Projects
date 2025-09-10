

--2. Use the Window Function, rank()
select * from
(select region, event, count(medal) as gold_medal,
rank() over (partition by event order by count(medal) desc) as rank
	from medal_event
	where event like '%Fencing%' and medal ilike '%gold%' 
	group by region, event
	order by event, rank)
	where rank <=3;

-- 3. Using Aggregate Functions as Window Functions
select region, year, medal, count(*) as c,
	sum(count(*)) over (partition by region, medal order by year, medal ) as sum
	from medal_event
	group by medal, region, year
	order by region, year, medal;

-- 4. Use the Window Function, lag()
select event, year, height, 
	lag(height, 1, null) over (partition by event order by  year)
	from medal_event
	where medal like 'Gold' and event ilike '%pole vault%' and height is not null
	order by event, year;
