-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'HMS Victory', 'Ship of the line', 1765.0, 'First-rate', 'UK');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'Horatio Nelson', '47', 'First-rate ship of the line', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 1, 'Thomas Hardy', '36', 'First-rate ship of the line', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (3, 1, 'Cuthbert Collingwood', '55', 'Second-rate ship of the line', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (4, 1, 'Edward Pellew', '48', 'Third-rate ship of the line', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (5, 1, 'William Bligh', '51', 'Fourth-rate ship of the line', 'Commander');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank" FROM (SELECT * FROM "captain" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("class" = 'Third-rate ship of the line')) AS RHS WHERE (LHS.rank = RHS.rank))) ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
('Admiral',)
('Admiral',)
('Commander',)
*/

-- Prediction Query
SELECT rank FROM captain EXCEPT SELECT rank FROM captain WHERE CLASS = 'Third-rate ship of the line';

/*
Prediction Result:
('Admiral',)
('Commander',)
*/