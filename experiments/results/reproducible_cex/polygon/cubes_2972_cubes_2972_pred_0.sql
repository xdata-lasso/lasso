-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (11, '2', '2', 2, 2, '2');
INSERT INTO "buildings" ("id", "name", "city", "height", "stories", "status") VALUES (10, '2', '2', 2, 2, '2');
INSERT INTO "Companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (2, '17', '18', '19', 20, 15, 21, '22');
INSERT INTO "Companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (12, '2', '2', NULL, 2, 15, 2, '2');
INSERT INTO "Office_locations" ("building_id", "company_id", "move_in_year") VALUES (10, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT industry FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value_billion AS market_value_billion FROM companies AS LHS INNER JOIN (SELECT profits_billion, COUNT(*) AS n FROM companies GROUP BY profits_billion) AS RHS ON (LHS.id = RHS.n AND LHS.profits_billion = RHS.profits_billion)) ORDER BY industry;

/*
Gold Result:
('19',)
*/

-- Prediction Query
SELECT Industry FROM Companies GROUP BY Industry ORDER BY COUNT(*) DESC, Industry NULLS LAST LIMIT 1;

/*
Prediction Result:
('19',)
*/