-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (14, NULL, '34', '26', 3001, 35, '36', '37', '27');
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (13, 0, '38', '32', 3001, 39, '40', '41', '33');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1, '22', 23, 24, '25');
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (0, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count___ FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.park AS park, RHS.status AS status, RHS.n_distinct AS n_distinct FROM country AS LHS CROSS JOIN (SELECT park, status, COUNT(DISTINCT country_id) AS n_distinct FROM roller_coaster GROUP BY park, status) AS RHS) WHERE (n_distinct >= 3000 OR n_distinct <> country_id) ORDER BY count___;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM country WHERE NOT country_id IN (SELECT country_id FROM roller_coaster WHERE LENGTH > 3000);

/*
Prediction Result:
(0,)
*/