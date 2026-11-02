-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard GROUP BY, ordering by Location (inverse to count and insertion order), and detects incorrect INNER JOINs with station_company (both 0-to-1 and 1-to-many relationships).
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (1, 1, 'Alpha Corp', 'New York', 'Oil', 100.0, 10.0, 200.0, 150.0);
INSERT INTO "company" ("Company_ID", "Rank", "Company", "Headquarters", "Main_Industry", "Sales_billion", "Profits_billion", "Assets_billion", "Market_Value") VALUES (2, 2, 'Beta Inc', 'London', 'Gas', 80.0, 8.0, 160.0, 120.0);
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (1, 2000, 'Chicago', 'Alice', 'Bob', 'Charlie');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (2, 2005, 'Chicago', 'Alice', 'David', 'Eve');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (3, 2010, 'Boston', 'Frank', 'Grace', 'Heidi');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (4, 2012, 'Boston', 'Ivan', 'Judy', 'Karl');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (5, 2015, 'Boston', 'Liam', 'Mallory', 'Niaj');
INSERT INTO "gas_station" ("Station_ID", "Open_Year", "Location", "Manager_Name", "Vice_Manager_Name", "Representative_Name") VALUES (6, 2018, 'Austin', 'Olivia', 'Peggy', 'Quentin');
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (1, 1, 1);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (1, 2, 2);
INSERT INTO "station_company" ("Station_ID", "Company_ID", "Rank_of_the_Year") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, n AS count___ FROM (SELECT LOCATION, COUNT(*) AS n FROM gas_station GROUP BY LOCATION) ORDER BY LOCATION, count___ NULLS LAST;

/*
Gold Result:
('Austin', 1)
('Boston', 3)
('Chicago', 2)
*/

-- Prediction Query
SELECT LOCATION, COUNT(*) FROM gas_station GROUP BY LOCATION ORDER BY COUNT(*), LOCATION NULLS LAST;

/*
Prediction Result:
('Austin', 1)
('Chicago', 2)
('Boston', 3)
*/