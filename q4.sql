-- Query 4
--For each type (city property, water property, and other) report the average
--number of extra guests (that is, not including the renter themself) for
--properties of that type. Compute the average across all rentings of that
--type of property. Each renting should contribute once to the average, even
--if it is for multiple weeks.
SET SEARCH_PATH TO vacationschema,
                   PUBLIC;


DROP TABLE IF EXISTS q4 CASCADE;


CREATE TABLE q4(city_avg_guest FLOAT,
 water_avg_guest FLOAT,
  other_avg_guest FLOAT);


DROP VIEW IF EXISTS guest_count CASCADE;


DROP VIEW IF EXISTS rental_data CASCADE;


DROP VIEW IF EXISTS other CASCADE;


DROP VIEW IF EXISTS city_guest CASCADE;


DROP VIEW IF EXISTS water_guest CASCADE;


DROP VIEW IF EXISTS other_guest CASCADE;


DROP VIEW IF EXISTS averages CASCADE;


CREATE VIEW guest_count AS
SELECT rental_code,
       COUNT(guest_id) - 1 AS num_guests
FROM checkin
GROUP BY rental_code;


CREATE VIEW rental_data AS
SELECT guest_count.rental_code,
       property_id,
       num_guests
FROM guest_count
INNER JOIN rental ON guest_count.rental_code = rental.rental_code;


CREATE VIEW other AS
SELECT property_id
FROM property
EXCEPT
  (SELECT property_id
   FROM water)
EXCEPT
  (SELECT property_id
   FROM city);


CREATE VIEW city_guest AS
SELECT rental_data.property_id,
       num_guests
FROM rental_data
INNER JOIN city ON rental_data.property_id = city.property_id;


CREATE VIEW water_guest AS
SELECT rental_data.property_id,
       num_guests
FROM rental_data
INNER JOIN water ON rental_data.property_id = water.property_id;


CREATE VIEW other_guest AS
SELECT rental_data.property_id,
       num_guests
FROM rental_data
INNER JOIN other ON rental_data.property_id = other.property_id;


CREATE VIEW averages AS
SELECT
  (SELECT AVG(num_guests::FLOAT)
   FROM city_guest) AS city_avg_guest,

  (SELECT AVG(num_guests::FLOAT)
   FROM water_guest) AS water_avg_guest,

  (SELECT AVG(num_guests::FLOAT)
   FROM other_guest) AS other_avg_guest ;


INSERT INTO q4
SELECT *
FROM averages;


SELECT *
FROM q4;