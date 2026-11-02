-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gas_station (station_id, open_year, location, manager_name, vice_manager_name, representative_name) VALUES (0, 1, 'default2', 'default1', 'ExxonMobil', 'default2'), (1, NULL, 'ExxonMobil', 'default1', NULL, 'default2'), (2, NULL, NULL, NULL, NULL, 'default1');
INSERT INTO company (company_id, rank, company, headquarters, main_industry, sales_billion, profits_billion, assets_billion, market_value) VALUES (1, NULL, 'ExxonMobil', NULL, NULL, 1.0, NULL, 0.0, NULL), (0, 1, 'default1', 'default1', NULL, 1.0, NULL, 0.0, NULL), (2, 0, 'default1', NULL, NULL, 1.0, 1.0, NULL, 0.0), (3, NULL, NULL, 'ExxonMobil', 'default1', NULL, 0.0, NULL, NULL), (4, 1, 'default1', 'default2', 'default1', 1.0, 0.0, 1.0, 0.0);
INSERT INTO station_company (station_id, company_id, rank_of_the_year) VALUES (2, 3, 1), (1, 1, 0), (2, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "manager_name" FROM (SELECT "LHS"."company_id" AS "company_id", "LHS"."rank" AS "rank", "LHS"."company" AS "company", "LHS"."headquarters" AS "headquarters", "LHS"."main_industry" AS "main_industry", "LHS"."sales_billion" AS "sales_billion", "LHS"."profits_billion" AS "profits_billion", "LHS"."assets_billion" AS "assets_billion", "LHS"."market_value" AS "market_value", "LHS"."station_id" AS "station_id", "LHS"."open_year" AS "open_year", "LHS"."location" AS "location", "LHS"."manager_name" AS "manager_name", "LHS"."vice_manager_name" AS "vice_manager_name", "LHS"."representative_name" AS "representative_name", "LHS"."rank_of_the_year" AS "rank_of_the_year" FROM (SELECT "LHS"."company_id" AS "company_id", "LHS"."rank" AS "rank", "LHS"."company" AS "company", "LHS"."headquarters" AS "headquarters", "LHS"."main_industry" AS "main_industry", "LHS"."sales_billion" AS "sales_billion", "LHS"."profits_billion" AS "profits_billion", "LHS"."assets_billion" AS "assets_billion", "LHS"."market_value" AS "market_value", "LHS"."station_id" AS "station_id", "LHS"."open_year" AS "open_year", "LHS"."location" AS "location", "LHS"."manager_name" AS "manager_name", "LHS"."vice_manager_name" AS "vice_manager_name", "LHS"."representative_name" AS "representative_name", "RHS"."rank_of_the_year" AS "rank_of_the_year" FROM (SELECT "LHS"."company_id" AS "company_id", "LHS"."rank" AS "rank", "LHS"."company" AS "company", "LHS"."headquarters" AS "headquarters", "LHS"."main_industry" AS "main_industry", "LHS"."sales_billion" AS "sales_billion", "LHS"."profits_billion" AS "profits_billion", "LHS"."assets_billion" AS "assets_billion", "LHS"."market_value" AS "market_value", "RHS"."station_id" AS "station_id", "RHS"."open_year" AS "open_year", "RHS"."location" AS "location", "RHS"."manager_name" AS "manager_name", "RHS"."vice_manager_name" AS "vice_manager_name", "RHS"."representative_name" AS "representative_name" FROM "company" AS "LHS" CROSS JOIN "gas_station" AS "RHS") AS "LHS" INNER JOIN "station_company" AS "RHS" ON ("LHS"."company_id" = "RHS"."company_id" AND "LHS"."station_id" = "RHS"."station_id")) AS "LHS" INNER JOIN (SELECT * FROM "company" WHERE ("company" = 'ExxonMobil')) AS RHS ON (LHS.company_id = RHS.company_id AND LHS.rank = RHS.rank AND LHS.company = RHS.company AND LHS.headquarters = RHS.headquarters AND LHS.main_industry = RHS.main_industry AND LHS.sales_billion = RHS.sales_billion AND LHS.profits_billion = RHS.profits_billion AND LHS.assets_billion = RHS.assets_billion AND LHS.market_value = RHS.market_value)) ORDER BY manager_name, "manager_name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.manager_name FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id JOIN gas_station AS T3 ON T1.station_id = T3.station_id WHERE T2.company = 'ExxonMobil';

/*
Prediction Result:
('default1',)
*/