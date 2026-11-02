-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (1, 'default2', NULL, 0.0, 1.0, 'default2', NULL, NULL), (0, 'default2', 0.0, 1.0, NULL, NULL, 'default2', 0), (2, 'default1', NULL, NULL, 1.0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM station ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('default1', None)
('default2', None)
('default2', 'default2')
*/

-- Prediction Query
SELECT name, LOCATION FROM station ORDER BY Annual_entry_exit, Annual_interchanges, station.station_id NULLS LAST;

/*
Prediction Result:
('default1', None)
('default2', 'default2')
('default2', None)
*/