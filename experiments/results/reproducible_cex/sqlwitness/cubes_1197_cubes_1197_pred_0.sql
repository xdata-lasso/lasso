-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (0, NULL, NULL, 1.0, 'default2', 'default1'), (2, 'default2', 'default1', 2.0, 'default2', 'default1'), (1, 'default2', NULL, 2.0, 'default1', 'default1'), (3, NULL, 'default2', 2.0, 'default1', NULL), (4, 'default2', NULL, 1.0, NULL, 'default2'), (5, NULL, 'default1', NULL, 'default1', NULL), (6, 'default2', 'default1', 0.0, NULL, 'default2'), (7, 'default1', NULL, 1.0, 'default2', 'default2'), (8, NULL, 'default2', NULL, 'default2', NULL), (9, 'default2', 'default2', 1.0, 'default2', NULL), (10, 'default2', 'default1', 0.0, NULL, 'default2');
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (1, 3, 'default2', 'default2', 'default1', 'default1'), (0, 4, 'default1', NULL, 'default2', NULL), (2, 0, 'default2', NULL, 'default2', 'default1'), (3, 5, 'default2', NULL, NULL, NULL), (4, 3, 'default1', NULL, 'default1', NULL), (5, 5, 'default2', NULL, NULL, 'default1'), (6, 9, 'default2', 'default1', 'default1', 'default2'), (7, 6, 'default1', 'default2', NULL, NULL), (8, 8, 'default1', 'default2', NULL, 'default1'), (9, 0, 'default2', 'default2', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rank FROM (SELECT * FROM (SELECT * FROM (SELECT rank, COUNT(*) AS n FROM captain GROUP BY rank) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT rank FROM captain GROUP BY rank ORDER BY COUNT(*) DESC, rank NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/