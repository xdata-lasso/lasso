-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("Station_ID", "Name", "Location") VALUES (1, 'Station A', 'London');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (1, 'Train A', '10:00', 'Service A');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (2, 'Train B', '11:00', 'Service B');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (1, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name", "time" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" = 'London')) AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name, "time" NULLS LAST;

/*
Gold Result:
('Train A', '10:00')
('Train B', '11:00')
*/

-- Prediction Query
SELECT T3.name, T3.time FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id WHERE T2.location = 'London' ORDER BY T3.time DESC, T1.train_id NULLS LAST, T1.station_id NULLS LAST, T2.station_id NULLS LAST, T3.train_id NULLS LAST;

/*
Prediction Result:
('Train B', '11:00')
('Train A', '10:00')
*/