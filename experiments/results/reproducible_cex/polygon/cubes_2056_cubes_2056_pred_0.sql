-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (10, NULL, NULL, NULL, NULL, 100, NULL, NULL, '22');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (9, 13, '18', '19', -463, 101, '20', '21', '22');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (12, '22', 22, 22, '22');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (13, '22', 22, 22, '22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status FROM roller_coaster WHERE (height <= 3300.0 AND height >= 100.0) ORDER BY status, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('22',)
('22',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster WHERE LENGTH > 3300 OR Height > 100;

/*
Prediction Result:
('22',)
*/