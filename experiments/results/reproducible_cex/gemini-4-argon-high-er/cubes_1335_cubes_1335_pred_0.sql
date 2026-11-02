-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (1, 2000, 'A', 'M1', 'V1', 'R1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 1990, 'B', 'M2', 'V2', 'R2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM gas_station ORDER BY LOCATION, gas_station.station_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT LOCATION FROM gas_station ORDER BY open_year, gas_station.station_id NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/