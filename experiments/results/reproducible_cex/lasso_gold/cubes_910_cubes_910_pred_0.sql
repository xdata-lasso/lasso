-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1011.5, 'Allen Robinson', 1012.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1016.5, 'Cristian Santos', 1017.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1018.5, 1011.5, 'mouth', 'Italy', 1014.5, '1974-05-05', '1975-06-06', 1015.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1013.5, 1016.5, 'offer', 'Netherlands', 1019.5, '1976-07-07', '1977-08-08', 1020.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno, origin, destination FROM flight ORDER BY flno;

/*
Gold Result:
(1013.5, 'offer', 'Netherlands')
(1018.5, 'mouth', 'Italy')
*/

-- Prediction Query
SELECT flno, origin, destination FROM Flight ORDER BY origin, Flight.flno NULLS LAST;

/*
Prediction Result:
(1018.5, 'mouth', 'Italy')
(1013.5, 'offer', 'Netherlands')
*/