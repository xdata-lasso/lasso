-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (10, 'Mountain View9', 9, 9, 9, 'Mountain View14', 'Mountain View9');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (9, 'Mountain View9', 9, 9, 9, 'Mountain View13', 'Mountain View9');
INSERT INTO "status" ("station_id", "bikes_available", "docks_available", "time") VALUES (9, 9, 9, 'Mountain View9');
INSERT INTO "status" ("station_id", "bikes_available", "docks_available", "time") VALUES (9, 9, 9, 'Mountain View9');
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (12, 9, 'Mountain View9', 'Mountain View9', 9, 'Mountain View9', 'Mountain View9', 9, 9, 'Mountain View9', 9);
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (11, 9, 'Mountain View9', 'Mountain View9', 9, 'Mountain View9', 'Mountain View9', 9, 9, 'Mountain View9', 9);
INSERT INTO "weather" ("date", "max_temperature_f", "mean_temperature_f", "min_temperature_f", "max_dew_point_f", "mean_dew_point_f", "min_dew_point_f", "max_humidity", "mean_humidity", "min_humidity", "max_sea_level_pressure_inches", "mean_sea_level_pressure_inches", "min_sea_level_pressure_inches", "max_visibility_miles", "mean_visibility_miles", "min_visibility_miles", "max_wind_speed_mph", "mean_wind_speed_mph", "max_gust_speed_mph", "precipitation_inches", "cloud_cover", "events", "wind_dir_degrees", "zip_code") VALUES ('Mountain View9', 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 'Mountain View9', 9, 9);
INSERT INTO "weather" ("date", "max_temperature_f", "mean_temperature_f", "min_temperature_f", "max_dew_point_f", "mean_dew_point_f", "min_dew_point_f", "max_humidity", "mean_humidity", "min_humidity", "max_sea_level_pressure_inches", "mean_sea_level_pressure_inches", "min_sea_level_pressure_inches", "max_visibility_miles", "mean_visibility_miles", "min_visibility_miles", "max_wind_speed_mph", "mean_wind_speed_mph", "max_gust_speed_mph", "precipitation_inches", "cloud_cover", "events", "wind_dir_degrees", "zip_code") VALUES ('Mountain View9', 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 'Mountain View9', 9, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "city", COUNT(*) AS "n" FROM "station" GROUP BY "city") WHERE ("city" = 'Mountain View') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM station WHERE city = 'Mountain View';

/*
Prediction Result:
(0,)
*/