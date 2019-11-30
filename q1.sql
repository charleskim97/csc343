--Query 1
--For each type of luxury (hot tub etc.), report the number of properties that offer that luxury.

SET SEARCH_PATH TO vacationschema, public;
drop table if exists q1 cascade;

DROP VIEW IF EXISTS luxuries CASCADE;

create table q1(
	luxury VARCHAR(9),
	num_properties INTEGER
);

create view luxuries as
select property_id, hottub, sauna, laundry, cleaning, breakfast, concierge
from Property
where hottub = true or sauna = true or laundry = true or cleaning = true or
	breakfast = true or concierge = true;

select sum(hottub::int) as hottub, sum(sauna::int) as sauna,
	sum(laundry::int) as laundry, sum(cleaning::int) as cleaning,
	sum(breakfast::int) as breakfast, sum(concierge::int) as concierge
from luxuries;
