-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Station Z', 100.5, 20.0, 120.5, 'London', 'Intercity', 10);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Station A', 150.0, 30.0, 180.0, 'London', 'Commuter', 12);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'Station M', 80.0, 10.0, 90.0, 'Manchester', 'Regional', 6);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (4, 'Station L', 90.0, 15.0, 105.0, 'london', 'Local', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (5, 'Station N', 50.0, 5.0, 55.0, NULL, 'Local', 2);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (1, 'Train B', '14:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (2, 'Train A', '12:00', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (3, 'Train A', '08:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (4, 'Train A', NULL, 'Night');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (5, 'Train C', '09:00', 'Regional');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (1, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (2, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (3, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (4, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (5, 3);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (5, 4);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name", "time" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" = 'London')) AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name, "time" NULLS LAST;

/*
Gold Result:
('Train A', '08:00')
('Train A', '12:00')
('Train A', None)
('Train B', '14:00')
*/

-- Prediction Query
SELECT T3.name, T3.time FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id WHERE T2.location = 'London' ORDER BY T3.time DESC, T1.train_id NULLS LAST, T1.station_id NULLS LAST, T2.station_id NULLS LAST, T3.train_id NULLS LAST;

/*
Prediction Result:
('Train B', '14:00')
('Train A', '12:00')
('Train A', '08:00')
('Train A', None)
*/