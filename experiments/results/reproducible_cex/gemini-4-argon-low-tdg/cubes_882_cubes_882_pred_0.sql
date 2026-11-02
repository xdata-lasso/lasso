-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY flno (ASC vs DESC, vs ORDER BY distance, vs ORDER BY price, vs insertion order).
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Airbus A380', 8000.0);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (300, 10, 'SFO', 'TYO', 5000.0, '2023-02-01', '2023-02-02', 900.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 10, 'SFO', 'JFK', 2500.0, '2023-02-03', '2023-02-03', 400.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (200, 10, 'SFO', 'HNL', 2400.0, '2023-02-04', '2023-02-04', 800.00);
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