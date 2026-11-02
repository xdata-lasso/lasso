-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality (n > n_other), DISTINCT removal of duplicate headquarters, and ORDER BY headquarters.
-- Also tests total Company count per HQ vs count per (HQ, Industry).
-- HQ_B has 2 companies total (1 Finance, 1 Retail), so max(n) for HQ_B is 1.
-- HQ_C has 2 companies in Tech (n=2).
-- HQ_A has 3 companies in Tech (n=3) and 2 in Retail (n=2).
-- Min(n) across table is 1 (from HQ_B). Thus HQ_A and HQ_C should be returned, HQ_B excluded.
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (1, 'Comp1', 'HQ_C', 'Tech', 10.0, 1.0, 5.0, '20');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (2, 'Comp2', 'HQ_C', 'Tech', 12.0, 1.2, 6.0, '22');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (3, 'Comp3', 'HQ_A', 'Tech', 15.0, 2.0, 8.0, '30');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (4, 'Comp4', 'HQ_A', 'Tech', 11.0, 1.1, 5.5, '21');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (5, 'Comp5', 'HQ_A', 'Tech', 9.0, 0.9, 4.5, '18');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (6, 'Comp6', 'HQ_A', 'Retail', 20.0, 3.0, 10.0, '40');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (7, 'Comp7', 'HQ_A', 'Retail', 25.0, 3.5, 12.0, '50');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (8, 'Comp8', 'HQ_B', 'Finance', 50.0, 5.0, 100.0, '80');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (9, 'Comp9', 'HQ_B', 'Retail', 5.0, 0.5, 2.0, '10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT headquarters FROM (SELECT LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.n AS n, RHS.headquarters AS headquarters_other, RHS.industry AS industry_other, RHS.n AS n_other FROM (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS LHS CROSS JOIN (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS RHS) WHERE (n > n_other) ORDER BY headquarters;

/*
Gold Result:
('HQ_A',)
('HQ_C',)
*/

-- Prediction Query
SELECT Headquarters FROM Companies GROUP BY Headquarters HAVING COUNT(*) > 2;

/*
Prediction Result:
('HQ_A',)
*/