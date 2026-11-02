-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out-of-order insertion, negative, zero, positive Station_IDs), distinct values across all columns (catches wrong column projections like Vice_Manager_Name or Representative_Name), and unreferenced gas stations (catches unnecessary INNER JOIN with station_company).
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'Alpha Corp', 'NY', 'Oil', 100.5, 10.2, 200.0, 150.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'Beta Inc', 'LA', 'Gas', 80.0, 8.0, 160.0, 120.0);
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (10, 2005, 'Downtown', 'Alice', 'Bob', 'Charlie');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (2, 2018, 'Uptown', 'David', 'Eve', 'Frank');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (-5, 1995, 'Suburb', 'Grace', 'Heidi', 'Ivan');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (0, 2020, 'Midtown', 'Judy', 'Mallory', 'Niaj');
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (10, 1, 1);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (10, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT station_id, LOCATION, manager_name FROM gas_station ORDER BY station_id;

/*
Gold Result:
(-5, 'Suburb', 'Grace')
(0, 'Midtown', 'Judy')
(2, 'Uptown', 'David')
(10, 'Downtown', 'Alice')
*/

-- Prediction Query
SELECT station_id, LOCATION, manager_name FROM gas_station ORDER BY open_year, gas_station.station_id NULLS LAST;

/*
Prediction Result:
(-5, 'Suburb', 'Grace')
(10, 'Downtown', 'Alice')
(2, 'Uptown', 'David')
(0, 'Midtown', 'Judy')
*/