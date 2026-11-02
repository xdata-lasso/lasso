-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values around 2000.0 (including exact 2000.0, 1999.9, 2000.1, 0, negative) and NULL distance.
-- Also tests ordering by flno vs ordering by distance, price, or aid.
INSERT INTO aircraft (aid, name, distance) VALUES (1.0, 'Boeing 747', 1000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (2.0, 'Airbus A380', 5000.0);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (300.0, 1.0, 'NYC', 'LON', 2000.1, '2023-01-03', '2023-01-04', 1500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100.0, 2.0, 'LAX', 'TYO', 5000.0, '2023-01-01', '2023-01-02', 3000.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (200.0, 1.0, 'SFO', 'SYD', 2001.0, '2023-01-02', '2023-01-03', 2000.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (400.0, 2.0, 'ORD', 'FRA', 2000.0, '2023-01-04', '2023-01-05', 2500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (500.0, 1.0, 'MIA', 'MAD', 1999.9, '2023-01-05', '2023-01-06', 2100.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (600.0, 2.0, 'BOS', 'DUB', 0.0, '2023-01-06', '2023-01-07', 2200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (700.0, 1.0, 'SEA', 'ICN', -2500.0, '2023-01-07', '2023-01-08', 2300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (800.0, 2.0, 'DFW', 'CDG', NULL, '2023-01-08', '2023-01-09', 2400.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno FROM flight WHERE (distance > 2000.0) ORDER BY flno;

/*
Gold Result:
(100.0,)
(200.0,)
(300.0,)
*/

-- Prediction Query
SELECT flno FROM Flight WHERE distance > 2000;

/*
Prediction Result:
(300.0,)
(100.0,)
(200.0,)
*/