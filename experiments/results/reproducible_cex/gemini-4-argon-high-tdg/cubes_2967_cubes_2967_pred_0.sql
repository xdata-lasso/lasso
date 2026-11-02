-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Tower A', 'New York', 300, 60, 'Completed');
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (2, 'Tower B', 'Beijing', 400, 80, 'Completed');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'AeroCorp', 'USA', 'Aerospace', 80.5, 8.2, 120.0, '150.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'SinoTech', 'China', 'Technology', 150.0, 20.5, 300.0, '500.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'DragonNet', 'China', 'Technology', 90.0, 12.0, 180.0, '250.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'AutoWerke', 'Germany', 'Automotive', 220.0, 15.0, 450.0, '190.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (5, 'NipponBank', 'Japan', 'Banking', 60.0, 7.5, 900.0, '110.0');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 1, 2010);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (2, 2, 2015);
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 2, 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "industry" FROM "companies" WHERE ("headquarters" <> 'USA' OR "headquarters" = 'China') ORDER BY industry, "industry" NULLS LAST;

/*
Gold Result:
('Automotive',)
('Banking',)
('Technology',)
*/

-- Prediction Query
SELECT Industry FROM Companies WHERE Headquarters = 'USA' INTERSECT SELECT Industry FROM Companies WHERE Headquarters = 'China';

/*
Prediction Result:
*/