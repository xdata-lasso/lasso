-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Companies (id, name, Headquarters, Industry) VALUES (1, 'CompA', 'NY', 'Tech');
INSERT INTO Companies (id, name, Headquarters, Industry) VALUES (2, 'CompB', 'NY', 'Tech');
INSERT INTO Companies (id, name, Headquarters, Industry) VALUES (3, 'CompC', 'NY', 'Tech');
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
('NY',)
*/