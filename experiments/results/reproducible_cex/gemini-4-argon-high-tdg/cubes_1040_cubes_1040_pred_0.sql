-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (2, 'Station M', 37.5, -122.2, 15, 'Palo Alto', '2013-08-05');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (10, 'Station A', 37.9, -122.5, 25, 'San Jose', '2013-08-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (100, 'Station Z', 37.1, -121.9, 11, 'Mountain View', '2013-08-10');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (10, 5, 20, '2013-08-29 12:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (100, 3, 8, '2013-08-29 12:00:00');
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (1, 300, '2013-08-29 09:00:00', 'Station A', 10, '2013-08-29 09:05:00', 'Station Z', 100, 50, 'Subscriber', 95113);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, lat, city FROM (SELECT * FROM (SELECT * FROM station ORDER BY id) LIMIT 1);

/*
Gold Result:
('Station M', 37.5, 'Palo Alto')
*/

-- Prediction Query
SELECT name, lat, city FROM station ORDER BY lat, station.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Station Z', 37.1, 'Mountain View')
*/