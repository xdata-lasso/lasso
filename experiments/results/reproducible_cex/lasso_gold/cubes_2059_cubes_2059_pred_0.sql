-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1007, 'Brandon Hall', 1008, 1009, 'play');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1013, 'Rhonda Smith', 1014, 1015, 'sure');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1010, 1007, 'Cristian Santos', 'offer', 1011.5, 1012.5, 'kind', 'discussion', 'list');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1016, NULL, 'Jay Ramirez', 'dinner', 1017.5, 1018.5, 'source', 'great', 'blue');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status, COUNT(*) OVER () AS count___ FROM roller_coaster ORDER BY status, count___ NULLS LAST;

/*
Gold Result:
('blue', 2)
('list', 2)
*/

-- Prediction Query
SELECT Status, COUNT(*) FROM roller_coaster GROUP BY Status;

/*
Prediction Result:
('blue', 1)
('list', 1)
*/