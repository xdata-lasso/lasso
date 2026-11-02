-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (1, 'Southern Railway', 'Express', 'Chennai Corp');
INSERT INTO "station" ("id", "network_name", "services", "local_authority") VALUES (2, 'Southern Railway', 'Passenger', 'Thrissur');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1, 200, 'Egmore Express', 'Chennai', 'Guruvayur', '14:30', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (2, 100, 'West Coast Mail', 'Chennai', 'Mumbai', '09:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (3, 150, 'Kerala Express', 'Delhi', 'Guruvayur', '11:15', 'Weekly');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (4, 120, 'Return Fast', 'Guruvayur', 'Chennai', '06:45', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (5, 180, 'Lowercase Train', 'chennai', 'guruvayur', '16:00', 'Daily');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (6, 50, 'Morning Super', 'Chennai', 'Guruvayur', '05:00', 'Weekly');
INSERT INTO "route" ("train_id", "station_id") VALUES (2, 1);
INSERT INTO "route" ("train_id", "station_id") VALUES (6, 1);
INSERT INTO "route" ("train_id", "station_id") VALUES (6, 2);
INSERT INTO "weekly_weather" ("station_id", "day_of_week", "high_temperature", "low_temperature", "precipitation", "wind_speed_mph") VALUES (1, 'Monday', 35, 26, 0.0, 12);
INSERT INTO "weekly_weather" ("station_id", "day_of_week", "high_temperature", "low_temperature", "precipitation", "wind_speed_mph") VALUES (2, 'Tuesday', 31, 24, 1.5, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "train_number", "time" FROM "train" WHERE ("origin" = 'Chennai' AND "destination" = 'Guruvayur') ORDER BY train_number, train.id NULLS LAST;

/*
Gold Result:
(50, '05:00')
(200, '14:30')
*/

-- Prediction Query
SELECT train_number, TIME FROM train WHERE origin = 'Chennai' AND destination = 'Guruvayur';

/*
Prediction Result:
(200, '14:30')
(50, '05:00')
*/