-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1001, 'Allison Hill', 1002.5, 1003.5, 'East Jill');
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1004, 1001, 'require', 1005.5, '600 Jeffery Parkways
New Jamesside, MT 29394', 'Kiribati', 1006, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM perpetrator WHERE (injured >= 50 AND injured > 20) ORDER BY country, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
('Kiribati',)
*/

-- Prediction Query
SELECT Country FROM perpetrator WHERE Injured > 50 INTERSECT SELECT Country FROM perpetrator WHERE Injured < 20;

/*
Prediction Result:
*/