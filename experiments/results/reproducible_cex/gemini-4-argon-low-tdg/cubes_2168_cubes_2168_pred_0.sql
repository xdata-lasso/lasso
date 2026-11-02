-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'King''s Cross', 80.5, 10.2, 90.7, 'Zone 1', 'East Coast', 11);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Euston', 45.0, 5.0, 50.0, 'Zone 1', 'West Coast', 18);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Aberdeen', 3.0, 0.5, 3.5, 'Aberdeen', 'ScotRail', 7);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'York', 10.0, 2.0, 12.0, 'Yorkshire', 'CrossCountry', 11);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (101, 'Flying Scotsman', '08:00', 'Express');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM station ORDER BY LOCATION;

/*
Gold Result:
('Aberdeen',)
('Yorkshire',)
('Zone 1',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM station;

/*
Prediction Result:
('Zone 1',)
('Aberdeen',)
('Yorkshire',)
*/