-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (train_id, name, time, service) VALUES (2, 'default1', 'default2', NULL), (0, NULL, 'default2', 'default1'), (1, 'default1', NULL, 'default1'), (3, 'default1', 'default1', 'default1'), (4, 'default1', NULL, NULL), (5, NULL, 'default2', 'default1'), (6, NULL, 'default2', NULL), (7, 'default1', NULL, NULL), (8, NULL, 'default1', 'default1'), (9, 'default2', 'default1', 'default1');
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (3, NULL, NULL, NULL, 2.0, NULL, 'default2', 3), (1, NULL, 3.0, NULL, 3.0, NULL, 'default2', 2), (0, 'default1', 3.0, 2.0, 2.0, 'default1', NULL, NULL), (2, 'default1', NULL, NULL, 1.0, 'default2', 'default2', 1), (4, NULL, 2.0, NULL, 0.0, NULL, 'default2', 3), (5, NULL, 3.0, 0.0, 0.0, 'default2', 'default1', 2), (6, NULL, 3.0, 2.0, 1.0, 'default2', 'default2', 1), (7, NULL, 1.0, 2.0, 3.0, 'default1', 'default2', 2), (8, 'default1', 2.0, 0.0, 0.0, 'default1', 'default1', 1), (9, 'default2', 1.0, 2.0, 3.0, NULL, 'default2', 2);
INSERT INTO train_station (train_id, station_id) VALUES (6, 4), (7, 0), (7, 9), (2, 2), (8, 6), (1, 0), (3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name, total_passengers, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY name, total_passengers) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('default1',)
*/