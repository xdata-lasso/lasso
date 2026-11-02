-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General comprehensive dataset:
-- Tests DISTINCT (multiple lower-price flights), ORDER BY flno, Ties for MAX(price),
-- NULLs in distance (for NULLS LAST), NULLs in price, and partitioned window mutants (via diverse aid/origin/destination).
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3500);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Embraer E175', 2000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (30, 1, 'NYC', 'LON', NULL, '2023-01-01', '2023-01-02', 1000.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (10, 2, 'LAX', 'SFO', 500, '2023-01-03', '2023-01-03', 1000.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (20, 1, 'NYC', 'PAR', 3600, '2023-01-05', '2023-01-06', 800.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (40, 2, 'LAX', 'SEA', 1000, '2023-01-07', '2023-01-07', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (5, 3, 'BOS', 'MIA', 1200, '2023-01-08', '2023-01-08', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT flno, distance FROM (SELECT LHS.flno AS flno, LHS.origin AS origin, LHS.destination AS destination, LHS.distance AS distance, LHS.departure_date AS departure_date, LHS.arrival_date AS arrival_date, LHS.price AS price, LHS.aid AS aid, LHS.maxprice AS maxprice, RHS.flno AS flno_other, RHS.origin AS origin_other, RHS.destination AS destination_other, RHS.distance AS distance_other, RHS.departure_date AS departure_date_other, RHS.arrival_date AS arrival_date_other, RHS.price AS price_other, RHS.aid AS aid_other, RHS.maxprice AS maxprice_other FROM (SELECT flno, origin, destination, distance, departure_date, arrival_date, price, aid, MAX(price) OVER () AS maxprice FROM flight) AS LHS CROSS JOIN (SELECT flno, origin, destination, distance, departure_date, arrival_date, price, aid, MAX(price) OVER () AS maxprice FROM flight) AS RHS) WHERE (price >= maxprice_other AND price_other < maxprice_other) ORDER BY flno, distance NULLS LAST;

/*
Gold Result:
(10.0, 500.0)
(30.0, None)
*/

-- Prediction Query
SELECT flno, distance FROM Flight ORDER BY price DESC, Flight.flno NULLS LAST LIMIT 1;

/*
Prediction Result:
(10.0, 500.0)
*/