-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 5000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A380', 6000);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Boeing 747', 7000);
INSERT INTO aircraft (aid, name, distance) VALUES (4, 'Cessna 172', 800);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 1, 'NYC', 'LON', 3500, '2023-01-01', '2023-01-02', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 1, 'LON', 'PAR', 200, '2023-01-01', '2023-01-01', 100.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (103, 1, 'PAR', 'NYC', 3600, '2023-01-02', '2023-01-02', 550.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (104, 2, 'LAX', 'TYO', 5500, '2023-01-01', '2023-01-02', 800.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (105, 3, 'MIA', 'BOG', 1500, '2023-01-01', '2023-01-01', 300.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.aid AS aid, LHS.departure_date AS departure_date, LHS.n AS n, RHS.name AS name, RHS.distance AS distance FROM (SELECT aid, departure_date, COUNT(*) AS n FROM flight GROUP BY aid, departure_date) AS LHS INNER JOIN aircraft AS RHS ON (LHS.aid = RHS.aid)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Airbus A380', 1)
('Boeing 747', 1)
('Boeing 747', 1)
('Boeing 747', 2)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid GROUP BY T1.aid;

/*
Prediction Result:
('Boeing 747', 3)
('Airbus A380', 1)
('Boeing 747', 1)
*/