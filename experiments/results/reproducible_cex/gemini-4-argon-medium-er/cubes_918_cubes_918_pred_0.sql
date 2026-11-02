-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (eid, name, salary) VALUES (1, 'Alice', 50000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Bob', 40000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, salary FROM employee ORDER BY name, employee.eid NULLS LAST;

/*
Gold Result:
('Alice', 50000.0)
('Bob', 40000.0)
*/

-- Prediction Query
SELECT name, salary FROM Employee ORDER BY salary, Employee.eid NULLS LAST;

/*
Prediction Result:
('Bob', 40000.0)
('Alice', 50000.0)
*/