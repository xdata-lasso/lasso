-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Ship A', 'Frigate', 1800.0, 'First-rate', 'UK');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'John', '40', 'First-rate', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 1, 'Jane', '45', 'First-rate', 'Admiral');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank" FROM (SELECT * FROM "captain" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("class" = 'Third-rate ship of the line')) AS RHS WHERE (LHS.rank = RHS.rank))) ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
('Admiral',)
('Admiral',)
*/

-- Prediction Query
SELECT rank FROM captain EXCEPT SELECT rank FROM captain WHERE CLASS = 'Third-rate ship of the line';

/*
Prediction Result:
('Admiral',)
*/