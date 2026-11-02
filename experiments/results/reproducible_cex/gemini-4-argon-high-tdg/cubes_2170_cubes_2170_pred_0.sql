-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (30, 'Echo', 150.5, 20.0, 170.5, 'Zone A', 'Commuter', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (10, 'Bravo', 300.0, 50.0, 350.0, 'Zone Z', 'Intercity', 6);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (20, 'Bravo', 120.0, 10.0, 130.0, 'Zone A', 'Regional', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (40, 'Alpha', 500.0, 100.0, 600.0, 'Zone M', 'Express', 8);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (50, 'Alpha', 250.0, 30.0, 280.0, 'Zone M', 'Local', 3);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (101, 'Morning Flyer', '08:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (102, 'Night Owl', '23:30', 'Local');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 10);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (102, 10);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM station ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('Alpha', 'Zone M')
('Alpha', 'Zone M')
('Bravo', 'Zone Z')
('Bravo', 'Zone A')
('Echo', 'Zone A')
*/

-- Prediction Query
SELECT name, LOCATION FROM station ORDER BY Annual_entry_exit, Annual_interchanges, station.station_id NULLS LAST;

/*
Prediction Result:
('Bravo', 'Zone A')
('Echo', 'Zone A')
('Alpha', 'Zone M')
('Bravo', 'Zone Z')
('Alpha', 'Zone M')
*/