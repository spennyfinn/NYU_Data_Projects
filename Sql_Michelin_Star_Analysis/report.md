# Overview
1. Name / Title: Michelin Starred Restaurants 2021.xlsx
2. Link to Data: https://guide.michelin.com/ 
3. Source / Origin: 
	* Author or Creator: Dimitris Angelides who webscraped from the Michelin Guide
	* Publication Date: December 2021
	* Publisher: Michelin Guide
	* Version or Data Accessed: Michelin Guide 2021 
4. License: Data files © Original Authors
5. Can You Use this Data Set for Your Intended Use Case? Yes!
* Format: .xlsx
* Size: 1.2 Mb
* Number of Records: 3,155
* Field/Column 1: Price_Range -- numerical data -- int -- np.array
* Field/Column 2: Cuisine -- categorical data  -- string -- np.array
* Field/Column N: Restaurant Name -- categorical data  -- string -- np.array
* Field/Column N: Michelin stars -- categorical data -- string  -- np.array
* Field/Column N: Latitude -- numerical data -- float -- np.array


# Table Design
I am including restaurant name, cuisine, amount of michelin stars, latitude, longitude, lower_price, and higher_price of the meals at the restaurant.
Id: Since my name column has a few duplicated I need to make this the primary key.

Restaurant: For this col I decided to make it NOT NULL since the restaurant needs to have a name. If it doesn't it can be exluded although I don't have any null vals in this dataset. I decided to make it a text datatype because the names of the restaurants are variable.

Cuisine: For this col I decided to make it NOT NULL. There are no NULL values in my dataset for any column but I thought it would be good practice to get used to some of the key words. This applies to all of the subsequent columns that have NOT NULL. I used text as the datatype for this col because the cuisine length varies.

Stars: For this col I decided to make it NOT NULL as defined above. Additionally, if is is a NULL value for this col it shouldn't be on the list since all of these restaurants need to have at least 1 star to be included. I used smallint because the values range from 1-3.

Latitude/Longitude: For this col I decided to use NOT NULL as defined above. I used numeric(10, 3) for long because the precision of these values can only range from -180-180. For lat I used numeric(9,7) because the values can only range from -90-90. I kept 7 digits after the decimal to ensure precision in case two restaurants are located close to each other.

Lower_price/Higher_price:  For this col I decided to use NOT NULL as defined above. I used numeric because some of the values are floating point numbers while others are integers. To be safe I am using numeric to ensure that the decimal isn't rounded.

# Import
1. Some of my column names contained spaces so I needed to rename them in convert.ipynb
2. I was trying to import the csv with more cols than the cols I wanted in my sql table so I had to select the cols I wanted in convert.ipynb and make a new df that was imported into a csv.

# Database Information

homework06=# \l
                             List of databases
    Name    |  Owner   | Encoding | Collate | Ctype |   Access privileges   
------------+----------+----------+---------+-------+-----------------------
 homework06 | postgres | UTF8     | C       | C     | 
 postgres   | postgres | UTF8     | C       | C     | 
 template0  | postgres | UTF8     | C       | C     | =c/postgres          +
            |          |          |         |       | postgres=CTc/postgres
 template1  | postgres | UTF8     | C       | C     | =c/postgres          +
            |          |          |         |       | postgres=CTc/postgres
(4 rows)


homework06=# \dt
             List of relations
 Schema |      Name      | Type  |  Owner   
--------+----------------+-------+----------
 public | michelin_guide | table | postgres
(1 row)

homework06=# \d michelin_guide
                                  Table "public.michelin_guide"
    Column    |     Type      | Collation | Nullable |                  Default                   
--------------+---------------+-----------+----------+--------------------------------------------
 id           | integer       |           | not null | nextval('michelin_guide_id_seq'::regclass)
 restaurant   | text          |           | not null | 
 cuisine      | text          |           | not null | 
 stars        | smallint      |           | not null | 
 lat          | numeric(10,7) |           | not null | 
 longitude    | numeric(10,7) |           | not null | 
 lower_price  | numeric       |           | not null | 
 higher_price | numeric       |           | not null | 
