-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Train_ID, and detects erroneous DISTINCT or Wrong ORDER BY columns (like Service or Time).
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (3, 'Alpha', '10:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (1, 'Alpha', '12:00', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (2, 'Alpha', '08:00', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (4, 'Beta', '06:00', 'Commuter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, service FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Alpha', 'Local')
('Alpha', 'Local')
('Alpha', 'Express')
('Beta', 'Commuter')
*/

-- Prediction Query
SELECT name, service FROM train ORDER BY TIME, train.train_id NULLS LAST;

/*
Prediction Result:
('Beta', 'Commuter')
('Alpha', 'Local')
('Alpha', 'Express')
('Alpha', 'Local')
*/