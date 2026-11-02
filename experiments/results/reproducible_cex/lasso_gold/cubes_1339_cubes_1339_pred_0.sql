-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1007, 1006, '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'Matthew Foster', 'Andrea Reid', 'Danielle Ford');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1005, 1007, '503 Linda Locks
Carlshire, FM 94599', 'Michael Miles', 'Judy Baker', 'Justin Baker');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT station_id, LOCATION, manager_name FROM gas_station ORDER BY station_id;

/*
Gold Result:
(1005, '503 Linda Locks\nCarlshire, FM 94599', 'Michael Miles')
(1007, '310 Kendra Common Apt. 164\nReidstad, GA 49021', 'Matthew Foster')
*/

-- Prediction Query
SELECT station_id, LOCATION, manager_name FROM gas_station ORDER BY open_year, gas_station.station_id NULLS LAST;

/*
Prediction Result:
(1007, '310 Kendra Common Apt. 164\nReidstad, GA 49021', 'Matthew Foster')
(1005, '503 Linda Locks\nCarlshire, FM 94599', 'Michael Miles')
*/