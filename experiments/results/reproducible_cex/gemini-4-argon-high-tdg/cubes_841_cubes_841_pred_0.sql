-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (1, 101, 'Express A', 'City X', 'City Y', '08:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (2, 102, 'Express B', 'City Y', 'City Z', '09:30', 'Weekdays');
INSERT INTO station (id, network_name, services, local_authority) VALUES (1, 'Net_Alpha', 'Rail', 'York');
INSERT INTO station (id, network_name, services, local_authority) VALUES (2, 'Net_Zeta', 'Zebra Shuttle', 'Bristol');
INSERT INTO station (id, network_name, services, local_authority) VALUES (3, 'Net_Beta', 'Airport Link', 'Bristol');
INSERT INTO station (id, network_name, services, local_authority) VALUES (4, 'Net_Gamma', 'Airport Link', 'Bristol');
INSERT INTO station (id, network_name, services, local_authority) VALUES (5, 'Net_Delta', 'Metro', 'Aberdeen');
INSERT INTO route (train_id, station_id) VALUES (1, 1);
INSERT INTO route (train_id, station_id) VALUES (1, 2);
INSERT INTO route (train_id, station_id) VALUES (2, 2);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (1, 'Monday', 65, 48, 0.1, 10);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (1, 'Tuesday', 68, 50, 0.0, 8);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (2, 'Monday', 70, 52, 0.4, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT local_authority, services FROM station ORDER BY local_authority, station.id NULLS LAST;

/*
Gold Result:
('Aberdeen', 'Metro')
('Bristol', 'Zebra Shuttle')
('Bristol', 'Airport Link')
('Bristol', 'Airport Link')
('York', 'Rail')
*/

-- Prediction Query
SELECT local_authority, services FROM station;

/*
Prediction Result:
('York', 'Rail')
('Bristol', 'Zebra Shuttle')
('Bristol', 'Airport Link')
('Bristol', 'Airport Link')
('Aberdeen', 'Metro')
*/