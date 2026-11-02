-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Boeing 777', 7500);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Airbus A330', 6000);
INSERT INTO aircraft (aid, name, distance) VALUES (4, 'Airbus A320', 5500);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (200, 3, 'Denver', 'Honolulu', 3300, '2023-05-04', '2023-05-04', 600.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (300, 1, 'Atlanta', 'Honolulu', 4500, '2023-05-02', '2023-05-02', 800.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (400, 2, 'Chicago', 'Honolulu', 4200, '2023-05-03', '2023-05-03', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 4, 'Boston', 'Honolulu', 5000, '2023-05-01', '2023-05-01', 400.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (500, 1, 'Honolulu', 'Seattle', 2700, '2023-05-05', '2023-05-05', 350.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (600, 2, 'Miami', 'Chicago', 1200, '2023-05-06', '2023-05-06', 250.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "origin" FROM "flight" WHERE ("destination" = 'Honolulu') ORDER BY origin, flight.flno NULLS LAST;

/*
Gold Result:
('Atlanta',)
('Boston',)
('Chicago',)
('Denver',)
*/

-- Prediction Query
SELECT origin FROM Flight WHERE destination = 'Honolulu';

/*
Prediction Result:
('Denver',)
('Atlanta',)
('Chicago',)
('Boston',)
*/