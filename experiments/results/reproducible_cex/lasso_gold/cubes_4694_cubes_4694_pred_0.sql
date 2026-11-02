-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1001, 'Allison Hill', 1005.5, 1009.5, 1013.5, '863 Lawrence Valleys
Port Lindachester, MA 36922', 'attorney', 14);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1002, 'Noah Rhodes', 1012.5, 1018.5, 1024.5, '16155 Roman Stream Suite 816
New Kellystad, OK 25704', 'development', 13);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1003, 'Angie Henderson', 1019.5, 1027.5, 1035.5, '341 Michelle Light
Shawnstad, GA 49021', 'white', 12);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1004, 'Daniel Wagner', 1026.5, 1036.5, 1046.5, '192 Frank Light Suite 835
East Lydiamouth, MO 35594', 'yes', 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM station WHERE (number_of_platforms < 15)) ORDER BY number_of_platforms DESC) LIMIT 1);

/*
Gold Result:
('863 Lawrence Valleys\nPort Lindachester, MA 36922',)
*/

-- Prediction Query
SELECT LOCATION FROM station EXCEPT SELECT LOCATION FROM station WHERE number_of_platforms >= 15;

/*
Prediction Result:
('16155 Roman Stream Suite 816\nNew Kellystad, OK 25704',)
('192 Frank Light Suite 835\nEast Lydiamouth, MO 35594',)
('341 Michelle Light\nShawnstad, GA 49021',)
('863 Lawrence Valleys\nPort Lindachester, MA 36922',)
*/