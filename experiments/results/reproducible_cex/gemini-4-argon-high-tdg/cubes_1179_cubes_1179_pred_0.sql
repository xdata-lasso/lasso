-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Ship_Alpha', 'Cargo', 1995.0, 'ShipClass_1', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Ship_Beta', 'Tanker', 2005.0, 'ShipClass_2', 'UK');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 2, 'Charlie', '45', 'C_Class', 'Commander');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 2, 'Alice', '55', 'Z_Class', 'Senior');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (3, 1, 'Bob', '38', 'B_Class', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (4, 2, 'Bob', '40', 'B_Class', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (5, 1, 'Alice', '30', 'A_Class', 'Junior');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, rank FROM captain ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Alice', 'Z_Class', 'Senior')
('Alice', 'A_Class', 'Junior')
('Bob', 'B_Class', 'Captain')
('Bob', 'B_Class', 'Captain')
('Charlie', 'C_Class', 'Commander')
*/

-- Prediction Query
SELECT name, CLASS, rank FROM captain;

/*
Prediction Result:
('Charlie', 'C_Class', 'Commander')
('Alice', 'Z_Class', 'Senior')
('Bob', 'B_Class', 'Captain')
('Bob', 'B_Class', 'Captain')
('Alice', 'A_Class', 'Junior')
*/