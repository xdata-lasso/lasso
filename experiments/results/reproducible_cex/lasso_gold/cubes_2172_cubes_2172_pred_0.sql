-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1001, 'Allison Hill', 1004.5, 1007.5, 1010.5, '819 Johnson Course
East William, AK 74064', 'trial', 1011);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1002, 'Allison Hill', 1011.5, 1016.5, 1010.5, '79402 Peterson Drives Apt. 511
Davisstad, PA 35172', 'blood', 1028.0);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1003, 'Allison Hill', 1018.5, 1025.5, 1010.5, '161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 'husband', 1045.0);
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1014, 'Mark Diaz', 'hospital', 'religious');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1015, 'Mark Diaz', 'hear', 'example');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1016, 'Mark Diaz', 'determine', 'science');
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1014, 1001);
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1014, 1002);
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1014, 1003);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT name, total_passengers, COUNT(*) AS n FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name, RHS.annual_entry_exit AS annual_entry_exit, RHS.annual_interchanges AS annual_interchanges, RHS.total_passengers AS total_passengers, RHS.location AS LOCATION, RHS.main_services AS main_services, RHS.number_of_platforms AS number_of_platforms FROM train_station AS LHS INNER JOIN station AS RHS ON (LHS.station_id = RHS.station_id)) GROUP BY name, total_passengers) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/