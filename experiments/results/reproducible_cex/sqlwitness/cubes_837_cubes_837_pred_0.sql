-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (0, NULL, 'Guruvayur', 'default1', 'default2', 'Chennai', 'Chennai'), (1, 0, NULL, 'Guruvayur', 'Guruvayur', 'default2', 'Guruvayur'), (2, 1, 'default2', 'Chennai', 'Guruvayur', NULL, NULL), (3, 0, 'Chennai', 'Guruvayur', 'default2', 'Guruvayur', 'Chennai'), (4, 1, 'default1', 'default1', 'Guruvayur', 'Guruvayur', 'Guruvayur'), (5, NULL, 'default2', NULL, 'default2', 'default1', 'default1'), (6, 1, 'Guruvayur', 'Guruvayur', 'default2', 'default2', 'default1'), (7, 1, 'Guruvayur', 'Guruvayur', NULL, NULL, 'Guruvayur'), (8, NULL, 'default2', 'default2', NULL, 'default1', NULL), (9, 1, 'default2', NULL, 'default2', 'Chennai', 'Chennai'), (10, NULL, NULL, 'default1', 'default2', NULL, 'Guruvayur'), (11, 0, 'default1', 'default1', 'Chennai', 'Chennai', 'default2'), (12, 1, NULL, NULL, 'default1', 'Chennai', 'Guruvayur'), (13, 0, 'default1', 'Chennai', 'Chennai', 'default1', 'Chennai'), (14, 1, 'Chennai', 'Guruvayur', 'Guruvayur', 'default2', 'default2'), (15, 0, NULL, NULL, 'Guruvayur', 'default2', 'default2'), (16, NULL, 'default2', 'Chennai', 'Chennai', 'Chennai', 'default2'), (17, 0, 'default2', 'default1', NULL, 'Guruvayur', 'Guruvayur'), (18, NULL, 'Chennai', NULL, 'default1', NULL, NULL), (19, 1, 'Guruvayur', 'Chennai', NULL, NULL, 'default1'), (20, 0, 'default1', 'Chennai', 'Guruvayur', NULL, 'default2'), (21, NULL, 'default2', NULL, 'default1', 'default1', 'default1'), (22, 0, 'default1', 'default1', 'default1', 'Guruvayur', 'default2'), (23, 0, 'Guruvayur', 'default1', 'default2', 'Chennai', NULL), (24, 1, 'Chennai', NULL, NULL, 'Guruvayur', 'default2'), (25, NULL, 'Chennai', NULL, 'Guruvayur', 'Guruvayur', 'Guruvayur'), (26, NULL, 'default1', NULL, 'Guruvayur', 'default2', 'Chennai'), (27, NULL, NULL, 'default1', 'default2', 'default1', 'default1'), (28, NULL, 'default2', 'Chennai', NULL, 'default1', 'default2'), (29, 0, 'default1', 'Guruvayur', 'Guruvayur', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "train_number", "time" FROM "train" WHERE ("origin" = 'Chennai' AND "destination" = 'Guruvayur') ORDER BY train_number, train.id NULLS LAST;

/*
Gold Result:
(0, None)
(1, None)
*/

-- Prediction Query
SELECT train_number, TIME FROM train WHERE origin = 'Chennai' AND destination = 'Guruvayur';

/*
Prediction Result:
(1, None)
(0, None)
*/