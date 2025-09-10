-- write your COPY statement to import a csv here
\copy michelin_guide (restaurant,cuisine,stars,longitude,lat,lower_price,higher_price)
FROM '/Users/spennyfinn/Documents/GitHub/homework06-spennyfinn/Michelin_Guide_2021.csv'
WITH CSV HEADER NULL 'N/A'
;





