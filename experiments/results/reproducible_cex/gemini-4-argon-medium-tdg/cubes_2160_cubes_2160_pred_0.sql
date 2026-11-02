-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO architect (id, name, nationality, gender) VALUES ('1', 'Frank Lloyd Wright', 'American', 'Male');
INSERT INTO architect (id, name, nationality, gender) VALUES ('2', 'Zaha Hadid', 'Iraqi-British', 'Female');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (1, 1, 'Loc1', 'Mill A', 'Windmill', 1900, 'Note B');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (2, 1, 'Loc2', 'Mill B', 'Windmill', 1905, 'Note B');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (3, 1, 'Loc3', 'Mill C', 'Windmill', 1910, 'Note A');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (4, 2, 'Loc4', 'Mill D', 'Watermill', 1920, 'Note C');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (5, 2, 'Loc5', 'Mill E', 'Watermill', 1925, 'Note C');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (6, 2, 'Loc6', 'Mill F', 'Watermill', 1930, 'Note C');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (7, 2, 'Loc7', 'Mill G', 'Watermill', 1935, 'Note C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT notes, TYPE, COUNT(*) AS n FROM mill GROUP BY notes, TYPE) ORDER BY TYPE DESC) LIMIT 1);

/*
Gold Result:
('Windmill', 1)
*/

-- Prediction Query
SELECT TYPE, COUNT(*) FROM mill GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Watermill', 4)
*/