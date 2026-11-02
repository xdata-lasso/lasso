-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3500);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Boeing 777', 9500);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 1, 'Austin', 'Miami', 1200, '2023-03-20', '2023-03-20', 450.75);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (5, 2, 'Chicago', 'Denver', 800, '2023-05-10', '2023-05-11', 300.50);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (20, 3, 'Boston', 'Seattle', 2500, '2023-01-15', '2023-01-15', 150.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno, origin, destination FROM flight ORDER BY flno;

/*
Gold Result:
(5.0, 'Chicago', 'Denver')
(20.0, 'Boston', 'Seattle')
(100.0, 'Austin', 'Miami')
*/

-- Prediction Query
SELECT flno, origin, destination FROM Flight ORDER BY origin, Flight.flno NULLS LAST;

/*
Prediction Result:
(100.0, 'Austin', 'Miami')
(20.0, 'Boston', 'Seattle')
(5.0, 'Chicago', 'Denver')
*/