Indexes:
    "michelin_guide_pkey" PRIMARY KEY, btree (id)





# Query Results

```
-- 1. the total number of rows in the database
count 
-------
  3155
(1 row)
```
```
-- 2. show the first 15 rows, but only display 3 columns (your choice)
 id |       restaurant        | stars 
----+-------------------------+-------
  1 | Pelagos                 |     1
  2 | Botrini's               |     1
  3 | Hytra                   |     1
  4 | CTC                     |     1
  5 | Varoulko Seaside        |     1
  6 | Primo Restaurant        |     1
  7 | Bros'                   |     1
  8 | Casamatta               |     1
  9 | Pietramare Natural Food |     1
 10 | Già Sotto l'Arco        |     1
 11 | Dattilo                 |     1
 12 | Cielo                   |     1
 13 | Due Camini              |     1
 14 | Abbruzzino              |     1
 15 | Hyle                    |     1
```

```
-- 3. do the same as above, but chose a column to sort on, and sort in descending order
  id  |          restaurant          | stars 
------+------------------------------+-------
 3155 | Manresa                      |     3
 3154 | Benu                         |     3
 3153 | Atelier Crenn                |     3
 3152 | Quince                       |     3
 3151 | The French Laundry           |     3
 3150 | SingleThread                 |     3
 3149 | Alinea                       |     3
 3148 | The Inn at Little Washington |     3
 3147 | Makimura                     |     3
 3146 | Quintessence                 |     3
 3145 | Sushi Yoshitake              |     3
 3144 | L'OSIER                      |     3
 3143 | RyuGin                       |     3
 3142 | Sazenka                      |     3
 3141 | Azabu Kadowaki               |     3
```
````
-- 4. add a new column without a default value
 id  |                          restaurant                           | price 
------+---------------------------------------------------------------+-------
    1 | Pelagos                                                       | 
    2 | Botrini's                                                     | 
    3 | Hytra                                                         | 
    4 | CTC                                                           | 
    5 | Varoulko Seaside                                              | 
    6 | Primo Restaurant                                              | 
    7 | Bros'                                                         | 
    8 | Casamatta                                                     | 
    9 | Pietramare Natural Food                                       | 
   10 | Già Sotto l'Arco                                              | 
   11 | Dattilo                                                       | 

```
```
-- 5. set the value of that new column
 id  |                          restaurant                           | price 
------+---------------------------------------------------------------+-------
    1 | Pelagos                                                       | $$
    2 | Botrini's                                                     | $$
    3 | Hytra                                                         | $$
    4 | CTC                                                           | $$
    5 | Varoulko Seaside                                              | $
    6 | Primo Restaurant                                              | $$
    7 | Bros'                                                         | $$$
    8 | Casamatta                                                     | $$
    9 | Pietramare Natural Food                                       | $$
   10 | Già Sotto l'Arco                                              | $$

```

```
-- 6. show only the unique (non duplicates) of a column of your choice
 price 
-------
 $$$
 $
 $$
 $$$$
(4 rows)
```

```
-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group
       cuisine         | sum |  round  
------------------------+-----+---------
 Seasonal Cuisine       |   1 | 1.00000
 Italian                |  74 | 1.10448
 Scottish               |   1 | 1.00000
 Soba                   |   3 | 1.00000
 Peruvian               |   1 | 1.00000
 Californian            |  15 | 1.15385
 Creative French        |  33 | 1.22222
 Country cooking        |  10 | 1.11111
 Finnish                |   1 | 1.00000
 Cantonese              |  92 | 1.33333
 Moroccan               |   1 | 1.00000
 Portuguese             |   3 | 1.00000
 Ningbo                 |   1 | 1.00000
 Mexican                |   8 | 1.14286
 Market Cuisine         |  20 | 1.05263
 Austrian               |   1 | 1.00000
 Steakhouse             |   9 | 1.00000
 Fusion                 |   5 | 1.00000
 Spanish Contemporary   |   1 | 1.00000
 Modern French          | 111 | 1.18085
 Jiangzhe               |   1 | 1.00000
 Asian Contemporary     |   3 | 1.50000
 Contemporary           | 157 | 1.36522
 World Cuisine          |   2 | 1.00000
 British Contemporary   |   3 | 1.50000
