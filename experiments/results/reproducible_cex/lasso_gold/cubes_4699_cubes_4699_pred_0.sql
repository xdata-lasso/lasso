-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1053, 'Edward Novak', 1054.5, 1055.5, 1056.5, '5133 Amanda Dam
Whitemouth, IA 10381', 'level', 1057);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1059, 'Amy Valdez', 1055.5, 1056.5, 1057.5, '7736 Franklin Alley
Bakermouth, LA 55945', 'same', 1058);
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1058, 'Kimberly Adkins', 'reach', 'now');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1064, 'Savannah Garcia', 'serious', 'message');
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1058, 1053);
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1064, 1059);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.station_id AS station_id, LHS.name AS name, LHS.annual_entry_exit AS annual_entry_exit, LHS.annual_interchanges AS annual_interchanges, LHS.total_passengers AS total_passengers, LHS.location AS LOCATION, LHS.main_services AS main_services, LHS.number_of_platforms AS number_of_platforms, RHS.train_id AS train_id, RHS.name AS name_other, RHS.time AS TIME, RHS.service AS service FROM station AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Amy Valdez', 'Savannah Garcia')
('Edward Novak', 'Kimberly Adkins')
*/

-- Prediction Query
SELECT T2.name, T3.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id;

/*
Prediction Result:
('Edward Novak', 'Kimberly Adkins')
('Amy Valdez', 'Savannah Garcia')
*/