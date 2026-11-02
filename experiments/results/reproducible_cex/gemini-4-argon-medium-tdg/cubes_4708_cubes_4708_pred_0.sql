-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Zulu', 100.0, 10.0, 110.0, 'North', 'Express', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Alpha', 200.0, 20.0, 220.0, 'South', 'Local', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Beta', 300.0, 30.0, 330.0, 'East', 'Express', 3);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Gamma', 400.0, 40.0, 440.0, 'West', 'Local', 1);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'Train1', '08:00', 'Daily');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (2, 'Train2', '09:00', 'Daily');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (3, 'Train3', '10:00', 'Weekend');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 3);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.station_id AS station_id, LHS.maxn AS maxn FROM (SELECT name, station_id, MAX(n) AS maxn FROM (SELECT name, station_id, COUNT(*) AS n FROM station GROUP BY name, station_id) GROUP BY name, station_id) AS LHS INNER JOIN train_station AS RHS ON (LHS.station_id = RHS.station_id AND LHS.maxn = RHS.train_id)) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta',)
*/