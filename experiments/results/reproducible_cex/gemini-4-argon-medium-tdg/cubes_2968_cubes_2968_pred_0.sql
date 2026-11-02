-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC, missing ORDER BY), duplicate names (DISTINCT vs ALL), and NULL handling in the projected/sorted column.
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'Zeta Corp', 'Boston', 'Tech', 10.5, 1.2, 50.0, '20.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'Alpha Inc', 'New York', 'Finance', 100.0, 15.0, 500.0, '250.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'Alpha Inc', 'Chicago', 'Retail', 25.0, 2.5, 30.0, '15.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, NULL, 'Seattle', 'Health', 5.0, 0.5, 10.0, '8.0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM companies ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Inc',)
('Alpha Inc',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT name FROM Companies ORDER BY Market_Value_billion DESC, Companies.id NULLS LAST;

/*
Prediction Result:
(None,)
('Alpha Inc',)
('Zeta Corp',)
('Alpha Inc',)
*/