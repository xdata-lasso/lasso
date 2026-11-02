-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ordering vs insertion order, ordering by wrong columns (name, distance), descending order, and unnecessary joins with other tables.
-- The minimum aid (10) is inserted second, has the lexicographically largest name ('Zephyr'), the largest distance (5000), and has no associated flights or certificates.
INSERT INTO aircraft (aid, name, distance) VALUES (50, 'Boeing 747', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Zephyr', 5000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A380', 1000);
INSERT INTO employee (eid, name, salary) VALUES (101, 'Alice', 90000.00);
INSERT INTO certificate (eid, aid) VALUES (101, 50);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (1001, 50, 'NYC', 'LAX', 2500, '2023-01-01', '2023-01-01', 400.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT aid, name FROM (SELECT * FROM (SELECT * FROM aircraft ORDER BY aid) LIMIT 1);

/*
Gold Result:
(2.0, 'Airbus A380')
*/

-- Prediction Query
SELECT aid, name FROM Aircraft ORDER BY distance DESC, Aircraft.aid NULLS LAST LIMIT 1;

/*
Prediction Result:
(10.0, 'Zephyr')
*/