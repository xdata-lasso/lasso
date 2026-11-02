-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (eid, name, salary) VALUES (300, 'Alice', 100000.00);
INSERT INTO employee (eid, name, salary) VALUES (100, 'Bob', 100000.01);
INSERT INTO employee (eid, name, salary) VALUES (200, 'Charlie', 99999.99);
INSERT INTO employee (eid, name, salary) VALUES (400, 'David', 150000.50);
INSERT INTO employee (eid, name, salary) VALUES (50, 'Eve', 50000.00);
INSERT INTO employee (eid, name, salary) VALUES (600, 'Frank', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT eid FROM employee WHERE (salary >= 100000.0) ORDER BY eid;

/*
Gold Result:
(100.0,)
(300.0,)
(400.0,)
*/

-- Prediction Query
SELECT eid FROM Employee WHERE salary > 100000;

/*
Prediction Result:
(100.0,)
(400.0,)
*/