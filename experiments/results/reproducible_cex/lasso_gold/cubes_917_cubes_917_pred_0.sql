-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1001.5, 'Allison Hill', 1005.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1002.5, 'Noah Rhodes', 1012.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1003.5, 'Angie Henderson', 1019.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1004.5, 'Daniel Wagner', 1026.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT aid, name FROM (SELECT * FROM (SELECT * FROM aircraft ORDER BY aid) LIMIT 1);

/*
Gold Result:
(1001.5, 'Allison Hill')
*/

-- Prediction Query
SELECT aid, name FROM Aircraft ORDER BY distance DESC, Aircraft.aid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1004.5, 'Daniel Wagner')
*/