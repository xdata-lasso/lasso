-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Boeing 747', 5000.0);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (300, 10, 'LAX', 'JFK', 2001.0, '2023-01-10', '2023-01-10', 450.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 10, 'SFO', 'ORD', 2000.0, '2023-01-11', '2023-01-11', 350.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (200, 10, 'SEA', 'MIA', 2500.0, '2023-01-12', '2023-01-12', 550.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (400, 10, 'BOS', 'ATL', 1999.0, '2023-01-13', '2023-01-13', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (50, 10, 'DEN', 'ANC', 2000.5, '2023-01-14', '2023-01-14', 400.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (500, 10, 'DFW', 'HOU', NULL, '2023-01-15', '2023-01-15', 150.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno FROM flight WHERE (distance > 2000.0) ORDER BY flno;

/*
Gold Result:
(50.0,)
(200.0,)
(300.0,)
*/

-- Prediction Query
SELECT flno FROM Flight WHERE distance > 2000;

/*
Prediction Result:
(300.0,)
(200.0,)
(50.0,)
*/