-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE predicate (AND vs OR, string matching, swapped origin/destination) and primary ORDER BY (departure_date).
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Boeing 747', 8000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (101, 1, 'Los Angeles', 'Honolulu', 2550, '2023-05-10', '2023-05-11', 450.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (102, 1, 'Los Angeles', 'Honolulu', 2550, '2023-05-01', '2023-05-02', 400.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (103, 1, 'Los Angeles', 'New York', 2475, '2023-05-05', '2023-05-06', 350.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (104, 1, 'Chicago', 'Honolulu', 4250, '2023-05-05', '2023-05-06', 650.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (105, 1, 'Honolulu', 'Los Angeles', 2550, '2023-05-05', '2023-05-06', 450.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "departure_date", "arrival_date" FROM "flight" WHERE ("origin" = 'Los Angeles' AND "destination" = 'Honolulu') ORDER BY departure_date, flight.flno NULLS LAST;

/*
Gold Result:
('2023-05-01', '2023-05-02')
('2023-05-10', '2023-05-11')
*/

-- Prediction Query
SELECT departure_date, arrival_date FROM Flight WHERE origin = 'Los Angeles' AND destination = 'Honolulu';

/*
Prediction Result:
('2023-05-10', '2023-05-11')
('2023-05-01', '2023-05-02')
*/