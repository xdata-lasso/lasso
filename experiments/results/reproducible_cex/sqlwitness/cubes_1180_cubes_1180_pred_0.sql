-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (0, NULL, 'default1', 0.0, 'default2', 'default1'), (1, 'default2', 'default1', NULL, 'default1', 'default1'), (2, 'default1', 'default2', 1.0, 'default2', 'default1'), (3, 'default2', 'default1', NULL, 'default1', NULL), (4, 'default1', NULL, 1.0, 'default2', NULL), (5, 'default1', 'default1', NULL, 'default2', 'default2');
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (1, 2, 'default1', 'default2', 'default1', 'default2'), (0, 3, NULL, NULL, 'default1', NULL), (2, 0, NULL, 'default1', 'default2', 'default2'), (3, 3, 'default1', 'default1', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM captain ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age DESC, captain.captain_id NULLS LAST;

/*
Prediction Result:
('default1',)
(None,)
('default1',)
(None,)
*/