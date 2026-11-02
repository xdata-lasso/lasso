-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1, 'Zeta Station', 37.2, 40.0, 50, 'San Jose', '2013-08-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (2, 'Alpha Station', 37.4999, -122.1, 15, 'Palo Alto', '2013-08-02');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (3, 'Boundary Station', 37.5, -122.2, 20, 'Redwood City', '2013-08-03');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (4, 'Alpha Station', 36.9, 50.0, 45, 'San Jose', '2013-08-04');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (5, 'North Station', 37.8, 10.0, 12, 'San Francisco', '2013-08-05');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (40, 'Beta Station', 37.0, 45.0, 40, 'Mountain View', '2013-08-06');
INSERT INTO "status" ("station_id", "bikes_available", "docks_available", "time") VALUES (1, 10, 40, '2013-09-01 10:00:00');
INSERT INTO "status" ("station_id", "bikes_available", "docks_available", "time") VALUES (1, 12, 38, '2013-09-01 11:00:00');
INSERT INTO "status" ("station_id", "bikes_available", "docks_available", "time") VALUES (3, 5, 15, '2013-09-01 10:00:00');
INSERT INTO "status" ("station_id", "bikes_available", "docks_available", "time") VALUES (5, 6, 6, '2013-09-01 10:00:00');
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (101, 300, '2013-09-01 08:00:00', 'Zeta Station', 1, '2013-09-01 08:05:00', 'North Station', 5, 11, 'Subscriber', 95113);
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (102, 420, '2013-09-01 09:00:00', 'Zeta Station', 1, '2013-09-01 09:07:00', 'Boundary Station', 3, 12, 'Customer', 94063);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "station" WHERE ("lat" < '37.5') ORDER BY name, station.id NULLS LAST;

/*
Gold Result:
('Alpha Station',)
('Alpha Station',)
('Beta Station',)
('Zeta Station',)
*/

-- Prediction Query
SELECT name FROM station WHERE lat < 37.5;

/*
Prediction Result:
('Zeta Station',)
('Alpha Station',)
('Alpha Station',)
('Beta Station',)
*/