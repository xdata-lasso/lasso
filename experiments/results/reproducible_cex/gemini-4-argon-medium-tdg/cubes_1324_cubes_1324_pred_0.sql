-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by company name (ascending), duplicate projection preservation (testing against DISTINCT), and filtering mutations (negative/zero/NULL numeric columns).
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 10, 'Zeta Corp', 'New York', 'Tech', 100.5, 10.2, 200.0, 500.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 1, 'Alpha Inc', 'London', 'Finance', 0.0, -5.0, 50.0, 10.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, NULL, 'Beta LLC', 'Tokyo', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 5, 'Alpha Inc', 'London', 'Retail', 20.0, 2.0, 30.0, 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, headquarters FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('Alpha Inc', 'London')
('Alpha Inc', 'London')
('Beta LLC', 'Tokyo')
('Zeta Corp', 'New York')
*/

-- Prediction Query
SELECT company, headquarters FROM company ORDER BY market_value DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('Zeta Corp', 'New York')
('Alpha Inc', 'London')
('Alpha Inc', 'London')
('Beta LLC', 'Tokyo')
*/