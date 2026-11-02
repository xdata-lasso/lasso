-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1032, 'Pamela Romero', 1033.5, 1034.5, 1035.5, '227 Joseph Well
Brandtside, WV 96174', 'effect', 1036);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1037, 'Eric Carney', 1034.5, 1035.5, 1036.5, '893 Nathaniel Estates Apt. 957
North Sarahport, IA 08093', 'road', 1037);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM station AS LHS WHERE NOT EXISTS(SELECT 1 FROM train_station AS RHS WHERE (LHS.station_id = RHS.station_id))) ORDER BY name;

/*
Gold Result:
('Eric Carney',)
('Pamela Romero',)
*/

-- Prediction Query
SELECT name FROM station WHERE NOT station_id IN (SELECT station_id FROM train_station);

/*
Prediction Result:
('Pamela Romero',)
('Eric Carney',)
*/