-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (16, NULL, NULL, NULL, 19, NULL, '-719', NULL, '22');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (24, NULL, NULL, NULL, 27, NULL, NULL, NULL, NULL);
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (11, NULL, NULL, NULL, NULL);
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (12, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT park FROM (SELECT LHS.roller_coaster_id AS roller_coaster_id, LHS.name AS name, LHS.park AS park, LHS.country_id AS country_id, LHS.length AS LENGTH, LHS.height AS height, LHS.speed AS speed, LHS.opened AS opened, LHS.status AS status, RHS.status AS status_other, RHS.speed AS speed_other FROM roller_coaster AS LHS CROSS JOIN (SELECT status, MAX(speed) AS speed FROM roller_coaster GROUP BY status) AS RHS) WHERE (speed = speed_other) ORDER BY park;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Park FROM roller_coaster ORDER BY Speed DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/