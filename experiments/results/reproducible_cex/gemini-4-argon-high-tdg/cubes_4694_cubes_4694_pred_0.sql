-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Alpha', 100.0, 50.0, 150.0, 'Loc_A', 'Srv_A', 9);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Beta', 600.0, 300.0, 900.0, 'Loc_B', 'Srv_B', 15);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Gamma', 500.0, 250.0, 750.0, 'Loc_M', 'Srv_M', 14);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Delta', 50.0, 25.0, 75.0, 'Loc_D', 'Srv_D', 20);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (5, 'Omega', 900.0, 450.0, 1350.0, 'Loc_Z', 'Srv_Z', 2);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (101, 'Express_1', '08:00', 'Intercity');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (102, 'Local_2', '09:30', 'Commuter');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 2);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (102, 4);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (102, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM station WHERE (number_of_platforms < 15)) ORDER BY number_of_platforms DESC) LIMIT 1);

/*
Gold Result:
('Loc_M',)
*/

-- Prediction Query
SELECT LOCATION FROM station EXCEPT SELECT LOCATION FROM station WHERE number_of_platforms >= 15;

/*
Prediction Result:
('Loc_A',)
('Loc_M',)
('Loc_Z',)
*/