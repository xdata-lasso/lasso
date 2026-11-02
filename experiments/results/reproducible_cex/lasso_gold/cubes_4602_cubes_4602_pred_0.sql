-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1001, 'Allison Hill', 1002, 1003, 'dog');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1004, 1001, 'Brian Yang', 'offer', 1005.5, 1006.5, 'begin', 'performance', 'knowledge');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1007, 1001, 'Brandon Hall', 'play', 1008.5, 1009.5, 'agreement', 'option', 'decide');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT park FROM (SELECT LHS.roller_coaster_id AS roller_coaster_id, LHS.name AS name, LHS.park AS park, LHS.country_id AS country_id, LHS.length AS LENGTH, LHS.height AS height, LHS.speed AS speed, LHS.opened AS opened, LHS.status AS status, RHS.status AS status_other, RHS.speed AS speed_other FROM roller_coaster AS LHS CROSS JOIN (SELECT status, MAX(speed) AS speed FROM roller_coaster GROUP BY status) AS RHS) WHERE (speed = speed_other) ORDER BY park;

/*
Gold Result:
('offer',)
('play',)
*/

-- Prediction Query
SELECT Park FROM roller_coaster ORDER BY Speed DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('offer',)
*/