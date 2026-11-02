-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (3, 1, 'Alpha', 'NY', 'Oil', 100.0, 10.0, 200.0, 300.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 1, 'Alpha', 'NY', 'Oil', 100.0, 10.0, 200.0, 300.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 3, 'Alpha', 'LA', 'Gas', 50.0, 5.0, 100.0, 150.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (5, 2, 'Beta', 'TX', 'Energy', 80.0, 8.0, 160.0, 240.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (4, 4, 'Beta', 'FL', 'Oil', 40.0, 4.0, 80.0, 120.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, rank FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('Alpha', 1)
('Alpha', 3)
('Alpha', 1)
('Beta', 4)
('Beta', 2)
*/

-- Prediction Query
SELECT company, rank FROM company ORDER BY Sales_billion DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('Alpha', 1)
('Alpha', 1)
('Beta', 2)
('Alpha', 3)
('Beta', 4)
*/