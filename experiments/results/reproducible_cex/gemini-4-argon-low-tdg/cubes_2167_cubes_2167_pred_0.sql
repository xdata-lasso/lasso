-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values (14, 15, 16, 24, 25, 26), NULLs, and basic filtering.
-- Catches > vs >=, < vs <=, AND vs OR, and incorrect bounds (e.g., BETWEEN 15 AND 25).
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Station 14', 10.0, 2.0, 12.0, 'Loc_14', 'Regional', 14);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Station 15', 15.0, 3.0, 18.0, 'Loc_15', 'Intercity', 15);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'Station 16', 20.0, 4.0, 24.0, 'Loc_16', 'Commuter', 16);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (4, 'Station 24', 25.0, 5.0, 30.0, 'Loc_24', 'High Speed', 24);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (5, 'Station 25', 30.0, 6.0, 36.0, 'Loc_25', 'Local', 25);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (6, 'Station 26', 35.0, 7.0, 42.0, 'Loc_26', 'Express', 26);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (7, 'Station NullPlat', 40.0, 8.0, 48.0, 'Loc_NullPlat', 'Express', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM station WHERE (number_of_platforms > 15 AND number_of_platforms < 25) ORDER BY LOCATION;

/*
Gold Result:
('Loc_16',)
('Loc_24',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM station WHERE number_of_platforms >= 15 AND total_passengers > 25;

/*
Prediction Result:
('Loc_24',)
('Loc_25',)
('Loc_26',)
*/