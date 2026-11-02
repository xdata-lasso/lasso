-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO station (id, network_name, services, local_authority) VALUES (0, 'default1', NULL, NULL), (1, 'default1', 'default2', 'default1'), (2, 'default2', 'default2', NULL), (3, 'default1', NULL, 'default2');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (0, 2, 'default1', 'default1', NULL, 'default2', 'default2'), (1, 0, NULL, 'default1', NULL, 'default1', NULL), (2, NULL, NULL, 'default2', 'default2', NULL, 'default1');
INSERT INTO route (train_id, station_id) VALUES (1, 0), (0, 2), (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.id AS id, LHS.train_number AS train_number, LHS.name AS name, LHS.origin AS origin, LHS.destination AS destination, LHS.time AS TIME, LHS.interval AS interval FROM train AS LHS INNER JOIN (SELECT MAX(n) AS maxn FROM (SELECT station_id, train_id, COUNT(*) AS n FROM route GROUP BY station_id, train_id)) AS RHS ON (LHS.id = RHS.maxn)) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT t1.name FROM train AS t1 JOIN route AS t2 ON t1.id = t2.train_id GROUP BY t2.train_id ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/