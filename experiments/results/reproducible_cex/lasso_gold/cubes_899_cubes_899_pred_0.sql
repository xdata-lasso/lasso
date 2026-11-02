-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1057.5, 'Benjamin Stanley', 1058.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1062.5, 'Bobby Hall', 1063.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1059.5, 1057.5, 'spring', 'Honolulu', 1060.5, '1992-01-23', '1993-02-01', 1061.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1064.5, 1062.5, 'husband', 'Honolulu', 1065.5, '1994-03-02', '1995-04-03', 1066.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "origin" FROM "flight" WHERE ("destination" = 'Honolulu') ORDER BY origin, flight.flno NULLS LAST;

/*
Gold Result:
('husband',)
('spring',)
*/

-- Prediction Query
SELECT origin FROM Flight WHERE destination = 'Honolulu';

/*
Prediction Result:
('spring',)
('husband',)
*/