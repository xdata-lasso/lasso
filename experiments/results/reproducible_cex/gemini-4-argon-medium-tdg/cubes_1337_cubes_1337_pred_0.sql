-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. INNER JOIN vs LEFT JOIN (Company 4 has no station_company records)
-- 2. GROUP BY company, profits_billion vs GROUP BY company (Company 'Alpha' has two IDs with different profits_billion; also tests ORDER BY count___ tie-breaking for same company name with counts 2 and 1)
-- 3. GROUP BY company, profits_billion vs GROUP BY company_id (Company 'Beta' has two IDs with the SAME profits_billion, so they should merge into a single group of count 2)
-- 4. Unnecessary JOIN with gas_station (Station 1 is not used)
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'Alpha', 'NY', 'Oil', 100.0, 10.0, 200.0, 300.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'Alpha', 'CA', 'Gas', 150.0, 20.0, 250.0, 350.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 3, 'Beta', 'TX', 'Oil', 80.0, 10.0, 100.0, 150.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 4, 'Gamma', 'FL', 'Energy', 50.0, 5.0, 80.0, 90.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 5, 'Beta', 'WA', 'Energy', 90.0, 10.0, 110.0, 160.0);
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (1, 1995, 'Loc0', 'M0', 'V0', 'R0');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (10, 2000, 'Loc1', 'M1', 'V1', 'R1');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (20, 2005, 'Loc2', 'M2', 'V2', 'R2');
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (10, 1, 1);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (20, 1, 2);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (10, 2, 3);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (10, 3, 4);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (20, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, n AS count___ FROM (SELECT company, profits_billion, COUNT(*) AS n FROM (SELECT LHS.company_id AS company_id, LHS.rank AS rank, LHS.company AS company, LHS.headquarters AS headquarters, LHS.main_industry AS main_industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value AS market_value, RHS.station_id AS station_id, RHS.rank_of_the_year AS rank_of_the_year FROM company AS LHS INNER JOIN station_company AS RHS ON (LHS.company_id = RHS.company_id)) GROUP BY company, profits_billion) ORDER BY company, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 1)
('Alpha', 2)
('Beta', 2)
*/

-- Prediction Query
SELECT T2.company, COUNT(*) FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id GROUP BY T1.company_id;

/*
Prediction Result:
('Alpha', 2)
('Alpha', 1)
('Beta', 1)
('Beta', 1)
*/