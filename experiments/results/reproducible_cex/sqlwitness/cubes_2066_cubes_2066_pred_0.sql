-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (country_id, name, population, area, languages) VALUES (1, 'default2', 0, 0, NULL), (0, 'default1', NULL, 0, NULL);
INSERT INTO roller_coaster (roller_coaster_id, country_id, name, park, length, height, speed, opened, status) VALUES (1, 1, 'default2', 'default2', 1.0, NULL, 'default1', NULL, NULL), (0, 1, 'default1', NULL, NULL, 2.0, NULL, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT speed FROM (SELECT * FROM (SELECT * FROM roller_coaster ORDER BY country_id DESC, roller_coaster.roller_coaster_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Speed FROM roller_coaster ORDER BY LENGTH DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/