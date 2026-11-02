-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (1026, 1027, 'surface', 'Joe Martinez', 1028, 'win', 'Juan Calderon', 1029, 1030, 'present', 1031);
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (1032, 1033, 'value', 'Laura Bush', 1034, 'answer', 'Patricia Galloway', 1035, 1036, 'top', 1037);
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (1038, NULL, 'early', 'Jamie Chavez', 1040, 'they', 'Jacob Clark', 1041, 1042, 'example', 1043);
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (1044, NULL, 'science', 'Maria Lynch', 1046, 'Congress', 'Danielle Ford', 1047, 1048, 'expect', 1049);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM (SELECT LHS.id AS id, LHS.duration AS duration, LHS.start_date AS start_date, LHS.start_station_name AS start_station_name, LHS.start_station_id AS start_station_id, LHS.end_date AS end_date, LHS.end_station_name AS end_station_name, LHS.end_station_id AS end_station_id, LHS.bike_id AS bike_id, LHS.subscription_type AS subscription_type, LHS.zip_code AS zip_code FROM trip AS LHS INNER JOIN (SELECT MIN(duration) AS duration FROM trip) AS RHS ON (LHS.duration = RHS.duration)) ORDER BY id;

/*
Gold Result:
(1026,)
*/

-- Prediction Query
SELECT id FROM trip ORDER BY duration, trip.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1038,)
*/