-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1001, 1002, 'Rodriguez, Figueroa and Sanchez', 'chair', 'Banking', 1003.5, 1004.5, 1005.5, 1006.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarters" FROM "company" WHERE ("main_industry" = 'Banking' AND "main_industry" <> 'Oil and gas') ORDER BY headquarters, company.company_id NULLS LAST;

/*
Gold Result:
('chair',)
*/

-- Prediction Query
SELECT headquarters FROM company WHERE main_industry = 'Banking' INTERSECT SELECT headquarters FROM company WHERE main_industry = 'Oil and gas';

/*
Prediction Result:
*/