```

```
-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups 
        cuisine        | sum |  round  
-----------------------+-----+---------
 Italian               |  74 | 1.10448
 Californian           |  15 | 1.15385
 Creative French       |  33 | 1.22222
 Country cooking       |  10 | 1.11111
 Cantonese             |  92 | 1.33333
 Mexican               |   8 | 1.14286
 Market Cuisine        |  20 | 1.05263
 Modern French         | 111 | 1.18085
 Asian Contemporary    |   3 | 1.50000
 Contemporary          | 157 | 1.36522
 British Contemporary  |   3 | 1.50000
 Piedmontese           |   9 | 1.28571
 Spanish               |  14 | 1.07692
 Indian                |  12 | 1.09091
 French Contemporary   |  52 | 1.52941
 Beijing Cuisine       |  11 | 1.22222
 Classic French        |  76 | 1.38182
 French                | 142 | 1.30275
 Sushi                 |  83 | 1.25758
 Asian                 |  10 | 1.42857
 Thai                  |  15 | 1.07143
 Modern Cuisine        | 960 | 1.10855
 Korean                |  24 | 1.50000
 European Contemporary |  19 | 1.26667
 Sichuan               |   4 | 1.33333
 Innovative            |  70 | 1.40000
...
```

```
-- 9. determining the frequency of the cuisines
        cuisine         | count 
------------------------+-------
 Seasonal Cuisine       |     1
 Italian                |    67
 Scottish               |     1
 Soba                   |     3
 Peruvian               |     1
 Californian            |    13
 Creative French        |    27
 Country cooking        |     9
 Finnish                |     1
 Cantonese              |    69
 Moroccan               |     1
 Portuguese             |     3
 Ningbo                 |     1
 Mexican                |     7
 Market Cuisine         |    19
 Austrian               |     1
 Steakhouse             |     9
 Fusion                 |     5
 Spanish Contemporary   |     1
 Modern French          |    94
 Jiangzhe               |     1
 Asian Contemporary     |     2
 Contemporary           |   115
 World Cuisine          |     2
 British Contemporary   |     2
...
```

```
-- 10. star distribution
 stars | count 
-------+-------
     3 |   133
     2 |   461
     1 |  2561
(3 rows)
```

```
-- 11. finding the cheapest cuisines based on lower price col
       cuisine         |  min   
------------------------+--------
 Street Food            |    4.5
 Dim Sum                |    6.5
 Ramen                  |    6.6
 Soba                   |    6.6
 Japanese               |    6.6
 Cantonese Roast Meats  |   8.45
 Cantonese              |   11.2
 Thai                   |   12.0
 Noodles and Congee     |   13.0
 Shanghainese           |   14.0
 Hungarian              |   14.3
 Modern Cuisine         |   14.7
 Tempura                |   16.5
 Taiwanese              |   18.6
 Italian Contemporary   |   18.9
 Italian                |   19.8
 Chinese                |   19.8
 Unagi / Freshwater Eel |   19.8
 Creative               |  19.95
 Contemporary           |   22.0
 Asian                  |  22.05
 Fujian                 |   22.5
 Teochew                |   22.5
 French                 |   23.1
 American               |   24.0
 Californian            |   25.0
```

```
-- 12. number of restaurants in the northern hemisphere
 northern_hemisphere 
---------------------
                3141
(1 row)
```