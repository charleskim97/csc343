SET SEARCH_PATH TO vacationschema, public;
DROP TABLE IF EXISTS q5 cascade;
CREATE TABLE q5( 
	property_id INTEGER, 
	highest_price DECIMAL(19,4),
	lowest_price DECIMAL(19,4),
	range DECIMAL(19,4), 
	star varchar(1) );

DROP VIEW IF EXISTS prices CASCADE; 
DROP VIEW IF EXISTS star CASCADE; 
DROP VIEW IF EXISTS combined CASCADE;

CREATE VIEW prices 
AS 
  SELECT property_id, 
         Max(price)              AS highest_price, 
         Min(price)              AS lowest_price, 
         Max(price) - Min(price) AS Range 
  FROM   rent 
         INNER JOIN rental 
                 ON rent.rental_code = rental.rental_code 
  GROUP  BY property_id; 

CREATE VIEW star 
AS 
  SELECT property_id, 
         '*' AS star 
  FROM   prices 
  WHERE  range = (SELECT Max(range) 
                  FROM   prices); 

CREATE VIEW combined 
AS 
  SELECT prices.property_id, 
         highest_price, 
         lowest_price, 
         range, 
         star 
  FROM   prices 
         LEFT JOIN star 
                ON prices.property_id = star.property_id; 

INSERT INTO q5 
SELECT * 
FROM   combined; 

SELECT * 
FROM   q5; 