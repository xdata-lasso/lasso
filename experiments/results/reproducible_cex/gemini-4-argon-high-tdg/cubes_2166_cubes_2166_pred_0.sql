-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Central', 100.5, 20.0, 120.5, 'Downtown', 'Intercity', 4);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'North', 50.0, 10.0, 60.0, 'Uptown', 'Commuter', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM train ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM train;

/*
Prediction Result:
(0,)
*/