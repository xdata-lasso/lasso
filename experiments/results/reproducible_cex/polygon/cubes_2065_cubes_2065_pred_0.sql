-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (9, 10, '14', '14', 14, 12, '14', '14', NULL);
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (7, 10, '14', '14', 14, 12, '14', '14', NULL);
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (10, '14', 14, 14, '14');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (11, '14', 14, 14, '14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM (SELECT height, status, COUNT(*) AS n FROM roller_coaster GROUP BY height, status) WHERE (n <= 2) ORDER BY status;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status HAVING COUNT(*) > 2;

/*
Prediction Result:
*/