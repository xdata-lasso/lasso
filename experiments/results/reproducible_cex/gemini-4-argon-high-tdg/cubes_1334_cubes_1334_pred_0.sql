-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 10, 'Zeta Corp', 'New York', 'Energy', 120.5, 12.3, 200.0, 150.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 1, 'Alpha Inc', 'London', 'Chemicals', 85.0, 9.5, 110.0, 95.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (3, 2, 'Omega LLC', 'Tokyo', 'Logistics', 60.0, 4.2, 75.0, 50.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (1, 2010, 'Downtown', 'Alice', 'Bob', 'Charlie');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 2015, 'Uptown', 'David', 'Eve', 'Frank');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (1, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, main_industry FROM (SELECT * FROM company AS LHS WHERE NOT EXISTS(SELECT 1 FROM station_company AS RHS WHERE (LHS.company_id = RHS.company_id))) ORDER BY company, main_industry NULLS LAST;

/*
Gold Result:
('Omega LLC', 'Logistics')
('Zeta Corp', 'Energy')
*/

-- Prediction Query
SELECT company, main_industry FROM company WHERE NOT company_id IN (SELECT company_id FROM station_company);

/*
Prediction Result:
('Zeta Corp', 'Energy')
('Omega LLC', 'Logistics')
*/