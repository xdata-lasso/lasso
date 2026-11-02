-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "employee" ("eid", "name", "salary") VALUES (300, 'Mark Young', 50000.00);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (100, 'Mark Young', 90000.00);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (200, 'Mark Young', 70000.00);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (150, 'Mark Younger', 60000.00);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (250, 'mark young', 65000.00);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (50, 'John Smith', 80000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "eid", "salary" FROM "employee" WHERE ("name" = 'Mark Young') ORDER BY eid;

/*
Gold Result:
(100.0, 90000.0)
(200.0, 70000.0)
(300.0, 50000.0)
*/

-- Prediction Query
SELECT eid, salary FROM Employee WHERE name = 'Mark Young';

/*
Prediction Result:
(300.0, 50000.0)
(100.0, 90000.0)
(200.0, 70000.0)
*/