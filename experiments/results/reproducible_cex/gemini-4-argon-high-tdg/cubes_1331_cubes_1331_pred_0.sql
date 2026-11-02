-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 2, 'Sinopec', 'China', 'Oil and gas', 411.7, 5.1, 302.2, 95.3);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 5, 'ExxonMobil', 'USA', 'Oil and gas', 268.9, 19.7, 348.7, 343.2);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (3, 1, 'ExxonMobil', 'USA', 'Energy', 310.5, 25.0, 360.0, 390.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (4, 10, 'BP', 'UK', 'Oil and gas', 222.8, 3.4, 276.2, 113.8);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (5, 2, 'Sinopec', 'China', 'Chemicals', 190.0, 2.1, 150.0, 60.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (101, 1998, 'Beijing', 'Alice Wang', 'Bob Li', 'Charlie Zhang');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (102, 2005, 'London', 'David Smith', 'Eve Jones', 'Frank Brown');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (101, 1, 99);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 1, 88);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 4, 77);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, rank FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('BP', 10)
('ExxonMobil', 5)
('ExxonMobil', 1)
('Sinopec', 2)
('Sinopec', 2)
*/

-- Prediction Query
SELECT company, rank FROM company ORDER BY Sales_billion DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('Sinopec', 2)
('ExxonMobil', 1)
('ExxonMobil', 5)
('BP', 10)
('Sinopec', 2)
*/