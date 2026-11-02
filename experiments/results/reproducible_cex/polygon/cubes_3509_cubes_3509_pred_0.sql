-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (23, 34, '30', '30', 30, '1000-01-31', '1000-01-31', 30);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (22, 34, '30', '30', 30, '1000-01-31', '1000-01-31', 30);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (34, '30', 30);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (32, '30', 30);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (25, '30', NULL);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (24, '30', NULL);
INSERT INTO "certificate" ("eid", "aid") VALUES (25, 32);
INSERT INTO "certificate" ("eid", "aid") VALUES (24, 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, salary FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.aid AS aid, LHS.n AS n FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.aid AS aid, RHS.n AS n FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, RHS.aid AS aid FROM employee AS LHS INNER JOIN certificate AS RHS ON (LHS.eid = RHS.eid)) AS LHS INNER JOIN (SELECT eid, COUNT(*) AS n FROM certificate GROUP BY eid) AS RHS ON (LHS.eid = RHS.eid)) AS LHS INNER JOIN (SELECT eid, MAX(n) OVER () AS n FROM (SELECT eid, COUNT(*) AS n FROM certificate GROUP BY eid)) AS RHS ON (LHS.eid = RHS.eid AND LHS.n = RHS.n)) ORDER BY name, salary NULLS LAST;

/*
Gold Result:
('30', None)
*/

-- Prediction Query
SELECT T1.name, T1.salary FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid GROUP BY T1.eid ORDER BY COUNT(*) DESC, T1.name NULLS LAST, T1.salary NULLS LAST LIMIT 1;

/*
Prediction Result:
('30', None)
*/