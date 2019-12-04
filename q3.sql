--Find the host/hosts with the highest average host rating. Report their email
--address, average host rating, and the price for the most expensive booking
--week they have every recorded.

SET SEARCH_PATH TO vacationschema,
                   PUBLIC;

DROP TABLE IF EXISTS q3 CASCADE;


CREATE TABLE q3(host_id INTEGER, email varchar(80),
avg_host_rating FLOAT, most_expensive DECIMAL(19, 4));


DROP VIEW IF EXISTS average_ratings CASCADE;


DROP VIEW IF EXISTS max_avg_host CASCADE;


DROP VIEW IF EXISTS host_data CASCADE;

DROP VIEW IF EXISTS property_price CASCADE;

DROP VIEW IF EXISTS host_price CASCADE;

DROP VIEW IF EXISTS max_host_price CASCADE;

DROP VIEW IF EXISTS max_host_data CASCADE;

DROP VIEW IF EXISTS max_host_data_avg CASCADE;


CREATE VIEW average_ratings AS
SELECT host_id,
       avg(rating) AS avg_host_rating
FROM host_rating
GROUP BY host_id
ORDER BY avg_host_rating DESC
LIMIT 1;


CREATE VIEW max_avg_host AS
SELECT *
FROM average_ratings
WHERE avg_host_rating =
    (SELECT max(avg_host_rating)
     FROM average_ratings);


CREATE VIEW host_data AS
SELECT max_avg_host.host_id,
       host.host_email
FROM max_avg_host
INNER JOIN HOST ON max_avg_host.host_id = host.host_id;


CREATE VIEW property_price AS
SELECT property_id,
       price
FROM rent
INNER JOIN rental ON rent.rental_code = rental.rental_code;


CREATE VIEW host_price AS
SELECT host_id,
       property_price.property_id,
       price
FROM property
INNER JOIN property_price ON property.property_id = property_price.property_id;


CREATE VIEW max_host_price AS
SELECT host_price.host_id,
       max(price) AS max_price
FROM host_price
INNER JOIN host_data ON host_price.host_id = host_data.host_id
GROUP BY host_price.host_id;


CREATE VIEW max_host_data AS
SELECT max_host_price.host_id,
       host_email,
       max_price
FROM max_host_price
INNER JOIN host_data ON max_host_price.host_id = host_data.host_id;


CREATE VIEW max_host_data_avg AS
SELECT max_host_data.host_id,
       host_email,
       avg_host_rating,
       max_price
FROM max_host_data
INNER JOIN average_ratings 
ON max_host_data.host_id = average_ratings.host_id;


INSERT INTO q3
SELECT *
FROM max_host_data_avg;


SELECT *
FROM q3;
