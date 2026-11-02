-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the maximum certificate count across multiple aircraft (kills LIMIT 1 mutants),
-- ORDER BY name (reverse insertion order), DISTINCT (multiple certificates per winning aircraft),
-- and the difference between MAX and MIN counts.
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Zulu', 5000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Alpha', 6000);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Middle', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (4, 'Uncertified', 4000);
INSERT INTO employee (eid, name, salary) VALUES (101, 'Emp1', 70000);
INSERT INTO employee (eid, name, salary) VALUES (102, 'Emp2', 80000);
INSERT INTO employee (eid, name, salary) VALUES (103, 'Emp3', 90000);
INSERT INTO certificate (eid, aid) VALUES (101, 1);
INSERT INTO certificate (eid, aid) VALUES (102, 1);
INSERT INTO certificate (eid, aid) VALUES (103, 1);
INSERT INTO certificate (eid, aid) VALUES (101, 2);
INSERT INTO certificate (eid, aid) VALUES (102, 2);
INSERT INTO certificate (eid, aid) VALUES (103, 2);
INSERT INTO certificate (eid, aid) VALUES (101, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, LHS.eid AS eid, LHS.n AS n FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, LHS.eid AS eid, RHS.n AS n FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, RHS.eid AS eid FROM aircraft AS LHS INNER JOIN certificate AS RHS ON (LHS.aid = RHS.aid)) AS LHS INNER JOIN (SELECT aid, COUNT(*) AS n FROM certificate GROUP BY aid) AS RHS ON (LHS.aid = RHS.aid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT aid, COUNT(*) AS n FROM certificate GROUP BY aid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT T2.name FROM Certificate AS T1 JOIN Aircraft AS T2 ON T2.aid = T1.aid GROUP BY T1.aid ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/