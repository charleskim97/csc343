-- What constraints from the domain could not be enforced, if any? The
-- constraint for keeping the number of guests under capacity would not be 

DROP SCHEMA IF EXISTS vacationschema cascade; CREATE SCHEMA vacationschema;
SET search_path TO vacationschema, public;

-- Contains unique host ID's and their corresponding email 
CREATE TABLE Host (
host_id SERIAL PRIMARY KEY, host_email varchar(80) NOT NULL );

-- Contains general property information
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


-- Contains data for City properties

CREATE TABLE City( 
	property_id integer REFERENCES Property(property_id) PRIMARY KEY,
	walk integer NOT NULL,
	transit varchar(6) NOT NULL
	 );

-- Contains data for Water properties 
CREATE TABLE Water(
	property_id integer REFERENCES Property(property_id) PRIMARY KEY,
	beach BOOLEAN default false,
	lake BOOLEAN default false, 
	pool BOOLEAN default false, 
	beachl BOOLEAN default false, 
	lakel BOOLEAN default false, 
	pooll BOOLEAN default false 
	);

-- Contains the property_id for each rental instance 
CREATE TABLE Rental(
rental_code INT PRIMARY KEY, 
property_id INT REFERENCES Property(property_id)
);

	
-- Rent information on a weekly basis (rental_id) 
-- Each rental instance determined by rental_code, not rental_id 
-- Weekly rents determined by rental id 
CREATE TABLE Rent( 
	rental_id INT PRIMARY KEY,
	date DATE NOT NULL,
	rental_code INT REFERENCES Rental(rental_code), 
	price DECIMAL(19,4) NOT NULL
);



-- Contains check-in information of guest and rental instance 
CREATE TABLE Checkin( 
	checkin_id SERIAL PRIMARY KEY, 
	name varchar(80) NOT NULL, 
	guest_id INT NOT NULL, 
	rental_code INT NOT NULL REFERENCES Rental(rental_code));

-- Contains renter information of each rental instance 
CREATE TABLE Renter(
checkin_id INT PRIMARY KEY REFERENCES Checkin(checkin_id),
rental_code INT NOT NULL REFERENCES Rental(rental_code) UNIQUE,
dob DATE NOT NULL, 
address varchar(50) NOT NULL, 
creditcard varchar(50) NOT NULL, 
rental_date DATE NOT NULL, 
CHECK ((rental_date - interval '18 years') >= dob));

-- Contains property ratings 
CREATE TABLE Property_Rating(
rating_id SERIAL PRIMARY KEY, 
property_id integer REFERENCES Property(property_id), 
checkin_id integer REFERENCES Checkin(checkin_id), 
rating INTEGER NOT NULL );

-- Contains host ratings 
CREATE TABLE Host_Rating( 
	host_rating_id SERIAL PRIMARY KEY, 
	host_id integer REFERENCES Host(host_id),
	checkin_id integer REFERENCES Renter(checkin_id),
	 rating INTEGER NOT NULL );

-- Contains comment ratings 
CREATE TABLE Comments( 
	rating_id INT PRIMARY KEY REFERENCES Property_Rating(rating_id),
	 comm VARCHAR(280) NOT NULL );
