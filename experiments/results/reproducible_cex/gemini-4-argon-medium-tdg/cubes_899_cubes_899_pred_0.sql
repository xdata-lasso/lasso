-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (101, 'Boeing 747', 8000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1, 101, 'Seattle', 'Honolulu', 2600, '2023-05-01', '2023-05-01', 450.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (2, 101, 'Los Angeles', 'Honolulu', 2550, '2023-05-01', '2023-05-01', 400.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (3, 101, 'Los Angeles', 'Honolulu', 2550, '2023-05-02', '2023-05-02', 420.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (4, 101, 'Chicago', 'Miami', 1200, '2023-05-01', '2023-05-01', 300.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (5, 101, 'Honolulu', 'Seattle', 2600, '2023-05-03', '2023-05-03', 460.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "origin" FROM "flight" WHERE ("destination" = 'Honolulu') ORDER BY origin, flight.flno NULLS LAST;

/*
Gold Result:
('Los Angeles',)
('Los Angeles',)
('Seattle',)
*/

-- Prediction Query
SELECT origin FROM Flight WHERE destination = 'Honolulu';

/*
Prediction Result:
('Seattle',)
('Los Angeles',)
('Los Angeles',)
*/