-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'HMS Valiant', 'Escort', 2010.0, 'Frigate', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'USS Johnston', 'Combat', 1995.0, 'Destroyer', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'FS Colbert', 'Warship', 1970.5, 'Cruiser', 'France');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (10, 'USS Hoel', 'Combat', 1980.0, 'Destroyer', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (11, 'USS Heermann', 'Combat', 1985.0, 'Destroyer', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (20, 'FS Tourville', 'Warship', 1975.0, 'Cruiser', 'France');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (50, 'U-995', 'Stealth', 2020.0, 'Submarine', 'Germany');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (101, 1, 'Arthur Pendelton', '45', 'Frigate', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (102, 3, 'Ernest Evans', '36', 'Destroyer', 'Commander');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (103, 3, 'Robert Copeland', '34', 'Cruiser', 'Lieutenant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT built_year FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.flag AS flag_other FROM ship AS LHS INNER JOIN (SELECT CLASS, flag, COUNT(*) AS n FROM ship GROUP BY CLASS, flag) AS RHS ON (LHS.ship_id = RHS.n AND LHS.class = RHS.class)) ORDER BY built_year;

/*
Gold Result:
(1970.5,)
(1995.0,)
(2010.0,)
*/

-- Prediction Query
SELECT built_year FROM ship GROUP BY built_year ORDER BY COUNT(*) DESC, built_year NULLS LAST LIMIT 1;

/*
Prediction Result:
(1970.5,)
*/