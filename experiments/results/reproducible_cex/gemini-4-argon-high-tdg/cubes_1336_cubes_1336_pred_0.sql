-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO company (Company_ID, Rank, Company, Headquarters, Main_Industry, Sales_billion, Profits_billion, Assets_billion, Market_Value) VALUES (1, 1, 'PetroCorp', 'Houston', 'Oil and Gas', 120.5, 15.2, 200.0, 180.0);
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (1, 1995, 'Loc_1', 'Zack', 'V_Zack1', 'R_Zack1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (2, 1998, 'Loc_2', 'Zack', 'V_Zack2', 'R_Zack2');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (3, 2001, 'Loc_3', 'Alice', 'V_Alice1', 'R_Alice1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (4, 2002, 'Loc_4', 'Alice', 'V_Alice2', 'R_Alice2');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (5, 2003, 'Loc_5', 'Alice', 'V_Alice3', 'R_Alice3');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (6, 1980, 'Loc_6', 'Bob', 'V_Bob1', 'R_Bob1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (7, 2010, 'Loc_7', 'Bob', 'V_Bob2', 'R_Bob2');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (8, 2005, 'Loc_8', 'Charlie', 'V_Charlie1', 'R_Charlie1');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (9, 2005, 'Loc_9', 'Charlie', 'V_Charlie2', 'R_Charlie2');
INSERT INTO gas_station (Station_ID, Open_Year, Location, Manager_Name, Vice_Manager_Name, Representative_Name) VALUES (10, 1990, 'Loc_10', 'Diana', 'V_Diana1', 'R_Diana1');
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (8, 1, 1);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (9, 1, 2);
INSERT INTO station_company (Station_ID, Company_ID, Rank_of_the_Year) VALUES (10, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manager_name FROM (SELECT manager_name, COUNT(DISTINCT open_year) AS n_distinct FROM gas_station GROUP BY manager_name) WHERE (n_distinct >= 2000 OR n_distinct <> 1) ORDER BY manager_name;

/*
Gold Result:
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT manager_name FROM gas_station WHERE open_year > 2000 GROUP BY manager_name ORDER BY COUNT(*) DESC, manager_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/