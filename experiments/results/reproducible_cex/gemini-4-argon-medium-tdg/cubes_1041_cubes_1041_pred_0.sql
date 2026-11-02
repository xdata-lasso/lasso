-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (1, 'Zeta Station', 37.7, -122.4, 15, 'San Francisco', '2013-08-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (2, 'Alpha Station', 37.8, -122.5, 7, 'San Jose', '2013-08-02');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (3, 'Beta Station', 37.9, -122.6, 20, 'Palo Alto', '2013-08-03');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (7, 'Gamma Station', 37.6, -122.3, 19, 'Mountain View', '2013-08-04');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (1, 7, 8, '2013-08-29 12:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (1, 7, 8, '2013-08-29 12:01:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (2, 6, 7, '2013-08-29 12:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (3, 7, 13, '2013-08-29 12:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (7, 8, 11, '2013-08-29 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.lat AS lat, LHS.long AS long, LHS.dock_count AS dock_count, LHS.city AS city, LHS.installation_date AS installation_date, RHS.bikes_available AS bikes_available, RHS.docks_available AS docks_available, RHS.time AS TIME FROM station AS LHS INNER JOIN (SELECT * FROM status WHERE (bikes_available = 7)) AS RHS ON (LHS.id = RHS.station_id)) ORDER BY name;

/*
Gold Result:
('Beta Station',)
('Zeta Station',)
*/

-- Prediction Query
SELECT DISTINCT T1.name FROM station AS T1 JOIN status AS T2 ON T1.id = T2.station_id WHERE T2.bikes_available = 7;

/*
Prediction Result:
('Zeta Station',)
('Beta Station',)
*/