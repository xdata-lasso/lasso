-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 10, 'Alpha Bank', 'NY', 'Banking', 50.5, 10.2, 200.0, 150.75);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 5, 'Beta Fin', 'London', 'Banking', 80.0, 15.0, 500.0, 300.25);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 1, 'Gamma Oil', 'Texas', 'Oil and Gas', 120.0, 25.0, 400.0, 450.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 8, 'Delta Corp', 'Tokyo', 'banking', 60.0, 8.0, 150.0, 90.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 12, 'Epsilon Trust', 'Zurich', NULL, 40.0, 5.0, 100.0, 70.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank", "company", "market_value" FROM "company" WHERE ("main_industry" = 'Banking') ORDER BY rank, company.company_id NULLS LAST;

/*
Gold Result:
(5, 'Beta Fin', 300.25)
(10, 'Alpha Bank', 150.75)
*/

-- Prediction Query
SELECT rank, company, market_value FROM company WHERE main_industry = 'Banking' ORDER BY sales_billion, profits_billion, company.company_id NULLS LAST;

/*
Prediction Result:
(10, 'Alpha Bank', 150.75)
(5, 'Beta Fin', 300.25)
*/