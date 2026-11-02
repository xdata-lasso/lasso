-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1001, 'Allison Hill', 'all', 'better', 1004.5, 1007.5, 1010.5, 'discover');
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1002, 'Noah Rhodes', 'all', 'better', 1015.5, 1020.5, 1025.5, 'early');
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1003, 'Angie Henderson', 'all', 'better', 1026.5, 1033.5, 1040.5, 'mouth');
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1013, 'Kristina Baldwin', 'collection', 'save', 1016.5, 1019.5, 1022.5, 'knowledge');
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1014, 'Jennifer Cole', 'collection', 'save', 1027.5, 1032.5, 1037.5, 'grow');
INSERT INTO "companies" ("id", "name", "headquarters", "industry", "sales_billion", "profits_billion", "assets_billion", "market_value_billion") VALUES (1015, 'Sean Blake', 'collection', 'save', 1038.5, 1045.5, 1052.5, 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT headquarters FROM (SELECT LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.n AS n, RHS.headquarters AS headquarters_other, RHS.industry AS industry_other, RHS.n AS n_other FROM (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS LHS CROSS JOIN (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS RHS) WHERE (n > n_other) ORDER BY headquarters;

/*
Gold Result:
*/

-- Prediction Query
SELECT Headquarters FROM Companies GROUP BY Headquarters HAVING COUNT(*) > 2;

/*
Prediction Result:
('all',)
('collection',)
*/