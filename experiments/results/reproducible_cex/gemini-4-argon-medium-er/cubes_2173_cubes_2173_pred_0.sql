-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("Station_ID", "Name", "Location", "Number_of_Platforms") VALUES (1, 'B', 'Loc1', 2);
INSERT INTO "station" ("Station_ID", "Name", "Location", "Number_of_Platforms") VALUES (2, 'A', 'Loc2', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, number_of_platforms FROM station ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('A', 'Loc2', 4)
('B', 'Loc1', 2)
*/

-- Prediction Query
SELECT name, LOCATION, number_of_platforms FROM station;

/*
Prediction Result:
('B', 'Loc1', 2)
('A', 'Loc2', 4)
*/