-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1003, 1004, '654 Jason Track
Curtisfurt, CT 47553', 'Lindsey Roman', 'Kimberly Dudley', 'Juan Calderon');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1005, NULL, '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'Michael Miles', 'Andrea Reid', 'Danielle Ford');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1007, 1008, '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'Timothy Watts', 'Frederick Tate', 'Rodney Trujillo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION, n AS count___ FROM (SELECT LOCATION, COUNT(*) AS n FROM gas_station GROUP BY LOCATION) ORDER BY LOCATION, count___ NULLS LAST;

/*
Gold Result:
('310 Kendra Common Apt. 164\nReidstad, GA 49021', 2)
('654 Jason Track\nCurtisfurt, CT 47553', 1)
*/

-- Prediction Query
SELECT LOCATION, COUNT(*) FROM gas_station GROUP BY LOCATION ORDER BY COUNT(*), LOCATION NULLS LAST;

/*
Prediction Result:
('654 Jason Track\nCurtisfurt, CT 47553', 1)
('310 Kendra Common Apt. 164\nReidstad, GA 49021', 2)
*/