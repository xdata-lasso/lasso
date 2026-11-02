-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1038.5, 'Lisa Jackson', NULL);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1039.5, 'Carla Gray', NULL);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1040.5, 'Margaret Hawkins DDS', NULL);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1044.5, 'Patty Perez', NULL);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1045.5, 'Ethan Adams', NULL);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1046.5, 'Tommy Walter', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT aid, name FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, LHS.maxdistance AS maxdistance, RHS.aid AS aid_other, RHS.name AS name_other, RHS.distance AS distance_other, RHS.maxdistance AS maxdistance_other FROM (SELECT aid, name, distance, MAX(distance) OVER () AS maxdistance FROM aircraft) AS LHS CROSS JOIN (SELECT aid, name, distance, MAX(distance) OVER () AS maxdistance FROM aircraft) AS RHS) WHERE (distance = maxdistance_other OR distance_other > maxdistance_other) ORDER BY aid, name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT aid, name FROM Aircraft ORDER BY distance DESC, Aircraft.aid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1038.5, 'Lisa Jackson')
*/