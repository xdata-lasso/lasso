-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (1, NULL, 'default1', 0.0, 'default1', NULL), (0, NULL, NULL, 1.0, 'default2', NULL), (2, 'default1', 'default1', 1.0, 'default1', 'default2'), (3, 'default1', 'default1', NULL, 'default1', 'default1'), (4, NULL, 'default2', 1.0, NULL, 'default1');
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (0, NULL, 'default2', 'default2', NULL, 'default1'), (1, 0, 'default1', 'default1', 'default1', NULL), (2, 3, NULL, 'default2', 'default2', 'default1'), (3, 4, NULL, NULL, NULL, 'default1'), (4, 4, 'default2', 'default1', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, rank FROM (SELECT rank, COUNT(*) AS n FROM captain GROUP BY rank) ORDER BY count___, rank NULLS LAST;

/*
Gold Result:
(1, 'default2')
(1, None)
(3, 'default1')
*/

-- Prediction Query
SELECT COUNT(*), rank FROM captain GROUP BY rank;

/*
Prediction Result:
(1, None)
(3, 'default1')
(1, 'default2')
*/