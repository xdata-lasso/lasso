-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (0, NULL, 'Third-rate ship of the line', 0.0, 'default1', NULL), (2, 'default2', 'Third-rate ship of the line', 1.0, 'default1', 'Third-rate ship of the line'), (1, 'default2', 'Third-rate ship of the line', 2.0, 'default1', 'default2');
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (2, 2, 'Third-rate ship of the line', NULL, 'Third-rate ship of the line', NULL), (1, 1, 'default1', 'default2', 'default1', 'Third-rate ship of the line'), (0, 2, 'Third-rate ship of the line', 'Third-rate ship of the line', 'default2', 'Third-rate ship of the line'), (3, NULL, 'Third-rate ship of the line', 'default1', 'Third-rate ship of the line', NULL), (4, 1, NULL, 'default2', 'Third-rate ship of the line', 'default1'), (5, NULL, 'default1', 'default2', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank" FROM (SELECT * FROM "captain" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("class" = 'Third-rate ship of the line')) AS RHS WHERE (LHS.rank = RHS.rank))) ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('Third-rate ship of the line',)
('Third-rate ship of the line',)
*/

-- Prediction Query
SELECT rank FROM captain EXCEPT SELECT rank FROM captain WHERE CLASS = 'Third-rate ship of the line';

/*
Prediction Result:
('Third-rate ship of the line',)
*/