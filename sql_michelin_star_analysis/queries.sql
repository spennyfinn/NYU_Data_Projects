-- write your queries underneath each number:
 
-- 1. the total number of rows in the database
select count(id) from michelin_guide;

-- 2. show the first 15 rows, but only display 3 columns (your choice)
select id, restaurant, stars
    from michelin_guide 
    limit 15;
-- 3. do the same as above, but chose a column to sort on, and sort in descending order
select id, restaurant, stars
    from michelin_guide 
    order by id desc
    limit 15;
-- 4. add a new column without a default value
alter table michelin_guide 
add column price varchar(4);
-- 5. set the value of that new column
update michelin_guide set price = '$' where lower_price < 50;
update michelin_guide set price = '$$' where lower_price < 100 and lower_price >= 50;
update michelin_guide set price = '$$$' where lower_price < 150 and lower_price >= 100;
update michelin_guide set price = '$$$$' where lower_price >= 150;
-- 6. show only the unique (non duplicates) of a column of your choice
select distinct price from michelin_guide;
-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group 
select cuisine, sum(stars), round(avg(stars),5) 
    from michelin_guide 
    group by cuisine;
-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups 
select cuisine, sum(stars), round(avg(stars),5) 
    from michelin_guide 
    group by cuisine
    having round(avg(stars),5) >1;
-- 9. determining the frequency of the cuisines
select cuisine, count(cuisine)
    from michelin_guide
    group by cuisine;
-- 10. how many restaurants have each star
select stars, count(*)
    from michelin_guide
    group by stars
    order by stars desc;
-- 11. Finding the cheapest cuisines
select cuisine, min(lower_price)
    from michelin_guide
    group by cuisine
    order by min(lower_price) asc;
-- 12. Number of restaurants in the Northern Hemisphere
select count(*) as Northern_Hemisphere
    from michelin_guide
    where lat > 0;