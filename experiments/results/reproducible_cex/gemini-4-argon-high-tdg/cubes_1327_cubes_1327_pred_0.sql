-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'Zeta Corp', 'Germany', 'Automotive', 150.5, 12.3, 300.0, 200.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 3, 'Alpha Inc', 'Vietnam', 'Technology', 80.0, 15.0, 120.0, 250.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (3, 2, 'Beta LLC', 'USA', 'Retail', 500.0, 20.0, 400.0, 600.0);
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (101, 2005, 'Berlin', 'Hans', 'Fritz', 'Karl');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (102, 2010, 'Munich', 'Anna', 'Clara', 'Eva');
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (101, 1, 1);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (102, 1, 2);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (101, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "company", "main_industry" FROM "company" WHERE ("headquarters" <> 'USA') ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('Alpha Inc', 'Technology')
('Zeta Corp', 'Automotive')
*/

-- Prediction Query
SELECT company, main_industry FROM company WHERE headquarters <> 'USA';

/*
Prediction Result:
('Zeta Corp', 'Automotive')
('Alpha Inc', 'Technology')
*/