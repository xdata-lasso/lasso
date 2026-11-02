-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (destination = 'Honolulu' vs others, origin = 'Honolulu'),
-- duplicate retention (SELECT vs SELECT DISTINCT), and ordering (ASC vs DESC).
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Boeing 747', 8000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (101, 1, 'Chicago', 'Honolulu', 4200, '2023-01-01', '2023-01-01', 500.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (102, 1, 'Boston', 'Honolulu', 5000, '2023-01-02', '2023-01-02', 600.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (103, 1, 'Boston', 'Honolulu', 5000, '2023-01-03', '2023-01-03', 650.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (104, 1, 'Honolulu', 'Chicago', 4200, '2023-01-04', '2023-01-04', 500.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (105, 1, 'Seattle', 'Miami', 2700, '2023-01-05', '2023-01-05', 350.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "origin" FROM "flight" WHERE ("destination" = 'Honolulu') ORDER BY origin, flight.flno NULLS LAST;

/*
Gold Result:
('Boston',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT origin FROM Flight WHERE destination = 'Honolulu';

/*
Prediction Result:
('Chicago',)
('Boston',)
('Boston',)
*/