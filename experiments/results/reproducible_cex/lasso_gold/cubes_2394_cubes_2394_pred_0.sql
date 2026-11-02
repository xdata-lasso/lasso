-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1029, 'Amber Perez', 1030.5, 1031.5, 'figure', 'Belgium');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1039, 'Danielle Ford', 1040.5, 1041.5, 'expect', 'Uzbekistan');
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1032, 1029, 'Sharon James', 'Korea', 'prove', 1033.5);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1037, 1029, 'Melinda Jones', 'North Macedonia', 'Congress', 1038.5);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1042, 1039, 'Kristin Cohen', 'Tajikistan', 'special', 1043.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.climber_id AS climber_id, RHS.name AS name_other, RHS.country AS country_other, RHS.time AS TIME, RHS.points AS points FROM mountain AS LHS INNER JOIN climber AS RHS ON (LHS.mountain_id = RHS.mountain_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Kristin Cohen', 'Danielle Ford')
('Melinda Jones', 'Amber Perez')
('Sharon James', 'Amber Perez')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID;

/*
Prediction Result:
('Sharon James', 'Amber Perez')
('Melinda Jones', 'Amber Perez')
('Kristin Cohen', 'Danielle Ford')
*/