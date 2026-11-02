-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by price (ASC vs DESC), LIMIT 3 boundary (5 rows), and decoupling of price, distance, and flno.
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (105, 1, 'NYC', 'LAX', 5000, '2023-01-01', '2023-01-01', 100.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 1, 'LAX', 'SFO', 4000, '2023-01-02', '2023-01-02', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (104, 1, 'SFO', 'SEA', 1000, '2023-01-03', '2023-01-03', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 1, 'SEA', 'ORD', 2000, '2023-01-04', '2023-01-04', 400.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (103, 1, 'ORD', 'NYC', 3000, '2023-01-05', '2023-01-05', 500.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno FROM (SELECT * FROM (SELECT * FROM flight ORDER BY price, flight.flno NULLS LAST) LIMIT 3);

/*
Gold Result:
(105.0,)
(102.0,)
(104.0,)
*/

-- Prediction Query
SELECT flno FROM Flight ORDER BY distance ASC, Flight.flno NULLS LAST LIMIT 3;

/*
Prediction Result:
(104.0,)
(101.0,)
(103.0,)
*/