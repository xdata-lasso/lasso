-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Zeta Station', 100.0, 10.0, 110.0, 'London', 'Commuter', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Alpha Station', 200.0, 20.0, 220.0, 'London', 'Intercity', 6);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'Beta Station', 150.0, 15.0, 165.0, 'Manchester', 'Regional', 2);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (4, 'Gamma Station', 50.0, 5.0, 55.0, 'london', 'Local', 1);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (5, 'Delta Station', 80.0, 8.0, 88.0, 'London Bridge', 'Local', 3);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (6, 'Epsilon Station', 90.0, 9.0, 99.0, NULL, 'Local', 2);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (7, 'Unlinked London', 300.0, 30.0, 330.0, 'London', 'Express', 8);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (10, 'Train B', '14:00', 'London');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (20, 'Train A', '09:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (30, 'Train C', '11:00', 'London');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (40, 'Train D', '16:00', 'Regional');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (20, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (30, 3);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (30, 4);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (30, 5);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (30, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name", "time" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" = 'London')) AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name, "time" NULLS LAST;

/*
Gold Result:
('Train A', '09:00')
('Train B', '14:00')
*/

-- Prediction Query
SELECT T3.name, T3.time FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id WHERE T2.location = 'London' ORDER BY T3.time DESC, T1.train_id NULLS LAST, T1.station_id NULLS LAST, T2.station_id NULLS LAST, T3.train_id NULLS LAST;

/*
Prediction Result:
('Train B', '14:00')
('Train A', '09:00')
*/