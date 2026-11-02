-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (10, 1, 'Boundary Corp', 'New York', 'Energy', 120.0, 15.0, 200.0, 100.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (20, 2, 'JustAbove Inc', 'Houston', 'Oil', 80.0, 8.0, 150.0, 100.01);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (30, 3, 'JustBelow LLC', 'Dallas', 'Gas', 95.0, 9.0, 110.0, 99.99);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (40, 4, 'MegaValue Co', 'Chicago', 'Refining', 300.0, 40.0, 500.0, 500.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (50, 5, 'NullValue Ltd', 'Seattle', 'Energy', 150.0, 20.0, 250.0, NULL);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (1, 2010, 'Zeta Ave', 'Alice', 'Bob', 'Charlie');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 2012, 'Beta St', 'David', 'Eve', 'Frank');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (3, 2015, 'Alpha Rd', 'Grace', 'Heidi', 'Ivan');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (4, 2018, 'Gamma Blvd', 'Judy', 'Karl', 'Liam');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (5, 2020, 'Delta Way', 'Mallory', 'Niaj', 'Olivia');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (1, 20, 2);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (2, 10, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (3, 40, 4);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (4, 30, 3);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (5, 50, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.station_id AS station_id, LHS.open_year AS open_year, LHS.location AS LOCATION, LHS.manager_name AS manager_name, LHS.vice_manager_name AS vice_manager_name, LHS.representative_name AS representative_name, LHS.company_id AS company_id, LHS.rank_of_the_year AS rank_of_the_year, RHS.rank AS rank, RHS.company AS company, RHS.headquarters AS headquarters, RHS.main_industry AS main_industry, RHS.sales_billion AS sales_billion, RHS.profits_billion AS profits_billion, RHS.assets_billion AS assets_billion, RHS.market_value AS market_value FROM (SELECT LHS.station_id AS station_id, LHS.open_year AS open_year, LHS.location AS LOCATION, LHS.manager_name AS manager_name, LHS.vice_manager_name AS vice_manager_name, LHS.representative_name AS representative_name, RHS.company_id AS company_id, RHS.rank_of_the_year AS rank_of_the_year FROM gas_station AS LHS INNER JOIN station_company AS RHS ON (LHS.station_id = RHS.station_id)) AS LHS INNER JOIN (SELECT * FROM company WHERE (market_value > 100.0)) AS RHS ON (LHS.company_id = RHS.company_id)) ORDER BY LOCATION;

/*
Gold Result:
('Alpha Rd',)
('Zeta Ave',)
*/

-- Prediction Query
SELECT T3.location FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id JOIN gas_station AS T3 ON T1.station_id = T3.station_id WHERE T2.market_value > 100;

/*
Prediction Result:
('Zeta Ave',)
('Alpha Rd',)
*/