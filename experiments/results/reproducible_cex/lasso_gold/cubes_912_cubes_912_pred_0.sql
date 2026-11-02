-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1095.5, 'Airbus A340-300', 1096.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1100.5, 'Airbus A340-300', 1101.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1102.5, 1095.5, 'guy', 'Netherlands', 1098.5, '1977-04-14', '1978-05-15', 1099.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1097.5, 1100.5, 'her', 'Tanzania', 1103.5, '1979-06-16', '1980-07-17', 1104.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "flno" FROM (SELECT "LHS"."flno" AS "flno", "LHS"."origin" AS "origin", "LHS"."destination" AS "destination", "LHS"."distance" AS "distance", "LHS"."departure_date" AS "departure_date", "LHS"."arrival_date" AS "arrival_date", "LHS"."price" AS "price", "LHS"."aid" AS "aid", "RHS"."name" AS "name", "RHS"."distance" AS "distance_other" FROM "flight" AS "LHS" INNER JOIN (SELECT * FROM "aircraft" WHERE ("name" = 'Airbus A340-300')) AS RHS ON (LHS.aid = RHS.aid)) ORDER BY flno, "flno" NULLS LAST;

/*
Gold Result:
(1097.5,)
(1102.5,)
*/

-- Prediction Query
SELECT T1.flno FROM Flight AS T1 JOIN Aircraft AS T2 ON T1.aid = T2.aid WHERE T2.name = 'Airbus A340-300';

/*
Prediction Result:
(1102.5,)
(1097.5,)
*/