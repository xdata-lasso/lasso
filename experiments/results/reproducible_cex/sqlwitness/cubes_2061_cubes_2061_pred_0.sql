-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (country_id, name, population, area, languages) VALUES (0, NULL, 0, 0, 'default1'), (1, 'default1', NULL, 1, 'default1'), (2, NULL, 1, 1, 'default2'), (3, 'default1', NULL, NULL, 'default2'), (4, NULL, 0, NULL, 'default1');
INSERT INTO roller_coaster (roller_coaster_id, country_id, name, park, length, height, speed, opened, status) VALUES (1, NULL, 'default1', 'default2', NULL, NULL, 'default1', 'default2', 'default2'), (0, 3, 'default2', 'default2', NULL, 0.0, NULL, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM roller_coaster ORDER BY name, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM roller_coaster ORDER BY LENGTH ASC, roller_coaster.roller_coaster_id NULLS LAST;

/*
Prediction Result:
('default2',)
('default1',)
*/