-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'ExxonMobil', 'USA', 'Oil and gas', 433.5, 41.1, 331.1, 407.4);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'JPMorgan Chase', 'USA', 'Banking', 110.8, 19.0, 2265.8, 170.1);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 10, 'Toyota', 'Japan', 'Automotive', 228.5, 3.6, 381.0, 175.4);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (4, 15, 'Sony', 'Japan', 'Technology', 79.2, 1.2, 153.5, 18.2);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (5, 8, 'Total', 'France', 'Oil and gas', 216.2, 15.9, 213.0, 118.0);
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (101, 2005, 'USA', 'John Smith', 'Jane Doe', 'Bob Brown');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (102, 2010, 'France', 'Pierre Dupont', 'Marie Curie', 'Luc Besson');
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (101, 5, 1);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (102, 5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquarters" FROM (SELECT * FROM "company" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "company" WHERE ("main_industry" = 'Banking')) AS RHS WHERE (LHS.headquarters = RHS.headquarters))) ORDER BY headquarters, "headquarters" NULLS LAST;

/*
Gold Result:
('France',)
('Japan',)
('Japan',)
*/

-- Prediction Query
SELECT headquarters FROM company EXCEPT SELECT headquarters FROM company WHERE main_industry = 'Banking';

/*
Prediction Result:
('France',)
('Japan',)
*/