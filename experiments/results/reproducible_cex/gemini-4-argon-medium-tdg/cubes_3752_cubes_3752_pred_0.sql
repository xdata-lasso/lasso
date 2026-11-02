-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Alpha', 'Cargo', 1995.0, 'C_Low', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Beta', 'Cargo', 1995.0, 'C_Low', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Gamma', 'Cargo', 1995.0, 'C_Low', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (4, 'Delta', 'Tanker', 2010.0, 'A_Lowest', 'Panama');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (5, 'Epsilon', 'Destroyer', 2002.0, 'Z_Highest', 'France');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (101, 1, 'Smith', '45', 'ZZZ_Captain_Class', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (102, 4, 'Jones', '50', 'AAA_Captain_Class', 'Commander');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT built_year FROM (SELECT * FROM (SELECT * FROM (SELECT built_year, CLASS, MAX(n) AS n FROM (SELECT ship_id, name, TYPE, built_year, CLASS, flag, COUNT(*) OVER () AS n FROM ship) GROUP BY built_year, CLASS) ORDER BY CLASS DESC) LIMIT 1);

/*
Gold Result:
(2002.0,)
*/

-- Prediction Query
SELECT built_year FROM ship GROUP BY built_year ORDER BY COUNT(*) DESC, built_year NULLS LAST LIMIT 1;

/*
Prediction Result:
(1995.0,)
*/