-- write your table creation sql here!
DROP TABLE michelin_guide;
CREATE TABLE michelin_guide(
    id serial PRIMARY KEY,
    restaurant text NOT NULL,
    cuisine text NOT NULL,
    stars smallint NOT NULL,
    lat numeric(10,7) NOT NULL,
    longitude numeric(10,7) NOT NULL,
    lower_price numeric NOT NULL,
    higher_price numeric NOT NULL 
);