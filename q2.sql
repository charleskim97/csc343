SET SEARCH_PATH TO vacationschema, public;
DROP TABLE IF EXISTS q2 cascade;

CREATE TABLE q2(
	avg_rating_at_capacity FLOAT,
	num_properties_at_capacity INTEGER,
	avg_rating_below_capacity FLOAT,
	num_properties_below_capacity INTEGER);


DROP VIEW IF EXISTS capacities CASCADE;
DROP VIEW IF EXISTS guest_count CASCADE;
DROP VIEW IF EXISTS rental_guest_counts CASCADE;
DROP VIEW IF EXISTS at_capacity CASCADE;
DROP VIEW IF EXISTS below_capacity CASCADE;
DROP VIEW IF EXISTS ratings CASCADE;
DROP VIEW IF EXISTS at_capacity_rating CASCADE;
DROP VIEW IF EXISTS below_capacity_rating CASCADE;
DROP VIEW IF EXISTS query2 CASCADE;
DROP VIEW IF EXISTS num_at CASCADE;

CREATE VIEW capacities AS 
SELECT     rental_code, 
           rental.property_id, 
           capacity 
FROM       rental 
INNER JOIN property 
ON         rental.property_id = property.property_id;

CREATE VIEW guest_count AS 
SELECT   rental_code, 
         Count(checkin_id) AS num_guests 
FROM     checkin 
GROUP BY rental_code;CREATE VIEW rental_guest_counts AS 
SELECT     capacities.rental_code, 
           capacities.property_id, 
           num_guests, 
           capacity 
FROM       capacities 
INNER JOIN guest_count 
ON         capacities.rental_code = guest_count.rental_code;

CREATE VIEW at_capacity AS 
SELECT rental_code 
FROM   rental_guest_counts 
WHERE  num_guests = capacity;CREATE VIEW below_capacity AS 
SELECT rental_code 
FROM   rental_guest_counts 
WHERE  num_guests < capacity;CREATE VIEW ratings AS 
SELECT     rental_code, 
           rating 
FROM       checkin 
INNER JOIN property_rating 
ON         checkin.checkin_id = property_rating.checkin_id;

CREATE VIEW at_capacity_rating AS 
SELECT     ratings.rental_code, 
           rating 
FROM       ratings 
INNER JOIN at_capacity 
ON         ratings.rental_code = at_capacity.rental_code;

CREATE VIEW below_capacity_rating AS 
SELECT     ratings.rental_code, 
           rating 
FROM       ratings 
INNER JOIN below_capacity 
ON         ratings.rental_code = below_capacity.rental_code;

CREATE VIEW query2 AS 
SELECT 
       ( 
              SELECT Avg(rating::float) 
              FROM   at_capacity_rating) AS avg_rating_at_capacity, 
       ( 
              SELECT Count(rental_code) 
              FROM   at_capacity) AS num_at_capacity, 
       ( 
              SELECT Avg(rating::float) 
              FROM   below_capacity_rating) AS avg_rating_below_capacity, 
       ( 
              SELECT Count(rental_code) 
              FROM   below_capacity) AS num_below_capacity;INSERT INTO q2
SELECT * 
FROM   query2;SELECT * 
FROM   q2;