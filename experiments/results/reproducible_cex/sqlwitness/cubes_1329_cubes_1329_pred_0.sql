-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (company_id, rank, company, headquarters, main_industry, sales_billion, profits_billion, assets_billion, market_value) VALUES (1, 1, 'Banking', 'default1', NULL, 1.0, NULL, 1.0, 1.0), (0, 1, NULL, NULL, 'default2', 0.0, 1.0, 0.0, 1.0), (2, 0, 'Banking', 'default2', 'default2', 0.0, 0.0, NULL, 0.0), (3, 0, 'Banking', 'default1', 'Banking', 0.0, 0.0, 1.0, NULL), (4, 1, 'default2', 'default2', 'Banking', 0.0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank", "company", "market_value" FROM "company" WHERE ("main_industry" = 'Banking') ORDER BY rank, company.company_id NULLS LAST;

/*
Gold Result:
(0, 'Banking', None)
(1, 'default2', None)
*/

-- Prediction Query
SELECT rank, company, market_value FROM company WHERE main_industry = 'Banking' ORDER BY sales_billion, profits_billion, company.company_id NULLS LAST;

/*
Prediction Result:
(1, 'default2', None)
(0, 'Banking', None)
*/