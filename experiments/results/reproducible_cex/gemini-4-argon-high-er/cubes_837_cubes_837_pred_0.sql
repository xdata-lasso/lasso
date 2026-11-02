-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (1, 200, 'Express A', 'Chennai', 'Guruvayur', '10:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (2, 100, 'Express B', 'Chennai', 'Guruvayur', '11:00', 'Daily');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "train_number", "time" FROM "train" WHERE ("origin" = 'Chennai' AND "destination" = 'Guruvayur') ORDER BY train_number, train.id NULLS LAST;

/*
Gold Result:
(100, '11:00')
(200, '10:00')
*/

-- Prediction Query
SELECT train_number, TIME FROM train WHERE origin = 'Chennai' AND destination = 'Guruvayur';

/*
Prediction Result:
(200, '10:00')
(100, '11:00')
*/