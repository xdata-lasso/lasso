-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (1, 'North Hub', 40.0, -71.0, 15, 'Boston', '2013-08-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (2, 'Union Depot', 30.0, -104.9, 20, 'Denver', '2013-05-10');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (3, 'Lake Shore', 10.0, -87.6, 12, 'Chicago', '2013-06-15');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (4, 'Capitol Square', 20.0, -97.7, 18, 'Austin', '2013-07-20');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (5, 'South Congress', 45.0, -97.8, 22, 'Austin', '2013-09-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (6, 'Back Bay', 65.0, -71.1, 10, 'Boston', '2013-10-12');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (7, 'Millennium Park', 10.0, -87.7, 25, 'Chicago', '2013-11-05');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (8, 'Navy Pier', 58.0, -87.5, 30, 'Chicago', '2013-12-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (9, 'Mile High', 36.0, -105.0, 14, 'Denver', '2014-01-15');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (10, 'Emerald Point', 10.0, -122.3, 16, 'Echo', '2014-02-20');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (1, 7, 8, '2014-03-01 08:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (4, 10, 8, '2014-03-01 08:00:00');
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (101, 360, '2014-03-01 09:00:00', 'North Hub', 1, '2014-03-01 09:06:00', 'Back Bay', 6, 501, 'Subscriber', 94107);
INSERT INTO weather (date, max_temperature_f, mean_temperature_f, min_temperature_f, max_dew_point_f, mean_dew_point_f, min_dew_point_f, max_humidity, mean_humidity, min_humidity, max_sea_level_pressure_inches, mean_sea_level_pressure_inches, min_sea_level_pressure_inches, max_visibility_miles, mean_visibility_miles, min_visibility_miles, max_wind_Speed_mph, mean_wind_speed_mph, max_gust_speed_mph, precipitation_inches, cloud_cover, events, wind_dir_degrees, zip_code) VALUES ('2014-03-01', 68, 60, 52, 50, 45, 40, 80, 65, 50, 30.1, 30.0, 29.9, 10, 10, 10, 15, 8, 20, 0, 2, 'Rain', 180, 94107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT city FROM (SELECT city, lat, MAX(lat) AS maxlat FROM station GROUP BY city, lat) ORDER BY city;

/*
Gold Result:
('Austin',)
('Boston',)
('Chicago',)
('Denver',)
('Echo',)
*/

-- Prediction Query
SELECT city FROM station GROUP BY city ORDER BY MAX(lat) DESC, city NULLS LAST;

/*
Prediction Result:
('Boston',)
('Chicago',)
('Austin',)
('Denver',)
('Echo',)
*/