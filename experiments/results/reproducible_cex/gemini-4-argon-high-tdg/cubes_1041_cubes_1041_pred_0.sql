-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (1, 'Zeta Station', 37.78, -122.40, 15, 'San Francisco', '2013-08-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (2, 'Alpha Station', 37.79, -122.41, 7, 'San Francisco', '2013-08-02');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (3, 'Beta Station', 37.80, -122.42, 7, 'San Jose', '2013-08-03');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (4, 'Gamma Station', 37.81, -122.43, 20, 'Mountain View', '2013-08-04');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (5, 'Delta Station', 37.82, -122.44, 10, 'Palo Alto', '2013-08-05');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (1, 7, 8, '2014-01-01 08:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (1, 7, 8, '2014-01-01 08:01:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (1, 10, 5, '2014-01-01 08:02:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (2, 7, 0, '2014-01-01 08:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (2, 3, 4, '2014-01-01 08:05:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (3, 6, 7, '2014-01-01 08:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (3, 8, 5, '2014-01-01 08:05:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (4, 3, 17, '2014-01-01 08:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (4, 4, 16, '2014-01-01 08:05:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.lat AS lat, LHS.long AS long, LHS.dock_count AS dock_count, LHS.city AS city, LHS.installation_date AS installation_date, RHS.bikes_available AS bikes_available, RHS.docks_available AS docks_available, RHS.time AS TIME FROM station AS LHS INNER JOIN (SELECT * FROM status WHERE (bikes_available = 7)) AS RHS ON (LHS.id = RHS.station_id)) ORDER BY name;

/*
Gold Result:
('Alpha Station',)
('Zeta Station',)
*/

-- Prediction Query
SELECT DISTINCT T1.name FROM station AS T1 JOIN status AS T2 ON T1.id = T2.station_id WHERE T2.bikes_available = 7;

/*
Prediction Result:
('Zeta Station',)
('Alpha Station',)
*/