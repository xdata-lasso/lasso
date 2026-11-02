-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (13, 14, '797', '797', 797, '1002-03-09', '1002-03-09', 797);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (12, NULL, '797', '797', 797, '1002-03-09', '1002-03-09', 797);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (14, '18', 797);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (15, '19', 796);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (17, '797', 797);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (16, '797', 797);
INSERT INTO "certificate" ("eid", "aid") VALUES (16, 15);
INSERT INTO "certificate" ("eid", "aid") VALUES (16, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT aid, name FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, LHS.maxdistance AS maxdistance, RHS.aid AS aid_other, RHS.name AS name_other, RHS.distance AS distance_other, RHS.maxdistance AS maxdistance_other FROM (SELECT aid, name, distance, MAX(distance) OVER () AS maxdistance FROM aircraft) AS LHS CROSS JOIN (SELECT aid, name, distance, MAX(distance) OVER () AS maxdistance FROM aircraft) AS RHS) WHERE (distance = maxdistance_other OR distance_other > maxdistance_other) ORDER BY aid, name NULLS LAST;

/*
Gold Result:
(14.0, '18')
*/

-- Prediction Query
SELECT aid, name FROM Aircraft ORDER BY distance DESC, Aircraft.aid NULLS LAST LIMIT 1;

/*
Prediction Result:
(14.0, '18')
*/