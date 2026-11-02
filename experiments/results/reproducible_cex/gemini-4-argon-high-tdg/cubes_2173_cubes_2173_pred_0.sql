-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Zeta', 500.5, 100.0, 600.5, 'North', 'Express', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Alpha', 200.0, 50.0, 250.0, 'South', 'Local', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Alpha', 300.0, 75.0, 375.0, 'South', 'Local', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Beta', 400.0, 80.0, 480.0, 'West', 'Regional', 6);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (5, 'Beta', 150.0, 20.0, 170.0, 'East', 'Commuter', 1);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (101, 'Flying Scotsman', '08:00', 'Intercity');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (102, ' Highland Chieftain', '12:30', 'Express');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (102, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, number_of_platforms FROM station ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('Alpha', 'South', 2)
('Alpha', 'South', 2)
('Beta', 'West', 6)
('Beta', 'East', 1)
('Zeta', 'North', 4)
*/

-- Prediction Query
SELECT name, LOCATION, number_of_platforms FROM station;

/*
Prediction Result:
('Zeta', 'North', 4)
('Alpha', 'South', 2)
('Alpha', 'South', 2)
('Beta', 'West', 6)
('Beta', 'East', 1)
*/