-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("Station_ID", "Name", "Total_Passengers", "Location") VALUES (1, 'B', 100.0, 'York');
INSERT INTO "station" ("Station_ID", "Name", "Total_Passengers", "Location") VALUES (2, 'A', 200.0, 'York');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "total_passengers" FROM "station" WHERE ("location" <> 'London') ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('A', 200.0)
('B', 100.0)
*/

-- Prediction Query
SELECT name, total_passengers FROM station WHERE LOCATION <> 'London';

/*
Prediction Result:
('B', 100.0)
('A', 200.0)
*/