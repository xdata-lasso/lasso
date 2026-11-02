-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: train --
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483648, -55602865, 'swwqcgsk', 'tra_907821', '9n8c4pgu7v', 'e4', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483647, 1160656988, 'ia2yp', 'tra_907821', 'uzhsrwbbp6lu', 'hvdlttilbnpr', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483646, 2087640001, 'dposiie5unw', 'tra_907821', 'klfa9000t', 'c4ecigce', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483645, -1585009206, '52zb', 'tra_907821', 'uo4nrqrofqy', '5s5b', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483644, 2107872094, '02eutliqa11r', 'tra_907821', 'ytoo3o9', 'l7', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483643, 1178636309, 'ex1', 'tra_907821', 'ji7zwau2', 'dwyrq13pyu78', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483642, 244829661, 'jsl', 'tra_907821', 'b4yp5qi', 'rkf9vqx5', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483641, 1836127587, 'f8jegd2', 'tra_907821', 'vy9uxj4', 'wb', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483640, -1929953647, 'ph2', 'tra_907821', 'nd', 'wnqcx', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483639, 722884590, 'hncprjtu0dz', 'tra_907821', '9fjgq8n2f', 'dqv0gcb9', NULL);

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483638, 172461907, 'k3zbily', 'tra_907821', 'kn6vc', '6ah', NULL);

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483637, -348113485, 'jswwlq7xb', 'tra_907821', '72fxa7ryfd', 'z16ni', NULL);

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483636, 2011234363, 'ai5', NULL, 'h', 'ogrgjd8y', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483635, 1129658414, '1afgo', NULL, 'ri', 'tsj3ayxp1q4', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483634, -1538707438, 'den8c68x', NULL, 'vacx7afu5', '1of77p', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483633, -435350511, '72ctdctmfg62', 'tra_907821', '0v', 'q8qdjpe1', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483632, -1180042408, '78507cvt', 'tra_907821', 'ptt', '6b', 'tra_0a2293');

INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (-2147483631, -1171104889, '5zi36c4bfkfo', 'tra_907821', 'c', '0', 'tra_0a2293');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin FROM (SELECT interval, origin, COUNT(*) AS n FROM train GROUP BY interval, origin) WHERE (n <> 1) ORDER BY origin;

/*
Gold Result:
(None,)
('tra_907821',)
('tra_907821',)
*/

-- Prediction Query
SELECT origin FROM train GROUP BY origin HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
('tra_907821',)
*/