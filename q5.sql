SET SEARCH_PATH TO vacationschema, public;
drop table if exists q5 cascade;
create table q5(
	property_id INTEGER,
	highest_price DECIMAL(19,4),
	lowest_price DECIMAL(19,4),
	range DECIMAL(19,4),
	star varchar(1)
	);

DROP VIEW IF EXISTS prices CASCADE;
DROP VIEW IF EXISTS star CASCADE;
DROP VIEW IF EXISTS combined CASCADE;
CREATE VIEW prices as
SELECT property_id, MAX(price) as highest_price, MIN(price) as lowest_price, MAX(PRICE) - MIN(price) as Range from rent inner join rental on rent.rental_code = rental.rental_code GROUP BY property_id;

CREATE VIEW star as
SELECT property_id, '*' AS star FROM prices where range = (SELECT MAX(range) FROM prices);

CREATE VIEW COMBINED as
select prices.property_id, highest_price, lowest_price, range, star from prices left join star on prices.property_id = star.property_id;

INSERT INTO q5
select * from combined;
select * from q5;