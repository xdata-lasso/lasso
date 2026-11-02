-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by local_authority ASC, tie-breaking by station.id ASC, and preservation of duplicates (refuting DISTINCT or GROUP BY mutants).
-- Also ensures station.id tie-breaker does not match alphabetical order of services or network_name.
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (10, 'NetZ', 'ServiceB', 'AuthA');
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (2, 'NetA', 'ServiceZ', 'AuthA');
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (5, 'NetM', 'ServiceZ', 'AuthA');
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (1, 'NetB', 'ServiceA', 'AuthB');
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (20, 'NetC', 'ServiceC', 'AuthA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT local_authority, services FROM station ORDER BY local_authority, station.id NULLS LAST;

/*
Gold Result:
('AuthA', 'ServiceZ')
('AuthA', 'ServiceZ')
('AuthA', 'ServiceB')
('AuthA', 'ServiceC')
('AuthB', 'ServiceA')
*/

-- Prediction Query
SELECT local_authority, services FROM station;

/*
Prediction Result:
('AuthB', 'ServiceA')
('AuthA', 'ServiceZ')
('AuthA', 'ServiceZ')
('AuthA', 'ServiceB')
('AuthA', 'ServiceC')
*/