-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Alpha', 500);
INSERT INTO aircraft (aid, name, distance) VALUES (50, 'Zephyr', 9000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Midway', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (25, 'Delta', 1500);
INSERT INTO employee (eid, name, salary) VALUES (101, 'John Smith', 85000.00);
INSERT INTO certificate (eid, aid) VALUES (101, 10);
INSERT INTO certificate (eid, aid) VALUES (101, 50);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (1001, 10, 'Boston', 'Chicago', 400, '2023-05-01', '2023-05-01', 250.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (1002, 50, 'New York', 'London', 3500, '2023-05-02', '2023-05-03', 800.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT aid, name FROM (SELECT * FROM (SELECT * FROM aircraft ORDER BY aid) LIMIT 1);

/*
Gold Result:
(2.0, 'Midway')
*/

-- Prediction Query
SELECT aid, name FROM Aircraft ORDER BY distance DESC, Aircraft.aid NULLS LAST LIMIT 1;

/*
Prediction Result:
(50.0, 'Zephyr')
*/