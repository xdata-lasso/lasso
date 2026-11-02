-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Total certificates (n) = 6 (so n <= 5 is false).
-- Tests: distance boundary values (5000.0, 4999.9, NULL), duplicate elimination (DISTINCT), ORDER BY name, and uncertified aircraft (INNER JOIN vs LEFT JOIN).
-- Tests: PARTITION BY aid vs OVER () because each aircraft has <= 5 certificates, though total n is 6.
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Zeta', 5000.0);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (2, 'Alpha', 4999.9);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (3, 'Beta', 6000.0);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (4, 'Uncertified', 7000.0);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (5, 'NullDist', NULL);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (101, 'Emp1', 50000.0);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (102, 'Emp2', 60000.0);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (103, 'Emp3', 70000.0);
INSERT INTO "certificate" ("eid", "aid") VALUES (101, 1);
INSERT INTO "certificate" ("eid", "aid") VALUES (102, 1);
INSERT INTO "certificate" ("eid", "aid") VALUES (101, 2);
INSERT INTO "certificate" ("eid", "aid") VALUES (102, 2);
INSERT INTO "certificate" ("eid", "aid") VALUES (103, 3);
INSERT INTO "certificate" ("eid", "aid") VALUES (103, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, RHS.eid AS eid, RHS.n AS n FROM aircraft AS LHS INNER JOIN (SELECT eid, aid, COUNT(*) OVER () AS n FROM certificate) AS RHS ON (LHS.aid = RHS.aid)) WHERE (distance >= 5000.0 OR n <= 5) ORDER BY name;

/*
Gold Result:
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.name FROM Certificate AS T1 JOIN Aircraft AS T2 ON T2.aid = T1.aid WHERE T2.distance > 5000 GROUP BY T1.aid ORDER BY COUNT(*) >= 5, T2.name NULLS LAST;

/*
Prediction Result:
('Beta',)
*/