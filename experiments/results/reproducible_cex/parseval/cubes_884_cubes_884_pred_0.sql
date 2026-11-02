-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: aircraft --
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1.0, 'Boeing 737-800', 1.0);

INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (2.0, 'Boeing 737-800', 2.0);

INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (3.0, 'Boeing 737-800', 3.0);

-- Inserting into table: employee --
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1.0, 'emp_2f2cf2', 0.01);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (2.0, 'emp_2f2cf2', 0.02);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (3.0, 'emp_2f2cf2', 0.03);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (4.0, 'emp_2f2cf2', 0.04);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (5.0, 'emp_927fbe', 0.05);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (6.0, 'emp_2f2cf2', 0.06);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (7.0, 'emp_2f2cf2', 0.07);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (8.0, 'emp_2f2cf2', 0.08);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (9.0, 'emp_2f2cf2', 0.09);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (10.0, 'emp_2f2cf2', 0.1);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (11.0, 'emp_2f2cf2', 0.11);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (12.0, 'emp_2f2cf2', 0.12);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (13.0, 'emp_2f2cf2', 0.13);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (14.0, 'emp_2f2cf2', 0.14);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (15.0, 'emp_2f2cf2', 0.15);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (16.0, 'emp_2f2cf2', 0.16);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (17.0, 'emp_2f2cf2', 0.17);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (18.0, 'emp_2f2cf2', 0.18);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (19.0, 'emp_2f2cf2', 0.19);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (20.0, 'emp_2f2cf2', 0.2);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (21.0, 'emp_2f2cf2', 0.21);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (22.0, 'emp_2f2cf2', 0.22);

INSERT INTO "employee" ("eid", "name", "salary") VALUES (23.0, NULL, 0.23);

-- Inserting into table: certificate --
INSERT INTO "certificate" ("eid", "aid") VALUES (1.0, 1.0);

INSERT INTO "certificate" ("eid", "aid") VALUES (2.0, 1.0);

INSERT INTO "certificate" ("eid", "aid") VALUES (1.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT * FROM (SELECT * FROM (SELECT "LHS"."aid" AS "aid", "LHS"."name" AS "name", "LHS"."distance" AS "distance", "RHS"."eid" AS "eid", "RHS"."name" AS "name_other", "RHS"."salary" AS "salary" FROM (SELECT * FROM "aircraft" WHERE ("name" = 'Boeing 737-800')) AS LHS CROSS JOIN employee AS RHS) WHERE (name <> name_other)) AS LHS WHERE NOT EXISTS(SELECT 1 FROM certificate AS RHS WHERE (LHS.aid = RHS.aid AND LHS.eid = RHS.eid))) ORDER BY name;

/*
Gold Result:
('emp_2f2cf2',)
('emp_927fbe',)
*/

-- Prediction Query
SELECT name FROM Employee EXCEPT SELECT T1.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid JOIN Aircraft AS T3 ON T3.aid = T2.aid WHERE T3.name = 'Boeing 737-800';

/*
Prediction Result:
(None,)
('emp_927fbe',)
*/