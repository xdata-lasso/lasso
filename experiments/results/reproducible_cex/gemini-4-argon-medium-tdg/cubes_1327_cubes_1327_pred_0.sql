-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'Exxon', 'USA', 'Oil and gas', 400.0, 40.0, 300.0, 500.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'Sinopec', 'China', 'Oil and gas', 450.0, 20.0, 250.0, 100.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 3, 'Toyota', 'Japan', 'Automotive', 250.0, 15.0, 400.0, 200.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 4, 'Shell', 'UK', 'Oil and gas', 350.0, 25.0, 350.0, 220.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "company", "main_industry" FROM "company" WHERE ("headquarters" <> 'USA') ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('Shell', 'Oil and gas')
('Sinopec', 'Oil and gas')
('Toyota', 'Automotive')
*/

-- Prediction Query
SELECT company, main_industry FROM company WHERE headquarters <> 'USA';

/*
Prediction Result:
('Sinopec', 'Oil and gas')
('Toyota', 'Automotive')
('Shell', 'Oil and gas')
*/