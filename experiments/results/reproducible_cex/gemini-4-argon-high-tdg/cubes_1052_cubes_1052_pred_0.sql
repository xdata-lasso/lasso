-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2013-08-30', 75, 65, 55, 58, 54, 50, 85, 70, 55, 30.4, 30.3, 30.2, 10, 10, 10, 15, 8, 20, 0, 2, 'Fog', 270, 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2013-08-28', 78, 68, 58, 60, 56, 52, 88, 72, 56, 31.1, 31.0, 30.9, 10, 10, 10, 14, 7, 18, 0, 1, '', 280, 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2013-08-29', 76, 66, 56, 59, 55, 51, 86, 71, 54, 30.8, 30.65, 30.5, 10, 10, 10, 16, 9, 22, 0, 3, 'Rain', 260, 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2013-08-27', 72, 62, 52, 55, 51, 47, 80, 65, 50, 30.4, 30.29, 30.1, 10, 10, 10, 12, 6, 15, 0, 4, '', 250, 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2013-08-31', 80, 70, 60, 61, 57, 53, 90, 75, 60, 31.2, 31.01, 30.8, 10, 10, 10, 18, 10, 25, 0, 5, '', 290, 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2013-08-26', 70, 60, 50, 53, 49, 45, 78, 63, 48, 30.2, 30.0, 29.8, 10, 10, 10, 11, 5, 14, 0, 2, '', 240, 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2013-09-01', 82, 72, 62, 62, 58, 54, 85, 70, 55, 30.6, NULL, 30.4, 10, 10, 10, 13, 7, 17, 0, 1, '', 275, 94107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date" FROM "weather" WHERE ("mean_sea_level_pressure_inches" <= 31.0 AND "mean_sea_level_pressure_inches" >= '30.3') ORDER BY date, weather.max_temperature_f NULLS LAST, weather.mean_temperature_f NULLS LAST, weather.min_temperature_f NULLS LAST, weather.max_dew_point_f NULLS LAST, weather.mean_dew_point_f NULLS LAST, weather.min_dew_point_f NULLS LAST, weather.max_humidity NULLS LAST, weather.mean_humidity NULLS LAST, weather.min_humidity NULLS LAST, weather.max_sea_level_pressure_inches NULLS LAST, weather.mean_sea_level_pressure_inches NULLS LAST, weather.min_sea_level_pressure_inches NULLS LAST, weather.max_visibility_miles NULLS LAST, weather.mean_visibility_miles NULLS LAST, weather.min_visibility_miles NULLS LAST, weather.max_wind_speed_mph NULLS LAST, weather.mean_wind_speed_mph NULLS LAST, weather.max_gust_speed_mph NULLS LAST, weather.precipitation_inches NULLS LAST, weather.cloud_cover NULLS LAST, weather.events NULLS LAST, weather.wind_dir_degrees NULLS LAST, weather.zip_code NULLS LAST;

/*
Gold Result:
('2013-08-28',)
('2013-08-29',)
('2013-08-30',)
*/

-- Prediction Query
SELECT date FROM weather WHERE mean_sea_level_pressure_inches BETWEEN 30.3 AND 31;

/*
Prediction Result:
('2013-08-30',)
('2013-08-28',)
('2013-08-29',)
*/