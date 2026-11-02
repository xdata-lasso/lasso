-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'PeakZ', 9000.0, 4000.0, 'RangeA', 'CountryX');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'PeakA', 9000.0, 3000.0, 'RangeB', 'CountryY');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'PeakM', 5000.0, 9000.0, 'RangeC', 'CountryZ');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 3, 'Climber1', 'CountryZ', '10:00', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.mountain_id AS mountain_id_other, RHS.prominence AS prominence_other, RHS.range AS range_other, RHS.country AS country_other FROM (SELECT mountain_id, name, MAX(height) OVER () AS height, prominence, RANGE, country FROM mountain) AS LHS INNER JOIN mountain AS RHS ON (LHS.height = RHS.height AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('PeakA',)
('PeakZ',)
*/

-- Prediction Query
SELECT Name FROM mountain ORDER BY Height DESC, mountain.mountain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('PeakZ',)
*/