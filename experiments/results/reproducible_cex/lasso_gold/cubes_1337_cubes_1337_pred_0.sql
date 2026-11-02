-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1010, 1011, 'Davis Inc', 'her', 'throw', 1012.5, 1013.5, 1014.5, 1015.5);
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1019, NULL, 'Lynch and Sons', 'none', 'shoulder', 1021.5, 1022.5, 1023.5, 1024.5);
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1028, 1029, 'Lynch and Sons', 'water', 'past', 1030.5, 1022.5, 1031.5, 1032.5);
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1016, 1017, '78161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 'Jamie Chavez', 'Carla Kelly', 'Mia Sutton');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1025, 1026, '4835 Jeremy Bypass Suite 641
New Nancy, MD 28370', 'Jennifer Rocha', 'Derek Wright', 'Deborah Richards');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1033, 1034, '87101 Courtney Turnpike
Carlsonfurt, MS 78605', 'Kendra Maddox DVM', 'Nathan Maldonado', 'Debra Davidson');
INSERT INTO "station_company" ("station_id", "company_id", "rank_of_the_year") VALUES (1016, 1010, 1018);
INSERT INTO "station_company" ("station_id", "company_id", "rank_of_the_year") VALUES (1025, 1019, 1027);
INSERT INTO "station_company" ("station_id", "company_id", "rank_of_the_year") VALUES (1033, 1028, 1035);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, n AS count___ FROM (SELECT company, profits_billion, COUNT(*) AS n FROM (SELECT LHS.company_id AS company_id, LHS.rank AS rank, LHS.company AS company, LHS.headquarters AS headquarters, LHS.main_industry AS main_industry, LHS.sales_billion AS sales_billion, LHS.profits_billion AS profits_billion, LHS.assets_billion AS assets_billion, LHS.market_value AS market_value, RHS.station_id AS station_id, RHS.rank_of_the_year AS rank_of_the_year FROM company AS LHS INNER JOIN station_company AS RHS ON (LHS.company_id = RHS.company_id)) GROUP BY company, profits_billion) ORDER BY company, count___ NULLS LAST;

/*
Gold Result:
('Davis Inc', 1)
('Lynch and Sons', 2)
*/

-- Prediction Query
SELECT T2.company, COUNT(*) FROM station_company AS T1 JOIN company AS T2 ON T1.company_id = T2.company_id GROUP BY T1.company_id;

/*
Prediction Result:
('Davis Inc', 1)
('Lynch and Sons', 1)
('Lynch and Sons', 1)
*/