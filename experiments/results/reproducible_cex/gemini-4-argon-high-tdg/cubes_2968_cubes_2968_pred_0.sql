-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (10, 'Empire Tower', 'New York', 400, 90, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (20, 'Skyline Center', 'Chicago', 310, 70, 'Completed');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'Zeta Global', 'New York', 'Tech', 50.5, 10.2, 120.0, '200.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'Alpha Corp', 'Chicago', 'Finance', 80.0, 15.0, 300.0, '150.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'Beta Systems', 'Boston', 'Retail', 25.0, 2.5, 40.0, '35.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'Alpha Corp', 'Austin', 'Energy', 60.0, 8.0, 110.0, '95.0');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (10, 1, 2015);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (20, 1, 2018);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (10, 2, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM companies ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
('Alpha Corp',)
('Alpha Corp',)
('Beta Systems',)
('Zeta Global',)
*/

-- Prediction Query
SELECT name FROM Companies ORDER BY Market_Value_billion DESC, Companies.id NULLS LAST;

/*
Prediction Result:
('Alpha Corp',)
('Beta Systems',)
('Zeta Global',)
('Alpha Corp',)
*/