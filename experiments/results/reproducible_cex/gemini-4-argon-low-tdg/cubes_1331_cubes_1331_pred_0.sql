-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Company ASC, secondary ordering by Company_ID, duplicate (company, rank) pairs (to kill DISTINCT), and unlinked companies vs linked companies (to kill INNER JOIN with station_company).
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (10, 3, 'Beta', 'NY', 'Oil', 100.0, 10.0, 200.0, 150.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 1, 'Alpha', 'CA', 'Gas', 200.0, 20.0, 300.0, 250.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'Alpha', 'TX', 'Oil', 150.0, 15.0, 250.0, 200.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (8, 3, 'Beta', 'FL', 'Energy', 90.0, 9.0, 180.0, 120.0);
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (1, 2000, 'Downtown', 'John', 'Jane', 'Bob');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (2, 2005, 'Uptown', 'Alice', 'Tom', 'Jerry');
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (1, 10, 99);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (2, 10, 88);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, rank FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('Alpha', 2)
('Alpha', 1)
('Beta', 3)
('Beta', 3)
*/

-- Prediction Query
SELECT company, rank FROM company ORDER BY Sales_billion DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('Alpha', 1)
('Alpha', 2)
('Beta', 3)
('Beta', 3)
*/