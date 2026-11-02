-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting, DISTINCT vs ALL on Open_Year, boundary n_distinct = 1 vs 2, and confusion between COUNT(DISTINCT open_year) and open_year >= 2000.
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (1, 1995, 'LocA', 'Alice', 'V1', 'R1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 1998, 'LocB', 'Alice', 'V2', 'R2');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (3, 2005, 'LocC', 'Bob', 'V3', 'R3');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (4, 2005, 'LocD', 'Charlie', 'V4', 'R4');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (5, 2005, 'LocE', 'Charlie', 'V5', 'R5');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (6, 1990, 'LocF', 'David', 'V6', 'R6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manager_name FROM (SELECT manager_name, COUNT(DISTINCT open_year) AS n_distinct FROM gas_station GROUP BY manager_name) WHERE (n_distinct >= 2000 OR n_distinct <> 1) ORDER BY manager_name;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT manager_name FROM gas_station WHERE open_year > 2000 GROUP BY manager_name ORDER BY COUNT(*) DESC, manager_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Charlie',)
*/