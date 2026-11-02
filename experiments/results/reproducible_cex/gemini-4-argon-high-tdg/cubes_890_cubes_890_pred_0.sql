-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 120000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A380', 150000);
INSERT INTO employee (eid, name, salary) VALUES (30, 'Bob', 150000.00);
INSERT INTO employee (eid, name, salary) VALUES (10, 'Alice', 120000.00);
INSERT INTO employee (eid, name, salary) VALUES (20, 'Charlie', 100000.00);
INSERT INTO employee (eid, name, salary) VALUES (5, 'David', 99999.99);
INSERT INTO employee (eid, name, salary) VALUES (15, 'Eve', NULL);
INSERT INTO certificate (eid, aid) VALUES (30, 1);
INSERT INTO certificate (eid, aid) VALUES (30, 2);
INSERT INTO certificate (eid, aid) VALUES (5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT eid FROM employee WHERE (salary >= 100000.0) ORDER BY eid;

/*
Gold Result:
(10.0,)
(20.0,)
(30.0,)
*/

-- Prediction Query
SELECT eid FROM Employee WHERE salary > 100000;

/*
Prediction Result:
(30.0,)
(10.0,)
*/