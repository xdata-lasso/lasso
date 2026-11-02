-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (location <> 'London'), DISTINCT vs ALL (duplicate train names across different stations), and ORDER BY direction/column (station.Name vs train.Name).
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Zeta Station', 10.5, 2.0, 12.5, 'Manchester', 'Intercity', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Alpha Station', 20.0, 5.0, 25.0, 'Birmingham', 'Regional', 6);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'Beta Station', 50.0, 10.0, 60.0, 'London', 'Commuter', 10);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (101, 'Beta Express', '08:00', 'Fast');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (102, 'Alpha Flyer', '09:00', 'Slow');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (103, 'Gamma Local', '10:00', 'Local');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (101, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (103, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."station_id" AS "station_id_other", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" <> 'London')) AS LHS CROSS JOIN (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.time AS TIME, RHS.service AS service FROM train_station AS LHS LEFT JOIN train AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS) WHERE (station_id = station_id_other) ORDER BY name;

/*
Gold Result:
('Alpha Flyer',)
('Alpha Flyer',)
('Beta Express',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN train AS T2 ON T1.train_id = T2.train_id WHERE NOT T1.station_id IN (SELECT T4.station_id FROM train_station AS T3 JOIN station AS T4 ON T3.station_id = T4.station_id WHERE t4.location = 'London');

/*
Prediction Result:
('Beta Express',)
('Alpha Flyer',)
('Alpha Flyer',)
*/