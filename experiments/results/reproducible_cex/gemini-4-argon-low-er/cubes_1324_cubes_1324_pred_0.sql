-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (Company_ID, Company, Headquarters, Market_Value) VALUES (1, 'A', 'HQ1', 10.0);
INSERT INTO company (Company_ID, Company, Headquarters, Market_Value) VALUES (2, 'B', 'HQ2', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, headquarters FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('A', 'HQ1')
('B', 'HQ2')
*/

-- Prediction Query
SELECT company, headquarters FROM company ORDER BY market_value DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('B', 'HQ2')
('A', 'HQ1')
*/