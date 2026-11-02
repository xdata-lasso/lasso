-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY tie-breaking (same Company, different Company_ID), DISTINCT vs ALL (duplicate output rows), and NULLs in projected/ordered columns.
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (10, 2, 'Acme', 'Germany', 'Auto', 50.0, 5.0, 100.0, 150.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 1, 'Acme', 'France', 'Aerospace', 60.0, 6.0, 120.0, 180.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (8, 3, 'Acme', 'Canada', 'Auto', 40.0, 4.0, 80.0, 120.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (20, 4, NULL, 'Canada', 'Mining', 30.0, 3.0, 60.0, 90.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (15, 5, NULL, 'UK', NULL, 20.0, 2.0, 40.0, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "company", "main_industry" FROM "company" WHERE ("headquarters" <> 'USA') ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
(None, None)
(None, 'Mining')
('Acme', 'Aerospace')
('Acme', 'Auto')
('Acme', 'Auto')
*/

-- Prediction Query
SELECT company, main_industry FROM company WHERE headquarters <> 'USA';

/*
Prediction Result:
('Acme', 'Aerospace')
('Acme', 'Auto')
('Acme', 'Auto')
(None, None)
(None, 'Mining')
*/