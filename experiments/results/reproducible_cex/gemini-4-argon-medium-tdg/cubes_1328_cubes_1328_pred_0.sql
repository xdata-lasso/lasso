-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 10, 'Zeta Corp', 'Boston', 'Energy', 10.0, 5.0, 20.0, 200.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 20, 'Eta Corp', 'Denver', 'Energy', 10.0, 5.0, 20.0, 300.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (1, 2005, 'Duplicate_Location', 'M1', 'V1', 'R1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 2001, 'Zebra_Location', 'M2', 'V2', 'R2');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (3, 2015, 'Alpha_Location', 'M3', 'V3', 'R3');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (1, 1, 5);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (1, 2, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (2, 1, 2);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (3, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.station_id AS station_id, LHS.open_year AS open_year, LHS.location AS LOCATION, LHS.manager_name AS manager_name, LHS.vice_manager_name AS vice_manager_name, LHS.representative_name AS representative_name, LHS.company_id AS company_id, LHS.rank_of_the_year AS rank_of_the_year, RHS.rank AS rank, RHS.company AS company, RHS.headquarters AS headquarters, RHS.main_industry AS main_industry, RHS.sales_billion AS sales_billion, RHS.profits_billion AS profits_billion, RHS.assets_billion AS assets_billion, RHS.market_value AS market_value FROM (SELECT LHS.station_id AS station_id, LHS.open_year AS open_year, LHS.location AS LOCATION, LHS.manager_name AS manager_name, LHS.vice_manager_name AS vice_manager_name, LHS.representative_name AS representative_name, RHS.company_id AS company_id, RHS.rank_of_the_year AS rank_of_the_year FROM gas_station AS LHS INNER JOIN station_company AS RHS ON (LHS.station_id = RHS.station_id)) AS LHS INNER JOIN (SELECT * FROM company WHERE (market_value > 100.0)) AS RHS ON (LHS.company_id = RHS.company_id)) ORDER BY LOCATION;

/*
Gold Result:
('Alpha_Location',)
('Duplicate_Location',)
('Duplicate_Location',)
('Zebra_Location',)
*/

-- Prediction Query
SELECT T3.location FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id JOIN gas_station AS T3 ON T1.station_id = T3.station_id WHERE T2.market_value > 100;

/*
Prediction Result:
('Duplicate_Location',)
('Duplicate_Location',)
('Zebra_Location',)
('Alpha_Location',)
*/