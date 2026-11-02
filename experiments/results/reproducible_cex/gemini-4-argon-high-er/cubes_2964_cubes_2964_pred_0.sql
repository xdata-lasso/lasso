-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'CompA', 'CityA', 'Aerospace', 10.0, 1.0, 5.0, '12.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'CompB1', 'CityB', 'Banking', 20.0, 2.0, 15.0, '25.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'CompB2', 'CityC', 'Banking', 30.0, 3.0, 25.0, '35.0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT industry FROM companies ORDER BY industry;

/*
Gold Result:
('Aerospace',)
('Banking',)
*/

-- Prediction Query
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC, Industry NULLS LAST;

/*
Prediction Result:
('Banking',)
('Aerospace',)
*/