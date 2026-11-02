-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (1023, 'Meredith Barnes', 'list', 'perform');
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (1028, 'Abigail Shaffer', 'save', 'knowledge');
INSERT INTO "weekly_weather" ("station_id", "day_of_week", "high_temperature", "low_temperature", "precipitation", "wind_speed_mph") VALUES (1023, 'fall', 1024, 1025, 1026.5, 1027);
INSERT INTO "weekly_weather" ("station_id", "day_of_week", "high_temperature", "low_temperature", "precipitation", "wind_speed_mph") VALUES (1028, 'grow', NULL, 1030, 1031.5, 1032);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanhigh_temperature AS avg_high_temperature_, day_of_week FROM (SELECT day_of_week, AVG(high_temperature) AS meanhigh_temperature FROM weekly_weather GROUP BY day_of_week) ORDER BY avg_high_temperature_, day_of_week NULLS LAST;

/*
Gold Result:
(None, 'grow')
(1024.0, 'fall')
*/

-- Prediction Query
SELECT AVG(high_temperature), day_of_week FROM weekly_weather GROUP BY day_of_week;

/*
Prediction Result:
(1024.0, 'fall')
(None, 'grow')
*/