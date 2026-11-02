-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Zulu Station', 100.5, 10.0, 110.5, 'North', 'Express', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Alpha Station', 200.0, 20.0, 220.0, 'South', 'Local', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Alpha Station', 150.0, 15.0, 165.0, 'East', 'Regional', 3);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Beta Station', 300.0, 30.0, 330.0, 'West', 'Express', 5);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (5, 'Gamma Station', 400.0, 40.0, 440.0, 'Central', 'Intercity', 6);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'Train One', '08:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (2, 'Train Two', '09:00', 'Local');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (3, 'Train Three', '10:00', 'Regional');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 4);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 4);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM station AS LHS WHERE NOT EXISTS(SELECT 1 FROM train_station AS RHS WHERE (LHS.station_id = RHS.station_id))) ORDER BY name;

/*
Gold Result:
('Alpha Station',)
('Alpha Station',)
('Zulu Station',)
*/

-- Prediction Query
SELECT name FROM station WHERE NOT station_id IN (SELECT station_id FROM train_station);

/*
Prediction Result:
('Zulu Station',)
('Alpha Station',)
('Alpha Station',)
*/