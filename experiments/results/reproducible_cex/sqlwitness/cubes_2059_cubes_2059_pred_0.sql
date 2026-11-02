-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (country_id, name, population, area, languages) VALUES (1, NULL, NULL, NULL, 'default1'), (0, 'default2', 1, 1, 'default2'), (2, 'default1', 0, NULL, 'default2');
INSERT INTO roller_coaster (roller_coaster_id, country_id, name, park, length, height, speed, opened, status) VALUES (0, NULL, 'default2', NULL, NULL, 1.0, NULL, 'default1', NULL), (1, 1, 'default2', NULL, NULL, NULL, 'default2', NULL, NULL), (2, 1, 'default1', 'default2', 1.0, NULL, 'default1', 'default2', 'default1'), (3, NULL, NULL, 'default2', 1.0, 0.0, 'default2', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status, COUNT(*) OVER () AS count___ FROM roller_coaster ORDER BY status, count___ NULLS LAST;

/*
Gold Result:
(None, 4)
('default1', 4)
('default2', 4)
*/

-- Prediction Query
SELECT Status, COUNT(*) FROM roller_coaster GROUP BY Status;

/*
Prediction Result:
(None, 2)
('default1', 1)
('default2', 1)
*/