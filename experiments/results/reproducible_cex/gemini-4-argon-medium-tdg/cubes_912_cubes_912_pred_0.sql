-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, filtering by aircraft name, ordering, and ignoring unreferenced tables (employee, certificate)
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Airbus A340-300', 8000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (2, 'Boeing 747-400', 8500);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (3, 'airbus a340-300', 8000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (300, 1, 'JFK', 'LHR', 3450, '2023-05-01', '2023-05-02', 650.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (100, 1, 'LAX', 'NRT', 5450, '2023-06-01', '2023-06-02', 950.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (200, 2, 'SFO', 'FRA', 5699, '2023-07-01', '2023-07-02', 800.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (400, 3, 'ORD', 'CDG', 4150, '2023-08-01', '2023-08-02', 700.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flno" FROM (SELECT "LHS"."flno" AS "flno", "LHS"."origin" AS "origin", "LHS"."destination" AS "destination", "LHS"."distance" AS "distance", "LHS"."departure_date" AS "departure_date", "LHS"."arrival_date" AS "arrival_date", "LHS"."price" AS "price", "LHS"."aid" AS "aid", "RHS"."name" AS "name", "RHS"."distance" AS "distance_other" FROM "flight" AS "LHS" INNER JOIN (SELECT * FROM "aircraft" WHERE ("name" = 'Airbus A340-300')) AS RHS ON (LHS.aid = RHS.aid)) ORDER BY flno, "flno" NULLS LAST;

/*
Gold Result:
(100.0,)
(300.0,)
*/

-- Prediction Query
SELECT T1.flno FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid WHERE T2.name = 'Airbus A340-300';

/*
Prediction Result:
(300.0,)
(100.0,)
*/