-- 1. Show the possible values of the year column int he country stats table sorted by most recent year first

select distinct year
    from country_stats
    order by year desc;


-- 2. Show the names of the first 5 countries in the database when sorted in alphabetical order by name.

select distinct name
    from countries
    order by name 
    limit 5;

-- 3. Adjust the previous query to show both the country name and the gdp from 2018, but this time show the top 5 countries by gdp


select country.name, stats.gdp
    from countries as country
    join country_stats as stats
        on country.country_id = stats.country_id
    where stats.year = 2018
    order by stats.gdp desc
    limit 5;

-- 4.How many countries are associated with each region id?

select region_id, count(1) as country_count
    from countries
    group by region_id
    order by count(1) desc;

-- 5. Whats the average area of countries in each region id?

select region_id, round(avg(area)) as avg_area
    from countries
    group by region_id
    order by avg_area;

-- 6. Use the same query as above, but only show the groups with an average country area less than 1000

select region_id, round(avg(area)) as avg_area
    from countries
    group by region_id
    having round(avg(area)) < 1000
	order by avg_area;

-- 7. Create a report displaying the name and population of every continent in the database from the year 2018 in millions.
select c.name, round((sum(stats.population::decimal)/1000000),2) as tot_pop
    from continents as c
    join regions as r
        on c.continent_id = r.continent_id
    join countries as cs
        on r.region_id = cs.region_id
    join country_stats as stats
        on cs.country_id = stats.country_id
	where stats.year = 2018
	group by c.name
	order by tot_pop desc;

-- 8. List the names of all of the countries that do not have a language

select name 
    from countries as c
    full outer join country_languages as cl
        on c.country_id = cl.country_id
    where official is null
    order by name ;

-- 9. Show the country name and number of associated languages of the top 10 countries with the most languages

select c.name, count(1) as lang_count 
	from countries as c
	join country_languages as cl
		on c.country_id = cl.country_id
	group by c.name
	order by  count(1) desc, name asc
	limit 10;

-- 10. Repeat your previous query, but display a comma separated list of spoken languages rather than a count (use the aggregate function for strings, string_agg. A single example row (note that results before and above have been omitted for formatting):

select c.name, string_agg(l.language, ',') 
	from countries as c
	join country_languages as cl
		on c.country_id = cl.country_id
	join languages as l
		on l.language_id = cl.language_id
	group by c.name
	order by c.name;


-- 11. What's the average number of languages in every country in a region in the dataset? Show both the region's name and the average. Make sure to include countries that don't have a language in your calculations. (Hint: using your previous queries and additional subqueries may be useful)
	
select r.name,round(avg(counts.lang_count),1) as avg_lang_count_per_country from (select c.name, c.region_id, count(1) as lang_count
	from countries as c
	left join country_languages as cl
		on c.country_id = cl.country_id
	group by c.name, c.region_id) counts
	join regions as r
		on r.region_id = counts.region_id
	group by r.name
	order by avg_lang_count_per_country desc;


--Show the country name and its "national day" for the country with the most recent national day and the country with the oldest national day. Do this with a single query. (Hint: both subqueries and UNION may be helpful here). The output may look like this:

select name, national_day
from countries 
where national_day =(select max(national_day) from countries) or national_day = (select min(national_day) from countries)
order by national_day desc;