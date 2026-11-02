-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (101, 1, 'Apex Energy', 'Houston', 'Oil and Gas', 150.5, 12.3, 200.0, 180.2);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (102, 2, 'Beacon Fuel', 'London', 'Refining', 95.0, 8.1, 120.5, 110.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (103, 3, 'Crest Corp', 'Tokyo', 'Chemicals', 60.2, 4.5, 80.0, 75.4);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (10, 2005, 'Zeta Blvd', 'Alice Green', 'Victor Vance', 'Rachel Ray');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 2018, 'Mu Street', 'Diana Prince', 'Walter White', 'Sam Stone');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (5, 1992, 'Alpha Way', 'Charlie Brown', 'Xavier Woods', 'Tina Turner');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (20, 2001, 'Delta Ave', 'Bob Martin', 'Yvonne Strahovski', 'Uma Thurman');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (5, 101, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (5, 102, 2);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (10, 101, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT station_id, LOCATION, manager_name FROM gas_station ORDER BY station_id;

/*
Gold Result:
(2, 'Mu Street', 'Diana Prince')
(5, 'Alpha Way', 'Charlie Brown')
(10, 'Zeta Blvd', 'Alice Green')
(20, 'Delta Ave', 'Bob Martin')
*/

-- Prediction Query
SELECT station_id, LOCATION, manager_name FROM gas_station ORDER BY open_year, gas_station.station_id NULLS LAST;

/*
Prediction Result:
(5, 'Alpha Way', 'Charlie Brown')
(20, 'Delta Ave', 'Bob Martin')
(10, 'Zeta Blvd', 'Alice Green')
(2, 'Mu Street', 'Diana Prince')
*/