-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, DISTINCT deduplication (multiple stations per city with different/same lat),
-- ORDER BY city (inserted in reverse alphabetical order), and stations without corresponding status/trip records.
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1, 'Station Z1', 37.7, -122.4, 15, 'San Jose', '2013-08-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (2, 'Station Z2', 37.8, -122.4, 15, 'San Jose', '2013-08-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (3, 'Station A1', 37.3, -121.9, 20, 'Mountain View', '2013-08-02');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (4, 'Station A2', 37.3, -121.9, 20, 'Mountain View', '2013-08-03');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (5, 'Station M1', 37.5, -122.2, 10, 'Palo Alto', '2013-08-04');
INSERT INTO "status" ("station_id", "bikes_available", "docks_available", "time") VALUES (1, 5, 10, '2013-08-29 12:00:00');
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (101, 300, '2013-08-29 09:00:00', 'Station Z1', 1, '2013-08-29 09:05:00', 'Station Z2', 2, 50, 'Subscriber', 95113);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT city FROM (SELECT city, lat, MAX(lat) AS maxlat FROM station GROUP BY city, lat) ORDER BY city;

/*
Gold Result:
('Mountain View',)
('Palo Alto',)
('San Jose',)
*/

-- Prediction Query
SELECT city FROM station GROUP BY city ORDER BY MAX(lat) DESC, city NULLS LAST;

/*
Prediction Result:
('San Jose',)
('Palo Alto',)
('Mountain View',)
*/