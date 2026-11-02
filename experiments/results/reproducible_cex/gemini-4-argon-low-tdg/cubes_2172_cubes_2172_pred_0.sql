-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic count boundary conditions (n=0, n=1, n=2, n=3) and ORDER BY name (inserted out of alphabetical order).
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Zeta', 10.0, 2.0, 12.0, 'LocA', 'SvcA', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Alpha', 20.0, 5.0, 25.0, 'LocB', 'SvcB', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Beta', 15.0, 3.0, 18.0, 'LocC', 'SvcC', 3);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Gamma', 5.0, 1.0, 6.0, 'LocD', 'SvcD', 1);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (101, 'Express 1', '08:00', 'Fast');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (102, 'Express 2', '09:00', 'Fast');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (103, 'Local 1', '10:00', 'Slow');
-- Zeta: n = 2 (Boundary: included)
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (102, 1);
-- Alpha: n = 3 (Included)
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (102, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (103, 2);
-- Beta: n = 1 (Boundary: excluded)
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 3);
-- Gamma: n = 0 (Excluded; also tests INNER JOIN vs RIGHT/FULL OUTER JOIN);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name, total_passengers, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY name, total_passengers) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/