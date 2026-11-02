-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (2, 100, 'Express', 'CityA', 'CityB', '10:00', 'Daily');
INSERT INTO station (id, network_name, services, local_authority) VALUES (1, 'Central', 'All', 'AuthA');
INSERT INTO route (train_id, station_id) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.train_number AS train_number, LHS.name AS name, LHS.origin AS origin, LHS.destination AS destination, LHS.time AS TIME, LHS.interval AS interval, RHS.station_id AS station_id, RHS.train_id AS train_id FROM train AS LHS INNER JOIN (SELECT station_id, train_id, COUNT(*) AS n FROM route GROUP BY station_id, train_id) AS RHS ON (LHS.id = RHS.n)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT t1.name FROM train AS t1 JOIN route AS t2 ON t1.id = t2.train_id GROUP BY t2.train_id ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Express',)
*/