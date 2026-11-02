-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 1, 'Alpha', 'HQ1', 'Oil', 100.0, 10.0, 200.0, 150.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 2, 'Alpha', 'HQ2', 'Oil', 120.0, 12.0, 220.0, 160.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (3, 3, 'Alpha', 'HQ3', 'Gas', 90.0, 9.0, 180.0, 140.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (4, 4, 'Beta', 'HQ4', 'Tech', 80.0, 8.0, 160.0, 130.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (5, 5, 'Beta', 'HQ5', 'Retail', 70.0, 7.0, 140.0, 120.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (6, 6, 'Beta', 'HQ6', NULL, 60.0, 6.0, 120.0, 110.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (7, 7, 'Gamma', 'HQ7', 'Auto', 50.0, 5.0, 100.0, 100.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (8, 8, 'Delta', 'HQ8', 'Finance', 40.0, 4.0, 80.0, 90.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (1, 2000, 'Loc1', 'M1', 'VM1', 'R1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 2005, 'Loc2', 'M2', 'VM2', 'R2');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (3, 2010, 'Loc3', 'M3', 'VM3', 'R3');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (1, 7, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (2, 8, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (3, 8, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, main_industry FROM (SELECT * FROM company AS LHS WHERE NOT EXISTS(SELECT 1 FROM station_company AS RHS WHERE (LHS.company_id = RHS.company_id))) ORDER BY company, main_industry NULLS LAST;

/*
Gold Result:
('Alpha', 'Gas')
('Alpha', 'Oil')
('Alpha', 'Oil')
('Beta', 'Retail')
('Beta', 'Tech')
('Beta', None)
*/

-- Prediction Query
SELECT company, main_industry FROM company WHERE NOT company_id IN (SELECT company_id FROM station_company);

/*
Prediction Result:
('Alpha', 'Oil')
('Alpha', 'Oil')
('Alpha', 'Gas')
('Beta', 'Tech')
('Beta', 'Retail')
('Beta', None)
*/