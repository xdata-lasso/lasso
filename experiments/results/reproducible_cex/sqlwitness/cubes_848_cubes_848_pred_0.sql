-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, height, weight, "home town") VALUES (0, NULL, NULL, 0.0, NULL), (1, 'default2', 1.0, NULL, NULL), (2, 'default2', NULL, 0.0, 'default1'), (3, 'default2', 0.0, 0.0, NULL), (4, 'default1', 0.0, 0.0, NULL), (5, NULL, NULL, 0.0, 'default2'), (6, 'default1', NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(injured) OVER () AS avg_injured_ FROM perpetrator ORDER BY avg_injured_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(Injured) FROM perpetrator;

/*
Prediction Result:
(None,)
*/