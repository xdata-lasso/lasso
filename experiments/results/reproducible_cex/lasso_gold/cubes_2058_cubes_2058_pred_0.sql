-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1070, 'Janice Carlson', 1071, 1072, 'management');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1076, 'Sheila Evans', 1077, 1078, 'put');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1073, 1070, 'Tricia Valencia', 'about', 1074.5, 1075.5, 'response', 'set', 'building');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1079, 1076, 'Jonathan White', 'activity', 1075.5, 1076.5, 'seven', 'type', 'serve');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.roller_coaster_id AS roller_coaster_id, RHS.name AS name_other, RHS.park AS park, RHS.length AS LENGTH, RHS.height AS height, RHS.speed AS speed, RHS.opened AS opened, RHS.status AS status FROM country AS LHS INNER JOIN roller_coaster AS RHS ON (LHS.country_id = RHS.country_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Jonathan White', 'Sheila Evans')
('Tricia Valencia', 'Janice Carlson')
*/

-- Prediction Query
SELECT T2.Name, T1.Name FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID = T2.Country_ID;

/*
Prediction Result:
('Tricia Valencia', 'Janice Carlson')
('Jonathan White', 'Sheila Evans')
*/