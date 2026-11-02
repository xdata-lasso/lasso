-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1001, 2001, '433 Jill Springs
New Roberttown, CO 29158', 'Michael Miles', 'Andrea Reid', 'Rodney Trujillo');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1002, 2001, '386 Shane Harbors
Port Lindachester, MA 36922', 'Michael Miles', 'Danielle Ford', 'Austin Gentry');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1003, 2001, '16155 Roman Stream Suite 816
New Kellystad, OK 25704', 'Michael Miles', 'Timothy Watts', 'Michelle Lewis');
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (1004, 2001, '341 Michelle Light
Shawnstad, GA 49021', 'Michael Miles', 'Frederick Tate', 'Dr. Marvin Thomas Jr.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manager_name FROM (SELECT manager_name, COUNT(DISTINCT open_year) AS n_distinct FROM gas_station GROUP BY manager_name) WHERE (n_distinct >= 2000 OR n_distinct <> 1) ORDER BY manager_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT manager_name FROM gas_station WHERE open_year > 2000 GROUP BY manager_name ORDER BY COUNT(*) DESC, manager_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Michael Miles',)
*/