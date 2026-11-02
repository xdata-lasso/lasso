-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1.0, 'emp_85a01f', 0.01);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (2.0, 'emp_85a01f', 0.02);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT eid, name, salary, AVG(salary) OVER () AS meansalary FROM employee) ORDER BY salary DESC) LIMIT 13);

/*
Gold Result:
('emp_85a01f',)
('emp_85a01f',)
*/

-- Prediction Query
SELECT name FROM Employee WHERE salary > (SELECT AVG(salary) FROM Employee);

/*
Prediction Result:
('emp_85a01f',)
*/