-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: company --
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1, -55602865, 'swwqcgsk', 'com_2b8057', 'Banking', 572.766956, 206.939346, 604.777832, 874.871895);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (3, -106629402, 'u7', 'com_2b8057', 'Banking', 328.996339, 906.21648, 483.665643, 818.685402);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (2, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'com_93969d', 86.520366, 65.761562, 779.409124, 640.719621);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (4, 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 'Oil and gas', 737.440743, 334.878198, 55.194297, 303.05704);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (5, -1610064545, 'n', 'rmdp', NULL, 227.766936, 971.82669, 133.007885, 75.403642);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (6, -1209887326, 'klfa9000t', 'c4ecigce', NULL, 467.07027, 875.837169, 893.977471, 502.947917);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (7, -1585009206, '52zb', 'uo4nrqrofqy', NULL, 242.260296, 938.694822, 499.570479, 710.141592);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (8, 2107872094, '02eutliqa11r', 'ytoo3o9', NULL, 111.926013, 731.301441, 691.846832, 907.988865);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (9, 1178636309, 'ex1', 'ji7zwau2', NULL, 920.013763, 689.091906, 58.013475, 356.693236);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarters" FROM "company" WHERE ("main_industry" = 'Banking' AND "main_industry" <> 'Oil and gas') ORDER BY headquarters, company.company_id NULLS LAST;

/*
Gold Result:
('com_2b8057',)
('com_2b8057',)
*/

-- Prediction Query
SELECT headquarters FROM company WHERE main_industry = 'Banking' INTERSECT SELECT headquarters FROM company WHERE main_industry = 'Oil and gas';

/*
Prediction Result:
*/