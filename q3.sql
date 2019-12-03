--Find the host/hosts with the highest average host rating. Report their email address, average host rating,
--and the price for the most expensive booking week they have every recorded.


SET SEARCH_PATH TO vacationschema, public;
drop table if exists q3 cascade;

create table q3(
	host_id INTEGER,
	email varchar(80),
	avg_host_rating FLOAT,
	most_expensive DECIMAL(19,4)
	);
	
DROP VIEW IF EXISTS average_ratings CASCADE;
DROP VIEW IF EXISTS max_avg_host CASCADE;
DROP VIEW IF EXISTS host_data CASCADE;
DROP VIEW IF EXISTS property_price CASCADE;
DROP VIEW IF EXISTS host_price CASCADE;
DROP VIEW IF EXISTS max_host_price CASCADE;
DROP VIEW IF EXISTS max_host_data CASCADE;
DROP VIEW IF EXISTS max_host_data_avg CASCADE;

CREATE VIEW average_ratings as
SELECT host_id, avg(rating) as avg_host_rating from host_rating group by host_id ORDER BY avg_host_rating DESC LIMIT 1;

CREATE VIEW max_avg_host as
select * from average_ratings where avg_host_rating = (SELECT max(avg_host_rating) FROM average_ratings);

CREATE VIEW host_data as
select max_avg_host.host_id, host.host_email from max_avg_host inner join host on max_avg_host.host_id = host.host_id;

CREATE VIEW property_price as
select property_id, price from rent inner join rental on rent.rental_code = rental.rental_code;

CREATE VIEW host_price as 
select host_id, property_price.property_id, price from property inner join property_price on property.property_id = property_price.property_id;

CREATE VIEW max_host_price as
select host_price.host_id, max(price) as max_price from host_price inner join host_data on host_price.host_id = host_data.host_id GROUP BY host_price.host_id;

CREATE VIEW max_host_data as
select max_host_price.host_id, host_email, max_price from max_host_price inner join host_data on max_host_price.host_id = host_data.host_id;

CREATE VIEW max_host_data_avg as
select max_host_data.host_id, host_email, avg_host_rating, max_price  FROM max_host_data inner join average_ratings on max_host_data.host_id = average_ratings.host_id;

insert into q3
select * from max_host_data_avg;

select * from q3;