-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (out of order relative to Train_ID) and secondary ordering by Train_ID when Names tie.
-- Also tests that trains not present in train_station are included (refutes INNER JOIN mutants).
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Central', 100.5, 50.0, 150.5, 'Downtown', 'Intercity', 4);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (10, 'Zebra Express', '08:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (20, 'Alpha Line', '12:00', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (5, 'Alpha Line', '09:00', 'Regional');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, TIME, service FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Alpha Line', '09:00', 'Regional')
('Alpha Line', '12:00', 'Local')
('Zebra Express', '08:00', 'Express')
*/

-- Prediction Query
SELECT name, TIME, service FROM train;

/*
Prediction Result:
('Alpha Line', '09:00', 'Regional')
('Zebra Express', '08:00', 'Express')
('Alpha Line', '12:00', 'Local')
*/