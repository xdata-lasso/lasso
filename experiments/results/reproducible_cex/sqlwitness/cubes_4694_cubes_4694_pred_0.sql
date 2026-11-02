-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO station (station_id, name, annual_entry_exit, annual_interchanges, total_passengers, location, main_services, number_of_platforms) VALUES (15, 'default1', NULL, NULL, 16.0, 'default1', 'default2', 15), (0, 'default1', 1.0, 0.0, 14.0, 'default2', 'default1', 16), (14, 'default2', 1.0, 15.0, 15.0, 'default2', 'default1', 15), (16, NULL, 16.0, 14.0, 0.0, 'default2', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM station WHERE (number_of_platforms < 15)) ORDER BY number_of_platforms DESC) LIMIT 1);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT LOCATION FROM station EXCEPT SELECT LOCATION FROM station WHERE number_of_platforms >= 15;

/*
Prediction Result:
*/