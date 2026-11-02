-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Boeing 737', 5000);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (101, 'John Doe', 80000.00);
INSERT INTO "certificate" ("eid", "aid") VALUES (101, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, RHS.eid AS eid, RHS.n AS n FROM aircraft AS LHS INNER JOIN (SELECT eid, aid, COUNT(*) OVER () AS n FROM certificate) AS RHS ON (LHS.aid = RHS.aid)) WHERE (distance >= 5000.0 OR n <= 5) ORDER BY name;

/*
Gold Result:
('Boeing 737',)
*/

-- Prediction Query
SELECT T2.name FROM Certificate AS T1 JOIN Aircraft AS T2 ON T2.aid = T1.aid WHERE T2.distance > 5000 GROUP BY T1.aid ORDER BY COUNT(*) >= 5, T2.name NULLS LAST;

/*
Prediction Result:
*/