-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Boeing 747', 8000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1, 1, 'Los Angeles', 'Honolulu', 2550, '2023-08-15', '2023-08-15', 450.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (2, 1, 'Los Angeles', 'Honolulu', 2550, '2023-03-10', '2023-03-11', 520.50);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (3, 1, 'Los Angeles', 'Honolulu', 2550, '2023-05-20', '2023-05-20', 399.99);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (4, 1, 'Los Angeles', 'Chicago', 1745, '2023-04-01', '2023-04-01', 300.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (5, 1, 'Seattle', 'Honolulu', 2677, '2023-04-02', '2023-04-02', 410.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (6, 1, 'Honolulu', 'Los Angeles', 2550, '2023-04-03', '2023-04-03', 460.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (7, 1, 'Chicago', 'Seattle', 1733, '2023-04-04', '2023-04-04', 280.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "departure_date", "arrival_date" FROM "flight" WHERE ("origin" = 'Los Angeles' AND "destination" = 'Honolulu') ORDER BY departure_date, flight.flno NULLS LAST;

/*
Gold Result:
('2023-03-10', '2023-03-11')
('2023-05-20', '2023-05-20')
('2023-08-15', '2023-08-15')
*/

-- Prediction Query
SELECT departure_date, arrival_date FROM Flight WHERE origin = 'Los Angeles' AND destination = 'Honolulu';

/*
Prediction Result:
('2023-08-15', '2023-08-15')
('2023-03-10', '2023-03-11')
('2023-05-20', '2023-05-20')
*/