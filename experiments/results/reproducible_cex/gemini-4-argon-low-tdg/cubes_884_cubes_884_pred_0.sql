-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join (NOT EXISTS), name inequality (employee named 'Boeing 737-800'),
-- cross-aircraft certification (certified for other aircraft), and ORDER BY.
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 737-800', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 2500);
INSERT INTO employee (eid, name, salary) VALUES (101, 'Charlie', 80000.00);
INSERT INTO employee (eid, name, salary) VALUES (102, 'Alice', 90000.00);
INSERT INTO employee (eid, name, salary) VALUES (103, 'Boeing 737-800', 70000.00);
INSERT INTO employee (eid, name, salary) VALUES (104, 'Bob', 85000.00);
INSERT INTO certificate (eid, aid) VALUES (101, 1);
INSERT INTO certificate (eid, aid) VALUES (102, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT * FROM (SELECT * FROM (SELECT "LHS"."aid" AS "aid", "LHS"."name" AS "name", "LHS"."distance" AS "distance", "RHS"."eid" AS "eid", "RHS"."name" AS "name_other", "RHS"."salary" AS "salary" FROM (SELECT * FROM "aircraft" WHERE ("name" = 'Boeing 737-800')) AS LHS CROSS JOIN employee AS RHS) WHERE (name <> name_other)) AS LHS WHERE NOT EXISTS(SELECT 1 FROM certificate AS RHS WHERE (LHS.aid = RHS.aid AND LHS.eid = RHS.eid))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT name FROM Employee EXCEPT SELECT T1.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid JOIN Aircraft AS T3 ON T3.aid = T2.aid WHERE T3.name = 'Boeing 737-800';

/*
Prediction Result:
('Alice',)
('Bob',)
('Boeing 737-800',)
*/