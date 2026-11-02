-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Central', 100.5, 20.0, 120.5, 'City', 'Intercity', 4);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (20, 'Alpha', '10:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (10, 'Alpha', '08:00', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (30, 'Beta', '09:00', 'Regional');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (20, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, service FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Alpha', 'Local')
('Alpha', 'Express')
('Beta', 'Regional')
*/

-- Prediction Query
SELECT name, service FROM train ORDER BY TIME, train.train_id NULLS LAST;

/*
Prediction Result:
('Alpha', 'Local')
('Beta', 'Regional')
('Alpha', 'Express')
*/