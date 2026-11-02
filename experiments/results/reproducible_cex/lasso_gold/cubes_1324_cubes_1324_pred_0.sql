-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1038, 1039, 'Davis Inc', 'her', 'throw', 1040.5, 1041.5, 1042.5, 1043.5);
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1044, 1045, 'Williams and Sons', 'her', 'machine', 1046.5, 1047.5, 1048.5, 1049.5);
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1050, 1051, 'Mcclure, Ward and Lee', 'production', 'themselves', 1052.5, 1053.5, 1054.5, 1055.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, headquarters FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('Davis Inc', 'her')
('Mcclure, Ward and Lee', 'production')
('Williams and Sons', 'her')
*/

-- Prediction Query
SELECT company, headquarters FROM company ORDER BY market_value DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('Mcclure, Ward and Lee', 'production')
('Williams and Sons', 'her')
('Davis Inc', 'her')
*/