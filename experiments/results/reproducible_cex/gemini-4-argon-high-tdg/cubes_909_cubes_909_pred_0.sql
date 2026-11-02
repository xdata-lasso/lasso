-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Zeppelin', 5000);
INSERT INTO aircraft (aid, name, distance) VALUES (20, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (30, 'Airbus A320', 3000);
INSERT INTO employee (eid, name, salary) VALUES (1, 'Alice Smith', 95000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Bob Jones', 120000.00);
INSERT INTO certificate (eid, aid) VALUES (1, 10);
INSERT INTO certificate (eid, aid) VALUES (2, 10);
INSERT INTO certificate (eid, aid) VALUES (1, 30);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 10, 'NYC', 'LON', 3500, '2023-05-01', '2023-05-01', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 10, 'LON', 'PAR', 5000, '2023-05-01', '2023-05-01', 150.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (103, 10, 'PAR', 'BER', 6000, '2023-05-01', '2023-05-02', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (104, 10, 'BER', 'ROM', 1200, '2023-05-02', '2023-05-02', 180.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (105, 10, 'ROM', 'MAD', 1400, '2023-05-03', '2023-05-03', 210.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (201, 20, 'LAX', 'JFK', 2500, '2023-05-01', '2023-05-01', 400.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (202, 20, 'LAX', 'JFK', 2500, '2023-05-01', '2023-05-01', 400.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.aid AS aid, LHS.departure_date AS departure_date, LHS.n AS n, RHS.name AS name, RHS.distance AS distance FROM (SELECT aid, departure_date, COUNT(*) AS n FROM flight GROUP BY aid, departure_date) AS LHS INNER JOIN aircraft AS RHS ON (LHS.aid = RHS.aid)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Boeing 747', 2)
('Zeppelin', 1)
('Zeppelin', 1)
('Zeppelin', 3)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid GROUP BY T1.aid;

/*
Prediction Result:
('Zeppelin', 5)
('Boeing 747', 2)
*/