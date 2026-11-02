-- Schema DDL
CREATE TABLE "STATION" (
    "ID" INT,
    "NAME" TEXT,
    "LAT" FLOAT,
    "LONG" FLOAT,
    "DOCK_COUNT" INT,
    "CITY" TEXT,
    "INSTALLATION_DATE" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "STATUS" (
    "STATION_ID" INT,
    "BIKES_AVAILABLE" INT,
    "DOCKS_AVAILABLE" INT,
    "TIME" TEXT,
    FOREIGN KEY ("STATION_ID") REFERENCES "STATION"("ID")
);
CREATE TABLE "TRIP" (
    "ID" INT,
    "DURATION" INT,
    "START_DATE" TEXT,
    "START_STATION_NAME" TEXT,
    "START_STATION_ID" INT,
    "END_DATE" TEXT,
    "END_STATION_NAME" TEXT,
    "END_STATION_ID" INT,
    "BIKE_ID" INT,
    "SUBSCRIPTION_TYPE" TEXT,
    "ZIP_CODE" INT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "WEATHER" (
    "DATE" TEXT,
    "MAX_TEMPERATURE_F" INT,
    "MEAN_TEMPERATURE_F" INT,
    "MIN_TEMPERATURE_F" INT,
    "MAX_DEW_POINT_F" INT,
    "MEAN_DEW_POINT_F" INT,
    "MIN_DEW_POINT_F" INT,
    "MAX_HUMIDITY" INT,
    "MEAN_HUMIDITY" INT,
    "MIN_HUMIDITY" INT,
    "MAX_SEA_LEVEL_PRESSURE_INCHES" FLOAT,
    "MEAN_SEA_LEVEL_PRESSURE_INCHES" FLOAT,
    "MIN_SEA_LEVEL_PRESSURE_INCHES" FLOAT,
    "MAX_VISIBILITY_MILES" INT,
    "MEAN_VISIBILITY_MILES" INT,
    "MIN_VISIBILITY_MILES" INT,
    "MAX_WIND_SPEED_MPH" INT,
    "MEAN_WIND_SPEED_MPH" INT,
    "MAX_GUST_SPEED_MPH" INT,
    "PRECIPITATION_INCHES" INT,
    "CLOUD_COVER" INT,
    "EVENTS" TEXT,
    "WIND_DIR_DEGREES" INT,
    "ZIP_CODE" INT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STATION VALUES (1, 0, 0, 0, 0, 0, 0);
INSERT INTO STATION VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO STATUS VALUES (1, 0, 0, 0);
INSERT INTO STATUS VALUES (1, 0, 0, 0);
INSERT INTO TRIP VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO TRIP VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO WEATHER VALUES (NULL, 0, -1, -2, -1, -1, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 0, NULL, 0, -1, 0);
INSERT INTO WEATHER VALUES (0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, cloud_cover AS max_temperature_f___min_temperature_f FROM (SELECT * FROM (SELECT * FROM weather ORDER BY min_temperature_f DESC, weather.date NULLS LAST, weather.max_temperature_f NULLS LAST, weather.mean_temperature_f NULLS LAST, weather.max_dew_point_f NULLS LAST, weather.mean_dew_point_f NULLS LAST, weather.min_dew_point_f NULLS LAST, weather.max_humidity NULLS LAST, weather.mean_humidity NULLS LAST, weather.min_humidity NULLS LAST, weather.max_sea_level_pressure_inches NULLS LAST, weather.mean_sea_level_pressure_inches NULLS LAST, weather.min_sea_level_pressure_inches NULLS LAST, weather.max_visibility_miles NULLS LAST, weather.mean_visibility_miles NULLS LAST, weather.min_visibility_miles NULLS LAST, weather.max_wind_speed_mph NULLS LAST, weather.mean_wind_speed_mph NULLS LAST, weather.max_gust_speed_mph NULLS LAST, weather.precipitation_inches NULLS LAST, weather.cloud_cover NULLS LAST, weather.events NULLS LAST, weather.wind_dir_degrees NULLS LAST, weather.zip_code NULLS LAST) LIMIT 1);

/*
Gold Result:
('0', 1)
*/

-- Prediction Query
SELECT date, max_temperature_f - min_temperature_f FROM weather ORDER BY max_temperature_f - min_temperature_f, weather.date NULLS LAST, weather.max_temperature_f NULLS LAST, weather.mean_temperature_f NULLS LAST, weather.min_temperature_f NULLS LAST, weather.max_dew_point_f NULLS LAST, weather.mean_dew_point_f NULLS LAST, weather.min_dew_point_f NULLS LAST, weather.max_humidity NULLS LAST, weather.mean_humidity NULLS LAST, weather.min_humidity NULLS LAST, weather.max_sea_level_pressure_inches NULLS LAST, weather.mean_sea_level_pressure_inches NULLS LAST, weather.min_sea_level_pressure_inches NULLS LAST, weather.max_visibility_miles NULLS LAST, weather.mean_visibility_miles NULLS LAST, weather.min_visibility_miles NULLS LAST, weather.max_wind_speed_mph NULLS LAST, weather.mean_wind_speed_mph NULLS LAST, weather.max_gust_speed_mph NULLS LAST, weather.precipitation_inches NULLS LAST, weather.cloud_cover NULLS LAST, weather.events NULLS LAST, weather.wind_dir_degrees NULLS LAST, weather.zip_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('0', 1)
*/