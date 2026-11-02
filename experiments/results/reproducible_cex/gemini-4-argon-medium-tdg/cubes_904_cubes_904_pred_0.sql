-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (102, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (101, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (103, 'Airbus A380', 9000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, distance FROM aircraft ORDER BY name, aircraft.aid NULLS LAST;

/*
Gold Result:
('Airbus A380', 9000.0)
('Boeing 747', 8000.0)
('Boeing 747', 8000.0)
*/

-- Prediction Query
SELECT name, distance FROM Aircraft;

/*
Prediction Result:
('Boeing 747', 8000.0)
('Boeing 747', 8000.0)
('Airbus A380', 9000.0)
*/