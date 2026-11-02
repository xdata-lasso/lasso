-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1048.5, 'Carla Kelly', 1049.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1052.5, 'Melinda Jones', 1053.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1054.5, 1048.5, 'prove', 'Chile', 2001.0, '1994-03-02', '1995-04-03', 1051.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1050.5, 1052.5, 'religious', 'Ethiopia', 2001.0, '1996-05-04', '1997-06-05', 1055.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno FROM flight WHERE (distance > 2000.0) ORDER BY flno;

/*
Gold Result:
(1050.5,)
(1054.5,)
*/

-- Prediction Query
SELECT flno FROM Flight WHERE distance > 2000;

/*
Prediction Result:
(1054.5,)
(1050.5,)
*/