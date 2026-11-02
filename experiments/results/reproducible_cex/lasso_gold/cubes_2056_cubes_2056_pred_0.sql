-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1001, 'Allison Hill', 1002, 1003, 'dog');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1004, 1001, 'Brian Yang', 'offer', 1005.5, 100.0, 'begin', 'performance', 'knowledge');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status FROM roller_coaster WHERE (height <= 3300.0 AND height >= 100.0) ORDER BY status, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('knowledge',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster WHERE LENGTH > 3300 OR Height > 100;

/*
Prediction Result:
*/