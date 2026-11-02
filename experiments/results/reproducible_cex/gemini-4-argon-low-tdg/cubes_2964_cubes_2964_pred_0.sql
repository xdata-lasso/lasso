-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Apex Tower', 'New York', 300, 70, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'Beta Plaza', 'Chicago', 200, 50, 'Under Construction');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'Zeta Corp', 'Boston', 'Technology', 10.5, 1.2, 50.0, '100.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'Alpha Inc', 'Seattle', 'Finance', 25.0, -2.5, 120.0, '80.5');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'Beta LLC', 'Austin', 'Technology', 5.0, 0.0, 15.0, '20.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'Gamma Ltd', 'Miami', 'Aerospace', 0.0, 5.5, 200.0, '150.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (5, 'Delta Co', 'Denver', 'Retail', 100.0, 8.0, 90.0, '250.0');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 1, 2010);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (2, 1, 2015);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 2, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT industry FROM companies ORDER BY industry;

/*
Gold Result:
('Aerospace',)
('Finance',)
('Retail',)
('Technology',)
*/

-- Prediction Query
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC, Industry NULLS LAST;

/*
Prediction Result:
('Technology',)
('Aerospace',)
('Finance',)
('Retail',)
*/