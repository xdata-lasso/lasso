-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (1, 101, 'Express A', 'City North', 'City South', '08:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (2, 102, 'Local B', 'City East', 'City West', '09:30', 'Hourly');
INSERT INTO station (id, network_name, services, local_authority) VALUES (1, 'Central', 'Intercity', 'Metro Council');
INSERT INTO station (id, network_name, services, local_authority) VALUES (2, 'Parkway', 'Regional', 'County Council');
INSERT INTO station (id, network_name, services, local_authority) VALUES (3, 'Harbor', 'Commuter', 'Port Authority');
INSERT INTO station (id, network_name, services, local_authority) VALUES (4, 'Hilltop', 'Local', 'District Council');
INSERT INTO route (train_id, station_id) VALUES (1, 1);
INSERT INTO route (train_id, station_id) VALUES (2, 1);
INSERT INTO route (train_id, station_id) VALUES (1, 2);
INSERT INTO route (train_id, station_id) VALUES (2, 4);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (1, 'Monday', 30, 20, 0.5, 10);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (1, 'Tuesday', 10, 5, 1.2, 15);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (2, 'Tuesday', 40, 25, 0.0, 20);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (1, 'Wednesday', 15, 10, 0.1, 5);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (2, 'Wednesday', 20, 12, 0.2, 8);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (3, 'Wednesday', 25, 18, 0.3, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanhigh_temperature AS avg_high_temperature_, day_of_week FROM (SELECT day_of_week, AVG(high_temperature) AS meanhigh_temperature FROM weekly_weather GROUP BY day_of_week) ORDER BY avg_high_temperature_, day_of_week NULLS LAST;

/*
Gold Result:
(20.0, 'Wednesday')
(25.0, 'Tuesday')
(30.0, 'Monday')
*/

-- Prediction Query
SELECT AVG(high_temperature), day_of_week FROM weekly_weather GROUP BY day_of_week;

/*
Prediction Result:
(30.0, 'Monday')
(25.0, 'Tuesday')
(20.0, 'Wednesday')
*/