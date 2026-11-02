-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (country_id, name, population, area, languages) VALUES (0, 'German', 1, 1, 'default1'), (1, 'German', NULL, 1, NULL), (2, 'German', NULL, 0, 'German'), (3, NULL, 0, 0, 'default2'), (4, NULL, 0, NULL, 'German'), (5, NULL, NULL, NULL, 'default1'), (6, 'default1', NULL, 1, NULL), (7, 'German', 1, 0, 'default1'), (8, NULL, 0, 1, 'default1'), (9, 'default1', 0, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "country" WHERE ("languages" <> 'German') ORDER BY name, country.country_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('German',)
('German',)
('default1',)
*/

-- Prediction Query
SELECT Name FROM country WHERE Languages <> 'German';

/*
Prediction Result:
('German',)
(None,)
(None,)
('German',)
(None,)
('default1',)
*/