-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO architect (id, name, nationality, gender) VALUES ('default2', NULL, 'Grondzeiler', 'default1'), ('default1', NULL, 'Grondzeiler', 'default2'), ('Grondzeiler', 'Grondzeiler', NULL, 'default1'), ('unique_3', 'default2', 'Grondzeiler', 'default2');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (1, 'default1', NULL, 'Grondzeiler', 'default2', NULL, NULL), (0, NULL, NULL, 'Grondzeiler', 'Grondzeiler', 1, 'Grondzeiler'), (2, 'unique_3', NULL, NULL, 'Grondzeiler', NULL, 'Grondzeiler'), (3, NULL, 'default2', 'default1', NULL, NULL, NULL), (4, 'default2', NULL, 'default1', 'Grondzeiler', 1, 'default1'), (5, 'Grondzeiler', NULL, NULL, NULL, 1, 'Grondzeiler'), (6, 'unique_3', 'Grondzeiler', 'Grondzeiler', 'default2', NULL, 'Grondzeiler'), (7, 'Grondzeiler', 'Grondzeiler', NULL, 'Grondzeiler', NULL, 'Grondzeiler'), (8, 'unique_3', NULL, 'default2', 'default1', 1, NULL), (9, 'default1', 'default1', 'Grondzeiler', NULL, NULL, 'Grondzeiler'), (10, 'default1', 'default2', 'default1', 'default1', NULL, NULL), (11, 'unique_3', 'default2', 'default2', 'Grondzeiler', 0, 'default1'), (12, 'default2', 'default1', NULL, NULL, 0, 'default2'), (13, 'Grondzeiler', 'default2', NULL, 'Grondzeiler', NULL, 'default1'), (14, 'Grondzeiler', 'default1', 'default2', 'default2', 0, NULL), (15, 'default2', 'Grondzeiler', 'Grondzeiler', 'Grondzeiler', 0, 'default2'), (16, 'default1', 'default1', NULL, 'default1', 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "built_year" FROM "mill" WHERE ("type" = 'Grondzeiler') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
(None, None)
(None, None)
(None, None)
('Grondzeiler', 1)
('Grondzeiler', 0)
('default1', 1)
('default2', 0)
*/

-- Prediction Query
SELECT name, built_year FROM mill WHERE TYPE = 'Grondzeiler';

/*
Prediction Result:
('Grondzeiler', 1)
(None, None)
('default1', 1)
(None, None)
('default2', 0)
(None, None)
('Grondzeiler', 0)
*/