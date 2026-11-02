-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (0, 1, 'default1', 'default1', NULL, 'default2', 'default2'), (2, 1, 'default1', 'default1', 'default2', 'default1', NULL), (1, 1, 'default1', NULL, 'default2', 'default1', NULL), (3, 1, 'default2', NULL, 'default1', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin FROM (SELECT interval, origin, COUNT(*) AS n FROM train GROUP BY interval, origin) WHERE (n <> 1) ORDER BY origin;

/*
Gold Result:
*/

-- Prediction Query
SELECT origin FROM train GROUP BY origin HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
('default1',)
*/