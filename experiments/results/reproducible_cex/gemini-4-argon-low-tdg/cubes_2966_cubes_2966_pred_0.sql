-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Zero matching rows dataset:
-- Crucial for distinguishing Window Function `COUNT(*) OVER ()` (which returns 0 rows when WHERE matches nothing)
-- from standard Aggregate `SELECT COUNT(*)` without GROUP BY (which returns 1 row with value 0).
INSERT INTO "buildings" ("id", "name", "City", "Height", "Stories", "Status") VALUES (1, 'Tech Plaza', 'Austin', 150, 30, 'Completed');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'Tech Corp', 'Austin', 'Technology', 50.0, 10.0, 200.0, '500.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'Health Inc', 'Boston', 'Healthcare', 30.0, 4.0, 80.0, '120.0');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'Null Ind', 'Seattle', NULL, 15.0, 1.5, 40.0, '35.0');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (1, 1, 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS "count___" FROM "companies" WHERE ("industry" = 'Banking' OR "industry" = 'Conglomerate') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Companies WHERE Industry = 'Banking' OR Industry = 'Conglomerate';

/*
Prediction Result:
(0,)
*/