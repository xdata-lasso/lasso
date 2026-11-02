-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Boundary conditions for n > 15 (CityB has 15 rows, CityC has 16 rows, CityA has 17 rows).
-- 2. ORDER BY city ASC vs ORDER BY count___ ASC (CityA has 17, CityC has 16).
-- 3. COUNT(*) vs COUNT(name) or COUNT(DISTINCT name) (CityC has NULL and duplicate names).
-- 4. COUNT(*) vs SUM(dock_count) (CityD has 1 row with dock_count = 20).
-- 5. Unintended INNER JOIN with status or trip tables (CityA and CityC have no corresponding status/trip records, while CityB does).
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (1, 'S1', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (2, 'S2', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (3, 'S3', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (4, 'S4', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (5, 'S5', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (6, 'S6', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (7, 'S7', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (8, 'S8', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (9, 'S9', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (10, 'S10', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (11, 'S11', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (12, 'S12', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (13, 'S13', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (14, 'S14', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (15, 'S15', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (16, 'S16', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (17, 'S17', 37.1, -122.1, 1, 'CityA', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (18, 'B1', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (19, 'B2', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (20, 'B3', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (21, 'B4', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (22, 'B5', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (23, 'B6', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (24, 'B7', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (25, 'B8', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (26, 'B9', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (27, 'B10', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (28, 'B11', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (29, 'B12', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (30, 'B13', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (31, 'B14', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (32, 'B15', 37.2, -122.2, 2, 'CityB', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (33, NULL, 37.3, -122.3, NULL, 'CityC', NULL);
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (34, NULL, 37.3, -122.3, NULL, 'CityC', NULL);
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (35, 'DupName', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (36, 'DupName', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (37, 'C5', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (38, 'C6', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (39, 'C7', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (40, 'C8', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (41, 'C9', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (42, 'C10', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (43, 'C11', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (44, 'C12', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (45, 'C13', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (46, 'C14', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (47, 'C15', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (48, 'C16', 37.3, -122.3, 0, 'CityC', '2020-01-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (49, 'D1', 37.4, -122.4, 20, 'CityD', '2020-01-01');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (18, 5, 5, '2020-01-01 10:00:00');
INSERT INTO status (station_id, bikes_available, docks_available, time) VALUES (18, 6, 4, '2020-01-01 11:00:00');
INSERT INTO trip (id, duration, start_date, start_station_name, start_station_id, end_date, end_station_name, end_station_id, bike_id, subscription_type, zip_code) VALUES (1, 100, '2020-01-01', 'B1', 18, '2020-01-01', 'B2', 19, 101, 'Subscriber', 94107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city, n AS count___ FROM (SELECT city, COUNT(*) AS n FROM station GROUP BY city) WHERE (n > 15) ORDER BY city, count___ NULLS LAST;

/*
Gold Result:
('CityA', 17)
('CityC', 16)
*/

-- Prediction Query
SELECT city, COUNT(*) FROM station GROUP BY city HAVING COUNT(*) >= 15;

/*
Prediction Result:
('CityA', 17)
('CityB', 15)
('CityC', 16)
*/