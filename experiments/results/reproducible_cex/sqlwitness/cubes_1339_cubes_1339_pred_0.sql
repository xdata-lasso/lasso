-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gas_station (station_id, open_year, location, manager_name, vice_manager_name, representative_name) VALUES (1, 0, NULL, NULL, NULL, 'default2'), (0, 0, 'default2', 'default1', 'default2', NULL), (2, 1, 'default1', NULL, 'default1', NULL), (3, NULL, 'default2', NULL, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT station_id, LOCATION, manager_name FROM gas_station ORDER BY station_id;

/*
Gold Result:
(0, 'default2', 'default1')
(1, None, None)
(2, 'default1', None)
(3, 'default2', None)
*/

-- Prediction Query
SELECT station_id, LOCATION, manager_name FROM gas_station ORDER BY open_year, gas_station.station_id NULLS LAST;

/*
Prediction Result:
(3, 'default2', None)
(0, 'default2', 'default1')
(1, None, None)
(2, 'default1', None)
*/