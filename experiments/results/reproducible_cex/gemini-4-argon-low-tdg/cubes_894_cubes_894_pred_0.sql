-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Boeing 737-800', 3000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (2, 'Boeing 737-800', 3200);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (3, 'Embraer E175', 2000);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (201, 'Zack', 120000);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (202, 'Aaron', 80000);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (203, 'Aaron', 85000);
INSERT INTO "certificate" ("eid", "aid") VALUES (201, 1);
INSERT INTO "certificate" ("eid", "aid") VALUES (201, 2);
INSERT INTO "certificate" ("eid", "aid") VALUES (202, 1);
INSERT INTO "certificate" ("eid", "aid") VALUES (203, 2);
INSERT INTO "certificate" ("eid", "aid") VALUES (203, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."eid" AS "eid", "LHS"."aid" AS "aid", "RHS"."name" AS "name", "RHS"."salary" AS "salary" FROM (SELECT * FROM "certificate" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "aircraft" WHERE ("name" <> 'Boeing 737-800')) AS RHS WHERE (LHS.aid = RHS.aid))) AS LHS INNER JOIN employee AS RHS ON (LHS.eid = RHS.eid)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Aaron',)
('Aaron',)
('Zack',)
('Zack',)
*/

-- Prediction Query
SELECT T1.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid JOIN Aircraft AS T3 ON T3.aid = T2.aid WHERE T3.name = 'Boeing 737-800';

/*
Prediction Result:
('Zack',)
('Zack',)
('Aaron',)
('Aaron',)
*/