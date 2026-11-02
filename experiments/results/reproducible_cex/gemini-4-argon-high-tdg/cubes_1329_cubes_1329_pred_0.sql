-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 50, 'Beta Bank', 'London', 'Banking', 80.1, 10.2, 900.3, 200.5);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 10, 'Zeta Bank', 'New York', 'Banking', 120.4, 5.5, 500.6, 150.2);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 30, 'Alpha Bank', 'Tokyo', 'Banking', 40.7, 25.8, 300.9, 350.8);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 5, 'Banking', 'Banking', 'Oil and Gas', 500.0, 45.0, 1000.0, 600.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 15, 'Delta Corp', 'Paris', 'Retail', 90.0, 8.0, 110.0, 75.0);
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (101, 1998, 'Downtown', 'Alice', 'Bob', 'Charlie');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (102, 2005, 'Uptown', 'David', 'Eve', 'Frank');
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (101, 2, 1);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (102, 2, 2);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (101, 3, 5);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (102, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank", "company", "market_value" FROM "company" WHERE ("main_industry" = 'Banking') ORDER BY rank, company.company_id NULLS LAST;

/*
Gold Result:
(10, 'Zeta Bank', 150.2)
(30, 'Alpha Bank', 350.8)
(50, 'Beta Bank', 200.5)
*/

-- Prediction Query
SELECT rank, company, market_value FROM company WHERE main_industry = 'Banking' ORDER BY sales_billion, profits_billion, company.company_id NULLS LAST;

/*
Prediction Result:
(30, 'Alpha Bank', 350.8)
(50, 'Beta Bank', 200.5)
(10, 'Zeta Bank', 150.2)
*/