-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3500);
INSERT INTO employee (eid, name, salary) VALUES (101, 'Alice Smith', 95000.00);
INSERT INTO certificate (eid, aid) VALUES (101, 1);
INSERT INTO certificate (eid, aid) VALUES (101, 2);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (10, 1, 'Seattle', 'Miami', 2700, '2023-06-01', '2023-06-01', 300.01);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (80, 2, 'Boston', 'Atlanta', 200, '2023-06-02', '2023-06-02', 350.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (50, 1, 'Boston', 'Denver', 800, '2023-06-03', '2023-06-03', 600.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (90, 1, 'Austin', 'Dallas', 500, '2023-06-04', '2023-06-04', 300.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (95, 2, 'Austin', 'Houston', 400, '2023-06-05', '2023-06-05', 299.99);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (400, 1, 'Chicago', 'Phoenix', 1500, '2023-06-06', '2023-06-06', 150.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin, destination FROM flight WHERE (price > 300.0) ORDER BY origin, flight.flno NULLS LAST;

/*
Gold Result:
('Boston', 'Denver')
('Boston', 'Atlanta')
('Seattle', 'Miami')
*/

-- Prediction Query
SELECT origin, destination FROM Flight WHERE price > 300;

/*
Prediction Result:
('Seattle', 'Miami')
('Boston', 'Atlanta')
('Boston', 'Denver')
*/