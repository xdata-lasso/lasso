-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (0, 'default2', NULL, 1.0, 'Midshipman', 'default1'), (1, 'Midshipman', 'Midshipman', NULL, 'default2', NULL);
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (1, NULL, 'Lieutenant', 'Lieutenant', NULL, 'Midshipman'), (0, NULL, NULL, 'default2', NULL, 'Midshipman'), (2, NULL, 'Lieutenant', 'Midshipman', 'Lieutenant', 'Lieutenant'), (3, NULL, 'Lieutenant', 'Lieutenant', 'default1', 'Lieutenant'), (4, 1, 'Lieutenant', 'Lieutenant', 'Lieutenant', 'Midshipman'), (5, NULL, 'default2', 'Midshipman', 'Lieutenant', 'Lieutenant'), (6, 0, 'default1', NULL, 'Midshipman', 'Midshipman'), (7, 1, 'default1', NULL, 'Midshipman', 'default2'), (8, NULL, NULL, NULL, 'default2', NULL), (9, 1, NULL, 'default2', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "captain" WHERE ("rank" = 'Midshipman' OR "rank" = 'Lieutenant') ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
(None,)
('Lieutenant',)
('Lieutenant',)
('Lieutenant',)
('Lieutenant',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM captain WHERE rank = 'Midshipman' OR rank = 'Lieutenant';

/*
Prediction Result:
(None,)
('Lieutenant',)
('Lieutenant',)
('Lieutenant',)
('Lieutenant',)
('default2',)
('default1',)
*/