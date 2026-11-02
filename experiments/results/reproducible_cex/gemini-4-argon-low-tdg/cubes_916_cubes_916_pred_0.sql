-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY origin, flight.flno NULLS LAST
-- Specifically ensures that tie-breaking on flno is observable by giving same origin different destinations in inverse order of flno
-- Also tests SQLite's allowance of NULL in non-INTEGER PRIMARY KEY (flno is REAL PRIMARY KEY) to test NULLS LAST vs NULLS FIRST
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Airbus A320', 3000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (200, 1, 'CHI', 'MIA', 1200, '2023-02-01', '2023-02-01', 400.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 1, 'CHI', 'SEA', 1700, '2023-02-01', '2023-02-01', 450.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (NULL, 1, 'CHI', 'BOS', 850, '2023-02-01', '2023-02-01', 350.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (50, 1, 'ATL', 'DEN', 1400, '2023-02-01', '2023-02-01', 600.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (300, 1, NULL, 'DFW', 1000, '2023-02-01', '2023-02-01', 500.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin, destination FROM flight WHERE (price > 300.0) ORDER BY origin, flight.flno NULLS LAST;

/*
Gold Result:
(None, 'DFW')
('ATL', 'DEN')
('CHI', 'SEA')
('CHI', 'MIA')
('CHI', 'BOS')
*/

-- Prediction Query
SELECT origin, destination FROM Flight WHERE price > 300;

/*
Prediction Result:
('CHI', 'MIA')
('CHI', 'SEA')
('CHI', 'BOS')
('ATL', 'DEN')
(None, 'DFW')
*/