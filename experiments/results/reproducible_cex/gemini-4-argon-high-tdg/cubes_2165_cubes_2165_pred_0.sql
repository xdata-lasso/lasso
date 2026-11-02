-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Central', 120.0, 30.0, 200.0, 'Birmingham', 'CrossCountry', 8);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Central', 180.0, 40.0, 300.0, 'Manchester', 'Northern', 10);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Central', 60.0, 15.0, 100.0, 'Cardiff', 'Transport for Wales', 6);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Paddington', 400.0, 100.0, 550.0, 'London', 'Great Western', 14);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (5, 'Victoria', 250.0, 50.0, 450.0, 'Manchester', 'TransPennine', 6);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (6, 'Victoria', 210.0, 90.0, 450.0, 'York', 'LNER', 9);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (7, 'Abbey Wood', 80.0, 10.0, 95.0, 'Bristol', 'Regional', 2);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (101, 'Flying Scotsman', '08:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (102, 'Midland Pullman', '10:30', 'InterCity');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (102, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "total_passengers" FROM "station" WHERE ("location" <> 'London') ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('Abbey Wood', 95.0)
('Central', 200.0)
('Central', 300.0)
('Central', 100.0)
('Victoria', 450.0)
('Victoria', 450.0)
*/

-- Prediction Query
SELECT name, total_passengers FROM station WHERE LOCATION <> 'London';

/*
Prediction Result:
('Central', 200.0)
('Central', 300.0)
('Central', 100.0)
('Victoria', 450.0)
('Victoria', 450.0)
('Abbey Wood', 95.0)
*/