SET search_path TO vacationschema, public;
INSERT INTO Host(host_id, host_email)
VALUES(1, 'luke@gmail.com'), (2, 'leia@gmail.com'), (3, 'han@gmail.com');


--Insert into Property and Water
--1
INSERT INTO Property (property_id,num_bed,num_bath,capacity,address,
			hottub,cleaning, host_id)
VALUES (1,3,1,6,'Tatooine',true,true, 1);
--2
INSERT INTO Property (property_id,num_bed,num_bath,capacity,address,
			hottub,sauna,cleaning, host_id)
VALUES (2,1,1,2,'Alderaan',true,true,true, 2);
INSERT INTO Water (property_id, lake)
VALUES (2, true);
--3
INSERT INTO Property (property_id,num_bed,num_bath,capacity,address,
			breakfast,concierge, host_id)
VALUES (3,2,1,3,'Corellia',true,true, 3);
INSERT INTO City (property_id, walk, transit)
VALUES (3, 20, 'bus');
--4
INSERT INTO Property (property_id,num_bed,num_bath,capacity,address,
			laundry, host_id)
VALUES (4,2,1,2,'Verona',true, 2);
--5
INSERT INTO Property (property_id,num_bed,num_bath,capacity,address,
			hottub, host_id)
VALUES (5,2,2,4,'Florence',true,3);
--6
INSERT INTO Property (property_id,num_bed,num_bath,capacity,address,
			hottub,sauna,laundry,cleaning,concierge, host_id)
VALUES (6,1,1,2,'Toronto',true,true,true,true,true, 1);

--RENTAL INSERT

INSERT INTO Rental (rental_code, property_id)
VALUES (1, 2), (2, 3), (3, 2), (4, 5), (5, 5); 

INSERT INTO Rent(rental_id, date, rental_code, price)
VALUES(1, '2019-01-05', 1, 580),
(2, '2019-01-12', 2, 750),  
(3, '2019-01-19', 2, 750),
(4, '2019-01-12', 3, 600),
(5, '2019-01-05', 4, 1000),
(6, '2019-01-12', 5, 1220);

INSERT INTO Checkin(checkin_id, name, guest_id, rental_code)
VALUES
-- Rental 1
(1, 'Darth Vader', 1, 1),
(2, 'Leia, Princess', 2, 1),
-- Rental 2
(3, 'Leia, Princess', 2, 2),
(4, 'Romeo Montague', 3, 2),
(5, 'Juliet Capulet', 4, 2),
-- Rental 3
(6, 'Romeo Montague', 3, 3),
(7, 'Juliet Capulet', 4, 3),
-- Rental 4
(8, 'Mercutio', 5, 4),
(9, 'Romeo Montague', 3, 4),
(10, 'Darth Vader', 1, 4),
-- Rental 5
(11, 'Chewbacca', 6, 5),
(12, 'Leia, Princess', 2, 5);

INSERT INTO Renter(checkin_id, rental_code, dob, address, creditcard, 
	rental_date)
VALUES
(1, 1, '1985-12-06','Death Star', 3466704824219330, '2019-01-05'),
(3, 2, '1001-10-05','Alderaan', 6011253896008199, '2019-01-12'),
(6, 3, '1988-05-11','Verona', 5446447451075463, '2019-01-12'), 
(8, 4, '1988-03-03','Verona', 4666153163329984, '2019-01-05'),
(11, 5, '1998-09-15','Kashyyyk', 6011624297465933, '2019-01-12');

INSERT INTO Property_Rating(rating_id, property_id, checkin_id, rating)
VALUES
--1
(1,2,2,5),
(2,2,1,2),
--2
(3,3,4,5),
(4,3,5,5),
(5,3,3,1),
--3
(6,2,7,5),
--4
(7,5,8,1),
(8,5,9,1),
--5
(9,5,11,3);

INSERT INTO Host_Rating(host_rating_id, host_id, checkin_id, rating)
VALUES
(1,2,1,2),
(2,3,3,5),
(3,2,6,3),
(4,3,8,4),
(5,3,11,4);

INSERT INTO Comments(rating_id, comm)
VALUES
(1,'Looks like she hides rebel scum here.'),
(3,'A bit scruffy, could do with more regular housekeeping'),
(9,'Fantastic, arggg');
