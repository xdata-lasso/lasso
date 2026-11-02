-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Paddington', 35.5, 5.2, 40.7, 'London', 'Great Western', 14);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Waverley', 22.1, 3.0, 25.1, 'Edinburgh', 'East Coast', 20);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Piccadilly', 28.4, 4.1, 32.5, 'Manchester', 'West Coast', 14);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'New Street', 31.0, 6.5, 37.5, 'Birmingham', 'CrossCountry', 12);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (10, 'Royal Scot', '08:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (20, 'Flying Scotsman', '09:30', 'InterCity');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (30, 'Midland Pullman', '11:15', 'Regional');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (40, 'Thames Clipper', '14:00', 'Commuter');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (40, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 3);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (20, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."station_id" AS "station_id_other", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" <> 'London')) AS LHS CROSS JOIN (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.time AS TIME, RHS.service AS service FROM train_station AS LHS LEFT JOIN train AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS) WHERE (station_id = station_id_other) ORDER BY name;

/*
Gold Result:
('Flying Scotsman',)
('Royal Scot',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN train AS T2 ON T1.train_id = T2.train_id WHERE NOT T1.station_id IN (SELECT T4.station_id FROM train_station AS T3 JOIN station AS T4 ON T3.station_id = T4.station_id WHERE t4.location = 'London');

/*
Prediction Result:
('Royal Scot',)
('Flying Scotsman',)
*/