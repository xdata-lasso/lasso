-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3000);
INSERT INTO employee (eid, name, salary) VALUES (101, 'Zack', 60000);
INSERT INTO employee (eid, name, salary) VALUES (102, 'Alice', 95000);
INSERT INTO employee (eid, name, salary) VALUES (103, 'Alice', 85000);
INSERT INTO employee (eid, name, salary) VALUES (104, 'Alice', NULL);
INSERT INTO employee (eid, name, salary) VALUES (105, 'Bob', 100000);
INSERT INTO certificate (eid, aid) VALUES (101, 1);
INSERT INTO certificate (eid, aid) VALUES (101, 2);
INSERT INTO certificate (eid, aid) VALUES (102, 1);
INSERT INTO certificate (eid, aid) VALUES (102, 2);
INSERT INTO certificate (eid, aid) VALUES (103, 1);
INSERT INTO certificate (eid, aid) VALUES (103, 2);
INSERT INTO certificate (eid, aid) VALUES (104, 1);
INSERT INTO certificate (eid, aid) VALUES (104, 2);
INSERT INTO certificate (eid, aid) VALUES (105, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, salary FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.aid AS aid, LHS.n AS n FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.aid AS aid, RHS.n AS n FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, RHS.aid AS aid FROM employee AS LHS INNER JOIN certificate AS RHS ON (LHS.eid = RHS.eid)) AS LHS INNER JOIN (SELECT eid, COUNT(*) AS n FROM certificate GROUP BY eid) AS RHS ON (LHS.eid = RHS.eid)) AS LHS INNER JOIN (SELECT eid, MAX(n) OVER () AS n FROM (SELECT eid, COUNT(*) AS n FROM certificate GROUP BY eid)) AS RHS ON (LHS.eid = RHS.eid AND LHS.n = RHS.n)) ORDER BY name, salary NULLS LAST;

/*
Gold Result:
('Alice', 85000.0)
('Alice', 95000.0)
('Alice', None)
('Zack', 60000.0)
*/

-- Prediction Query
SELECT T1.name, T1.salary FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid GROUP BY T1.eid ORDER BY COUNT(*) DESC, T1.name NULLS LAST, T1.salary NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice', 85000.0)
*/