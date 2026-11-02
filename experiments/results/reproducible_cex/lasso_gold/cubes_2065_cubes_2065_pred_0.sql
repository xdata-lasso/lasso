-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1001, 'Allison Hill', 1004, 1007, 'all');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1002, 'Noah Rhodes', 1011.0, 1016.0, 'better');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1003, 'Angie Henderson', 1018.0, 1025.0, 'discover');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1010, 1001, 'Lance Hoffman', 'song', 1013.5, 1016.5, 'save', 'fall', 'source');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1011, 1001, 'Meredith Barnes', 'sure', 1024.5, 1016.5, 'knowledge', 'clearly', 'source');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1012, 1001, 'Donald Booth', 'collection', 1035.5, 1016.5, 'grow', 'dinner', 'source');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM (SELECT height, status, COUNT(*) AS n FROM roller_coaster GROUP BY height, status) WHERE (n <= 2) ORDER BY status;

/*
Gold Result:
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status HAVING COUNT(*) > 2;

/*
Prediction Result:
('source',)
*/