-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Alpha', 100.5, 20.0, 120.5, 'York', 'Intercity', 2);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Beta', 200.0, 50.0, 250.0, 'London', 'Express', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'Gamma', 300.0, 75.0, 375.0, 'London', 'Commuter', 6);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (4, 'Delta', 40.0, 5.0, 45.0, 'Aberdeen', 'Regional', 1);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (101, 'Flying Scotsman', '08:00', 'Intercity');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (102, 'Capital Express', '09:30', 'Express');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (101, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (101, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM station ORDER BY LOCATION;

/*
Gold Result:
('Aberdeen',)
('London',)
('York',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM station;

/*
Prediction Result:
('York',)
('London',)
('Aberdeen',)
*/