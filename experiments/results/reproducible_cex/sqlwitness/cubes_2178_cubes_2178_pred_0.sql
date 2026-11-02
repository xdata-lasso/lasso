-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (train_id, name, time, service) VALUES (1, 'default1', 'default2', NULL), (0, 'London', 'default1', 'default1'), (2, NULL, NULL, 'default1'), (3, 'default2', NULL, 'default1'), (4, 'default2', 'default2', 'default2'), (5, NULL, 'default2', 'default2'), (6, NULL, 'default1', 'London'), (7, 'default2', NULL, 'London'), (8, 'default1', NULL, 'London');
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (0, NULL, 0.0, 0.0, 0.0, 'default1', 'default1', NULL), (1, 'default2', 0.0, 1.0, 1.0, 'London', 'default1', NULL), (2, 'default2', 0.0, NULL, 1.0, 'London', NULL, 0), (3, NULL, NULL, 0.0, 0.0, NULL, 'default2', NULL), (4, NULL, NULL, 1.0, 0.0, 'default2', NULL, 0), (5, 'London', 1.0, NULL, 1.0, 'default2', 'default1', NULL), (6, 'default1', 0.0, NULL, 1.0, 'default1', 'default1', NULL), (7, 'default1', 0.0, NULL, 0.0, 'default1', 'default1', 0), (8, 'default1', 0.0, 0.0, 1.0, 'London', 'London', 0), (9, NULL, 0.0, 0.0, NULL, 'London', 'default2', 0), (10, 'default2', 0.0, 1.0, 1.0, 'default2', 'London', NULL), (11, 'default2', NULL, NULL, 1.0, 'London', NULL, 0);
INSERT INTO train_station (train_id, station_id) VALUES (5, 2), (0, 9), (0, 7), (7, 10), (2, 3), (5, 9), (3, 2), (8, 11), (1, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name", "time" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" = 'London')) AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name, "time" NULLS LAST;

/*
Gold Result:
(None, 'default2')
(None, 'default2')
('London', 'default1')
('default1', 'default2')
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT T3.name, T3.time FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id WHERE T2.location = 'London' ORDER BY T3.time DESC, T1.train_id NULLS LAST, T1.station_id NULLS LAST, T2.station_id NULLS LAST, T3.train_id NULLS LAST;

/*
Prediction Result:
('default1', 'default2')
(None, 'default2')
(None, 'default2')
('London', 'default1')
('default2', None)
('default1', None)
*/