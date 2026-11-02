-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Central Station', 10.5, 2.0, 12.5, 'London', 'Intercity', 8);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'North Station', 5.0, 1.0, 6.0, 'York', 'Regional', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Unused Station', 1.0, 0.2, 1.2, 'Leeds', 'Local', 2);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (40, 'Alpha', '09:00', 'Beta Line');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (10, 'Bravo', '14:00', 'Regional');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (30, 'Alpha', '09:00', 'Beta Line');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (5, 'Charlie', '06:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (20, 'Alpha', '18:00', 'Zeta Line');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, service FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Alpha', 'Zeta Line')
('Alpha', 'Beta Line')
('Alpha', 'Beta Line')
('Bravo', 'Regional')
('Charlie', 'Express')
*/

-- Prediction Query
SELECT name, service FROM train ORDER BY TIME, train.train_id NULLS LAST;

/*
Prediction Result:
('Charlie', 'Express')
('Alpha', 'Beta Line')
('Alpha', 'Beta Line')
('Bravo', 'Regional')
('Alpha', 'Zeta Line')
*/