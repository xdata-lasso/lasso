-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (1, 101, 'Express 1', 'Chicago', ' Dest1', '08:00', 'Z');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (2, 102, 'Express 2', 'Chicago', 'Dest2', '09:00', 'Z');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (3, 103, 'Express 3', 'Chicago', 'Dest3', '10:00', 'Z');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (4, 104, 'Express 4', 'Chicago', 'Dest4', '11:00', 'Z');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (5, 201, 'Flyer 1', 'Boston', 'Dest5', '07:00', 'A');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (6, 202, 'Flyer 2', 'Boston', 'Dest6', '07:30', 'A');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (7, 301, 'Arrow 1', 'Austin', 'Dest7', '12:00', 'M');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (8, 302, 'Arrow 2', 'Austin', 'Dest8', '13:00', 'M');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (9, 303, 'Arrow 3', 'Austin', 'Dest9', '14:00', 'M');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (10, 401, 'Solo 1', 'Denver', 'SharedDest', '15:00', 'A');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (11, 402, 'Solo 2', 'Denver', 'SharedDest', '16:00', 'Z');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (12, 501, 'Regional 1', 'El Paso', 'SharedDest', '17:00', 'Q');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (13, 502, 'Regional 2', 'Fargo', 'SharedDest', '18:00', 'Q');
INSERT INTO train (id, train_number, name, origin, destination, time, interval) VALUES (14, 601, 'Single', 'Miami', 'Dest10', '19:00', 'W');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin FROM (SELECT interval, origin, COUNT(*) AS n FROM train GROUP BY interval, origin) WHERE (n <> 1) ORDER BY origin;

/*
Gold Result:
('Austin',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT origin FROM train GROUP BY origin HAVING COUNT(*) > 1;

/*
Prediction Result:
('Austin',)
('Boston',)
('Chicago',)
('Denver',)
*/