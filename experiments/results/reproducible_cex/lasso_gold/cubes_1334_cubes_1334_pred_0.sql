-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1040, 1041, 'Zuniga, Wong and Lynch', 'fall', 'Congress', 1042.5, 1043.5, 1044.5, 1045.5);
INSERT INTO "company" ("company_id", "rank", "company", "headquarters", "main_industry", "sales_billion", "profits_billion", "assets_billion", "market_value") VALUES (1046, 1042, 'Delacruz Group', 'religious', 'long', 1043.5, 1044.5, 1045.5, 1046.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, main_industry FROM (SELECT * FROM company AS LHS WHERE NOT EXISTS(SELECT 1 FROM station_company AS RHS WHERE (LHS.company_id = RHS.company_id))) ORDER BY company, main_industry NULLS LAST;

/*
Gold Result:
('Delacruz Group', 'long')
('Zuniga, Wong and Lynch', 'Congress')
*/

-- Prediction Query
SELECT company, main_industry FROM company WHERE NOT company_id IN (SELECT company_id FROM station_company);

/*
Prediction Result:
('Zuniga, Wong and Lynch', 'Congress')
('Delacruz Group', 'long')
*/