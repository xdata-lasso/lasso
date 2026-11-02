-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (company_id, rank, company, headquarters, main_industry, sales_billion, profits_billion, assets_billion, market_value) VALUES (0, 0, NULL, 'default1', 'default1', 0.0, NULL, NULL, 1.0), (1, 1, 'default1', 'default1', 'default2', 1.0, 0.0, NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, rank FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
(None, 0)
('default1', 1)
*/

-- Prediction Query
SELECT company, rank FROM company ORDER BY Sales_billion DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('default1', 1)
(None, 0)
*/