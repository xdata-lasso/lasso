-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Union', 100.5, 50.0, 150.5, 'North', 'Express', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Union', 200.0, 75.5, 275.5, 'South', 'Local', 2);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'Central', 300.0, 100.0, 400.0, 'North', 'Express', 6);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (4, 'Ghost', 10.0, 5.0, 15.0, 'East', 'None', 1);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (101, 'Bullet', '08:00', 'Fast');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (102, 'Commuter', '09:00', 'Slow');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (103, 'Night', '23:00', 'Sleeper');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (104, 'UnusedTrain', '12:00', 'None');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (101, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (103, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (101, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LOCATION, name, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY LOCATION, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Central', 1)
('Union', 1)
('Union', 3)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id;

/*
Prediction Result:
('Union', 3)
('Union', 1)
('Central', 1)
*/