-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: station --
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (1, 'sta_9d7f16', 1.0, 582.588439, -55602865, 'sta_939fe6', 'swwqcgsk');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (2, 'sta_9d7f16', 1.0, 572.766956, 1610062532, 'sta_939fe6', 'pgu7vfe4');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (3, 'sta_9d7f16', 1.0, 779.409124, 1160656988, 'sta_939fe6', 'ia2yp');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483645, 'sta_4bc935', 0.0, 718.397869, -1670923962, 'sta_2165d6', 'rwbbp6luhvd');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483644, 'sta_4bc935', 0.5, 179.378884, -841692980, 'sta_2165d6', 'bnp');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483643, 'sta_4bc935', 0.0, 787.938887, 2087640001, 'sta_2165d6', 'dposiie5unw');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (4, NULL, 582.588439, 680.190136, -55602865, 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (5, 'e4', NULL, 779.409124, 1160656988, 'ia2yp', 'uzhsrwbbp6lu');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (6, 'hvdlttilbnpr', 986.066566, 666.330692, 907682809, NULL, 'siie');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, lat, city FROM (SELECT * FROM (SELECT * FROM station ORDER BY id) LIMIT 1);

/*
Gold Result:
('sta_4bc935', 0.0, 'sta_2165d6')
*/

-- Prediction Query
SELECT name, lat, city FROM station ORDER BY lat, station.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('e4', None, 'ia2yp')
*/