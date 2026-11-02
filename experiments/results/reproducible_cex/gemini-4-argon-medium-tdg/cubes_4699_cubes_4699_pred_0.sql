-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Station_B', 100.5, 10.0, 110.5, 'Loc_1', 'Svc_1', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Station_A', 200.0, 20.0, 220.0, 'Loc_2', 'Svc_2', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Station_Unmatched', 50.0, 5.0, 55.0, 'Loc_3', 'Svc_3', 1);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'Train_Z', '08:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (2, 'Train_Y', '09:00', 'Local');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (3, 'Train_Unmatched', '10:00', 'Freight');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.station_id AS station_id, LHS.name AS name, LHS.annual_entry_exit AS annual_entry_exit, LHS.annual_interchanges AS annual_interchanges, LHS.total_passengers AS total_passengers, LHS.location AS LOCATION, LHS.main_services AS main_services, LHS.number_of_platforms AS number_of_platforms, RHS.train_id AS train_id, RHS.name AS name_other, RHS.time AS TIME, RHS.service AS service FROM station AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Station_A', 'Train_Z')
('Station_B', 'Train_Y')
*/

-- Prediction Query
SELECT T2.name, T3.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id;

/*
Prediction Result:
('Station_B', 'Train_Y')
('Station_A', 'Train_Z')
*/