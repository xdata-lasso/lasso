-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (train_id, name, time, service) VALUES (2, 'default1', 'default1', 'default1'), (1, 'default2', 'default1', 'default2'), (0, NULL, 'default2', 'default2'), (3, NULL, NULL, NULL), (4, NULL, 'default2', 'default2'), (5, NULL, NULL, 'default1'), (6, 'default2', 'default1', NULL), (7, 'default2', NULL, 'default1'), (8, 'default2', 'default1', NULL), (9, 'default2', 'default1', 'default1'), (10, 'default2', NULL, 'default1'), (11, NULL, 'default2', 'default2'), (12, 'default2', 'default1', 'default1'), (13, NULL, NULL, 'default2'), (14, NULL, 'default1', NULL), (15, 'default2', 'default1', 'default2');
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (1, 'default1', NULL, 0.0, 2.0, 'default1', 'default2', 0), (2, NULL, 2.0, 1.0, 2.0, 'default2', 'default1', NULL), (0, NULL, 2.0, 1.0, 0.0, NULL, NULL, 2), (3, 'default1', 2.0, NULL, 1.0, 'default2', NULL, 1), (4, 'default1', 0.0, 0.0, NULL, 'default1', NULL, 0), (5, 'default1', 2.0, 0.0, 1.0, 'default1', 'default1', 1), (6, 'default2', NULL, 0.0, NULL, 'default1', 'default2', 0), (7, 'default1', NULL, 0.0, 2.0, NULL, 'default1', NULL), (8, 'default1', NULL, NULL, 1.0, 'default2', 'default1', NULL), (9, NULL, 2.0, 0.0, 1.0, 'default1', 'default1', 0), (10, 'default1', 1.0, 2.0, 0.0, NULL, NULL, NULL), (11, 'default2', 1.0, NULL, 1.0, 'default2', 'default2', 2), (12, 'default2', 0.0, 2.0, 0.0, NULL, 'default1', 2), (13, NULL, NULL, 0.0, NULL, NULL, 'default1', 1), (14, 'default1', 0.0, NULL, 1.0, 'default2', 'default1', 2);
INSERT INTO train_station (train_id, station_id) VALUES (6, 13), (6, 1), (4, 0), (15, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.station_id AS station_id, LHS.maxn AS maxn FROM (SELECT name, station_id, MAX(n) AS maxn FROM (SELECT name, station_id, COUNT(*) AS n FROM station GROUP BY name, station_id) GROUP BY name, station_id) AS LHS INNER JOIN train_station AS RHS ON (LHS.station_id = RHS.station_id AND LHS.maxn = RHS.train_id)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/