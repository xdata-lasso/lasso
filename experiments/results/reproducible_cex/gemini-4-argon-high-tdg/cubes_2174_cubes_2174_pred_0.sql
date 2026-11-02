-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (10, 'Zeta', 100.5, 10.0, 110.5, 'LocA', 'Commuter', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (20, 'Alpha', 500.0, 50.0, 550.0, 'LocZ', 'Express', 8);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (30, 'Beta', 250.0, 25.0, 275.0, 'LocM', 'Regional', 6);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (40, 'Omega', 50.0, 5.0, 55.0, 'LocB', 'Local', 2);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'Train_One', '08:00', 'Daily');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (2, 'Train_Two', '09:30', 'Daily');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (10, 'Train_Ten', '11:00', 'Weekend');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (40, 'Train_Forty', '14:00', 'Night');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 10);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 20);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 20);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 20);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 30);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LOCATION, name, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY LOCATION, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 3)
('Beta', 2)
('Zeta', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id;

/*
Prediction Result:
('Zeta', 1)
('Alpha', 3)
('Beta', 2)
*/