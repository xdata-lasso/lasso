-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (19, 20, '22', 23, NULL, '26', 655, 27);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (18, 20, '655', 655, NULL, '655', 655, 655);
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (21, '655', 655, 655, '655');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (20, '655', 655, 655, '655');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, LHS.maxkilled AS maxkilled, RHS.perpetrator_id AS perpetrator_id_other, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.location AS location_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other, RHS.maxkilled AS maxkilled_other FROM (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS LHS CROSS JOIN (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS RHS) WHERE (killed >= maxkilled_other OR maxkilled <> maxkilled_other) ORDER BY LOCATION;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/