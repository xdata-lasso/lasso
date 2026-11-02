-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. INNER JOIN vs LEFT/OUTER JOIN (Station 4 has no trains).
-- 2. GROUP BY (Location, Name) vs GROUP BY (Name) or GROUP BY (Location) or GROUP BY (Station_ID).
-- 3. Secondary ORDER BY on count___ (Name 'Central' has two different Locations with different counts: 1 and 2).
-- 4. Duplicate output rows (SELECT vs SELECT DISTINCT) via same Name and same count in different Locations.
-- 5. Confusing train.Name with station.Name.
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (1, 'Central', 100.5, 10.0, 110.5, 'North', 'Intercity', 4);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (2, 'Central', 200.0, 20.0, 220.0, 'South', 'Regional', 2);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (3, 'West End', 150.0, 5.0, 155.0, 'North', 'Commuter', 3);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (4, 'Ghost Town', 0.0, 0.0, 0.0, 'East', 'None', 1);
INSERT INTO "station" ("Station_ID", "Name", "Annual_entry_exit", "Annual_interchanges", "Total_Passengers", "Location", "Main_Services", "Number_of_Platforms") VALUES (5, 'Central', 300.0, 30.0, 330.0, 'West', 'Regional', 2);
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (101, 'Express A', '08:00', 'Fast');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (102, 'Express B', '09:00', 'Fast');
INSERT INTO "train" ("Train_ID", "Name", "Time", "Service") VALUES (103, 'Local C', '10:00', 'Slow');
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (101, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 1);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (101, 2);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (103, 3);
INSERT INTO "train_station" ("Train_ID", "Station_ID") VALUES (102, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LOCATION, name, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY LOCATION, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Central', 1)
('Central', 1)
('Central', 2)
('West End', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id;

/*
Prediction Result:
('Central', 2)
('Central', 1)
('West End', 1)
('Central', 1)
*/