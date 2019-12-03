SET SEARCH_PATH TO vacationschema, public;
drop table if exists q2 cascade;

create table q2(
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

CREATE VIEW capacities as
select rental_code, rental.property_id, capacity from rental inner join property on rental.property_id = property.property_id;

CREATE VIEW guest_count as
select rental_code, count(checkin_id) as num_guests from checkin GROUP BY rental_code;

CREATE VIEW rental_guest_counts as
select capacities.rental_code, capacities.property_id, num_guests, capacity from capacities inner join guest_count on capacities.rental_code = guest_count.rental_code;

CREATE VIEW at_capacity as
select rental_code FROM rental_guest_counts where num_guests = capacity;

CREATE VIEW below_capacity as
select rental_code FROM rental_guest_counts where num_guests < capacity;

CREATE VIEW ratings as
SELECT rental_code, rating FROM checkin inner join property_rating on checkin.checkin_id = property_rating.checkin_id;

CREATE VIEW at_capacity_rating as
select ratings.rental_code, rating from ratings inner join at_capacity on ratings.rental_code = at_capacity.rental_code;

CREATE VIEW below_capacity_rating as
select ratings.rental_code, rating from ratings inner join below_capacity on ratings.rental_code = below_capacity.rental_code;

CREATE VIEW query2 as
select 
(select avg(rating::float) from at_capacity_rating) as avg_rating_at_capacity,
(select count(rental_code) FROM at_capacity) as num_at_capacity,
(select avg(rating::float) from below_capacity_rating) as avg_rating_below_capacity,
(select count(rental_code) FROM below_capacity) as num_below_capacity;

INSERT INTO q2
SELECT * from query2;

select * from q2;