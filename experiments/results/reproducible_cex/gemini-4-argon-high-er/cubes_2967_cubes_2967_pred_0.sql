-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (1, 'Company A', 'China', 'Technology', 10.0, 1.0, 20.0, '50.0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "industry" FROM "companies" WHERE ("headquarters" <> 'USA' OR "headquarters" = 'China') ORDER BY industry, "industry" NULLS LAST;

/*
Gold Result:
('Technology',)
*/

-- Prediction Query
SELECT Industry FROM Companies WHERE Headquarters = 'USA' INTERSECT SELECT Industry FROM Companies WHERE Headquarters = 'China';

/*
Prediction Result:
*/