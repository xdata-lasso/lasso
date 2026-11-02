-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: aircraft --
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1.0, 'air_777cba', 1.0);

-- Inserting into table: employee --
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1.0, 'lhs_52e411', 1.0);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (2.0, 'lhs_52e411', 1.0);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (3.0, 'emp_85a01f', 0.03);

-- Inserting into table: certificate --
INSERT INTO "certificate" ("eid", "aid") VALUES (1.0, 1.0);

INSERT INTO "certificate" ("eid", "aid") VALUES (2.0, 1.0);

INSERT INTO "certificate" ("eid", "aid") VALUES (3.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, salary FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.aid AS aid, LHS.n AS n FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.aid AS aid, RHS.n AS n FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, RHS.aid AS aid FROM employee AS LHS INNER JOIN certificate AS RHS ON (LHS.eid = RHS.eid)) AS LHS INNER JOIN (SELECT eid, COUNT(*) AS n FROM certificate GROUP BY eid) AS RHS ON (LHS.eid = RHS.eid)) AS LHS INNER JOIN (SELECT eid, MAX(n) OVER () AS n FROM (SELECT eid, COUNT(*) AS n FROM certificate GROUP BY eid)) AS RHS ON (LHS.eid = RHS.eid AND LHS.n = RHS.n)) ORDER BY name, salary NULLS LAST;

/*
Gold Result:
('emp_85a01f', 0.03)
('lhs_52e411', 1.0)
*/

-- Prediction Query
SELECT T1.name, T1.salary FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid GROUP BY T1.eid ORDER BY COUNT(*) DESC, T1.name NULLS LAST, T1.salary NULLS LAST LIMIT 1;

/*
Prediction Result:
('emp_85a01f', 0.03)
*/