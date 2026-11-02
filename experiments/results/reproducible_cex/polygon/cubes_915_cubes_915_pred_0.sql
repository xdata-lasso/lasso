-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (8, 10, NULL, '1', 1, '1000-01-02', '1000-01-15', 1);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (7, 9, NULL, '1', 1, '1000-01-02', '1000-01-14', 1);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (9, '1', 1);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (10, '1', 1);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (12, '1', 1);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (11, '1', 1);
INSERT INTO "certificate" ("eid", "aid") VALUES (12, 10);
INSERT INTO "certificate" ("eid", "aid") VALUES (11, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin, n AS count___ FROM (SELECT arrival_date, origin, COUNT(*) AS n FROM flight GROUP BY arrival_date, origin) ORDER BY origin, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
*/

-- Prediction Query
SELECT origin, COUNT(*) FROM Flight GROUP BY origin;

/*
Prediction Result:
(None, 2)
*/