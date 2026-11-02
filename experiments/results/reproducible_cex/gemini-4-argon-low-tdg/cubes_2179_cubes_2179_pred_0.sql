-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Central', 10.5, 2.5, 13.0, 'North', 'Express', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'West', 5.0, 1.0, 6.0, 'West', 'Local', 2);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (10, 'Zebra', '12:00', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (20, 'Alpha', '15:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (5, 'Alpha', '18:00', 'Regional');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (15, 'Beta', '09:00', 'Commuter');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, TIME, service FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Alpha', '18:00', 'Regional')
('Alpha', '15:00', 'Express')
('Beta', '09:00', 'Commuter')
('Zebra', '12:00', 'Local')
*/

-- Prediction Query
SELECT name, TIME, service FROM train;

/*
Prediction Result:
('Alpha', '18:00', 'Regional')
('Zebra', '12:00', 'Local')
('Beta', '09:00', 'Commuter')
('Alpha', '15:00', 'Express')
*/