-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1001.5, 'Allison Hill', 1004.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1002.5, 'Noah Rhodes', 1011.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1003.5, 'Angie Henderson', 1018.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1007.5, 1001.5, 'all', 'Bermuda', 1010.5, '1970-01-01', '1971-02-02', 1013.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1008.5, 1001.5, 'all', 'Cuba', 1021.5, '1970-01-01', '1971-02-03', 1030.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1009.5, 1001.5, 'all', 'Djibouti', 1032.5, '1970-01-01', '1971-02-04', 1047.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1016.5, 1001.5, 'mouth', 'Netherlands', 1019.5, '1974-05-05', '1975-06-06', 1022.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1017.5, 1001.5, 'mouth', 'Anguilla', 1030.5, '1974-05-05', '1975-06-07', 1039.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1018.5, 1001.5, 'mouth', 'Monaco', 1041.5, '1974-05-05', '1975-06-08', 1056.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin_other AS origin FROM (SELECT LHS.departure_date AS departure_date, LHS.origin AS origin, LHS.n AS n, RHS.departure_date AS departure_date_other, RHS.origin AS origin_other, RHS.n AS n_other FROM (SELECT departure_date, origin, COUNT(*) AS n FROM flight GROUP BY departure_date, origin) AS LHS CROSS JOIN (SELECT departure_date, origin, COUNT(*) AS n FROM flight GROUP BY departure_date, origin) AS RHS) WHERE (n < n_other) ORDER BY origin;

/*
Gold Result:
*/

-- Prediction Query
SELECT origin FROM Flight GROUP BY origin ORDER BY COUNT(*) DESC, origin NULLS LAST LIMIT 1;

/*
Prediction Result:
('all',)
*/