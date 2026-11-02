-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values for duration (99, 100, 101, 0), DISTINCT deduplication, and ORDER BY sorting.
-- Also tests column confusion (start_station_name vs end_station_name) and unnecessary JOINs with station.
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (1, 'Mismatched Station Name', 37.7, -122.4, 15, 'San Francisco', '2013-08-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (2, 'Orphaned Station', 37.8, -122.5, 20, 'San Jose', '2013-08-02');
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (1, 50, '2020-01-01 10:00', 'Zebra Station', 1, '2020-01-01 10:01', 'Alpha End', 2, 101, 'Subscriber', 94107);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (2, 100, '2020-01-01 11:00', 'Alpha Station', 99, '2020-01-01 11:02', 'Beta End', 98, 102, 'Customer', 94107);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (3, 99, '2020-01-01 12:00', 'Zebra Station', 1, '2020-01-01 12:02', 'Gamma End', 2, 103, 'Subscriber', 94107);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (4, 101, '2020-01-01 13:00', 'Beta Station', 2, '2020-01-01 13:02', 'Delta End', 1, 104, 'Customer', 94107);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (5, 0, '2020-01-01 14:00', 'Middle Station', 3, '2020-01-01 14:00', 'Epsilon End', 3, 105, 'Subscriber', 94107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT start_station_name FROM trip WHERE (duration <= 100) ORDER BY start_station_name;

/*
Gold Result:
('Alpha Station',)
('Middle Station',)
('Zebra Station',)
*/

-- Prediction Query
SELECT DISTINCT start_station_name FROM trip WHERE duration < 100;

/*
Prediction Result:
('Zebra Station',)
('Middle Station',)
*/