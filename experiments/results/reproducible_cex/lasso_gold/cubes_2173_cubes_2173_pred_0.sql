-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1012, 'Renee Morales', 1013.5, 1014.5, 1015.5, '327 Nelson Route
Lake Mark, WI 07832', 'drop', 1016);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1017, 'Calvin Nielsen', 1014.5, 1015.5, 1016.5, '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 'hear', 1017);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, number_of_platforms FROM station ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('Calvin Nielsen', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021', 1017)
('Renee Morales', '327 Nelson Route\nLake Mark, WI 07832', 1016)
*/

-- Prediction Query
SELECT name, LOCATION, number_of_platforms FROM station;

/*
Prediction Result:
('Renee Morales', '327 Nelson Route\nLake Mark, WI 07832', 1016)
('Calvin Nielsen', '959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021', 1017)
*/