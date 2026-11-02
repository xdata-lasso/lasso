-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT enforcement (multiple matching status rows per station), ordering (inserted out of id order), NULLS LAST handling, and duplicate station names across different IDs.
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (30, 'Central_Depot', 37.3, -121.9, 15, 'San Jose', '2013-08-10');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (10, NULL, 37.3, -121.9, 15, 'San Jose', '2013-08-11');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (20, 'Central_Depot', 37.3, -121.9, 15, 'San Jose', '2013-08-12');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (30, 14, 1, '2013-08-29 10:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (30, 20, 0, '2013-08-29 11:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (10, 15, 0, '2013-08-29 10:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (20, 13, 2, '2013-08-29 10:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (20, 8, 7, '2013-08-29 11:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.lat AS lat, LHS.long AS long, LHS.dock_count AS dock_count, LHS.city AS city, LHS.installation_date AS installation_date, RHS.bikes_available AS bikes_available, RHS.docks_available AS docks_available, RHS.time AS TIME FROM station AS LHS INNER JOIN (SELECT * FROM status WHERE (bikes_available > 12)) AS RHS ON (LHS.id = RHS.station_id)) ORDER BY id, name NULLS LAST;

/*
Gold Result:
(10, None)
(20, 'Central_Depot')
(30, 'Central_Depot')
*/

-- Prediction Query
SELECT DISTINCT T1.id, T1.name FROM station AS T1 JOIN status AS T2 ON T1.id = T2.station_id WHERE T2.bikes_available > 12;

/*
Prediction Result:
(30, 'Central_Depot')
(10, None)
(20, 'Central_Depot')
*/