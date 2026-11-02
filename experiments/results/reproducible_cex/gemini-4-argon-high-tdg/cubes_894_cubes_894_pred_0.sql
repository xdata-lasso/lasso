-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Airbus A320', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Boeing 737-800', 3500);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Boeing 747-400', 8000);
INSERT INTO employee (eid, name, salary) VALUES (1, 'Zack', 95000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Alice', 120000.00);
INSERT INTO employee (eid, name, salary) VALUES (3, 'Bob', 75000.00);
INSERT INTO employee (eid, name, salary) VALUES (4, 'Charlie', 60000.00);
INSERT INTO certificate (eid, aid) VALUES (1, 2);
INSERT INTO certificate (eid, aid) VALUES (2, 1);
INSERT INTO certificate (eid, aid) VALUES (2, 2);
INSERT INTO certificate (eid, aid) VALUES (3, 3);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 1, 'Los Angeles', 'Chicago', 1745, '2023-05-01', '2023-05-01', 350.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."eid" AS "eid", "LHS"."aid" AS "aid", "RHS"."name" AS "name", "RHS"."salary" AS "salary" FROM (SELECT * FROM "certificate" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "aircraft" WHERE ("name" <> 'Boeing 737-800')) AS RHS WHERE (LHS.aid = RHS.aid))) AS LHS INNER JOIN employee AS RHS ON (LHS.eid = RHS.eid)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T1.name FROM Employee AS T1 JOIN Certificate AS T2 ON T1.eid = T2.eid JOIN Aircraft AS T3 ON T3.aid = T2.aid WHERE T3.name = 'Boeing 737-800';

/*
Prediction Result:
('Zack',)
('Alice',)
*/