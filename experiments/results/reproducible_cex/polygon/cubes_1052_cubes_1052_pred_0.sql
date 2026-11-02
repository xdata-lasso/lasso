-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (24, '30.351', 51, 51, 51, '30.351', '30.351');
INSERT INTO "weather" ("date", "max_temperature_f", "mean_temperature_f", "min_temperature_f", "max_dew_point_f", "mean_dew_point_f", "min_dew_point_f", "max_humidity", "mean_humidity", "min_humidity", "max_sea_level_pressure_inches", "mean_sea_level_pressure_inches", "min_sea_level_pressure_inches", "max_visibility_miles", "mean_visibility_miles", "min_visibility_miles", "max_wind_speed_mph", "mean_wind_speed_mph", "max_gust_speed_mph", "precipitation_inches", "cloud_cover", "events", "wind_dir_degrees", "zip_code") VALUES ('30.351', 51, 51, 51, 51, 51, 51, 51, 51, 51, 51, 32, 51, 51, 51, 51, 51, 51, 51, 51, 51, '30.351', 51, 51);
INSERT INTO "weather" ("date", "max_temperature_f", "mean_temperature_f", "min_temperature_f", "max_dew_point_f", "mean_dew_point_f", "min_dew_point_f", "max_humidity", "mean_humidity", "min_humidity", "max_sea_level_pressure_inches", "mean_sea_level_pressure_inches", "min_sea_level_pressure_inches", "max_visibility_miles", "mean_visibility_miles", "min_visibility_miles", "max_wind_speed_mph", "mean_wind_speed_mph", "max_gust_speed_mph", "precipitation_inches", "cloud_cover", "events", "wind_dir_degrees", "zip_code") VALUES ('30.351', 27, 28, 29, 30, 33, 34, 35, 36, 37, 38, 31, 39, 40, 41, 42, 43, 44, 45, 46, 47, '30.348', 49, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date" FROM "weather" WHERE ("mean_sea_level_pressure_inches" <= 31.0 AND "mean_sea_level_pressure_inches" >= '30.3') ORDER BY date, weather.max_temperature_f NULLS LAST, weather.mean_temperature_f NULLS LAST, weather.min_temperature_f NULLS LAST, weather.max_dew_point_f NULLS LAST, weather.mean_dew_point_f NULLS LAST, weather.min_dew_point_f NULLS LAST, weather.max_humidity NULLS LAST, weather.mean_humidity NULLS LAST, weather.min_humidity NULLS LAST, weather.max_sea_level_pressure_inches NULLS LAST, weather.mean_sea_level_pressure_inches NULLS LAST, weather.min_sea_level_pressure_inches NULLS LAST, weather.max_visibility_miles NULLS LAST, weather.mean_visibility_miles NULLS LAST, weather.min_visibility_miles NULLS LAST, weather.max_wind_speed_mph NULLS LAST, weather.mean_wind_speed_mph NULLS LAST, weather.max_gust_speed_mph NULLS LAST, weather.precipitation_inches NULLS LAST, weather.cloud_cover NULLS LAST, weather.events NULLS LAST, weather.wind_dir_degrees NULLS LAST, weather.zip_code NULLS LAST;

/*
Gold Result:
('30.351',)
*/

-- Prediction Query
SELECT date FROM weather WHERE mean_sea_level_pressure_inches BETWEEN 30.3 AND 31;

/*
Prediction Result:
('30.351',)
*/