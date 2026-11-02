-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 737', 500.0);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Boeing 747', 1000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Airbus A320', 2500.0);
INSERT INTO aircraft (aid, name, distance) VALUES (4, 'Airbus A321', 2500.0);
INSERT INTO aircraft (aid, name, distance) VALUES (5, 'Boeing 777', 4000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (6, 'Boeing 787', 5000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (7, 'Airbus A380', 8000.0);
INSERT INTO aircraft (aid, name, distance) VALUES (8, 'Cessna 172', NULL);
INSERT INTO employee (eid, name, salary) VALUES (101, 'John Doe', 80000.0);
INSERT INTO certificate (eid, aid) VALUES (101, 3);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (10, 3, 'LAX', 'JFK', 2500.0, '2023-01-01', '2023-01-02', 300.0);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (11, 3, 'JFK', 'LAX', 2500.0, '2023-01-03', '2023-01-04', 300.0);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (12, 1, 'SFO', 'LAX', 3000.0, '2023-01-05', '2023-01-05', 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT distance) AS n_distinct FROM (SELECT * FROM aircraft WHERE (distance > 1000.0 AND distance < 5000.0))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Aircraft WHERE distance BETWEEN 1000 AND 5000;

/*
Prediction Result:
(5,)
*/