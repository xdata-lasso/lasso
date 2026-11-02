-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (25, NULL, NULL, 26.0, 26.0, 'default1', 'default1', 0), (1, 'default2', NULL, 1.0, 14.0, 'default1', 'default2', 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM station WHERE (number_of_platforms > 15 AND number_of_platforms < 25) ORDER BY LOCATION;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM station WHERE number_of_platforms >= 15 AND total_passengers > 25;

/*
Prediction Result:
*/