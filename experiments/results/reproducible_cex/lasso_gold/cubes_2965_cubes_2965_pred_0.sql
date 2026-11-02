-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1054, 'Timothy Wong', 'politics', 'prove', 1055.5, 1056.5, 1057.5, 'Congress');
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1058, 'Colleen Nguyen', 'expect', 'wish', 1056.5, 1057.5, 1058.5, 'push');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "companies" WHERE ("headquarters" <> 'USA') ORDER BY name, companies.id NULLS LAST;

/*
Gold Result:
('Colleen Nguyen',)
('Timothy Wong',)
*/

-- Prediction Query
SELECT name FROM Companies WHERE Headquarters <> 'USA';

/*
Prediction Result:
('Timothy Wong',)
('Colleen Nguyen',)
*/