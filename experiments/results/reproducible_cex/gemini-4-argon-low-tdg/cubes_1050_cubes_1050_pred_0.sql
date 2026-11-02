-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty "trip" table. Because of the CROSS JOIN with a GROUP BY subquery, an empty "trip" table yields 0 rows in RHS, so the overall query must return 0 rows even though Palo Alto stations exist.
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1, 'PA Station 1', 37.44, -122.16, 15, 'Palo Alto', '2013-08-14');
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (2, 'PA Station 2', 37.45, -122.15, 20, 'Palo Alto', '2013-08-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."lat" AS "lat", "LHS"."long" AS "long", "LHS"."dock_count" AS "dock_count", "LHS"."city" AS "city", "LHS"."installation_date" AS "installation_date", "RHS"."bike_id" AS "bike_id", "RHS"."end_station_id" AS "end_station_id", "RHS"."n" AS "n" FROM "station" AS "LHS" CROSS JOIN (SELECT "bike_id", "end_station_id", COUNT(*) AS "n" FROM "trip" GROUP BY "bike_id", "end_station_id") AS "RHS") WHERE ("city" = 'Palo Alto' OR n = 100) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM station WHERE city = 'Palo Alto' EXCEPT SELECT end_station_name FROM trip GROUP BY end_station_name HAVING COUNT(*) > 100;

/*
Prediction Result:
('PA Station 1',)
('PA Station 2',)
*/