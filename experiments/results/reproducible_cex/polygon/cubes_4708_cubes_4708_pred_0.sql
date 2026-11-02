-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (14, NULL, 24, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (13, NULL, 30, 31, 32, '33', '34', 35);
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1, '1', '1', '1');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (15, '1', '1', '1');
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1, 14);
INSERT INTO "train_station" ("train_id", "station_id") VALUES (15, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.station_id AS station_id, LHS.maxn AS maxn FROM (SELECT name, station_id, MAX(n) AS maxn FROM (SELECT name, station_id, COUNT(*) AS n FROM station GROUP BY name, station_id) GROUP BY name, station_id) AS LHS INNER JOIN train_station AS RHS ON (LHS.station_id = RHS.station_id AND LHS.maxn = RHS.train_id)) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/