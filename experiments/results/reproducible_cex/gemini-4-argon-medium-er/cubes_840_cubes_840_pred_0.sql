-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (1, 10, 'Train A', 'Origin A', 'Dest A', '12:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (2, 20, 'Train B', 'Origin B', 'Dest B', '08:00', 'Daily');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT train_number, name FROM train ORDER BY train_number, train.id NULLS LAST;

/*
Gold Result:
(10, 'Train A')
(20, 'Train B')
*/

-- Prediction Query
SELECT train_number, name FROM train ORDER BY TIME, train.id NULLS LAST;

/*
Prediction Result:
(20, 'Train B')
(10, 'Train A')
*/