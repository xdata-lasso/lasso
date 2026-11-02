-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1164, 1165, 'Ruiz Ltd', 'notice', 'area', 1166.5, 1167.5, 1168.5, 101.0);
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1172, 1173, 'Wilson, Weiss and Oconnell', 'box', 'particular', 1174.5, 1175.5, 1176.5, 101.0);
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1169, 1170, 'Unit 5310 Box 0330
DPO AP 20474', 'Jacob Hunter', 'Julie Scott', 'Larry Stuart');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1177, 1171, '2849 Marshall Views
Marcusbury, MP 11860', 'John Wilson', 'Samuel Short', 'Tyler Reid');
INSERT INTO "station_company" ("station_id", "company_id", "rank_of_the_year") VALUES (1169, 1164, 1171);
INSERT INTO "station_company" ("station_id", "company_id", "rank_of_the_year") VALUES (1177, 1172, 1179);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.station_id AS station_id, LHS.open_year AS open_year, LHS.location AS LOCATION, LHS.manager_name AS manager_name, LHS.vice_manager_name AS vice_manager_name, LHS.representative_name AS representative_name, LHS.company_id AS company_id, LHS.rank_of_the_year AS rank_of_the_year, RHS.rank AS rank, RHS.company AS company, RHS.headquarters AS headquarters, RHS.main_industry AS main_industry, RHS.sales_billion AS sales_billion, RHS.profits_billion AS profits_billion, RHS.assets_billion AS assets_billion, RHS.market_value AS market_value FROM (SELECT LHS.station_id AS station_id, LHS.open_year AS open_year, LHS.location AS LOCATION, LHS.manager_name AS manager_name, LHS.vice_manager_name AS vice_manager_name, LHS.representative_name AS representative_name, RHS.company_id AS company_id, RHS.rank_of_the_year AS rank_of_the_year FROM gas_station AS LHS INNER JOIN station_company AS RHS ON (LHS.station_id = RHS.station_id)) AS LHS INNER JOIN (SELECT * FROM company WHERE (market_value > 100.0)) AS RHS ON (LHS.company_id = RHS.company_id)) ORDER BY LOCATION;

/*
Gold Result:
('2849 Marshall Views\nMarcusbury, MP 11860',)
('Unit 5310 Box 0330\nDPO AP 20474',)
*/

-- Prediction Query
SELECT T3.location FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id JOIN gas_station AS T3 ON T1.station_id = T3.station_id WHERE T2.market_value > 100;

/*
Prediction Result:
('Unit 5310 Box 0330\nDPO AP 20474',)
('2849 Marshall Views\nMarcusbury, MP 11860',)
*/