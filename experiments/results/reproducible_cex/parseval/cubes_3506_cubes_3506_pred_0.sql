-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: aircraft --
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1.0, 'air_10e091', 1.0);

INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (0.0, 'air_10e091', 1.0);

INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (-1.0, 'air_10e091', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT aid, name FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, LHS.maxdistance AS maxdistance, RHS.aid AS aid_other, RHS.name AS name_other, RHS.distance AS distance_other, RHS.maxdistance AS maxdistance_other FROM (SELECT aid, name, distance, MAX(distance) OVER () AS maxdistance FROM aircraft) AS LHS CROSS JOIN (SELECT aid, name, distance, MAX(distance) OVER () AS maxdistance FROM aircraft) AS RHS) WHERE (distance = maxdistance_other OR distance_other > maxdistance_other) ORDER BY aid, name NULLS LAST;

/*
Gold Result:
(-1.0, 'air_10e091')
(0.0, 'air_10e091')
(1.0, 'air_10e091')
*/

-- Prediction Query
SELECT aid, name FROM Aircraft ORDER BY distance DESC, Aircraft.aid NULLS LAST LIMIT 1;

/*
Prediction Result:
(-1.0, 'air_10e091')
*/