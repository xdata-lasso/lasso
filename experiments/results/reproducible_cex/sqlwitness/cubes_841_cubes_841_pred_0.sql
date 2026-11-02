-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO station (id, network_name, services, local_authority) VALUES (1, 'default2', 'default2', 'default1'), (0, 'default1', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT local_authority, services FROM station ORDER BY local_authority, station.id NULLS LAST;

/*
Gold Result:
(None, 'default2')
('default1', 'default2')
*/

-- Prediction Query
SELECT local_authority, services FROM station;

/*
Prediction Result:
(None, 'default2')
('default1', 'default2')
*/