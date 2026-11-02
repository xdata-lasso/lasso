-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (10, 'Airbus A340-300', 6000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (20, 'Airbus A340-300', 7500);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (30, 'Boeing 777', 6000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (40, 'Airbus A340', 6000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (50, 'airbus a340-300', 6000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (300, 10, 'New York', 'London', 3500, '2023-05-03', '2023-05-04', 400.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (50, 20, 'Paris', 'Tokyo', 6000, '2023-05-10', '2023-05-11', 900.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1000, 10, 'Berlin', 'Rome', 800, '2023-05-01', '2023-05-01', 150.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (200, 20, 'Madrid', 'Cairo', 2100, '2023-05-05', '2023-05-05', 600.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (150, 30, 'Boston', 'Seattle', 2500, '2023-05-02', '2023-05-02', 300.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (250, 40, 'Chicago', 'Miami', 1200, '2023-05-06', '2023-05-06', 220.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (350, 50, 'Dallas', 'Denver', 650, '2023-05-07', '2023-05-07', 180.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flno" FROM (SELECT "LHS"."flno" AS "flno", "LHS"."origin" AS "origin", "LHS"."destination" AS "destination", "LHS"."distance" AS "distance", "LHS"."departure_date" AS "departure_date", "LHS"."arrival_date" AS "arrival_date", "LHS"."price" AS "price", "LHS"."aid" AS "aid", "RHS"."name" AS "name", "RHS"."distance" AS "distance_other" FROM "flight" AS "LHS" INNER JOIN (SELECT * FROM "aircraft" WHERE ("name" = 'Airbus A340-300')) AS RHS ON (LHS.aid = RHS.aid)) ORDER BY flno, "flno" NULLS LAST;

/*
Gold Result:
(50.0,)
(200.0,)
(300.0,)
(1000.0,)
*/

-- Prediction Query
SELECT T1.flno FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid WHERE T2.name = 'Airbus A340-300';

/*
Prediction Result:
(300.0,)
(50.0,)
(1000.0,)
(200.0,)
*/