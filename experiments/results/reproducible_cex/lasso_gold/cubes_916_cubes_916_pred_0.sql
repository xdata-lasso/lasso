-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1053.5, 'Melinda Jones', 1054.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1057.5, 'Danielle Ford', 1058.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1055.5, 1053.5, 'push', 'Chile', 1056.5, '1996-05-04', '1970-08-07', 301.0);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1059.5, 1057.5, 'prove', 'Uzbekistan', 1060.5, '1998-07-06', '1997-06-05', 301.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin, destination FROM flight WHERE (price > 300.0) ORDER BY origin, flight.flno NULLS LAST;

/*
Gold Result:
('prove', 'Uzbekistan')
('push', 'Chile')
*/

-- Prediction Query
SELECT origin, destination FROM Flight WHERE price > 300;

/*
Prediction Result:
('push', 'Chile')
('prove', 'Uzbekistan')
*/