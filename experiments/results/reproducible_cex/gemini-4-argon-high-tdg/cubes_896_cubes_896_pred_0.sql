-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (300, 'Alpha', 1000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (100, 'Charlie', 5000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (200, 'Bravo', 1001.0);
INSERT INTO aircraft (aid, name, distance) VALUES (50, 'Delta', 999.0);
INSERT INTO aircraft (aid, name, distance) VALUES (400, 'Echo', 0.0);
INSERT INTO aircraft (aid, name, distance) VALUES (500, 'Foxtrot', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT aid FROM aircraft WHERE (distance >= 1000.0) ORDER BY aid;

/*
Gold Result:
(100.0,)
(200.0,)
(300.0,)
*/

-- Prediction Query
SELECT aid FROM Aircraft WHERE distance > 1000;

/*
Prediction Result:
(100.0,)
(200.0,)
*/