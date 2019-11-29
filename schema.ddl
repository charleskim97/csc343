DROP SCHEMA IF EXISTS vacationschema cascade;
CREATE SCHEMA vacationschema;
SET search_path TO vacationschema, public;

-- A property

CREATE TABLE Property (
	property_id integer PRIMARY KEY,
	num_bed integer NOT NULL,
	num_bath integer NOT NULL,
	capacity integer NOT NULL,
	address varchar(120) NOT NULL,
	city varchar(50),		--not sure why this is here
	city_prop BOOLEAN default false,
	water_prop BOOLEAN default false,
	walk integer,
	transit varchar(6),
	beach BOOLEAN default false,
	lake BOOLEAN default false,
	pool BOOLEAN default false,
	beachl BOOLEAN default false,
	lakel BOOLEAN default false,
	pooll BOOLEAN default false,
	hottub BOOLEAN default false,
	sauna BOOLEAN default false,
	laundry BOOLEAN default false,
	cleaning BOOLEAN default false,
	breakfast BOOLEAN default false,
	concierge BOOLEAN default false);

-- A guest
CREATE TABLE Guest(
	guest_id INT PRIMARY KEY, --not a primary key according to piazza
--https://piazza.com/class/k0cnia4anf0sl?cid=558
	dob DATE NOT NULL,
	host INT NOT NULL,
	name varchar(50) NOT NULL,
	address varchar(50) NOT NULL
	);

-- Credit Card Information
CREATE TABLE Credit(
	host_id INT PRIMARY KEY REFERENCES Guest(guest_id),
	creditcard INT NOT NULL
	);
	
-- Rent information on a weekly basis
CREATE TABLE Rent(
	rental_id INT PRIMARY KEY,
	property_id INT NOT NULL REFERENCES Property(property_id),
	host_id INT NOT NULL REFERENCES Guest(guest_id),
	price DECIMAL(19,4)
	);


	


