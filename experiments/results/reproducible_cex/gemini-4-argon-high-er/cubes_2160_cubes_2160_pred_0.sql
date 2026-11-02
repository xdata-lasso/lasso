-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO architect (id, name, nationality, gender) VALUES ('1', 'John Doe', 'USA', 'M');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (1, '1', 'Location A', 'Mill A', 'Water', 1900, 'Note 1');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (2, '1', 'Location B', 'Mill B', 'Water', 1905, 'Note 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT notes, TYPE, COUNT(*) AS n FROM mill GROUP BY notes, TYPE) ORDER BY TYPE DESC) LIMIT 1);

/*
Gold Result:
('Water', 1)
*/

-- Prediction Query
SELECT TYPE, COUNT(*) FROM mill GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Water', 2)
*/