-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1012, 'Abigail Shaffer', 1013.5, 1014.5, 'Petersonberg');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1019, NULL, NULL, NULL, NULL);
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1024, NULL, NULL, NULL, NULL);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1015, 1012, 'dinner', 1016.5, 'USNV Garcia
FPO AA 13177', 'Guinea-Bissau', 1017, 1018);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1012, 1019, 'throw', 1020.5, 'USNV Garcia
FPO AA 13177', 'Guatemala', 1021, 1022);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1023, 1024, 'dinner', 1016.5, 'USNV Garcia
FPO AA 13177', 'Guinea-Bissau', 1017, 1018);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1024, 1019, 'throw', 1020.5, 'USNV Garcia
FPO AA 13177', 'Guatemala', 1021, 1022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other FROM perpetrator AS LHS INNER JOIN perpetrator AS RHS ON (LHS.people_id = RHS.perpetrator_id AND LHS.location = RHS.location)) ORDER BY LOCATION;

/*
Gold Result:
('USNV Garcia\nFPO AA 13177',)
('USNV Garcia\nFPO AA 13177',)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('USNV Garcia\nFPO AA 13177',)
*/