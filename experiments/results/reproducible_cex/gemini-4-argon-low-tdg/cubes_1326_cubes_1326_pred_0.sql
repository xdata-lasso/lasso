-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join logic, duplicate preservation (SELECT vs SELECT DISTINCT / EXCEPT), and simple WHERE != 'Banking' mutations.
-- London has both Tech and Banking (should be excluded entirely).
-- Paris has two non-Banking companies (should return 'Paris' twice).
-- Tokyo has only Banking (should be excluded).
-- Berlin has one non-Banking company (should return 'Berlin' once).
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'Alpha Tech', 'London', 'Tech', 100.0, 10.0, 200.0, 300.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'Beta Bank', 'London', 'Banking', 150.0, 20.0, 500.0, 250.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 3, 'Gamma Retail', 'Paris', 'Retail', 80.0, 5.0, 90.0, 100.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 4, 'Delta Oil', 'Paris', 'Oil', 200.0, 15.0, 400.0, 350.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 5, 'Epsilon Bank', 'Tokyo', 'Banking', 120.0, 12.0, 600.0, 180.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (6, 6, 'Zeta Auto', 'Berlin', 'Auto', 90.0, 8.0, 150.0, 110.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarters" FROM (SELECT * FROM "company" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "company" WHERE ("main_industry" = 'Banking')) AS RHS WHERE (LHS.headquarters = RHS.headquarters))) ORDER BY headquarters, "headquarters" NULLS LAST;

/*
Gold Result:
('Berlin',)
('Paris',)
('Paris',)
*/

-- Prediction Query
SELECT headquarters FROM company EXCEPT SELECT headquarters FROM company WHERE main_industry = 'Banking';

/*
Prediction Result:
('Berlin',)
('Paris',)
*/