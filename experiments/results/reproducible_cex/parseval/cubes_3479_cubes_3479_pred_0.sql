-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: aircraft --
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1.0, 'lhs_e3e483', 1.0);

INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (2.0, 'lhs_e3e483', 1.0);

INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (3.0, 'air_777cba', 3.0);

-- Inserting into table: employee --
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1.0, 'emp_85a01f', 0.01);

-- Inserting into table: certificate --
INSERT INTO "certificate" ("eid", "aid") VALUES (1.0, 1.0);

INSERT INTO "certificate" ("eid", "aid") VALUES (1.0, 2.0);

INSERT INTO "certificate" ("eid", "aid") VALUES (1.0, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, LHS.eid AS eid, LHS.n AS n FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, LHS.eid AS eid, RHS.n AS n FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, RHS.eid AS eid FROM aircraft AS LHS INNER JOIN certificate AS RHS ON (LHS.aid = RHS.aid)) AS LHS INNER JOIN (SELECT aid, COUNT(*) AS n FROM certificate GROUP BY aid) AS RHS ON (LHS.aid = RHS.aid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT aid, COUNT(*) AS n FROM certificate GROUP BY aid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY name;

/*
Gold Result:
('air_777cba',)
('lhs_e3e483',)
*/

-- Prediction Query
SELECT T2.name FROM Certificate AS T1 JOIN Aircraft AS T2 ON T2.aid = T1.aid GROUP BY T1.aid ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('air_777cba',)
*/