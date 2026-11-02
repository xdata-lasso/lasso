-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by name (out of insertion order), tie-breaking by eid when salaries differ, and exclusion of uncertified employees vs certified employees (if mutant wrongly joins certificate).
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 5000);
INSERT INTO employee (eid, name, salary) VALUES (10, 'Charlie', 60000.00);
INSERT INTO employee (eid, name, salary) VALUES (30, 'Alice', 80000.00);
INSERT INTO employee (eid, name, salary) VALUES (20, 'Alice', 90000.00);
INSERT INTO employee (eid, name, salary) VALUES (5, 'Bob', 70000.00);
INSERT INTO certificate (eid, aid) VALUES (10, 1);
INSERT INTO certificate (eid, aid) VALUES (30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, salary FROM employee ORDER BY name, employee.eid NULLS LAST;

/*
Gold Result:
('Alice', 90000.0)
('Alice', 80000.0)
('Bob', 70000.0)
('Charlie', 60000.0)
*/

-- Prediction Query
SELECT name, salary FROM Employee ORDER BY salary, Employee.eid NULLS LAST;

/*
Prediction Result:
('Charlie', 60000.0)
('Bob', 70000.0)
('Alice', 80000.0)
('Alice', 90000.0)
*/