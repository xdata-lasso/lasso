-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (-760, 9, '-760', '-760', -760, '0997-12-02', '0997-12-02', -760);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (8, '-760', -760);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (9, '-760', -760);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (11, '12', NULL);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (10, '-760', -760);
INSERT INTO "certificate" ("eid", "aid") VALUES (11, 9);
INSERT INTO "certificate" ("eid", "aid") VALUES (10, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT meansalary AS avg_salary_, MAX(salary) OVER () AS max_salary_ FROM (SELECT eid, name, salary, AVG(salary) OVER () AS meansalary FROM employee) ORDER BY avg_salary_, max_salary_ NULLS LAST;

/*
Gold Result:
(-760.0, -760.0)
*/

-- Prediction Query
SELECT AVG(salary), MAX(salary) FROM Employee;

/*
Prediction Result:
(-760.0, -760.0)
*/