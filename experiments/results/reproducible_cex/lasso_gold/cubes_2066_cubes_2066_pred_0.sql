-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1001, 'Allison Hill', 1005, 1009, 'agreement');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1002, 'Noah Rhodes', 1012.0, 1018.0, 'option');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1003, 'Angie Henderson', 1019.0, 1027.0, 'decide');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1004, 'Daniel Wagner', 1026.0, 1036.0, 'sense');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1013, 1001, 'Kimberly Robinson', 'best', 1017.5, 1021.5, 'throw', 'surface', 'not');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1014, 1001, 'Rhonda Smith', 'husband', 1028.5, 1034.5, 'guy', 'animal', 'capital');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1015, 1001, 'Melissa Peterson', 'bill', 1039.5, 1047.5, 'PM', 'show', 'win');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1016, 1001, 'Tyler Rogers', 'her', 1050.5, 1060.5, 'everything', 'machine', 'human');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT speed FROM (SELECT * FROM (SELECT * FROM roller_coaster ORDER BY country_id DESC, roller_coaster.roller_coaster_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('throw',)
*/

-- Prediction Query
SELECT Speed FROM roller_coaster ORDER BY LENGTH DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('everything',)
*/