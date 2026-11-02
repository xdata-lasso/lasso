-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Boeing 747', 8000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (2, 'Airbus A320', 3000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (300, 1, 'Los Angeles', 'New York', 2500, '2023-05-01', '2023-05-01', 400.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (100, 2, 'Los Angeles', 'Chicago', 1700, '2023-05-02', '2023-05-02', 150.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (200, 1, 'Los Angeles', 'Tokyo', 5400, '2023-05-03', '2023-05-04', 900.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (400, 2, 'Chicago', 'Los Angeles', 1700, '2023-05-01', '2023-05-01', 150.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (500, 1, 'los angeles', 'Boston', 2600, '2023-05-01', '2023-05-01', 350.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (600, 1, 'Los Angeles International', 'Seattle', 1000, '2023-05-01', '2023-05-01', 120.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (700, 1, NULL, 'Miami', 2300, '2023-05-01', '2023-05-01', 300.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flno" FROM "flight" WHERE ("origin" = 'Los Angeles') ORDER BY flno;

/*
Gold Result:
(100.0,)
(200.0,)
(300.0,)
*/

-- Prediction Query
SELECT flno FROM Flight WHERE origin = 'Los Angeles';

/*
Prediction Result:
(300.0,)
(100.0,)
(200.0,)
*/