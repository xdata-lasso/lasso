-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic logic, DISTINCT requirement, ORDER BY, and distinguishes grouping by (headquarters, industry) vs grouping by (headquarters) or (industry) alone, as well as filtering vs non-filtering (SELECT DISTINCT headquarters FROM companies).
-- Counts by (HQ, Ind):
-- ('Boston', 'Tech'): 3
-- ('Boston', 'Retail'): 3
-- ('Austin', 'Tech'): 2
-- ('Chicago', 'Retail'): 1
-- ('Chicago', 'Finance'): 1
-- ('Chicago', 'Media'): 1
-- ('Chicago', 'Health'): 1
-- Min count is 1 ('Chicago', ...).
-- Expected Output: 'Austin', 'Boston'.
-- Catches:
-- 1. Missing DISTINCT (Boston appears multiple times from Tech and Retail, and comparing against multiple smaller groups).
-- 2. Grouping by Headquarters only (Chicago total is 4, which would be > Austin's 2).
-- 3. Grouping by Industry only.
-- 4. Reversed inequality (n < n_other would output Austin, Chicago).
-- 5. Equality (n >= n_other would include Chicago).
-- 6. Missing WHERE clause (would include Chicago).
-- 7. Wrong ORDER BY (e.g., DESC or ordering by count n).
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (1, 'B_Tech1', 'Boston', 'Tech', 10.0, 1.0, 5.0, '10');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (2, 'B_Tech2', 'Boston', 'Tech', 10.0, 1.0, 5.0, '10');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (3, 'B_Tech3', 'Boston', 'Tech', 10.0, 1.0, 5.0, '10');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (4, 'B_Ret1', 'Boston', 'Retail', 10.0, 1.0, 5.0, '10');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (5, 'B_Ret2', 'Boston', 'Retail', 10.0, 1.0, 5.0, '10');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (6, 'B_Ret3', 'Boston', 'Retail', 10.0, 1.0, 5.0, '10');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (7, 'A_Tech1', 'Austin', 'Tech', 20.0, 2.0, 10.0, '20');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (8, 'A_Tech2', 'Austin', 'Tech', 20.0, 2.0, 10.0, '20');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (9, 'C_Ret1', 'Chicago', 'Retail', 5.0, 0.5, 2.0, '5');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (10, 'C_Fin1', 'Chicago', 'Finance', 5.0, 0.5, 2.0, '5');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (11, 'C_Med1', 'Chicago', 'Media', 5.0, 0.5, 2.0, '5');
INSERT INTO "Companies" ("id", "name", "Headquarters", "Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value_billion") VALUES (12, 'C_Hea1', 'Chicago', 'Health', 5.0, 0.5, 2.0, '5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT headquarters FROM (SELECT LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.n AS n, RHS.headquarters AS headquarters_other, RHS.industry AS industry_other, RHS.n AS n_other FROM (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS LHS CROSS JOIN (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS RHS) WHERE (n > n_other) ORDER BY headquarters;

/*
Gold Result:
('Austin',)
('Boston',)
*/

-- Prediction Query
SELECT Headquarters FROM Companies GROUP BY Headquarters HAVING COUNT(*) > 2;

/*
Prediction Result:
('Boston',)
('Chicago',)
*/