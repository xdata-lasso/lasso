-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gas_station (station_id, open_year, location, manager_name, vice_manager_name, representative_name) VALUES (0, 0, 'default1', 'default1', NULL, NULL), (1, 1, NULL, 'default1', 'default2', 'default1'), (2, 1, 'default2', NULL, 'default2', NULL), (3, 1, 'default1', NULL, NULL, 'default2'), (4, NULL, 'default1', NULL, NULL, 'default2'), (5, NULL, NULL, 'default1', 'default1', 'default1'), (6, NULL, NULL, 'default2', 'default2', 'default2'), (7, 1, 'default2', 'default2', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, n AS count___ FROM (SELECT LOCATION, COUNT(*) AS n FROM gas_station GROUP BY LOCATION) ORDER BY LOCATION, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('default1', 3)
('default2', 2)
*/

-- Prediction Query
SELECT LOCATION, COUNT(*) FROM gas_station GROUP BY LOCATION ORDER BY COUNT(*), LOCATION NULLS LAST;

/*
Prediction Result:
('default2', 2)
('default1', 3)
(None, 3)
*/