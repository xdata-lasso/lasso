-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (1, 100, 'Express B', 'London', 'Manchester', '08:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (2, 20, 'Local D', 'Bristol', 'Cardiff', '09:30', 'Weekdays');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (3, 100, 'Express C', 'Leeds', 'York', '10:15', 'Hourly');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (4, 100, 'Express A', 'Glasgow', 'Edinburgh', '11:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (5, 100, 'Express B', 'London', 'Manchester', '08:00', 'Daily');
INSERT INTO station (id, network_name, services, local_authority) VALUES (10, 'Central', 'InterCity', 'Westminster');
INSERT INTO station (id, network_name, services, local_authority) VALUES (20, 'Northern', 'Regional', 'Camden');
INSERT INTO route (train_id, station_id) VALUES (1, 10);
INSERT INTO route (train_id, station_id) VALUES (1, 20);
INSERT INTO route (train_id, station_id) VALUES (3, 10);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (10, 'Monday', 18, 9, 1.2, 12);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (20, 'Tuesday', 15, 7, 0.0, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT train_number, name FROM train ORDER BY train_number, train.id NULLS LAST;

/*
Gold Result:
(20, 'Local D')
(100, 'Express B')
(100, 'Express C')
(100, 'Express A')
(100, 'Express B')
*/

-- Prediction Query
SELECT train_number, name FROM train ORDER BY TIME, train.id NULLS LAST;

/*
Prediction Result:
(100, 'Express B')
(100, 'Express B')
(20, 'Local D')
(100, 'Express C')
(100, 'Express A')
*/