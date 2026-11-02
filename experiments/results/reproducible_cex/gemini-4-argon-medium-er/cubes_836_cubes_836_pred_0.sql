-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO station (id, network_name, services, local_authority) VALUES (1, 'N1', 'S1', 'L1');
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (1, 'Monday', 20, 10, 0.0, 5);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (1, 'Tuesday', 10, 5, 0.0, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanhigh_temperature AS avg_high_temperature_, day_of_week FROM (SELECT day_of_week, AVG(high_temperature) AS meanhigh_temperature FROM weekly_weather GROUP BY day_of_week) ORDER BY avg_high_temperature_, day_of_week NULLS LAST;

/*
Gold Result:
(10.0, 'Tuesday')
(20.0, 'Monday')
*/

-- Prediction Query
SELECT AVG(high_temperature), day_of_week FROM weekly_weather GROUP BY day_of_week;

/*
Prediction Result:
(20.0, 'Monday')
(10.0, 'Tuesday')
*/