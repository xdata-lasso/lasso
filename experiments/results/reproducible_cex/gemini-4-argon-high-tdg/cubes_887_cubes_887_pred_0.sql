-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Embraer 175', 2000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (300, 10, 'Dallas', 'Houston', 240, '2023-06-10', '2023-06-10', 100.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 10, 'Austin', 'Houston', 160, '2023-06-11', '2023-06-11', 100.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (500, 10, 'Phoenix', 'Las Vegas', 255, '2023-06-12', '2023-06-12', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (200, 10, 'Denver', 'Salt Lake', 390, '2023-06-09', '2023-06-09', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (400, 10, 'Portland', 'Seattle', 145, '2023-06-08', '2023-06-08', 200.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno FROM (SELECT * FROM (SELECT * FROM flight ORDER BY price, flight.flno NULLS LAST) LIMIT 3);

/*
Gold Result:
(100.0,)
(300.0,)
(200.0,)
*/

-- Prediction Query
SELECT flno FROM Flight ORDER BY distance ASC, Flight.flno NULLS LAST LIMIT 3;

/*
Prediction Result:
(400.0,)
(100.0,)
(300.0,)
*/