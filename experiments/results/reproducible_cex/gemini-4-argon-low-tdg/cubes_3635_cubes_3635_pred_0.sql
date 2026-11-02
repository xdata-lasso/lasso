-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the minimum duration, ordering by id vs physical insertion order,
-- NULL duration handling, and differentiating id from duration, station_ids, and bike_id.
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (20, 50, '2023-01-01 10:00', 'Station A', 100, '2023-01-01 10:05', 'Station B', 200, 300, 'Subscriber', 94107);
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (10, 50, '2023-01-02 11:00', 'Station C', 101, '2023-01-02 11:05', 'Station D', 201, 301, 'Customer', 94105);
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (5, 100, '2023-01-03 12:00', 'Station E', 102, '2023-01-03 12:10', 'Station F', 202, 302, 'Subscriber', 94107);
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (1, NULL, '2023-01-04 13:00', 'Station G', 103, '2023-01-04 13:15', 'Station H', 203, 303, 'Customer', 94102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM (SELECT LHS.id AS id, LHS.duration AS duration, LHS.start_date AS start_date, LHS.start_station_name AS start_station_name, LHS.start_station_id AS start_station_id, LHS.end_date AS end_date, LHS.end_station_name AS end_station_name, LHS.end_station_id AS end_station_id, LHS.bike_id AS bike_id, LHS.subscription_type AS subscription_type, LHS.zip_code AS zip_code FROM trip AS LHS INNER JOIN (SELECT MIN(duration) AS duration FROM trip) AS RHS ON (LHS.duration = RHS.duration)) ORDER BY id;

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT id FROM trip ORDER BY duration, trip.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/