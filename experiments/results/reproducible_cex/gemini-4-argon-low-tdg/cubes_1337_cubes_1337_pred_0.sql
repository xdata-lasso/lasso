-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT JOIN (Company 4 has no stations), GROUP BY (Company, Profits_billion) vs GROUP BY Company alone, and ORDER BY (Company, count___).
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 1, 'Alpha', 'NY', 'Oil', 100.0, 10.5, 200.0, 150.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 2, 'Alpha', 'CA', 'Gas', 120.0, 20.5, 250.0, 180.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (3, 3, 'Beta', 'TX', 'Oil', 80.0, 10.5, 150.0, 120.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (4, 4, 'Gamma', 'FL', 'Energy', 50.0, 5.0, 100.0, 90.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (101, 2000, 'Loc1', 'M1', 'V1', 'R1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (102, 2005, 'Loc2', 'M2', 'V2', 'R2');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (103, 2010, 'Loc3', 'M3', 'V3', 'R3');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (101, 1, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 1, 2);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (103, 1, 3);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (101, 2, 2);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (102, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, n AS count___ FROM (SELECT company, profits_billion, COUNT(*) AS n FROM (SELECT LHS.company_id AS company_id, LHS.rank AS rank, LHS.company AS company, LHS.headquarters AS headquarters, LHS.main_industry AS main_industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value AS market_value, RHS.station_id AS station_id, RHS.rank_of_the_year AS rank_of_the_year FROM company AS LHS INNER JOIN station_company AS RHS ON (LHS.company_id = RHS.company_id)) GROUP BY company, profits_billion) ORDER BY company, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 1)
('Alpha', 3)
('Beta', 1)
*/

-- Prediction Query
SELECT T2.company, COUNT(*) FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id GROUP BY T1.company_id;

/*
Prediction Result:
('Alpha', 3)
('Alpha', 1)
('Beta', 1)
*/