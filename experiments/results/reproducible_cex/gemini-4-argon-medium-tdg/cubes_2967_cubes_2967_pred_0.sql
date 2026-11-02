-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive test: tests WHERE conditions ('USA', 'China', other countries, NULL), DISTINCT deduplication, and ORDER BY with NULLS.
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'CompA', 'USA', 'Tech', 10.0, 1.0, 50.0, '100');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'CompB', 'China', 'Finance', 20.0, 2.0, 100.0, '200');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'CompC', 'UK', 'Energy', 30.0, 3.0, 150.0, '300');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'CompD', 'Japan', 'Energy', 40.0, 4.0, 200.0, '400');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (5, 'CompE', NULL, 'Retail', 5.0, 0.5, 25.0, '50');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (6, 'CompF', 'Germany', NULL, 15.0, 1.5, 75.0, '150');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "industry" FROM "companies" WHERE ("headquarters" <> 'USA' OR "headquarters" = 'China') ORDER BY industry, "industry" NULLS LAST;

/*
Gold Result:
(None,)
('Energy',)
('Finance',)
*/

-- Prediction Query
SELECT Industry FROM Companies WHERE Headquarters = 'USA' INTERSECT SELECT Industry FROM Companies WHERE Headquarters = 'China';

/*
Prediction Result:
*/