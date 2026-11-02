-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: company --
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483648, -55602865, 'swwqcgsk', 'com_3c5eb6', '9n8c4pgu7v', 86.520366, 65.761562, 779.409124, 640.719621);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483647, 1160656988, 'ia2yp', 'com_2b1a5e', 'Banking', 718.397869, 324.940703, 399.341724, 110.957699);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (2, 700293388, 'wbbp6luhvdlt', 'com_3c5eb6', 'ilbnp', 787.938887, 986.066566, 666.330692, 46.9162);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (3, 907682809, 'siie', 'com_3c5eb6', 'unw6klfa', 587.783596, 558.971814, 406.809007, 419.146648);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483646, 1419861592, '4ecigce376n', 'com_2b1a5e', 'Banking', 805.746877, 322.782838, 779.28645, 566.030342);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483643, 742285925, 'u', 'com_3d261f', 'Banking', 225.300904, 760.580899, 590.639932, 280.204907);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483642, 781505063, 'rofqyp5s5b', 'com_3c5eb6', 'p', 705.580387, 673.065986, 825.231787, 75.551482);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483641, -868774469, 'qa1', 'com_c18c03', 'ryytoo3', 228.583847, 111.926013, 731.301441, 691.846832);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483640, 1178636309, 'ex1', 'com_3c5eb6', 'ji7zwau2', 920.013763, 689.091906, 58.013475, 356.693236);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483639, 364869063, 'q13py', 'com_2b1a5e', 'com_ef2077', 326.912005, 798.947629, 49.538289, 557.003843);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483638, -1362461264, 'l0b4y', NULL, 'p5qi2rkf9v', 263.638479, 778.01524, 629.623334, 860.770887);

INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (-2147483637, 1178000634, 'pz0f8jegd', NULL, 'Banking', 452.27611, 434.003102, 390.34832, 585.585659);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarters" FROM (SELECT * FROM "company" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "company" WHERE ("main_industry" = 'Banking')) AS RHS WHERE (LHS.headquarters = RHS.headquarters))) ORDER BY headquarters, "headquarters" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('com_3c5eb6',)
('com_3c5eb6',)
('com_3c5eb6',)
('com_3c5eb6',)
('com_3c5eb6',)
('com_c18c03',)
*/

-- Prediction Query
SELECT headquarters FROM company EXCEPT SELECT headquarters FROM company WHERE main_industry = 'Banking';

/*
Prediction Result:
('com_3c5eb6',)
('com_c18c03',)
*/