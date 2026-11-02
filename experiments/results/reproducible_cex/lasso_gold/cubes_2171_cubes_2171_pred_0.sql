-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1075, 'Thomas Harrell', 'fire', 'thought');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1078, 'Thomas Harrell', 'fire', 'thought');
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1075, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."station_id" AS "station_id", "LHS"."name" AS "name", "LHS"."annual_entry_exit" AS "annual_entry_exit", "LHS"."annual_interchanges" AS "annual_interchanges", "LHS"."total_passengers" AS "total_passengers", "LHS"."location" AS "location", "LHS"."main_services" AS "main_services", "LHS"."number_of_platforms" AS "number_of_platforms", "RHS"."train_id" AS "train_id", "RHS"."station_id" AS "station_id_other", "RHS"."name" AS "name_other", "RHS"."time" AS "time", "RHS"."service" AS "service" FROM (SELECT * FROM "station" WHERE ("location" <> 'London')) AS LHS CROSS JOIN (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.time AS TIME, RHS.service AS service FROM train_station AS LHS LEFT JOIN train AS RHS ON (LHS.train_id = RHS.train_id)) AS RHS) WHERE (station_id = station_id_other) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN train AS T2 ON T1.train_id = T2.train_id WHERE NOT T1.station_id IN (SELECT T4.station_id FROM train_station AS T3 JOIN station AS T4 ON T3.station_id = T4.station_id WHERE t4.location = 'London');

/*
Prediction Result:
('Thomas Harrell',)
*/