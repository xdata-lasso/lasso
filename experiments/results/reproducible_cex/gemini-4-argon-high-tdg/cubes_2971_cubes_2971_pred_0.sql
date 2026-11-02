-- Schema DDL
CREATE TABLE "buildings" ("id" INTEGER PRIMARY KEY, "name" TEXT, "City" TEXT, "Height" INTEGER, "Stories" INTEGER, "Status" TEXT);

CREATE TABLE "Companies" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Headquarters" TEXT, "Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value_billion" TEXT);

CREATE TABLE "Office_locations" ("building_id" INTEGER, "company_id" INTEGER, "move_in_year" INTEGER, PRIMARY KEY ("building_id", "company_id"), FOREIGN KEY ("company_id") REFERENCES "Companies" ("id"), FOREIGN KEY ("building_id") REFERENCES "buildings" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (1, 'Delta Tower', 'Delta', 300, 60, 'Completed');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (2, 'Delta Annex', 'Delta', 200, 40, 'Completed');
INSERT INTO buildings (id, name, City, Height, Stories, Status) VALUES (3, 'Delta Plaza', 'Delta', 150, 30, 'Completed');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (1, 'B1', 'HQ_Beta', 'Finance', 10.0, 1.0, 50.0, '20.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (2, 'B2', 'HQ_Beta', 'Finance', 10.0, 1.0, 50.0, '20.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (3, 'B3', 'HQ_Beta', 'Finance', 10.0, 1.0, 50.0, '20.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (4, 'B4', 'HQ_Beta', 'Finance', 10.0, 1.0, 50.0, '20.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (5, 'G1', 'HQ_Gamma', 'Retail', 15.0, 2.0, 30.0, '25.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (6, 'G2', 'HQ_Gamma', 'Retail', 15.0, 2.0, 30.0, '25.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (7, 'A1', 'HQ_Alpha', 'Tech', 12.0, 3.0, 40.0, '35.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (8, 'A2', 'HQ_Alpha', 'Tech', 12.0, 3.0, 40.0, '35.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (9, 'A3', 'HQ_Alpha', 'Tech', 12.0, 3.0, 40.0, '35.0');
INSERT INTO Companies (id, name, Headquarters, Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value_billion) VALUES (10, 'D1', 'HQ_Delta', 'Energy', 100.0, 20.0, 200.0, '150.0');
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (1, 10, 2010);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (2, 10, 2012);
INSERT INTO Office_locations (building_id, company_id, move_in_year) VALUES (3, 10, 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT headquarters FROM (SELECT LHS.headquarters AS headquarters, LHS.industry AS industry, LHS.n AS n, RHS.headquarters AS headquarters_other, RHS.industry AS industry_other, RHS.n AS n_other FROM (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS LHS CROSS JOIN (SELECT headquarters, industry, COUNT(*) AS n FROM companies GROUP BY headquarters, industry) AS RHS) WHERE (n > n_other) ORDER BY headquarters;

/*
Gold Result:
('HQ_Alpha',)
('HQ_Beta',)
('HQ_Gamma',)
*/

-- Prediction Query
SELECT Headquarters FROM Companies GROUP BY Headquarters HAVING COUNT(*) > 2;

/*
Prediction Result:
('HQ_Alpha',)
('HQ_Beta',)
*/