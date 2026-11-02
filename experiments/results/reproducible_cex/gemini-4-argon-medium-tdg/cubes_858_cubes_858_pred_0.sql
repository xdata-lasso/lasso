-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty "perpetrator" table behavior.
-- Window function over an empty table returns 0 rows, whereas a simple aggregate SELECT MAX(Year) returns 1 row with NULL.
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Solo Person', 170.0, 68.0, 'Madrid');
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