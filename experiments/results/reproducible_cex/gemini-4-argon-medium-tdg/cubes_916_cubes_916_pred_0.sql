-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Airbus A320', 3000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (50, 1, 'Chicago', 'Miami', 1200, '2023-02-01', '2023-02-01', 450.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (10, 1, 'Chicago', 'Dallas', 800, '2023-02-01', '2023-02-01', 350.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (30, 1, 'Chicago', 'Miami', 1200, '2023-02-02', '2023-02-02', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (5, 1, 'Atlanta', 'Boston', 900, '2023-02-01', '2023-02-01', 600.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (40, 1, 'Boston', 'Seattle', 2500, '2023-02-01', '2023-02-01', 400.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin, destination FROM flight WHERE (price > 300.0) ORDER BY origin, flight.flno NULLS LAST;

/*
Gold Result:
('Atlanta', 'Boston')
('Boston', 'Seattle')
('Chicago', 'Dallas')
('Chicago', 'Miami')
('Chicago', 'Miami')
*/

-- Prediction Query
SELECT origin, destination FROM Flight WHERE price > 300;

/*
Prediction Result:
('Chicago', 'Miami')
('Chicago', 'Dallas')
('Chicago', 'Miami')
('Atlanta', 'Boston')
('Boston', 'Seattle')
*/