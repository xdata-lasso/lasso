-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'B_Corp', 'UK', 'Oil and gas', 100.0, 10.0, 200.0, 150.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'A_Corp', 'France', 'Banking', 90.0, 9.0, 180.0, 140.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "company", "main_industry" FROM "company" WHERE ("headquarters" <> 'USA') ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('A_Corp', 'Banking')
('B_Corp', 'Oil and gas')
*/

-- Prediction Query
SELECT company, main_industry FROM company WHERE headquarters <> 'USA';

/*
Prediction Result:
('B_Corp', 'Oil and gas')
('A_Corp', 'Banking')
*/