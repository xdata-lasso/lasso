-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (10, 'Waterloo', 90.5, 10.0, 100.5, 'London', 'National Rail', 24);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (20, 'Paddington', 40.0, 5.0, 45.0, 'London', 'Great Western', 14);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (30, 'Victoria', 70.0, 8.5, 78.5, 'London', 'Southern', 19);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (40, 'Euston', 42.0, 3.0, 45.0, 'London', 'West Coast', 18);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'Express One', '08:00', 'Intercity');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (2, 'Express Two', '09:30', 'Regional');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 10);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 20);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 30);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (2, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name FROM train_station AS LHS INNER JOIN (SELECT name, station_id, COUNT(*) AS n FROM station GROUP BY name, station_id) AS RHS ON (LHS.station_id = RHS.station_id AND LHS.train_id = RHS.n)) ORDER BY name;

/*
Gold Result:
('Victoria',)
('Waterloo',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Victoria',)
*/