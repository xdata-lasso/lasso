-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Alpha', 100.0, 10.0, 110.0, 'Loc_14', 'Service_A', 14);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Beta', 200.0, 20.0, 220.0, 'Loc_15', 'Service_B', 15);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Gamma', 300.0, 30.0, 330.0, 'Loc_16', 'Service_C', 16);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Delta', 50.0, 5.0, 55.0, 'Loc_10', 'Service_D', 10);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'Express', '10:00', 'Fast');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM station WHERE (number_of_platforms < 15)) ORDER BY number_of_platforms DESC) LIMIT 1);

/*
Gold Result:
('Loc_14',)
*/

-- Prediction Query
SELECT LOCATION FROM station EXCEPT SELECT LOCATION FROM station WHERE number_of_platforms >= 15;

/*
Prediction Result:
('Loc_10',)
('Loc_14',)
*/