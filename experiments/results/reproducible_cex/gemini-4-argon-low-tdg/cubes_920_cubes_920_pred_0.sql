-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty employee table (0 rows) while other tables are populated.
-- Tests crucial boundary difference: Window COUNT(*) OVER () on 0 rows returns 0 rows, whereas Aggregate COUNT(*) returns 1 row with value 0.
INSERT INTO aircraft (aid, name, distance) VALUES (101, 'Boeing 747', 8000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (1, 101, 'LAX', 'JFK', 2500, '2023-01-01', '2023-01-01', 500.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM employee ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Employee;

/*
Prediction Result:
(0,)
*/