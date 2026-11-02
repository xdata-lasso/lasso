-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ordering by 'id' when insertion order does not match 'id' order, and ensures 'id' order differs from every other column's ascending/descending order. Also tests omission of joins with other tables.
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (50, 'Station_Alpha', 37.7, -122.4, 15, 'City_A', '2013-08-05');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (10, 'Station_Middle', 37.5, -122.2, 20, 'City_M', '2013-08-15');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (90, 'Station_Zeta', 37.1, -122.0, 25, 'City_Z', '2013-08-25');
INSERT INTO "status" ("station_id", "bikes_available", "docks_available", "time") VALUES (50, 5, 10, '2013-08-29 12:00:00');
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (1, 100, '2013-08-29 10:00:00', 'Station_Alpha', 50, '2013-08-29 10:01:40', 'Station_Zeta', 90, 101, 'Subscriber', 94107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, lat, city FROM (SELECT * FROM (SELECT * FROM station ORDER BY id) LIMIT 1);

/*
Gold Result:
('Station_Middle', 37.5, 'City_M')
*/

-- Prediction Query
SELECT name, lat, city FROM station ORDER BY lat, station.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Station_Zeta', 37.1, 'City_Z')
*/