-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (6, 9, '10', '10', 10, 10, '10', '10', NULL);
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (5, NULL, '10', '10', 10, 10, '10', '10', '11');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (7, '10', 10, 10, '10');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (9, '10', 10, 10, '10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status, COUNT(*) OVER () AS count___ FROM roller_coaster ORDER BY status, count___ NULLS LAST;

/*
Gold Result:
(None, 2)
('11', 2)
*/

-- Prediction Query
SELECT Status, COUNT(*) FROM roller_coaster GROUP BY Status;

/*
Prediction Result:
(None, 1)
('11', 1)
*/