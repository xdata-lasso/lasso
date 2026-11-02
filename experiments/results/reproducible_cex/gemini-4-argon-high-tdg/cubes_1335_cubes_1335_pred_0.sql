-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 1, 'bp', 'London', 'Oil and gas', 300.5, 25.0, 280.0, 210.0);
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (2, 2, 'Shell', 'The Hague', 'Energy', 350.0, 30.2, 320.0, 240.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (1, 2005, 'Westminster', 'Alice Smith', 'Bob Jones', 'Charlie Brown');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 1998, 'Herne Hill', 'David Clark', 'Eva Green', 'Frank White');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (3, 2012, 'Brixton', 'Grace Hall', 'Henry Adams', 'Ivy Baker');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (4, 2001, 'Herne Hill', 'Jack King', 'Karen Lee', 'Leo Scott');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (1, 1, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (1, 2, 2);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (2, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM gas_station ORDER BY LOCATION, gas_station.station_id NULLS LAST;

/*
Gold Result:
('Brixton',)
('Herne Hill',)
('Herne Hill',)
('Westminster',)
*/

-- Prediction Query
SELECT LOCATION FROM gas_station ORDER BY open_year, gas_station.station_id NULLS LAST;

/*
Prediction Result:
('Herne Hill',)
('Herne Hill',)
('Westminster',)
('Brixton',)
*/