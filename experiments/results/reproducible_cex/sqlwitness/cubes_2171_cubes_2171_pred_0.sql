-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (train_id, name, time, service) VALUES (0, 'London', NULL, NULL), (1, 'London', 'London', 'default2'), (2, 'London', 'default2', 'default2'), (3, NULL, 'default1', 'default2'), (4, 'London', 'default2', 'London'), (5, 'default1', NULL, NULL), (6, 'London', 'London', NULL), (7, 'default2', 'default2', 'London'), (8, 'London', 'London', NULL), (9, 'London', NULL, 'default1'), (10, 'London', NULL, 'default1');
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (0, NULL, 1.0, 0.0, 1.0, 'London', 'London', NULL), (1, 'default2', 1.0, 1.0, 1.0, 'London', 'default2', NULL), (2, 'default1', 1.0, 0.0, 0.0, 'default1', 'default1', NULL), (3, 'default1', 0.0, 0.0, 1.0, 'London', NULL, 1), (4, 'default1', NULL, 0.0, 0.0, 'default2', 'default2', 0), (5, 'default2', 1.0, 0.0, NULL, 'London', NULL, NULL), (6, NULL, NULL, 0.0, 1.0, NULL, 'default1', 1), (7, 'default2', 0.0, 1.0, 0.0, NULL, 'London', 0);
INSERT INTO train_station (train_id, station_id) VALUES (10, 4), (8, 3), (5, 7), (9, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."station_id" AS "station_id_other", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" <> 'London')) AS LHS CROSS JOIN (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.time AS TIME, RHS.service AS service FROM train_station AS LHS LEFT JOIN train AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS) WHERE (station_id = station_id_other) ORDER BY name;

/*
Gold Result:
('London',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN train AS T2 ON T1.train_id = T2.train_id WHERE NOT T1.station_id IN (SELECT T4.station_id FROM train_station AS T3 JOIN station AS T4 ON T3.station_id = T4.station_id WHERE t4.location = 'London');

/*
Prediction Result:
('London',)
('default1',)
*/