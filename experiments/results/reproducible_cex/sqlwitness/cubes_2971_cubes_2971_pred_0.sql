-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO companies (id, name, headquarters, industry, sales_billion, profits_billion, assets_billion, market_value_billion) VALUES (0, 'default1', NULL, 'default2', 0.0, 3.0, 2.0, 'default1'), (2, 'default1', NULL, 'default1', 3.0, NULL, 2.0, 'default2'), (1, 'default2', NULL, NULL, 1.0, 3.0, 2.0, 'default2'), (3, NULL, 'default2', 'default2', 1.0, 3.0, 3.0, NULL), (4, NULL, 'default2', 'default1', 3.0, NULL, 0.0, 'default1'), (5, NULL, 'default1', 'default1', 3.0, NULL, 3.0, 'default2'), (6, 'default1', NULL, 'default1', 1.0, 1.0, 2.0, NULL), (7, NULL, 'default1', 'default1', NULL, NULL, 0.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT headquarters FROM (SELECT LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.n AS n, RHS.headquarters AS headquarters_other, RHS.industry AS industry_other, RHS.n AS n_other FROM (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS LHS CROSS JOIN (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS RHS) WHERE (n > n_other) ORDER BY headquarters;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT Headquarters FROM Companies GROUP BY Headquarters HAVING COUNT(*) > 2;

/*
Prediction Result:
(None,)
*/