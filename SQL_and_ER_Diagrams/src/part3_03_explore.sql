

--1. Showing distribution of suspect and concomitant for each product code

select 
    product_code,
    count(*) FILTER (where product_type = 'SUSPECT') as suspect_count,
    count(*) FILTER (where product_type = 'CONCOMITANT') as concomitant_count
from staging_caers_event_product
group by  product_code
order by suspect_count desc,concomitant_count desc;

/*
 product_code | suspect_count | concomitant_count 
--------------+---------------+-------------------
 53           |         82858 |               638
 54           |         58803 |             30854
 23           |          5544 |                37
 29           |          3490 |               126
 3            |          3456 |               120
 16           |          2956 |               119
 24           |          2949 |               188
 5            |          2377 |                52
 41           |          2051 |               348
 9            |          1934 |                94
*/


-- 2 check if product_code,product name, and created_date is a candidate key... it is not
select 
	product,
	product_type,
	created_date,
	count(1)
from staging_caers_event_product
group by product, product_type, created_date
order by count(1) desc;

/*
   product   | product_type | created_date | count 
-------------+--------------+--------------+-------
 EXEMPTION 4 | SUSPECT      | 2017-06-28   |  3271
 EXEMPTION 4 | SUSPECT      | 2017-06-12   |  1616
 EXEMPTION 4 | SUSPECT      | 2017-06-02   |   948
 EXEMPTION 4 | SUSPECT      | 2017-05-23   |   922
 EXEMPTION 4 | SUSPECT      | 2021-11-13   |   541
 EXEMPTION 4 | SUSPECT      | 2021-11-20   |   441
 EXEMPTION 4 | SUSPECT      | 2021-07-06   |   404
 EXEMPTION 4 | SUSPECT      | 2021-11-15   |   397
 EXEMPTION 4 | SUSPECT      | 2021-11-17   |   378
 EXEMPTION 4 | SUSPECT      | 2017-03-20   |   376
(10 rows)
*/

--see how many times each product code is associated with multiple creation dates

select 
    product_code, 
    count(distinct created_date) as date_variants
from staging_caers_event_product
group by product_code
having count(distinct product_type) > 1
order by date_variants desc;

/*
 product_code | date_variants 
--------------+---------------
 54           |          5586
 53           |          4165
 29           |          2322
 3            |          2132
 16           |          1729
 23           |          1708
 24           |          1662
 41           |          1466
 20           |          1266
 5            |          1248
(10 rows)
*/



-- distribution of description

select 
	description,
	count(1) as freq
from staging_caers_event_product
group by description
order by count(1) desc
limit 10;

/*
                 description                  | freq  
----------------------------------------------+-------
 Vit/Min/Prot/Unconv Diet(Human/Animal)       | 89657
 Cosmetics                                    | 83496
 Nuts/Edible Seed                             |  5581
 Vegetables/Vegetable Products                |  4786
 Soft Drink/Water                             |  3616
 Bakery Prod/Dough/Mix/Icing                  |  3576
 Fruit/Fruit Prod                             |  3405
 Fishery/Seafood Prod                         |  3075
 Cereal Prep/Breakfast Food                   |  2429
 Dietary Conventional Foods/Meal Replacements |  2399
(10 rows)
*/