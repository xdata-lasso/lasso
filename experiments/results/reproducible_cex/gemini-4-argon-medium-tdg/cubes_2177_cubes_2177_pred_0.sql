-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Zulu Station', 100.5, 10.0, 110.5, 'North', 'Express', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Alpha Station', 200.0, 20.0, 220.0, 'South', 'Local', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Beta Station', 150.0, 15.0, 165.0, 'East', 'Regional', 3);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Gamma Station', 300.0, 30.0, 330.0, 'West', 'Intercity', 6);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (10, 'Morning Express', '08:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (20, 'Night Owl', '23:00', 'Local');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 3);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (20, 3);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM station AS LHS WHERE NOT EXISTS(SELECT 1 FROM train_station AS RHS WHERE (LHS.station_id = RHS.station_id))) ORDER BY name;

/*
Gold Result:
('Alpha Station',)
('Zulu Station',)
*/

-- Prediction Query
SELECT name FROM station WHERE NOT station_id IN (SELECT station_id FROM train_station);

/*
Prediction Result:
('Zulu Station',)
('Alpha Station',)
*/