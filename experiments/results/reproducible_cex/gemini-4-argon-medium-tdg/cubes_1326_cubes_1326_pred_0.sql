-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic relational anti-join (HQ with Banking + Tech vs HQ with only Tech), duplicates (SELECT vs SELECT DISTINCT / EXCEPT), and ordering.
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'BankCorp', 'New York', 'Banking', 100.0, 10.0, 500.0, 200.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'TechNY', 'New York', 'Technology', 80.0, 15.0, 200.0, 300.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 3, 'RetailLondon1', 'London', 'Retail', 50.0, 5.0, 100.0, 90.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 4, 'TechLondon2', 'London', 'Technology', 60.0, 8.0, 120.0, 110.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 5, 'AutoBerlin', 'Berlin', 'Automotive', 90.0, 9.0, 250.0, 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarters" FROM (SELECT * FROM "company" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "company" WHERE ("main_industry" = 'Banking')) AS RHS WHERE (LHS.headquarters = RHS.headquarters))) ORDER BY headquarters, "headquarters" NULLS LAST;

/*
Gold Result:
('Berlin',)
('London',)
('London',)
*/

-- Prediction Query
SELECT headquarters FROM company EXCEPT SELECT headquarters FROM company WHERE main_industry = 'Banking';

/*
Prediction Result:
('Berlin',)
('London',)
*/