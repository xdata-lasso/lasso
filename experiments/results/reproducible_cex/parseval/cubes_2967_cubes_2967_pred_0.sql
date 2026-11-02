-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: companies --
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (2, '5k5swwqcgs', 'A', 'com_5b88a1', 171.746906, 557.512061, 868.436572, 'c4pgu7vfe');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (3, 'hria2ypu', 'A', 'com_5b88a1', 882.963176, 841.297061, 294.861575, 'wbbp6');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (4, 'uhv', 'China', 'l', 303.05704, 125.12763, 22.535764, 'nprmdposii');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (5, '5k5swwqcgs', 'USA', '9n8', 874.871895, 475.173408, 935.695299, 'u7vfe4hria2y');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (6, '5k5swwqcgs', NULL, '9n8', 874.871895, 475.173408, 935.695299, 'u7vfe4hria2y');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (7, 'uzhs', NULL, 'rwbbp6luhvd', 179.378884, 304.02808, 182.319045, 'nprmdposii');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (8, '5u', NULL, 'w6kl', 83.204633, 5.585347, 871.191565, '00t5c4e');

INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (9, 'cigce376nium', NULL, '52zbuo4nrq', 597.420508, 220.906948, 82.05602, 'yp5s5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "industry" FROM "companies" WHERE ("headquarters" <> 'USA' OR "headquarters" = 'China') ORDER BY industry, "industry" NULLS LAST;

/*
Gold Result:
('com_5b88a1',)
('l',)
*/

-- Prediction Query
SELECT Industry FROM Companies WHERE Headquarters = 'USA' INTERSECT SELECT Industry FROM Companies WHERE Headquarters = 'China';

/*
Prediction Result:
*/