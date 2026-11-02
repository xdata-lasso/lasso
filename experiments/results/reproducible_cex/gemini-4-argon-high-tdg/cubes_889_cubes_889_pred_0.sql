-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'B737', 500.0);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'B747', 1000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'A320', 2500.0);
INSERT INTO aircraft (aid, name, distance) VALUES (4, 'A320', 2500.0);
INSERT INTO aircraft (aid, name, distance) VALUES (5, 'A320', 3500.0);
INSERT INTO aircraft (aid, name, distance) VALUES (6, 'B777', 5000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (7, 'A380', 7500.0);
INSERT INTO aircraft (aid, name, distance) VALUES (8, 'C172', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT distance) AS n_distinct FROM (SELECT * FROM aircraft WHERE (distance > 1000.0 AND distance < 5000.0))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Aircraft WHERE distance BETWEEN 1000 AND 5000;

/*
Prediction Result:
(5,)
*/