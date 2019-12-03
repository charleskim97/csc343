--For each type (city property, water property, and other) report the average number of extra guests (that is,
--not including the renter themself) for properties of that type. Compute the average across all rentings of that
--type of property. Each renting should contribute once to the average, even if it is for multiple weeks.



SET SEARCH_PATH TO vacationschema, public;
drop table if exists q4 cascade;

create table q4(
	city_avg_guest FLOAT,
	water_avg_guest FLOAT,
	other_avg_guest FLOAT
	);
	
DROP VIEW IF EXISTS guest_count CASCADE;
DROP VIEW IF EXISTS rental_data CASCADE;
DROP VIEW IF EXISTS other CASCADE;

DROP VIEW IF EXISTS city_guest CASCADE;

DROP VIEW IF EXISTS water_guest CASCADE;

DROP VIEW IF EXISTS other_guest CASCADE;

DROP VIEW IF EXISTS averages CASCADE;

CREATE VIEW guest_count as
select rental_code, count(guest_id) -1 as num_guests from checkin GROUP BY rental_code;

CREATE VIEW rental_data as
select guest_count.rental_code, property_id, num_guests FROM guest_count inner join rental on guest_count.rental_code = rental.rental_code;

CREATE VIEW other as
select property_id from property EXCEPT (select property_id from water) EXCEPT (select property_id from city);

CREATE VIEW city_guest as
select rental_data.property_id, num_guests FROM rental_data inner join city on rental_data.property_id = city.property_id;
CREATE VIEW water_guest as
select rental_data.property_id, num_guests FROM rental_data inner join water on rental_data.property_id = water.property_id;
CREATE VIEW other_guest as
select rental_data.property_id, num_guests FROM rental_data inner join other on rental_data.property_id = other.property_id;

CREATE VIEW averages as
select
(select avg(num_guests::float) FROM city_guest) as city_avg_guest,
(select avg(num_guests::float) from water_guest) as water_avg_guest,
(select avg(num_guests::float) from other_guest) as other_avg_guest ;

insert into q4
select * from averages;
select * from q4;