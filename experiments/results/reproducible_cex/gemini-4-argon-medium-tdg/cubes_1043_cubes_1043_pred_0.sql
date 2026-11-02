-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (n = 15 vs n = 16) and alphabetical ordering (Zebra inserted before Alpha).
-- Also includes a station with NULL name/dock_count in the n=16 group to kill mutants using COUNT(name) or COUNT(dock_count) instead of COUNT(*).
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1, 'Z1', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (2, 'Z2', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (3, 'Z3', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (4, 'Z4', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (5, 'Z5', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (6, 'Z6', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (7, 'Z7', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (8, 'Z8', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (9, 'Z9', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (10, 'Z10', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (11, 'Z11', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (12, 'Z12', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (13, 'Z13', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (14, 'Z14', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (15, 'Z15', 37.0, -122.0, 10, 'Zebra', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (16, NULL, NULL, NULL, NULL, 'Zebra', NULL);
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (17, 'B1', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (18, 'B2', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (19, 'B3', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (20, 'B4', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (21, 'B5', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (22, 'B6', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (23, 'B7', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (24, 'B8', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (25, 'B9', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (26, 'B10', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (27, 'B11', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (28, 'B12', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (29, 'B13', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (30, 'B14', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (31, 'B15', 37.0, -122.0, 20, 'Beta', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (32, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (33, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (34, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (35, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (36, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (37, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (38, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (39, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (40, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (41, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (42, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (43, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (44, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (45, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (46, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (47, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (48, 'A', 37.0, -122.0, 1, 'Alpha', '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city, n AS count___ FROM (SELECT city, COUNT(*) AS n FROM station GROUP BY city) WHERE (n > 15) ORDER BY city, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 17)
('Zebra', 16)
*/

-- Prediction Query
SELECT city, COUNT(*) FROM station GROUP BY city HAVING COUNT(*) >= 15;

/*
Prediction Result:
('Alpha', 17)
('Beta', 15)
('Zebra', 16)
*/