-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by train_number, tie-breaking by id, inverse correlations between columns, and duplicate (train_number, name) pairs to catch DISTINCT mutants or wrong ORDER BY columns/directions.
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (10, 300, 'Alpha', 'City A', 'City B', '08:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (20, 100, 'Zulu', 'City C', 'City D', '09:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (5, 200, 'Echo', 'City E', 'City F', '10:00', 'Weekly');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (15, 200, 'Bravo', 'City G', 'City H', '11:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (25, 200, 'Bravo', 'City I', 'City J', '12:00', 'Monthly');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT train_number, name FROM train ORDER BY train_number, train.id NULLS LAST;

/*
Gold Result:
(100, 'Zulu')
(200, 'Echo')
(200, 'Bravo')
(200, 'Bravo')
(300, 'Alpha')
*/

-- Prediction Query
SELECT train_number, name FROM train ORDER BY TIME, train.id NULLS LAST;

/*
Prediction Result:
(300, 'Alpha')
(100, 'Zulu')
(200, 'Echo')
(200, 'Bravo')
(200, 'Bravo')
*/