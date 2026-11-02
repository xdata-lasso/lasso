-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (1, 'York Central', 150.5, 20.0, 170.5, 'York', 'Intercity', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (2, 'Kings Cross', 800.0, 150.0, 950.0, 'London', 'Intercity', 5);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (3, 'Temple Meads', 300.0, 50.0, 350.0, 'Bristol', 'Regional', 2);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (4, 'Leeds City', 400.0, 60.0, 460.0, 'Leeds', 'Intercity', 99);
INSERT INTO station (Station_ID, Name, Annual_entry_exit, Annual_interchanges, Total_Passengers, Location, Main_Services, Number_of_Platforms) VALUES (5, 'Bath Spa', 120.0, 10.0, 130.0, 'Bath', 'Commuter', 6);
INSERT INTO train (Train_ID, Name, Time, Service) VALUES (101, 'Flying Scotsman', '08:00', 'Intercity');
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 1);
INSERT INTO train_station (Train_ID, Station_ID) VALUES (101, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT station_id, name, annual_entry_exit, annual_interchanges, total_passengers, LOCATION, main_services, number_of_platforms, name_other, annual_entry_exit_other, annual_interchanges_other, total_passengers_other, location_other, number_of_platforms_other, COUNT(*) OVER () AS n FROM (SELECT number_of_platforms AS station_id, name, annual_entry_exit, annual_interchanges, total_passengers, LOCATION, main_services, number_of_platforms, name_other, annual_entry_exit_other, annual_interchanges_other, total_passengers_other, location_other, number_of_platforms_other FROM (SELECT LHS.station_id AS station_id, LHS.name AS name, LHS.annual_entry_exit AS annual_entry_exit, LHS.annual_interchanges AS annual_interchanges, LHS.total_passengers AS total_passengers, LHS.location AS LOCATION, LHS.main_services AS main_services, LHS.number_of_platforms AS number_of_platforms, RHS.name AS name_other, RHS.annual_entry_exit AS annual_entry_exit_other, RHS.annual_interchanges AS annual_interchanges_other, RHS.total_passengers AS total_passengers_other, RHS.location AS location_other, RHS.number_of_platforms AS number_of_platforms_other FROM station AS LHS INNER JOIN station AS RHS ON (LHS.number_of_platforms = RHS.station_id AND LHS.main_services = RHS.main_services)))) ORDER BY LOCATION;

/*
Gold Result:
('York',)
*/

-- Prediction Query
SELECT LOCATION FROM station GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bath',)
*/