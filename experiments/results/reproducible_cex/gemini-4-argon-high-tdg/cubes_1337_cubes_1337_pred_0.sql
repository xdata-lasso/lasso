-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (10, 1, 'Zeta Corp', 'Houston', 'Oil and Gas', 500.0, 40.0, 400.0, 350.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (20, 2, 'Omega Inc', 'London', 'Energy', 300.0, 25.0, 250.0, 200.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (30, 3, 'Alpha LLC', 'Paris', 'Refining', 450.0, 35.0, 380.0, 310.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (40, 4, 'Ghost Oil', 'Dallas', 'Exploration', 100.0, 10.0, 90.0, 80.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (101, 1998, 'Downtown', 'Alice', 'Bob', 'Charlie');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (102, 2005, 'Uptown', 'David', 'Eve', 'Frank');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (103, 2012, 'Suburb', 'Grace', 'Heidi', 'Ivan');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (104, 2018, 'Highway', 'Judy', 'Karl', 'Liam');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (101, 10, 5);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 10, 6);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (101, 20, 7);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (101, 30, 8);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 30, 9);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (103, 30, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, n AS count___ FROM (SELECT company, profits_billion, COUNT(*) AS n FROM (SELECT LHS.company_id AS company_id, LHS.rank AS rank, LHS.company AS company, LHS.headquarters AS headquarters, LHS.main_industry AS main_industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value AS market_value, RHS.station_id AS station_id, RHS.rank_of_the_year AS rank_of_the_year FROM company AS LHS INNER JOIN station_company AS RHS ON (LHS.company_id = RHS.company_id)) GROUP BY company, profits_billion) ORDER BY company, count___ NULLS LAST;

/*
Gold Result:
('Alpha LLC', 3)
('Omega Inc', 1)
('Zeta Corp', 2)
*/

-- Prediction Query
SELECT T2.company, COUNT(*) FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id GROUP BY T1.company_id;

/*
Prediction Result:
('Zeta Corp', 2)
('Omega Inc', 1)
('Alpha LLC', 3)
*/