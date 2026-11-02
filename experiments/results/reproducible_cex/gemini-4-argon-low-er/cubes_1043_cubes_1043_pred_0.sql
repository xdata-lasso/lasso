-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO station (id, city) VALUES (1, 'SF');
INSERT INTO station (id, city) VALUES (2, 'SF');
INSERT INTO station (id, city) VALUES (3, 'SF');
INSERT INTO station (id, city) VALUES (4, 'SF');
INSERT INTO station (id, city) VALUES (5, 'SF');
INSERT INTO station (id, city) VALUES (6, 'SF');
INSERT INTO station (id, city) VALUES (7, 'SF');
INSERT INTO station (id, city) VALUES (8, 'SF');
INSERT INTO station (id, city) VALUES (9, 'SF');
INSERT INTO station (id, city) VALUES (10, 'SF');
INSERT INTO station (id, city) VALUES (11, 'SF');
INSERT INTO station (id, city) VALUES (12, 'SF');
INSERT INTO station (id, city) VALUES (13, 'SF');
INSERT INTO station (id, city) VALUES (14, 'SF');
INSERT INTO station (id, city) VALUES (15, 'SF');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city, n AS count___ FROM (SELECT city, COUNT(*) AS n FROM station GROUP BY city) WHERE (n > 15) ORDER BY city, count___ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT city, COUNT(*) FROM station GROUP BY city HAVING COUNT(*) >= 15;

/*
Prediction Result:
('SF', 15)
*/