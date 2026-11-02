-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO architect (id, name, nationality, gender) VALUES ('Donceel', 'default1', 'Donceel', 'default1'), ('default2', 'default1', 'Donceel', 'default1');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (1, 'default2', 'default2', 'default1', 'Donceel', NULL, 'Donceel'), (0, 'default2', 'default2', 'default2', 'default1', 1, NULL), (2, 'Donceel', 'default1', 'Donceel', NULL, 1, NULL), (3, NULL, 'default2', 'default1', 'default1', NULL, NULL), (4, 'default2', 'default1', 'default2', 'Donceel', 0, 'Donceel');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "mill" WHERE ("location" <> 'Donceel') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('Donceel',)
('default1',)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT name FROM mill WHERE LOCATION <> 'Donceel';

/*
Prediction Result:
('default2',)
('default1',)
('Donceel',)
('default1',)
('default2',)
*/