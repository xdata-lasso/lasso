-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO architect (id, name, nationality, gender) VALUES ('1', 'Arch A', 'USA', 'M');
INSERT INTO architect (id, name, nationality, gender) VALUES ('2', 'Arch B', 'UK', 'F');
INSERT INTO bridge (id, architect_id, name, location, length_meters, length_feet) VALUES (1, 1, 'Bridge 1', 'Loc A', 100.0, 328.0);
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (1, 1, 'Loc A', 'Mill 1', 'Watermill', 1800, 'Historic');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (2, 1, 'Loc B', 'Mill 2', 'Watermill', 1850, 'Historic');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (3, 1, 'Loc C', 'Mill 3', 'Watermill', 1900, 'Modern');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (4, 2, 'Loc D', 'Mill 4', 'Grinding', 1750, 'Historic');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (5, 2, 'Loc E', 'Mill 5', 'Grinding', 1760, 'Historic');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (6, 2, 'Loc F', 'Mill 6', 'Grinding', 1770, 'Historic');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (7, 2, 'Loc G', 'Mill 7', 'Grinding', 1780, 'Historic');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT notes, TYPE, COUNT(*) AS n FROM mill GROUP BY notes, TYPE) ORDER BY TYPE DESC) LIMIT 1);

/*
Gold Result:
('Watermill', 2)
*/

-- Prediction Query
SELECT TYPE, COUNT(*) FROM mill GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Grinding', 4)
*/