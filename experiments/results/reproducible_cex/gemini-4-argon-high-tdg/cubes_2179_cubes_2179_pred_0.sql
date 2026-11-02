-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Central', 500.5, 120.0, 620.5, 'Downtown', 'Intercity', 8);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Northgate', 200.0, 50.0, 250.0, 'North', 'Regional', 4);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (5, 'Alpha', '22:00', 'Suburban');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (10, 'Bravo', '14:00', 'Local');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (20, 'Alpha', '18:00', 'Regional');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (30, 'Alpha', '06:00', 'Express');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (20, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (20, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, TIME, service FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Alpha', '22:00', 'Suburban')
('Alpha', '18:00', 'Regional')
('Alpha', '06:00', 'Express')
('Bravo', '14:00', 'Local')
*/

-- Prediction Query
SELECT name, TIME, service FROM train;

/*
Prediction Result:
('Alpha', '22:00', 'Suburban')
('Bravo', '14:00', 'Local')
('Alpha', '18:00', 'Regional')
('Alpha', '06:00', 'Express')
*/