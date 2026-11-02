-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests GROUP BY vs no GROUP BY when there are zero 'Mountain View' rows.
-- With GROUP BY in subquery, the outer query returns 0 rows (empty result set).
-- A mutant without GROUP BY (e.g. SELECT COUNT(*) FROM station WHERE city = 'Mountain View') will return 1 row with value 0.
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1, 'San Jose Diridon', 37.32, -121.90, 27, 'San Jose', '2013-08-06');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (2, 'Palo Alto Caltrain', 37.44, -122.16, 23, 'Palo Alto', '2013-08-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "city", COUNT(*) AS "n" FROM "station" GROUP BY "city") WHERE ("city" = 'Mountain View') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM station WHERE city = 'Mountain View';

/*
Prediction Result:
(0,)
*/