-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (101, 'Boeing 747', 5000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (102, 'Airbus A380', 6000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (103, 'Concorde', 4000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (104, 'Cessna 172', 1000);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (105, 'Piper Cub', 500);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1, 'John Williams', 90000.00);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (2, 'Alice Brown', 80000.00);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (3, 'Zack Taylor', 85000.00);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (4, 'John Williams', 75000.00);
INSERT INTO "certificate" ("eid", "aid") VALUES (1, 101);
INSERT INTO "certificate" ("eid", "aid") VALUES (1, 102);
INSERT INTO "certificate" ("eid", "aid") VALUES (2, 102);
INSERT INTO "certificate" ("eid", "aid") VALUES (3, 102);
INSERT INTO "certificate" ("eid", "aid") VALUES (2, 103);
INSERT INTO "certificate" ("eid", "aid") VALUES (3, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT "LHS"."aid" AS "aid", "LHS"."name" AS "name", "LHS"."distance" AS "distance", "RHS"."eid" AS "eid" FROM "aircraft" AS "LHS" INNER JOIN "certificate" AS "RHS" ON ("LHS"."aid" = "RHS"."aid")) AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "employee" WHERE ("name" <> 'John Williams')) AS RHS WHERE (LHS.eid = RHS.eid))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Airbus A380',)
('Boeing 747',)
*/

-- Prediction Query
SELECT T3.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid JOIN Aircraft AS T3 ON T3.aid = T2.aid WHERE T1.name = 'John Williams';

/*
Prediction Result:
('Boeing 747',)
('Airbus A380',)
*/