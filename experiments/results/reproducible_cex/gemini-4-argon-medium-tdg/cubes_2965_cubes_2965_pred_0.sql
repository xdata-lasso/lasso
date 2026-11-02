-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Tower A', 'Tokyo', 200, 40, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'Tower B', 'New York', 300, 60, 'Completed');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'Zeta Corp', 'UK', 'Tech', 10.5, 1.2, 50.0, '100');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'Alpha Inc', 'USA', 'Finance', 20.0, 2.5, 80.0, '200');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'Beta Ltd', 'Japan', 'Auto', 15.0, 1.8, 60.0, '150');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'Alpha Inc', 'Canada', 'Retail', 5.0, 0.5, 20.0, '50');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (5, 'Alpha Inc', 'France', 'Luxury', 12.0, 3.0, 40.0, '120');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 1, 2010);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (2, 1, 2015);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (2, 2, 2012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "companies" WHERE ("headquarters" <> 'USA') ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Alpha Inc',)
('Beta Ltd',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT name FROM Companies WHERE Headquarters <> 'USA';

/*
Prediction Result:
('Zeta Corp',)
('Beta Ltd',)
('Alpha Inc',)
('Alpha Inc',)
*/