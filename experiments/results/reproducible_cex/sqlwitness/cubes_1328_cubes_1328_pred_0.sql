-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gas_station (station_id, open_year, location, manager_name, vice_manager_name, representative_name) VALUES (0, 99, 'default1', NULL, 'default1', 'default2'), (101, 0, 'default1', NULL, 'default1', 'default2'), (1, 0, 'default1', 'default2', 'default2', NULL), (100, 101, NULL, NULL, 'default1', NULL), (99, 0, 'default1', 'default2', 'default1', NULL), (2, 101, 'default2', 'default2', 'default2', 'default2'), (3, NULL, 'default2', NULL, 'default1', 'default1'), (4, NULL, NULL, 'default1', 'default2', 'default2'), (5, NULL, 'default1', 'default1', 'default1', NULL), (6, 0, 'default1', 'default1', 'default1', NULL), (7, 1, NULL, 'default2', 'default2', 'default2'), (8, NULL, 'default1', 'default2', 'default1', 'default2'), (9, 100, 'default2', 'default2', 'default2', 'default1'), (10, 0, 'default2', NULL, 'default2', 'default2'), (11, 0, 'default2', NULL, 'default2', 'default1');
INSERT INTO company (company_id, rank, company, headquarters, main_industry, sales_billion, profits_billion, assets_billion, market_value) VALUES (101, NULL, NULL, 'default1', 'default1', 101.0, 101.0, 101.0, NULL), (99, 0, 'default1', NULL, NULL, NULL, 100.0, 101.0, 99.0), (100, 1, 'default2', NULL, 'default1', 0.0, 100.0, NULL, 0.0), (0, NULL, NULL, 'default2', NULL, 1.0, 101.0, 99.0, 99.0), (1, 0, 'default1', NULL, 'default1', 0.0, NULL, 0.0, 0.0), (2, 1, 'default2', NULL, 'default2', 100.0, 101.0, 99.0, 99.0), (3, 100, NULL, NULL, NULL, 1.0, 1.0, NULL, 0.0), (4, NULL, 'default1', NULL, 'default1', NULL, 101.0, NULL, 100.0), (5, 99, 'default1', 'default2', NULL, NULL, 101.0, 99.0, 100.0), (6, 0, 'default2', 'default1', 'default2', 1.0, 0.0, 100.0, 0.0), (7, NULL, 'default1', 'default1', NULL, 101.0, 100.0, 1.0, 101.0), (8, 99, 'default2', 'default1', 'default2', 100.0, 1.0, NULL, 100.0), (9, 101, 'default2', NULL, 'default2', 0.0, 101.0, NULL, 99.0), (10, 0, 'default1', 'default2', 'default2', 1.0, 1.0, 101.0, 101.0), (11, 99, 'default2', 'default1', 'default2', 99.0, 0.0, 100.0, 0.0), (12, 101, 'default2', NULL, 'default1', 99.0, 101.0, 101.0, NULL), (13, 101, 'default1', NULL, 'default1', 99.0, 100.0, NULL, 100.0), (14, 100, 'default1', 'default1', 'default2', 0.0, 99.0, 0.0, 101.0), (15, 99, 'default2', 'default2', 'default1', NULL, 1.0, 100.0, 0.0), (16, 101, NULL, 'default1', 'default1', 99.0, 100.0, 0.0, 1.0), (17, 101, 'default1', NULL, NULL, NULL, 100.0, 1.0, 1.0), (18, 100, 'default1', 'default2', NULL, 100.0, 99.0, 100.0, 101.0), (19, 100, 'default1', 'default2', NULL, 100.0, 99.0, 100.0, 1.0), (20, 99, 'default2', 'default2', 'default1', 101.0, 100.0, 1.0, 99.0), (21, 0, NULL, 'default2', 'default2', 100.0, NULL, 0.0, 1.0);
INSERT INTO station_company (station_id, company_id, rank_of_the_year) VALUES (0, 1, 0), (101, 1, NULL), (10, 8, 100), (5, 8, 0), (100, 13, 101), (100, 7, 101), (101, 13, 100), (100, 100, 101), (0, 99, 101), (8, 5, 0), (101, 6, 99), (3, 13, 99), (0, 101, 1), (101, 21, 99), (99, 14, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.station_id AS station_id, LHS.open_year AS open_year, LHS.location AS LOCATION, LHS.manager_name AS manager_name, LHS.vice_manager_name AS vice_manager_name, LHS.representative_name AS representative_name, LHS.company_id AS company_id, LHS.rank_of_the_year AS rank_of_the_year, RHS.rank AS rank, RHS.company AS company, RHS.headquarters AS headquarters, RHS.main_industry AS main_industry, RHS.sales_billion AS sales_billion, RHS.profits_billion AS profits_billion, RHS.assets_billion AS assets_billion, RHS.market_value AS market_value FROM (SELECT LHS.station_id AS station_id, LHS.open_year AS open_year, LHS.location AS LOCATION, LHS.manager_name AS manager_name, LHS.vice_manager_name AS vice_manager_name, LHS.representative_name AS representative_name, RHS.company_id AS company_id, RHS.rank_of_the_year AS rank_of_the_year FROM gas_station AS LHS INNER JOIN station_company AS RHS ON (LHS.station_id = RHS.station_id)) AS LHS INNER JOIN (SELECT * FROM company WHERE (market_value > 100.0)) AS RHS ON (LHS.company_id = RHS.company_id)) ORDER BY LOCATION;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT T3.location FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id JOIN gas_station AS T3 ON T1.station_id = T3.station_id WHERE T2.market_value > 100;

/*
Prediction Result:
('default1',)
(None,)
*/