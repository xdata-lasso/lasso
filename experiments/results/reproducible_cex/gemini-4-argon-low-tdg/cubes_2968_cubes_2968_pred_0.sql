-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Empire State Building', 'New York', 381, 102, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'Willis Tower', 'Chicago', 442, 108, 'Completed');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'Zeta Corp', 'New York', 'Tech', 100.0, 20.0, 300.0, '500');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'Alpha Inc', 'Chicago', 'Finance', 50.0, 10.0, 200.0, '150');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'Alpha Inc', 'Boston', 'Retail', 25.0, 5.0, 100.0, '80');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'Beta LLC', 'San Francisco', 'Tech', 75.0, 15.0, 250.0, '300');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 1, 2010);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (2, 1, 2015);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 2, 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM companies ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Alpha Inc',)
('Beta LLC',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT name FROM Companies ORDER BY Market_Value_billion DESC, Companies.id NULLS LAST;

/*
Prediction Result:
('Alpha Inc',)
('Zeta Corp',)
('Beta LLC',)
('Alpha Inc',)
*/