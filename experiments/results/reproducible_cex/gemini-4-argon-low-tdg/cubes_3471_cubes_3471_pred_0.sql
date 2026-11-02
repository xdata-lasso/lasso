-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 737', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3500);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Boeing 777', 7000);
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Embraer 190', 2000);
INSERT INTO employee (eid, name, salary) VALUES (1, 'John Doe', 50000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Jane Smith', 60000.00);
INSERT INTO certificate (eid, aid) VALUES (1, 1);
INSERT INTO certificate (eid, aid) VALUES (2, 2);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (1, 1, 'Chicago', 'Miami', 1200, '2023-01-01', '2023-01-01', 250.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (2, 3, 'New York', 'London', 3500, '2023-01-02', '2023-01-03', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (3, 10, 'Boston', 'Dallas', 1500, '2023-01-04', '2023-01-04', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (4, 3, 'Boston', 'Seattle', 2500, '2023-01-05', '2023-01-05', 400.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (5, 2, 'Los Angeles', 'Tokyo', 5500, '2023-01-06', '2023-01-07', 800.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT origin FROM (SELECT flno, origin, destination, distance, departure_date, arrival_date, price, aid, n, departure_date_other, n AS maxn FROM (SELECT LHS.flno AS flno, LHS.origin AS origin, LHS.destination AS destination, LHS.distance AS distance, LHS.departure_date AS departure_date, LHS.arrival_date AS arrival_date, LHS.price AS price, LHS.aid AS aid, LHS.n AS n, RHS.departure_date AS departure_date_other FROM (SELECT flno, origin, destination, distance, departure_date, arrival_date, price, aid, COUNT(*) OVER () AS n FROM flight) AS LHS INNER JOIN (SELECT aid, departure_date, MAX(n) AS maxn FROM (SELECT flno, origin, destination, distance, departure_date, arrival_date, price, aid, COUNT(*) OVER () AS n FROM flight) GROUP BY aid, departure_date) AS RHS ON (LHS.n = RHS.maxn AND LHS.flno = RHS.aid))) ORDER BY origin;

/*
Gold Result:
('Boston',)
('Chicago',)
('New York',)
*/

-- Prediction Query
SELECT origin FROM Flight GROUP BY origin ORDER BY COUNT(*) DESC, origin NULLS LAST LIMIT 1;

/*
Prediction Result:
('Boston',)
*/