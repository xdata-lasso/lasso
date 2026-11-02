-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'Apex Tower', 'Chicago', 400, 90, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Apex Tower', 'New York', 300, 60, 'Under Construction');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (3, 'Zenith Plaza', 'Boston', 150, 30, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (4, NULL, 'Seattle', 200, 40, 'Planned');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (10, 'Acme Corp', 'New York', 'Tech', 50.5, 10.2, 100.0, '200');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 10, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM buildings ORDER BY name, buildings.id NULLS LAST;

/*
Gold Result:
(None,)
('Apex Tower',)
('Apex Tower',)
('Zenith Plaza',)
*/

-- Prediction Query
SELECT name FROM buildings ORDER BY Height DESC, buildings.id NULLS LAST;

/*
Prediction Result:
('Apex Tower',)
('Apex Tower',)
(None,)
('Zenith Plaza',)
*/