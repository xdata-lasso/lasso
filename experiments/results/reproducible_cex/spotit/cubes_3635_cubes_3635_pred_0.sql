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
INSERT INTO TRIP VALUES (0, -1, 15, 16, 0, 17, 18, 0, 0, 19, 0);
INSERT INTO TRIP VALUES (-1, -1, 20, 21, 0, 22, 23, 0, 0, 24, 0);
INSERT INTO WEATHER VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO WEATHER VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM (SELECT LHS.id AS id, LHS.duration AS duration, LHS.start_date AS start_date, LHS.start_station_name AS start_station_name, LHS.start_station_id AS start_station_id, LHS.end_date AS end_date, LHS.end_station_name AS end_station_name, LHS.end_station_id AS end_station_id, LHS.bike_id AS bike_id, LHS.subscription_type AS subscription_type, LHS.zip_code AS zip_code FROM trip AS LHS INNER JOIN (SELECT MIN(duration) AS duration FROM trip) AS RHS ON (LHS.duration = RHS.duration)) ORDER BY id;

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
SELECT id FROM trip ORDER BY duration, trip.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-1,)
*/