-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests primary sorting (departure_date ASC vs DESC) and secondary tie-breaker sorting (flno ASC vs DESC vs arrival_date)
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Airbus A320', 3300);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (202, 1, 'Los Angeles', 'Honolulu', 2550, '2023-06-15', '2023-06-16', 500.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (105, 1, 'Los Angeles', 'Honolulu', 2550, '2023-06-15', '2023-06-17', 520.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (301, 1, 'Los Angeles', 'Honolulu', 2550, '2023-06-10', '2023-06-11', 480.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "departure_date", "arrival_date" FROM "flight" WHERE ("origin" = 'Los Angeles' AND "destination" = 'Honolulu') ORDER BY departure_date, flight.flno NULLS LAST;

/*
Gold Result:
('2023-06-10', '2023-06-11')
('2023-06-15', '2023-06-17')
('2023-06-15', '2023-06-16')
*/

-- Prediction Query
SELECT departure_date, arrival_date FROM Flight WHERE origin = 'Los Angeles' AND destination = 'Honolulu';

/*
Prediction Result:
('2023-06-15', '2023-06-16')
('2023-06-15', '2023-06-17')
('2023-06-10', '2023-06-11')
*/