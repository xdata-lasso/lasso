-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1014, 'Rhonda Smith', 1015, 1016, 'sure');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1020, 'Brent Abbott', 1021, 1022, 'PM');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1017, 1014, 'Andrew Stevens', 'capital', 1019.5, 1019.5, 'source', 'great', 'bar');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1023, 1020, 'Jay Ramirez', 'dinner', 1018.5, 1020.5, 'win', 'human', 'blue');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LENGTH, height FROM roller_coaster ORDER BY LENGTH, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
(1018.5, 1020.5)
(1019.5, 1019.5)
*/

-- Prediction Query
SELECT LENGTH, Height FROM roller_coaster;

/*
Prediction Result:
(1019.5, 1019.5)
(1018.5, 1020.5)
*/