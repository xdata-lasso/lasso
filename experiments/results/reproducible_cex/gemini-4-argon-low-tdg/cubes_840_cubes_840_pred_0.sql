-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by train_number, inverse relationship between id and train_number,
-- tie-breaking on train_number using train.id, and exact duplicate (train_number, name) pairs to kill SELECT DISTINCT mutants.
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1, 300, 'Express', 'Boston', 'New York', '08:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (2, 100, 'Local', 'Chicago', 'Detroit', '09:30', 'Weekdays');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (3, 200, 'Flyer', 'Seattle', 'Portland', '11:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (4, 100, 'Local', 'Austin', 'Dallas', '14:15', 'Weekends');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (5, 200, 'Bullet', 'Miami', 'Orlando', '16:45', 'Hourly');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT train_number, name FROM train ORDER BY train_number, train.id NULLS LAST;

/*
Gold Result:
(100, 'Local')
(100, 'Local')
(200, 'Flyer')
(200, 'Bullet')
(300, 'Express')
*/

-- Prediction Query
SELECT train_number, name FROM train ORDER BY TIME, train.id NULLS LAST;

/*
Prediction Result:
(300, 'Express')
(100, 'Local')
(200, 'Flyer')
(100, 'Local')
(200, 'Bullet')
*/