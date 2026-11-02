-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (1000.0), off-by-one values, NULLs, and anti-correlated ordering between aid and distance.
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (30, 'Cessna 172', 1000.0);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (10, 'Boeing 747', 5000.0);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (20, 'Airbus A320', 1000.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (40, 'Piper Cub', 999.9);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (50, 'Glider', 0.0);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (60, 'Prototype', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT aid FROM aircraft WHERE (distance >= 1000.0) ORDER BY aid;

/*
Gold Result:
(10.0,)
(20.0,)
(30.0,)
*/

-- Prediction Query
SELECT aid FROM Aircraft WHERE distance > 1000;

/*
Prediction Result:
(10.0,)
(20.0,)
*/