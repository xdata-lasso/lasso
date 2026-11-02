-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (out of insertion order), tie-breaking by Station_ID, and preserves duplicate (Name, Location) pairs (kills SELECT DISTINCT, missing ORDER BY, DESC instead of ASC, or missing secondary sort).
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (10, 'Waterloo', 90.5, 10.2, 100.7, 'London', 'National Rail', 24);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (20, 'Victoria', 75.0, 8.5, 83.5, 'London', 'South Eastern', 19);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (5, 'Victoria', 12.0, 1.5, 13.5, 'London', 'Metrolink', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (15, 'Victoria', 5.0, 0.5, 5.5, 'Manchester', 'Northern', 6);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Euston', 45.0, 4.0, 49.0, 'London', 'West Coast', 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM station ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('Euston', 'London')
('Victoria', 'London')
('Victoria', 'Manchester')
('Victoria', 'London')
('Waterloo', 'London')
*/

-- Prediction Query
SELECT name, LOCATION FROM station ORDER BY Annual_entry_exit, Annual_interchanges, station.station_id NULLS LAST;

/*
Prediction Result:
('Victoria', 'Manchester')
('Victoria', 'London')
('Euston', 'London')
('Victoria', 'London')
('Waterloo', 'London')
*/