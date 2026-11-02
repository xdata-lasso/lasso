-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, sorting by Headquarters (including NULLs), DISTINCT vs ALL, and case sensitivity.
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 10, 'Alpha Bank', 'Zurich', 'Banking', 50.0, 5.0, 500.0, 60.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 20, 'Beta Bank', 'Amsterdam', 'Banking', 40.0, 4.0, 400.0, 50.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 30, 'Gamma Bank', 'Amsterdam', 'Banking', 30.0, 3.0, 300.0, 40.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 40, 'Ghost Bank', NULL, 'Banking', 20.0, 2.0, 200.0, 30.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 5, 'PetroCorp', 'Houston', 'Oil and gas', 100.0, 10.0, 200.0, 150.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (6, 15, 'TechCorp', 'Silicon Valley', 'Technology', 80.0, 15.0, 100.0, 300.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (7, 25, 'NullInd', 'London', NULL, 10.0, 1.0, 50.0, 20.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (8, 35, 'LowerBank', 'Berlin', 'banking', 15.0, 1.5, 60.0, 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarters" FROM "company" WHERE ("main_industry" = 'Banking' AND "main_industry" <> 'Oil and gas') ORDER BY headquarters, company.company_id NULLS LAST;

/*
Gold Result:
(None,)
('Amsterdam',)
('Amsterdam',)
('Zurich',)
*/

-- Prediction Query
SELECT headquarters FROM company WHERE main_industry = 'Banking' INTERSECT SELECT headquarters FROM company WHERE main_industry = 'Oil and gas';

/*
Prediction Result:
*/