-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Victoria', 50.5, 10.0, 60.5, 'London', 'National', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Paddington', 40.0, 5.0, 45.0, 'London', 'Express', 6);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Waterloo', 10.0, 2.0, 12.0, 'South', 'Commuter', 8);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Euston', 30.0, 8.0, 38.0, 'North', 'Intercity', 5);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (5, 'Kings Cross', 25.0, 4.0, 29.0, 'East', 'Regional', 2);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'Morning Express', '08:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (3, 'Midday Local', '12:00', 'Commuter');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (4, 'Night Sleeper', '23:00', 'Intercity');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (3, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (4, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM station AS LHS WHERE NOT EXISTS(SELECT 1 FROM train_station AS RHS WHERE (LHS.station_id = RHS.station_id))) ORDER BY name;

/*
Gold Result:
('Euston',)
('Victoria',)
('Waterloo',)
*/

-- Prediction Query
SELECT name FROM station WHERE NOT station_id IN (SELECT station_id FROM train_station);

/*
Prediction Result:
('Victoria',)
('Waterloo',)
('Euston',)
*/