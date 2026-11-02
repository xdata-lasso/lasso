-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (10, 'Zeta Complex', 'San Francisco', 400, 90, 'on-hold');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (5, 'Beta Complex', 'Los Angeles', 500, 110, 'on-hold');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (8, 'Alpha Complex', 'Chicago', 600, 120, 'on-hold');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Omega Complex', 'Houston', 350, 80, 'on-hold');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (20, 'on-hold', 'Phoenix', 100, 20, 'under construction');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (21, 'on-hold', 'on-hold', 110, 22, 'demolished');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "buildings" WHERE ("status" = 'on-hold') ORDER BY name, buildings.id NULLS LAST;

/*
Gold Result:
('Alpha Complex',)
('Beta Complex',)
('Omega Complex',)
('Zeta Complex',)
*/

-- Prediction Query
SELECT name FROM buildings WHERE Status = 'on-hold' ORDER BY Stories ASC, buildings.id NULLS LAST;

/*
Prediction Result:
('Omega Complex',)
('Zeta Complex',)
('Beta Complex',)
('Alpha Complex',)
*/