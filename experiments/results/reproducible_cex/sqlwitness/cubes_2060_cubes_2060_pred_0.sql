-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (country_id, name, population, area, languages) VALUES (1, NULL, 0, 1, NULL), (0, NULL, NULL, NULL, NULL);
INSERT INTO roller_coaster (roller_coaster_id, country_id, name, park, length, height, speed, opened, status) VALUES (1, 0, 'default2', 'default2', 1.0, 0.0, 'default2', 'default2', NULL), (0, 1, 'default2', 'default2', 1.0, 0.0, 'default1', 'default2', 'default1'), (2, 0, 'default1', 'default1', NULL, 1.0, 'default1', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LENGTH, height FROM roller_coaster ORDER BY LENGTH, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
(None, 1.0)
(1.0, 0.0)
(1.0, 0.0)
*/

-- Prediction Query
SELECT LENGTH, Height FROM roller_coaster;

/*
Prediction Result:
(1.0, 0.0)
(1.0, 0.0)
(None, 1.0)
*/