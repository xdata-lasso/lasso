-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1022, 'Carla Gray', 1042.5, 1046.5, 1050, 'Port Jesseville', 'size');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1023, 'Edward Fuller', 1033.5, 1039.5, 1045.0, 'Ramirezstad', 'prove');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1024, 'Heidi Lee', 1040.5, 1048.5, 1056.0, 'West Michael', 'Congress');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1025, 'Matthew Mejia', 1047.5, 1057.5, 1067.0, 'Jacquelineland', 'none');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1038, 'Calvin Nielsen', 1026.5, 1030.5, 1034, 'New Nancy', 'politics');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1039, 'Margaret Hawkins DDS', 1049.5, 1055.5, 1061.0, 'Jasonfort', 'option');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1040, 'Patty Perez', 1056.5, 1064.5, 1072.0, 'Wilkersonmouth', 'nothing');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1041, 'Ethan Adams', 1063.5, 1073.5, 1083.0, 'West Donald', 'everyone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, lat, city FROM (SELECT * FROM (SELECT * FROM station ORDER BY id) LIMIT 1);

/*
Gold Result:
('Carla Gray', 1042.5, 'Port Jesseville')
*/

-- Prediction Query
SELECT name, lat, city FROM station ORDER BY lat, station.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Calvin Nielsen', 1026.5, 'New Nancy')
*/