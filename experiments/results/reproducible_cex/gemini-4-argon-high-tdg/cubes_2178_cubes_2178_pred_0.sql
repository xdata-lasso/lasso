-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (10, 'Kings Cross', 80.0, 10.0, 90.0, 'London', 'East Coast', 11);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (20, 'Kings Cross', 75.0, 12.0, 87.0, 'London', 'Thameslink', 12);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (100, 'Flying Scotsman', '10:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (200, 'Metro Shuttle', '12:30', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (300, 'Metro Shuttle', '12:30', 'Local');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (100, 10);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (100, 20);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (200, 10);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (300, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name", "time" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" = 'London')) AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name, "time" NULLS LAST;

/*
Gold Result:
('Flying Scotsman', '10:00')
('Flying Scotsman', '10:00')
('Metro Shuttle', '12:30')
('Metro Shuttle', '12:30')
*/

-- Prediction Query
SELECT T3.name, T3.time FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id WHERE T2.location = 'London' ORDER BY T3.time DESC, T1.train_id NULLS LAST, T1.station_id NULLS LAST, T2.station_id NULLS LAST, T3.train_id NULLS LAST;

/*
Prediction Result:
('Metro Shuttle', '12:30')
('Metro Shuttle', '12:30')
('Flying Scotsman', '10:00')
('Flying Scotsman', '10:00')
*/