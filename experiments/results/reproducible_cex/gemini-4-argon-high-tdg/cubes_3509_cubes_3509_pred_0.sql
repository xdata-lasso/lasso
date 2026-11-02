-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Jet A', 2000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Jet B', 2500);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Jet C', 3000);
INSERT INTO employee (eid, name, salary) VALUES (1, 'Zack', 80000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Aaron', 70000.00);
INSERT INTO employee (eid, name, salary) VALUES (3, 'Mike', 90000.00);
INSERT INTO certificate (eid, aid) VALUES (1, 1);
INSERT INTO certificate (eid, aid) VALUES (1, 2);
INSERT INTO certificate (eid, aid) VALUES (2, 2);
INSERT INTO certificate (eid, aid) VALUES (2, 3);
INSERT INTO certificate (eid, aid) VALUES (3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, salary FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.aid AS aid, LHS.n AS n FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, LHS.aid AS aid, RHS.n AS n FROM (SELECT LHS.eid AS eid, LHS.name AS name, LHS.salary AS salary, RHS.aid AS aid FROM employee AS LHS INNER JOIN certificate AS RHS ON (LHS.eid = RHS.eid)) AS LHS INNER JOIN (SELECT eid, COUNT(*) AS n FROM certificate GROUP BY eid) AS RHS ON (LHS.eid = RHS.eid)) AS LHS INNER JOIN (SELECT eid, MAX(n) OVER () AS n FROM (SELECT eid, COUNT(*) AS n FROM certificate GROUP BY eid)) AS RHS ON (LHS.eid = RHS.eid AND LHS.n = RHS.n)) ORDER BY name, salary NULLS LAST;

/*
Gold Result:
('Aaron', 70000.0)
('Zack', 80000.0)
*/

-- Prediction Query
SELECT T1.name, T1.salary FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid GROUP BY T1.eid ORDER BY COUNT(*) DESC, T1.name NULLS LAST, T1.salary NULLS LAST LIMIT 1;

/*
Prediction Result:
('Aaron', 70000.0)
*/