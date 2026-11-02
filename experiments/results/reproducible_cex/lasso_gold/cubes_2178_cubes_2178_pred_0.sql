-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1119, 'Corey Herrera', 1120.5, 1121.5, 1122.5, 'London', 'challenge', 1123);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1125, 'Scott Pierce', 1126.5, 1127.5, 1128.5, 'London', 'apply', 1129);
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1124, 'Donald Wright', 'wind', 'bag');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1130, NULL, 'better', 'with');
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1124, 1119);
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1130, 1125);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name", "time" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" = 'London')) AS LHS INNER JOIN (SELECT LHS.train_id AS train_id, LHS.name AS name, LHS.time AS TIME, LHS.service AS service, RHS.station_id AS station_id FROM train AS LHS INNER JOIN train_station AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS ON (LHS.station_id = RHS.station_id)) ORDER BY name, "time" NULLS LAST;

/*
Gold Result:
(None, 'better')
('Donald Wright', 'wind')
*/

-- Prediction Query
SELECT T3.name, T3.time FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id JOIN train AS T3 ON T3.train_id = T1.train_id WHERE T2.location = 'London' ORDER BY T3.time DESC, T1.train_id NULLS LAST, T1.station_id NULLS LAST, T2.station_id NULLS LAST, T3.train_id NULLS LAST;

/*
Prediction Result:
('Donald Wright', 'wind')
(None, 'better')
*/