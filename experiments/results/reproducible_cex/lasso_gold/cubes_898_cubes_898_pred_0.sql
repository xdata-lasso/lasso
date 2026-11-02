-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1023.5, 'Mark Young', 1022.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1021.5, 'Mark Young', 1024.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "eid", "salary" FROM "employee" WHERE ("name" = 'Mark Young') ORDER BY eid;

/*
Gold Result:
(1021.5, 1024.5)
(1023.5, 1022.5)
*/

-- Prediction Query
SELECT eid, salary FROM Employee WHERE name = 'Mark Young';

/*
Prediction Result:
(1023.5, 1022.5)
(1021.5, 1024.5)
*/