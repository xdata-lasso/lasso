-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, "home town") VALUES (0, NULL, 1.0, 1.0, 'default1'), (1, NULL, 1.0, 1.0, 'default2'), (2, NULL, 1.0, 1.0, 'default2'), (3, 'default2', NULL, 0.0, 'default1'), (4, 'default2', 1.0, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(YEAR) OVER () AS max_year_ FROM perpetrator ORDER BY max_year_;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(YEAR) FROM perpetrator;

/*
Prediction Result:
(None,)
*/