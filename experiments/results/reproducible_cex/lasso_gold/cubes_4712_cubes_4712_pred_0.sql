-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1001, 'Allison Hill', 1002.5, 1003.5, 1004.5, '819 Johnson Course
East William, AK 74064', 'decide', 1005);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1005, 'Meredith Barnes', 1006.5, 1007.5, 1008.5, '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 'decide', 1009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT station_id, name, annual_entry_exit, annual_interchanges, total_passengers, LOCATION, main_services, number_of_platforms, name_other, annual_entry_exit_other, annual_interchanges_other, total_passengers_other, location_other, number_of_platforms_other, COUNT(*) OVER () AS n FROM (SELECT number_of_platforms AS station_id, name, annual_entry_exit, annual_interchanges, total_passengers, LOCATION, main_services, number_of_platforms, name_other, annual_entry_exit_other, annual_interchanges_other, total_passengers_other, location_other, number_of_platforms_other FROM (SELECT LHS.station_id AS station_id, LHS.name AS name, LHS.annual_entry_exit AS annual_entry_exit, LHS.annual_interchanges AS annual_interchanges, LHS.total_passengers AS total_passengers, LHS.location AS LOCATION, LHS.main_services AS main_services, LHS.number_of_platforms AS number_of_platforms, RHS.name AS name_other, RHS.annual_entry_exit AS annual_entry_exit_other, RHS.annual_interchanges AS annual_interchanges_other, RHS.total_passengers AS total_passengers_other, RHS.location AS location_other, RHS.number_of_platforms AS number_of_platforms_other FROM station AS LHS INNER JOIN station AS RHS ON (LHS.number_of_platforms = RHS.station_id AND LHS.main_services = RHS.main_services)))) ORDER BY LOCATION;

/*
Gold Result:
('819 Johnson Course\nEast William, AK 74064',)
*/

-- Prediction Query
SELECT LOCATION FROM station GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('26542 Susan Junction Apt. 161\nMelanieview, AS 06196',)
*/