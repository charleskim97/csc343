--Query 1
--For each type of luxury (hot tub etc.), 
--report the number of properties that offer that luxury.

SET SEARCH_PATH TO vacationschema, public;
drop table if exists q1 cascade;

DROP VIEW IF EXISTS luxuries CASCADE;

CREATE TABLE q1 
  ( 
     luxury         VARCHAR(9), 
     num_properties INTEGER 
  ); 

CREATE VIEW luxuries 
AS 
  SELECT property_id, 
         hottub, 
         sauna, 
         laundry, 
         cleaning, 
         breakfast, 
         concierge 
  FROM   property 
  WHERE  hottub = TRUE 
          OR sauna = TRUE 
          OR laundry = TRUE 
          OR cleaning = TRUE 
          OR breakfast = TRUE 
          OR concierge = TRUE; 

SELECT SUM(hottub :: INT)    AS hottub, 
       SUM(sauna :: INT)     AS sauna, 
       SUM(laundry :: INT)   AS laundry, 
       SUM(cleaning :: INT)  AS cleaning, 
       SUM(breakfast :: INT) AS breakfast, 
       SUM(concierge :: INT) AS concierge 
FROM   luxuries; 