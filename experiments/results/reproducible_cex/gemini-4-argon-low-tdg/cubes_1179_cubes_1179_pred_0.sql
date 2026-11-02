-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Captain_ID, and detects erroneous DISTINCT or GROUP BY clauses by having duplicate projected tuples (Name, Class, Rank) with different Captain_IDs.
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'HMS Victory', 'Warship', 1765.0, 'First-rate', 'UK');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (10, 1, 'Horatio', '45', 'A', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (5, 1, 'Horatio', '45', 'A', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'Arthur', '50', 'B', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (20, 1, 'Arthur', '30', 'C', 'Lieutenant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, rank FROM captain ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Arthur', 'B', 'Captain')
('Arthur', 'C', 'Lieutenant')
('Horatio', 'A', 'Admiral')
('Horatio', 'A', 'Admiral')
*/

-- Prediction Query
SELECT name, CLASS, rank FROM captain;

/*
Prediction Result:
('Arthur', 'B', 'Captain')
('Horatio', 'A', 'Admiral')
('Horatio', 'A', 'Admiral')
('Arthur', 'C', 'Lieutenant')
*/