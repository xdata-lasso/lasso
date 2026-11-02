-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (0, 'default1', 'default2', 0.0, 'default1', 'default2'), (2, 'default2', 'default2', 0.0, 'default2', NULL), (1, NULL, NULL, 0.0, NULL, 'default2');
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (0, 1, 'default2', 'default2', 'default1', 'default1'), (2, NULL, 'default2', 'default2', 'default2', 'default2'), (1, NULL, 'default1', NULL, NULL, 'default1'), (3, 2, 'default2', 'default1', 'default2', 'default1'), (4, NULL, 'default2', NULL, 'default2', NULL), (5, 0, 'default2', NULL, 'default1', 'default2'), (6, 1, 'default2', 'default1', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM captain ORDER BY ship_id DESC, captain.captain_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age, captain.captain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/