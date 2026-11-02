-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Airbus A320', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Concorde', 4000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 2, 'NYC', 'LON', 3450, '2023-05-01', '2023-05-02', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 1, 'LON', 'NYC', 3450, '2023-05-03', '2023-05-04', 450.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (103, 2, 'NYC', 'LON', 3450, '2023-05-05', '2023-05-06', 600.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (104, 3, 'PAR', 'ROM', 680, '2023-05-07', '2023-05-07', 200.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.aid AS aid, LHS.price AS price, LHS.n AS n, RHS.name AS name, RHS.distance AS distance FROM (SELECT aid, price, COUNT(*) AS n FROM (SELECT flno, destination AS origin, destination, distance, departure_date, arrival_date, price, aid, flno_other, distance_other, departure_date_other, arrival_date_other, price_other, aid_other FROM (SELECT flno, origin, origin AS destination, distance, departure_date, arrival_date, price, aid, flno_other, distance_other, departure_date_other, arrival_date_other, price_other, aid_other FROM (SELECT LHS.flno AS flno, LHS.origin AS origin, LHS.destination AS destination, LHS.distance AS distance, LHS.departure_date AS departure_date, LHS.arrival_date AS arrival_date, LHS.price AS price, LHS.aid AS aid, RHS.flno AS flno_other, RHS.distance AS distance_other, RHS.departure_date AS departure_date_other, RHS.arrival_date AS arrival_date_other, RHS.price AS price_other, RHS.aid AS aid_other FROM flight AS LHS INNER JOIN flight AS RHS ON (LHS.origin = RHS.destination AND LHS.destination = RHS.origin)))) GROUP BY aid, price) AS LHS LEFT JOIN aircraft AS RHS ON (LHS.aid = RHS.aid)) ORDER BY name;

/*
Gold Result:
('Airbus A320',)
('Boeing 747',)
('Boeing 747',)
*/

-- Prediction Query
SELECT T2.name FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid GROUP BY T1.aid HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Boeing 747',)
*/