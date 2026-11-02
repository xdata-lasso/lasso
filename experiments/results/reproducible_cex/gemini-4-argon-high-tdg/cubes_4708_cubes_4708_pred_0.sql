-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (10, 'Zeta', 10.5, 2.0, 12.5, 'North', 'Express', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (20, 'Alpha', 20.0, 5.0, 25.0, 'South', 'Local', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (30, 'Beta', 15.0, 3.0, 18.0, 'East', 'Regional', 3);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (40, 'Gamma', 8.0, 1.0, 9.0, 'West', 'Commuter', 5);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'Train_One', '08:00', 'Express');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (2, 'Train_Two', '09:00', 'Local');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (3, 'Train_Three', '10:00', 'Regional');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 10);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 20);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.station_id AS station_id, LHS.maxn AS maxn FROM (SELECT name, station_id, MAX(n) AS maxn FROM (SELECT name, station_id, COUNT(*) AS n FROM station GROUP BY name, station_id) GROUP BY name, station_id) AS LHS INNER JOIN train_station AS RHS ON (LHS.station_id = RHS.station_id AND LHS.maxn = RHS.train_id)) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/