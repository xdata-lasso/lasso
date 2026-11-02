-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 5000);
INSERT INTO employee (eid, name, salary) VALUES (1, NULL, 50000);
INSERT INTO certificate (eid, aid) VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT "LHS"."aid" AS "aid", "LHS"."name" AS "name", "LHS"."distance" AS "distance", "RHS"."eid" AS "eid" FROM "aircraft" AS "LHS" INNER JOIN "certificate" AS "RHS" ON ("LHS"."aid" = "RHS"."aid")) AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "employee" WHERE ("name" <> 'John Williams')) AS RHS WHERE (LHS.eid = RHS.eid))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Boeing 747',)
*/

-- Prediction Query
SELECT T3.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid JOIN Aircraft AS T3 ON T3.aid = T2.aid WHERE T1.name = 'John Williams';

/*
Prediction Result:
*/