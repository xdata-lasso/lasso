-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO architect (id, name, nationality, gender) VALUES ('1', 'John Smeaton', 'British', 'Male');
INSERT INTO architect (id, name, nationality, gender) VALUES ('2', 'William Cubitt', 'British', 'Male');
INSERT INTO bridge (id, architect_id, name, location, length_meters, length_feet) VALUES (1, 1, 'Coldstream Bridge', 'Scotland', 100.0, 328.0);
INSERT INTO bridge (id, architect_id, name, location, length_meters, length_feet) VALUES (2, 1, 'Perth Bridge', 'Scotland', 270.0, 885.0);
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (1, 1, 'Leeds', 'Mill One', 'Grinding', 1780, 'Z_note');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (2, 1, 'Leeds', 'Mill Two', 'Grinding', 1785, 'Z_note');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (3, 1, 'Leeds', 'Mill Three', 'Grinding', 1790, 'Z_note');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (4, 2, 'York', 'Mill Four', 'Sawmill', 1810, 'A_note');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (5, 1, 'Kent', 'Mill Five', 'Windmill', 1820, 'M_note');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (6, 2, 'Kent', 'Mill Six', 'Windmill', 1825, 'M_note');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT notes, TYPE, COUNT(*) AS n FROM mill GROUP BY notes, TYPE) ORDER BY TYPE DESC) LIMIT 1);

/*
Gold Result:
('Windmill', 2)
*/

-- Prediction Query
SELECT TYPE, COUNT(*) FROM mill GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Grinding', 3)
*/