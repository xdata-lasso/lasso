-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (Company_ID, Main_Industry) VALUES (1, 'Technology');
INSERT INTO company (Company_ID, Main_Industry) VALUES (2, 'Energy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT main_industry FROM company ORDER BY main_industry;

/*
Gold Result:
('Energy',)
('Technology',)
*/

-- Prediction Query
SELECT DISTINCT main_industry FROM company;

/*
Prediction Result:
('Technology',)
('Energy',)
*/