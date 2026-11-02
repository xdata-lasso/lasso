-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (1, 'Embarcadero', 37.79, -122.39, 15, 'San Francisco', '2013-08-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (2, 'Ferry Building', 37.795, -122.393, 20, 'San Francisco', '2013-08-02');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (3, 'Powell St', 37.78, -122.40, 19, 'San Francisco', '2013-08-03');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (4, 'Civic Center', 37.77, -122.41, 23, 'San Francisco', '2013-08-04');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (5, 'Market St', 37.775, -122.415, 27, 'San Francisco', '2013-08-05');
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (1, 99, '2023-05-03 10:00:00', 'Powell St', 3, '2023-05-03 10:01:39', 'Civic Center', 4, 301, 'Subscriber', 94102);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (2, 100, '2023-05-02 09:00:00', 'Embarcadero', 1, '2023-05-02 09:01:40', 'Ferry Building', 2, 102, 'Customer', 94105);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (3, 90, '2023-05-04 11:00:00', 'Embarcadero', 1, '2023-05-04 11:01:30', 'Market St', 5, 103, 'Subscriber', 94105);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (4, 50, '2023-05-01 08:00:00', 'Market St', 5, '2023-05-01 08:00:50', 'Powell St', 3, 204, 'Customer', 94103);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (5, 101, '2023-05-05 12:00:00', 'Civic Center', 4, '2023-05-05 12:01:41', 'Embarcadero', 1, 405, 'Subscriber', 94102);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (6, 250, '2023-05-06 13:00:00', 'Ferry Building', 2, '2023-05-06 13:04:10', 'Market St', 5, 506, 'Customer', 94111);
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (7, 300, '2023-05-07 14:00:00', 'Powell St', 3, '2023-05-07 14:05:00', 'Ferry Building', 2, 607, 'Subscriber', 94102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT start_station_name FROM trip WHERE (duration <= 100) ORDER BY start_station_name;

/*
Gold Result:
('Embarcadero',)
('Market St',)
('Powell St',)
*/

-- Prediction Query
SELECT DISTINCT start_station_name FROM trip WHERE duration < 100;

/*
Prediction Result:
('Powell St',)
('Embarcadero',)
('Market St',)
*/