-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (10, 20, 'Bank A', 'NY', 'Banking', 50.0, 5.0, 100.0, 300.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (20, 5, 'Bank Z', 'LA', 'Banking', 80.0, 8.0, 200.0, 100.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (15, 5, 'Bank M', 'SF', 'Banking', 90.0, 9.0, 250.0, 150.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, NULL, 'Bank Null', 'DC', 'Banking', 40.0, 4.0, 80.0, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank", "company", "market_value" FROM "company" WHERE ("main_industry" = 'Banking') ORDER BY rank, company.company_id NULLS LAST;

/*
Gold Result:
(None, 'Bank Null', 50.0)
(5, 'Bank M', 150.0)
(5, 'Bank Z', 100.0)
(20, 'Bank A', 300.0)
*/

-- Prediction Query
SELECT rank, company, market_value FROM company WHERE main_industry = 'Banking' ORDER BY sales_billion, profits_billion, company.company_id NULLS LAST;

/*
Prediction Result:
(None, 'Bank Null', 50.0)
(20, 'Bank A', 300.0)
(5, 'Bank Z', 100.0)
(5, 'Bank M', 150.0)
*/