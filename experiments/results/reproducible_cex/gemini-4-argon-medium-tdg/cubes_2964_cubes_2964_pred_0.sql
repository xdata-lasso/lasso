-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Apex Tower', 'New York', 300, 75, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'Zenith Plaza', 'Chicago', 250, 60, 'Under Construction');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'TechCorp', 'San Francisco', 'Technology', 120.5, 25.0, 200.0, '500');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'FinBank', 'New York', 'Finance', 80.0, 15.2, 1500.0, '300');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'SoftWorks', 'Seattle', 'Technology', 45.0, 10.5, 90.0, '150');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'AutoMake', 'Detroit', 'Automotive', 210.0, -5.0, 300.0, '80');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 1, 2010);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 2, 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT industry FROM companies ORDER BY industry;

/*
Gold Result:
('Automotive',)
('Finance',)
('Technology',)
*/

-- Prediction Query
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC, Industry NULLS LAST;

/*
Prediction Result:
('Technology',)
('Automotive',)
('Finance',)
*/