-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2014-01-01', 95, 70, 45, 50, 40, 30, 80, 60, 40, 30.1, 30.0, 29.9, 10, 9, 8, 15, 10, 20, 0, 2, 'Sunny', 180, 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2014-01-02', 75, 68, 60, 55, 50, 45, 85, 70, 55, 30.2, 30.1, 30.0, 10, 10, 10, 12, 8, 18, 1, 7, 'Rain', 200, 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2014-01-03', 80, 55, 30, 40, 35, 25, 75, 55, 35, 30.0, 29.9, 29.8, 10, 8, 6, 20, 15, 25, 0, 4, 'Fog', 90, 95113);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, cloud_cover AS max_temperature_f___min_temperature_f FROM (SELECT * FROM (SELECT * FROM weather ORDER BY min_temperature_f DESC, weather.date NULLS LAST, weather.max_temperature_f NULLS LAST, weather.mean_temperature_f NULLS LAST, weather.max_dew_point_f NULLS LAST, weather.mean_dew_point_f NULLS LAST, weather.min_dew_point_f NULLS LAST, weather.max_humidity NULLS LAST, weather.mean_humidity NULLS LAST, weather.min_humidity NULLS LAST, weather.max_sea_level_pressure_inches NULLS LAST, weather.mean_sea_level_pressure_inches NULLS LAST, weather.min_sea_level_pressure_inches NULLS LAST, weather.max_visibility_miles NULLS LAST, weather.mean_visibility_miles NULLS LAST, weather.min_visibility_miles NULLS LAST, weather.max_wind_speed_mph NULLS LAST, weather.mean_wind_speed_mph NULLS LAST, weather.max_gust_speed_mph NULLS LAST, weather.precipitation_inches NULLS LAST, weather.cloud_cover NULLS LAST, weather.events NULLS LAST, weather.wind_dir_degrees NULLS LAST, weather.zip_code NULLS LAST) LIMIT 1);

/*
Gold Result:
('2014-01-02', 7)
*/

-- Prediction Query
SELECT date, max_temperature_f - min_temperature_f FROM weather ORDER BY max_temperature_f - min_temperature_f, weather.date NULLS LAST, weather.max_temperature_f NULLS LAST, weather.mean_temperature_f NULLS LAST, weather.min_temperature_f NULLS LAST, weather.max_dew_point_f NULLS LAST, weather.mean_dew_point_f NULLS LAST, weather.min_dew_point_f NULLS LAST, weather.max_humidity NULLS LAST, weather.mean_humidity NULLS LAST, weather.min_humidity NULLS LAST, weather.max_sea_level_pressure_inches NULLS LAST, weather.mean_sea_level_pressure_inches NULLS LAST, weather.min_sea_level_pressure_inches NULLS LAST, weather.max_visibility_miles NULLS LAST, weather.mean_visibility_miles NULLS LAST, weather.min_visibility_miles NULLS LAST, weather.max_wind_speed_mph NULLS LAST, weather.mean_wind_speed_mph NULLS LAST, weather.max_gust_speed_mph NULLS LAST, weather.precipitation_inches NULLS LAST, weather.cloud_cover NULLS LAST, weather.events NULLS LAST, weather.wind_dir_degrees NULLS LAST, weather.zip_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('2014-01-02', 15)
*/