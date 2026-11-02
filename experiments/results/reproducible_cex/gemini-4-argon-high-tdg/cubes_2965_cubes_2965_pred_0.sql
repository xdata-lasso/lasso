-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Tower One', 'USA', 300, 60, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'Metro Center', 'London', 200, 40, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (3, 'Sky Plaza', 'Tokyo', 250, 50, 'Under Construction');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (10, 'Beta Inc', 'Canada', 'Energy', 10.0, 8.0, 300.0, '50');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (20, 'Gamma Ltd', 'Germany', 'Retail', 30.0, 5.0, 200.0, '100');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (30, 'Alpha Corp', 'Vietnam', 'Tech', 50.0, 2.0, 100.0, '200');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (40, 'Delta Co', 'Japan', 'Auto', 80.0, 1.0, 50.0, '400');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (50, 'AmeriCorp', 'USA', 'Finance', 90.0, 12.0, 500.0, '600');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (60, 'Stateside LLC', 'USA', 'Healthcare', 45.0, 6.0, 150.0, '250');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 10, 2015);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (2, 10, 2018);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (3, 20, 2020);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (2, 50, 2012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "companies" WHERE ("headquarters" <> 'USA') ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
('Alpha Corp',)
('Beta Inc',)
('Delta Co',)
('Gamma Ltd',)
*/

-- Prediction Query
SELECT name FROM Companies WHERE Headquarters <> 'USA';

/*
Prediction Result:
('Beta Inc',)
('Gamma Ltd',)
('Alpha Corp',)
('Delta Co',)
*/