-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Zeta', 100.0, 10.0, 500.0, 'North', 'Express', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Alpha', 200.0, 20.0, 100.0, 'South', 'Local', 2);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'Beta', 150.0, 15.0, 300.0, 'East', 'Regional', 3);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (4, 'Gamma', 50.0, 5.0, 50.0, 'West', 'Local', 1);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (10, 'Train_A', '08:00', 'Express');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (20, 'Train_B', '09:00', 'Local');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (30, 'Train_C', '10:00', 'Regional');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (20, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (20, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (30, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (10, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name, total_passengers, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY name, total_passengers) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/