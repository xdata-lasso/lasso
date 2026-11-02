-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'HMS Victory', 'Ship of the line', 1765.0, 'First-rate', 'UK');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (10, 1, 'Horatio', '20', 'A', 'Midshipman');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (20, 1, 'Bush', '28', 'B', 'Lieutenant');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (30, 1, 'Pellew', '45', 'A', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (40, 1, 'Nelson', '50', 'A', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (50, 1, 'Ghost', '99', 'C', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "captain" WHERE ("rank" = 'Midshipman' OR "rank" = 'Lieutenant') ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Bush',)
('Horatio',)
*/

-- Prediction Query
SELECT name FROM captain WHERE rank = 'Midshipman' OR rank = 'Lieutenant';

/*
Prediction Result:
('Horatio',)
('Bush',)
*/