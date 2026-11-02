-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (0, 100, 'Train Zero', 'City A', 'City B', '06:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (1, 500, 'Train One', 'City C', 'City D', '07:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (2, 1, 'Train Two', 'City E', 'City F', '08:00', 'Weekly');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (3, 300, 'Train Three', 'City G', 'City H', '09:00', 'Hourly');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (4, 400, 'Train Four', 'City I', 'City J', '10:00', 'Daily');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (5, 200, 'Train Five', 'City K', 'City L', '11:00', 'Monthly');
INSERT INTO station (id, network_name, services, local_authority) VALUES (10, 'North Net', 'Express', 'Auth A');
INSERT INTO station (id, network_name, services, local_authority) VALUES (20, 'South Net', 'Local', 'Auth B');
INSERT INTO station (id, network_name, services, local_authority) VALUES (30, 'East Net', 'Freight', 'Auth C');
INSERT INTO route (train_id, station_id) VALUES (5, 10);
INSERT INTO route (train_id, station_id) VALUES (5, 20);
INSERT INTO route (train_id, station_id) VALUES (4, 10);
INSERT INTO route (train_id, station_id) VALUES (3, 10);
INSERT INTO weekly_weather (station_id, day_of_week, high_temperature, low_temperature, precipitation, wind_speed_mph) VALUES (10, 'Monday', 70, 50, 0.1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.id AS id, LHS.train_number AS train_number, LHS.name AS name, LHS.origin AS origin, LHS.destination AS destination, LHS.time AS TIME, LHS.interval AS interval FROM train AS LHS INNER JOIN (SELECT MAX(n) AS maxn FROM (SELECT station_id, train_id, COUNT(*) AS n FROM route GROUP BY station_id, train_id)) AS RHS ON (LHS.id = RHS.maxn)) ORDER BY name;

/*
Gold Result:
('Train One',)
*/

-- Prediction Query
SELECT t1.name FROM train AS t1 JOIN route AS t2 ON t1.id = t2.train_id GROUP BY t2.train_id ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Train Five',)
*/