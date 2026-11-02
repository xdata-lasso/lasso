-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out-of-order insertion), numeric vs lexicographical sorting (9 vs 10 vs 100), and column swaps.
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 1, 'Chicago', 'Miami', 1200, '2023-05-01', '2023-05-01', 250.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (9, 1, 'New York', 'London', 3400, '2023-05-02', '2023-05-03', 800.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (10, 1, 'Boston', 'Seattle', 2500, '2023-05-04', '2023-05-04', 400.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno, origin, destination FROM flight ORDER BY flno;

/*
Gold Result:
(9.0, 'New York', 'London')
(10.0, 'Boston', 'Seattle')
(100.0, 'Chicago', 'Miami')
*/

-- Prediction Query
SELECT flno, origin, destination FROM Flight ORDER BY origin, Flight.flno NULLS LAST;

/*
Prediction Result:
(10.0, 'Boston', 'Seattle')
(100.0, 'Chicago', 'Miami')
(9.0, 'New York', 'London')
*/