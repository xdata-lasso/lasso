-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (train_id, name, time, service) VALUES (0, 'default1', NULL, NULL);
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (1, NULL, 0.0, 0.0, 0.0, 'default2', 'default1', NULL), (0, 'default1', 0.0, NULL, 2.0, 'default1', 'default1', 0), (2, NULL, NULL, 0.0, NULL, NULL, 'default2', 2);
INSERT INTO train_station (train_id, station_id) VALUES (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM station AS LHS WHERE NOT EXISTS(SELECT 1 FROM train_station AS RHS WHERE (LHS.station_id = RHS.station_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT name FROM station WHERE NOT station_id IN (SELECT station_id FROM train_station);

/*
Prediction Result:
('default1',)
(None,)
*/