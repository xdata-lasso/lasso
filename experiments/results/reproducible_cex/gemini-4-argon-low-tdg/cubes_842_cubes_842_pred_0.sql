-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY (interval, origin), HAVING/WHERE count <> 1, ORDER BY origin, and duplicate origins across different intervals (testing SELECT vs SELECT DISTINCT).
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1, 101, 'Express A', 'Zeta', 'Alpha', '08:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (2, 102, 'Express B', 'Zeta', 'Beta', '09:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (3, 103, 'Local A', 'Alpha', 'Gamma', '10:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (4, 104, 'Local B', 'Alpha', 'Delta', '11:00', 'Weekly');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (5, 105, 'Regional A', 'Beta', 'Zeta', '12:00', 'Weekly');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (6, 106, 'Regional B', 'Beta', 'Zeta', '13:00', 'Weekly');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (7, 107, 'Regional C', 'Beta', 'Alpha', '14:00', 'Weekly');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (8, 108, 'Rapid A', 'Beta', 'Gamma', '15:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (9, 109, 'Rapid B', 'Beta', 'Delta', '16:00', 'Daily');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin FROM (SELECT interval, origin, COUNT(*) AS n FROM train GROUP BY interval, origin) WHERE (n <> 1) ORDER BY origin;

/*
Gold Result:
('Beta',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT origin FROM train GROUP BY origin HAVING COUNT(*) > 1;

/*
Prediction Result:
('Alpha',)
('Beta',)
('Zeta',)
*/