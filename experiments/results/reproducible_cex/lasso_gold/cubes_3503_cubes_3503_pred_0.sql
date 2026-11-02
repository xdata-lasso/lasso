-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1038.5, 'Lisa Jackson', NULL);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1039.5, 'Carla Gray', NULL);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1040.5, 'Margaret Hawkins DDS', NULL);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1044.5, 'Patty Perez', NULL);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1045.5, 'Ethan Adams', NULL);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1046.5, 'Tommy Walter', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT eid_other AS eid, name_other AS name FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.maxsalary AS maxsalary, RHS.eid AS eid_other, RHS.name AS name_other, RHS.salary AS salary_other, RHS.maxsalary AS maxsalary_other FROM (SELECT eid, name, salary, MAX(salary) OVER () AS maxsalary FROM employee) AS LHS CROSS JOIN (SELECT eid, name, salary, MAX(salary) OVER () AS maxsalary FROM employee) AS RHS) WHERE (maxsalary = salary_other OR salary_other >= maxsalary_other) ORDER BY eid, name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT eid, name FROM Employee ORDER BY salary DESC, Employee.eid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1038.5, 'Lisa Jackson')
*/