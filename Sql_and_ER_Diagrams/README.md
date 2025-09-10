

 ## Part 1:
 * A one to many relationship exists between country_id and country_id in countries and country_languages respectively. This relationship exists because the country_id in countries is unqiue and the country_id in country_languages is not unique.
 * A one to many relationship exists between language_id and language_id in languages and country_languages respectively. This relationship exists because the id in languages is unqiue and the id in country_languages is not unique.
 * A one to many relationship exists between country_id and country_id in countries and country_stats respectively. This relationship exists because the country_id in countries is unqiue and the country_id in country_stats is not unique.
* A one to many relationship exists between region_id and region_id in countries and regions respectively. This relationship exists because the region_id in countries is unqiue and the region_id in regions is not unique.
* A one to many relationship exists between region_id and region_id in countries and regions respectively. This relationship exists because the region_id in countries is unqiue and the region_id in regions is not unique.
* A one to many relationship exists between name and region_name in region and region_areas respectively. This relationship exists because the region_id in regions is unqiue and the region_id in region_stats is not unique.


## Part 3_03

--1. Showing distribution of suspect and concomitant for each product code

This query counts how many times each product_code appears as a SUSPECT or CONCOMITANT product type in the staging_caers_event_product table, then lists the codes with the most SUSPECT entries first.

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


-- 2 check if product_code,product name, and created_date is a candidate key

The product_code, product name, and created_date is not a candidate key due to the count column showing more than one for at least one row. 

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


--see how many times each product code is associated with multiple creation dates

Product code and date is not a candidate key since the date_variant col has mulitple variants.

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





-- distribution of description

Shows the number of times each product description appears in the table. Vitamins, minerals, etc are the most common reported item in the table.
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



## ## Part 3: Examine a data set and create a normalized data model to store the data
![ERD for Caers Data](../img/part3_03_caers_er_diagram.png)

- `staging_caers_event_product` Table: Separated this table to store event-level data, ensuring that product details are not repeated for each report. It maintains a clear relationship with the `product` table through the `product_code` reference.
- `report_term` Table: Created as a separate table to store symptoms (`terms`). This normalization prevents storing multiple symptoms within the same field, ensuring atomicity and avoiding redundancy.
- `report_outcomes` Table: Similarly, this table is designed to store outcomes. This design choice ensures that each outcome is stored in a separate row, facilitating better querying and avoiding multiple outcomes being combined into a single field.
- `product` Table: By isolating product details (like `product_code`, `product_type`, and `description`), we reduce redundancy and ensure that product information is updated centrally without needing to repeat it across multiple records.
- `patient` Table: Created to store patient-related details separately from event data. This improves flexibility, as a patient may have multiple associated events, and it allows efficient management of patient information.