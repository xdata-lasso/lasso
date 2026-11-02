-- Schema DDL
CREATE TABLE "train" ("id" INTEGER PRIMARY KEY, "train_number" INTEGER, "name" TEXT, "origin" TEXT, "destination" TEXT, "time" TEXT, "interval" TEXT);

CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "network_name" TEXT, "services" TEXT, "local_authority" TEXT);

CREATE TABLE "route" ("train_id" INTEGER, "station_id" INTEGER, PRIMARY KEY ("train_id", "station_id"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"), FOREIGN KEY ("train_id") REFERENCES "train" ("id"));

CREATE TABLE "weekly_weather" ("station_id" INTEGER, "day_of_week" TEXT, "high_temperature" INTEGER, "low_temperature" INTEGER, "precipitation" REAL, "wind_speed_mph" INTEGER, PRIMARY KEY ("station_id", "day_of_week"), FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1050, 1053, 'Patricia Peterson', 'sound', 'Christmas Island', 'born', 'fire');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1051, 1058.0, 'Christopher Smith', 'sound', 'Madagascar', 'truth', 'fire');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1052, 1063.0, 'Michelle Stanton', 'sound', 'United States Minor Outlying Islands', 'process', 'fire');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1056, 1059, 'Lisa Hernandez', 'sound', 'Andorra', 'him', 'thought');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1057, 1064.0, 'Kimberly Osborne', 'sound', 'Bouvet Island (Bouvetoya)', 'unit', 'thought');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1058, 1069.0, 'April Nguyen', 'sound', 'Vanuatu', 'theory', 'thought');
INSERT INTO "train" ("id", "train_number", "name", "origin", "destination", "time", "interval") VALUES (1062, 1069.0, 'April Nguyen', 'sound', 'Vanuatu', 'theory', 'thought');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin FROM (SELECT interval, origin, COUNT(*) AS n FROM train GROUP BY interval, origin) WHERE (n <> 1) ORDER BY origin;

/*
Gold Result:
('sound',)
('sound',)
*/

-- Prediction Query
SELECT origin FROM train GROUP BY origin HAVING COUNT(*) > 1;

/*
Prediction Result:
('sound',)
*/