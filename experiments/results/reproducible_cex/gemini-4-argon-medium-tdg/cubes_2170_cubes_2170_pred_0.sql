-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, tie-breaking by Station_ID, and detects erroneous DISTINCT or GROUP BY clauses by having identical (Name, Location) pairs with different Station_IDs.
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (10, 'Victoria', 50.5, 10.2, 60.7, 'London', 'National Rail', 19);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Paddington', 40.0, 5.0, 45.0, 'London', 'Great Western', 14);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (5, 'Victoria', 12.3, 1.1, 13.4, 'London', 'Southeastern', 8);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'Victoria', 5.0, 0.5, 5.5, 'Manchester', 'Northern', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM station ORDER BY name, station.station_id NULLS LAST;

/*
Gold Result:
('Paddington', 'London')
('Victoria', 'Manchester')
('Victoria', 'London')
('Victoria', 'London')
*/

-- Prediction Query
SELECT name, LOCATION FROM station ORDER BY Annual_entry_exit, Annual_interchanges, station.station_id NULLS LAST;

/*
Prediction Result:
('Victoria', 'Manchester')
('Victoria', 'London')
('Paddington', 'London')
('Victoria', 'London')
*/