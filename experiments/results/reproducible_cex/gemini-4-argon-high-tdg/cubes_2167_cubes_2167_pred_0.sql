-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Delta', 10.5, 2.0, 12.5, 'Bristol', 'Regional', 15);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Beta', 40.0, 10.0, 50.0, 'York', 'Intercity', 20);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Charlie', 30.0, 5.0, 35.0, 'Aberdeen', 'ScotRail', 24);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Alpha', 80.0, 20.0, 100.0, 'London', 'High Speed', 16);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (5, 'Echo', 25.0, 4.0, 29.0, 'Glasgow', 'Suburban', 25);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (6, 'Foxtrot', 5.0, 1.0, 6.0, 'Cardiff', 'Local', 10);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (7, 'Golf', 90.0, 15.0, 105.0, 'Dover', 'International', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM station WHERE (number_of_platforms > 15 AND number_of_platforms < 25) ORDER BY LOCATION;

/*
Gold Result:
('Aberdeen',)
('London',)
('York',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM station WHERE number_of_platforms >= 15 AND total_passengers > 25;

/*
Prediction Result:
('York',)
('Aberdeen',)
('London',)
('Glasgow',)
('Dover',)
*/