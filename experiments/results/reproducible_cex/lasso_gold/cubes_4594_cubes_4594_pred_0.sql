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
SELECT DISTINCT status FROM (SELECT country_id, status, MAX(n) AS maxn FROM (SELECT roller_coaster_id, name, park, country_id, LENGTH, height, speed, opened, status, COUNT(*) OVER () AS n FROM roller_coaster) GROUP BY country_id, status) ORDER BY status;

/*
Gold Result:
('blue',)
('list',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status ORDER BY COUNT(*) DESC, Status NULLS LAST LIMIT 1;

/*
Prediction Result:
('blue',)
*/