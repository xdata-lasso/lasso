-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (eid, name, salary) VALUES (1, 'Alice', 100000.0);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Bob', 200000.0);
INSERT INTO employee (eid, name, salary) VALUES (3, 'Charlie', 150000.0);
INSERT INTO employee (eid, name, salary) VALUES (4, 'David', 150000.0);
INSERT INTO employee (eid, name, salary) VALUES (5, 'Eve', 99999.99);
INSERT INTO employee (eid, name, salary) VALUES (6, 'Frank', 200000.01);
INSERT INTO employee (eid, name, salary) VALUES (7, 'Grace', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT salary) AS n_distinct FROM (SELECT * FROM employee WHERE (salary > 100000.0 AND salary < 200000.0))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Employee WHERE salary BETWEEN 100000 AND 200000;

/*
Prediction Result:
(4,)
*/