-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (1, 'A', '2', 'S1');
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (2, 'B', '1', 'S2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, service FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('A', 'S1')
('B', 'S2')
*/

-- Prediction Query
SELECT name, service FROM train ORDER BY TIME, train.train_id NULLS LAST;

/*
Prediction Result:
('B', 'S2')
('A', 'S1')
*/