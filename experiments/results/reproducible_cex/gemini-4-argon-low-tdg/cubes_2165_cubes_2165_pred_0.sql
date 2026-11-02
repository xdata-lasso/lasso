-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (10, 'Victoria', 15.0, 2.0, 17.0, 'Manchester', 'Northern', 6);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (5, 'Victoria', 15.0, 2.0, 17.0, 'Birmingham', 'West Midlands', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Victoria', 35.0, 8.0, 43.0, 'Southend', 'Greater Anglia', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (20, 'Alpha Station', 5.0, 1.0, 6.0, 'York', 'LNER', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "total_passengers" FROM "station" WHERE ("location" <> 'London') ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('Alpha Station', 6.0)
('Victoria', 43.0)
('Victoria', 17.0)
('Victoria', 17.0)
*/

-- Prediction Query
SELECT name, total_passengers FROM station WHERE LOCATION <> 'London';

/*
Prediction Result:
('Victoria', 43.0)
('Victoria', 17.0)
('Victoria', 17.0)
('Alpha Station', 6.0)
*/