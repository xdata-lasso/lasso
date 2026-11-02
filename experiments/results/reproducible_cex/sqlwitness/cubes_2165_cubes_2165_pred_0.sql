-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (1, 'default2', 1.0, 0.0, 1.0, 'default2', NULL, 0), (0, NULL, NULL, NULL, 1.0, 'London', 'default1', 0), (2, 'default1', 0.0, 0.0, 1.0, 'default1', 'default2', 1), (3, NULL, 0.0, 0.0, 1.0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "total_passengers" FROM "station" WHERE ("location" <> 'London') ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('default1', 1.0)
('default2', 1.0)
*/

-- Prediction Query
SELECT name, total_passengers FROM station WHERE LOCATION <> 'London';

/*
Prediction Result:
('default2', 1.0)
('default1', 1.0)
*/