-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (10, '13', 14, 16, 853, '22', '17', 24);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (9, '18', 19, 20, 26, '23', '21', 15);
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (12, '22', '22', '22');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (11, '22', '22', '22');
INSERT INTO "train_station" ("train_id", "station_id") VALUES (11, 10);
INSERT INTO "train_station" ("train_id", "station_id") VALUES (12, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM station WHERE (number_of_platforms > 15 AND number_of_platforms < 25) ORDER BY LOCATION;

/*
Gold Result:
('22',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM station WHERE number_of_platforms >= 15 AND total_passengers > 25;

/*
Prediction Result:
('23',)
('22',)
*/