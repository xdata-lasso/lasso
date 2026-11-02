-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "captain" ("Captain_ID", "Class", "Rank") VALUES (1, 'First-rate', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Class", "Rank") VALUES (2, 'First-rate', 'Captain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank" FROM (SELECT * FROM "captain" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("class" = 'Third-rate ship of the line')) AS RHS WHERE (LHS.rank = RHS.rank))) ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
('Captain',)
('Captain',)
*/

-- Prediction Query
SELECT rank FROM captain EXCEPT SELECT rank FROM captain WHERE CLASS = 'Third-rate ship of the line';

/*
Prediction Result:
('Captain',)
*/