-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Sales_billion") VALUES (1, 1, 'A', 10.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Sales_billion") VALUES (2, 2, 'B', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, rank FROM company ORDER BY company, company.company_id NULLS LAST;

/*
Gold Result:
('A', 1)
('B', 2)
*/

-- Prediction Query
SELECT company, rank FROM company ORDER BY Sales_billion DESC, company.company_id NULLS LAST;

/*
Prediction Result:
('B', 2)
('A', 1)
*/