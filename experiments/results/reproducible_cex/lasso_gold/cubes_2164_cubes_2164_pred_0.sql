-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1004, 'Kevin Pacheco', 'mouth', 'kind');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1005, 'Allen Robinson', 'offer', 'play');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, service FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Allen Robinson', 'play')
('Kevin Pacheco', 'kind')
*/

-- Prediction Query
SELECT name, service FROM train ORDER BY TIME, train.train_id NULLS LAST;

/*
Prediction Result:
('Kevin Pacheco', 'kind')
('Allen Robinson', 'play')
*/