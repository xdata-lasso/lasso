-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (train_id, name, time, service) VALUES (0, 'default2', 'default1', 'default1'), (2, 'default1', NULL, 'default2'), (1, 'default1', 'default2', 'default2'), (3, NULL, 'default1', 'default2');
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (2, 'default2', NULL, 1.0, 1.0, 'default1', 'default1', 2), (0, NULL, 0.0, 1.0, 2.0, 'default2', 'default2', 1), (1, 'default1', 1.0, 1.0, 1.0, 'default1', 'default2', 0), (3, NULL, NULL, 2.0, NULL, NULL, 'default1', NULL), (4, NULL, 1.0, 2.0, 2.0, 'default1', NULL, 2), (5, 'default2', NULL, 2.0, 0.0, NULL, 'default1', 1), (6, 'default1', 2.0, 0.0, 1.0, 'default2', 'default2', 0), (7, 'default2', 0.0, 2.0, 2.0, NULL, 'default1', NULL), (8, NULL, 2.0, 2.0, 1.0, 'default2', NULL, 1);
INSERT INTO train_station (train_id, station_id) VALUES (3, 8), (2, 3), (0, 4), (3, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name FROM train_station AS LHS INNER JOIN (SELECT name, station_id, COUNT(*) AS n FROM station GROUP BY name, station_id) AS RHS ON (LHS.station_id = RHS.station_id AND LHS.train_id = RHS.n)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/