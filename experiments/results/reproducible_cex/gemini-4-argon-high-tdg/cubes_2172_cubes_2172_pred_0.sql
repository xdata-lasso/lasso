-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Zebra', 0.5, 0.5, 1.0, 'LocZ', 'Regional', 1);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Mango', 0.2, 0.3, 0.5, 'LocM', 'Local', 1);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Apple', 300.0, 200.0, 500.0, 'LocA', 'Express', 10);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Banana', 150.0, 150.0, 300.0, 'LocB', 'Intercity', 8);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (10, 'Train_Alpha', '08:00', 'Daily');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (20, 'Train_Beta', '09:00', 'Daily');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (30, 'Train_Gamma', '10:00', 'Weekend');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (20, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (30, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (20, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (10, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name, total_passengers, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY name, total_passengers) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Mango',)
('Zebra',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zebra',)
('Mango',)
*/