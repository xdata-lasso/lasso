-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (16, '20', -563, 17, '18', '19');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (12, '20', -564, 20, '20', '20');
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (20, 16, '20', '20', '20', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.mountain_id AS mountain_id_other, RHS.prominence AS prominence_other, RHS.range AS range_other, RHS.country AS country_other FROM (SELECT mountain_id, name, MAX(height) OVER () AS height, prominence, RANGE, country FROM mountain) AS LHS INNER JOIN mountain AS RHS ON (LHS.height = RHS.height AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('20',)
('20',)
*/

-- Prediction Query
SELECT Name FROM mountain ORDER BY Height DESC, mountain.mountain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('20',)
*/