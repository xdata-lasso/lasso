-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Station_Alpha', 100.5, 20.0, 120.5, 'Loc_1', 'Commuter', 2);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Station_Beta', 200.0, 50.0, 250.0, 'Loc_2', 'Express', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'Station_Orphan', 50.0, 0.0, 50.0, 'Loc_3', 'Regional', 1);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (10, 'Train_Zeta', '08:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (20, 'Train_Eta', '09:30', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (30, 'Train_Orphan', '12:00', 'Freight');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.station_id AS station_id, LHS.name AS name, LHS.annual_entry_exit AS annual_entry_exit, LHS.annual_interchanges AS annual_interchanges, LHS.total_passengers AS total_passengers, LHS.location AS LOCATION, LHS.main_services AS main_services, LHS.number_of_platforms AS number_of_platforms, RHS.train_id AS train_id, RHS.name AS name_other, RHS.time AS TIME, RHS.service AS service FROM station AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Station_Alpha', 'Train_Eta')
('Station_Beta', 'Train_Zeta')
*/

-- Prediction Query
SELECT T2.name, T3.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id;

/*
Prediction Result:
('Station_Beta', 'Train_Zeta')
('Station_Alpha', 'Train_Eta')
*/