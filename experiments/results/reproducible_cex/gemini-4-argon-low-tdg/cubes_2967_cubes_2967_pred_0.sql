-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Tower A', 'Beijing', 300, 60, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'Tower B', 'New York', 400, 80, 'Completed');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'CompA', 'USA', 'Tech', 10.0, 1.0, 5.0, '20');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'CompB', 'China', 'Finance', 20.0, 2.0, 10.0, '40');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'CompC', 'China', 'Finance', 25.0, 2.5, 12.0, '50');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'CompD', 'UK', 'Energy', 30.0, 3.0, 15.0, '60');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (5, 'CompE', 'Germany', NULL, 15.0, 1.5, 7.0, '30');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (6, 'CompF', 'Japan', NULL, 12.0, 1.2, 6.0, '25');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (7, 'CompG', NULL, 'Retail', 8.0, 0.8, 4.0, '15');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 2, 2010);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (2, 2, 2015);
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