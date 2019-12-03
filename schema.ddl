DROP SCHEMA IF EXISTS vacationschema cascade;
CREATE SCHEMA vacationschema;
SET search_path TO vacationschema, public;

--Additional Notes
--Read this for q2
	--https://piazza.com/class/k0cnia4anf0sl?cid=580
--for q4
	--https://piazza.com/class/k0cnia4anf0sl?cid=570
	--https://piazza.com/class/k0cnia4anf0sl?cid=568
--for q5
	--https://piazza.com/class/k0cnia4anf0sl?cid=577


-- A property
CREATE TABLE Host (
	host_id SERIAL PRIMARY KEY,
	host_email varchar(80) NOT NULL
	);

CREATE TABLE Property (
	property_id integer PRIMARY KEY,
	num_bed integer NOT NULL,
	num_bath integer NOT NULL,
	capacity integer NOT NULL CHECK (capacity >= num_bed), 
	address varchar(120) NOT NULL,	
	hottub BOOLEAN default false,
	sauna BOOLEAN default false,
	laundry BOOLEAN default false,
	cleaning BOOLEAN default false,
	breakfast BOOLEAN default false,
	concierge BOOLEAN default false,
	host_id INTEGER REFERENCES Host(host_id)
	);


-- City property data

CREATE TABLE City(
	property_id integer REFERENCES Property(property_id),
	walk integer NOT NULL,
	transit varchar(6) NOT NULL		--don't forget we have to manually input "none"
						--refer to https://piazza.com/class/k0cnia4anf0sl?cid=573
	);

-- Water property data
CREATE TABLE Water(
	property_id integer REFERENCES Property(property_id),
	beach BOOLEAN default false,
	lake BOOLEAN default false,
	pool BOOLEAN default false,
	beachl BOOLEAN default false,
	lakel BOOLEAN default false,
	pooll BOOLEAN default false
	);

--rental code lmao
CREATE TABLE Rental(
	rental_code INT PRIMARY KEY,
	property_id INT REFERENCES Property(property_id)
	);

	
-- Rent information on a weekly basis
-- Each rental determined by rental CODE
-- Weekly rents determined by rental ID
CREATE TABLE Rent(
	rental_id INT PRIMARY KEY,
	date DATE NOT NULL,
	rental_code INT REFERENCES Rental(rental_code),
	price DECIMAL(19,4) NOT NULL
	);



-- A guest
CREATE TABLE Checkin(
	checkin_id SERIAL PRIMARY KEY,
	name varchar(80) NOT NULL,
	guest_id INT NOT NULL,
	rental_code INT NOT NULL REFERENCES Rental(rental_code)	
	);

-- Renter Information
CREATE TABLE Renter(
	checkin_id INT PRIMARY KEY REFERENCES Checkin(checkin_id),
	rental_code INT NOT NULL REFERENCES Rental(rental_code),
	dob DATE NOT NULL,
	address varchar(50) NOT NULL,
	creditcard varchar(50) NOT NULL
	);

-- Property Ratings
CREATE TABLE Property_Rating(
	rating_id SERIAL PRIMARY KEY,
	property_id integer REFERENCES Property(property_id),
	checkin_id integer REFERENCES Checkin(checkin_id),
	rating INTEGER NOT NULL
	);

-- Host Ratings
CREATE TABLE Host_Rating(
	host_rating_id SERIAL PRIMARY KEY,
	host_id integer REFERENCES Host(host_id),
	checkin_id integer REFERENCES Renter(checkin_id),
	rating INTEGER NOT NULL
	);

--Comments
CREATE TABLE Comments(
	rating_id INT PRIMARY KEY REFERENCES Property_Rating(rating_id),
	comm VARCHAR(280) NOT NULL
	);
