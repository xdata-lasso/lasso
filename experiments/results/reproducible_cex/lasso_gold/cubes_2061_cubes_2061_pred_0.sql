-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1014, 'Rhonda Smith', 1015, 1016, 'sure');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1020, 'Brent Abbott', 1021, 1022, 'PM');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1017, 1014, 'Sandra Montgomery', 'capital', 1018.5, 1019.5, 'source', 'great', 'bar');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1023, 1020, 'Jay Ramirez', 'dinner', 1019.5, 1020.5, 'win', 'human', 'blue');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM roller_coaster ORDER BY name, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('Jay Ramirez',)
('Sandra Montgomery',)
*/

-- Prediction Query
SELECT Name FROM roller_coaster ORDER BY LENGTH ASC, roller_coaster.roller_coaster_id NULLS LAST;

/*
Prediction Result:
('Sandra Montgomery',)
('Jay Ramirez',)
*/