-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 1, 'Zeta Energy', 'Houston', 'Oil and Gas', 250.5, 25.0, 300.0, 400.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 5, 'Alpha Corp', 'Tokyo', 'Banking', 120.0, 12.5, 800.0, 180.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (3, 2, 'Alpha Corp', 'London', 'Banking', 150.0, 15.0, 900.0, 210.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (4, 3, 'Beta Group', 'Paris', 'Retail', 90.0, 5.5, 110.0, 95.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (5, 4, 'Beta Group', 'Paris', 'Retail', 85.0, 4.0, 105.0, 90.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (101, 2005, 'Houston', 'John Smith', 'Alice Brown', 'Bob White');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (102, 2012, 'London', 'Emma Wilson', 'David Lee', 'Clara Hall');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (101, 1, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 1, 2);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, headquarters FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('Alpha Corp', 'Tokyo')
('Alpha Corp', 'London')
('Beta Group', 'Paris')
('Beta Group', 'Paris')
('Zeta Energy', 'Houston')
*/

-- Prediction Query
SELECT company, headquarters FROM company ORDER BY market_value DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('Zeta Energy', 'Houston')
('Alpha Corp', 'London')
('Alpha Corp', 'Tokyo')
('Beta Group', 'Paris')
('Beta Group', 'Paris')
*/