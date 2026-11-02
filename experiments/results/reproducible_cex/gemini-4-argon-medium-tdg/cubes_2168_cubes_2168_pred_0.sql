-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests duplicate elimination (DISTINCT), reverse insertion order vs alphabetical sorting (ORDER BY),
-- and orphan stations vs connected stations (kills mutants with erroneous INNER JOIN on train_station).
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Victoria', 80.5, 10.2, 90.7, 'London', 'National Rail', 19);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Paddington', 45.0, 5.0, 50.0, 'London', 'Great Western', 14);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'New Street', 40.0, 8.0, 48.0, 'Birmingham', 'CrossCountry', 12);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (4, 'Waverley', 20.0, 2.0, 22.0, 'Edinburgh', 'ScotRail', 20);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (101, 'Flying Scotsman', '08:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (102, 'Midland Pullman', '12:30', 'InterCity');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (101, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM station ORDER BY LOCATION;

/*
Gold Result:
('Birmingham',)
('Edinburgh',)
('London',)
*/

-- Prediction Query
SELECT DISTINCT LOCATION FROM station;

/*
Prediction Result:
('London',)
('Birmingham',)
('Edinburgh',)
*/