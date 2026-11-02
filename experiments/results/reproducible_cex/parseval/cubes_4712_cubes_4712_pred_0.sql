-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: station --
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1, 'sta_d04494', 1.0, 1.0, 1.0, 'sta_43786a', '5k5swwqcgs', 1);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (-2147483647, 'sta_d497f7', 1.0, 1.0, 1.0, 'sta_38b515', '9n8', 1);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (2, '4', 249.706432, 99.523333, 314.813297, 'fe4hri', 'a2ypuzhsrwbb', 1072996612);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (3, 'luhvdltti', 182.319045, 998.421621, 207.290264, 'mdpos', 'ie5', -1209887326);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (4, 'klfa9000t', 827.854302, 983.124993, 828.555322, '4', 'ecigce376n', 1313172851);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (5, 'm52zbu', 225.300904, 760.580899, 590.639932, 'qrofq', 'p5s5bbp', 882961052);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (-2147483642, '2eutliqa11r', 997.73177, 881.232072, 377.535852, 'q_2_f88419', 'oo3o9hl72kl', -305670381);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (-2147483641, 'i7z', 353.163664, 15.406045, 712.264292, 'q_2_f88419', 'dwyrq13p', -533293970);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT station_id, name, annual_entry_exit, annual_interchanges, total_passengers, LOCATION, main_services, number_of_platforms, name_other, annual_entry_exit_other, annual_interchanges_other, total_passengers_other, location_other, number_of_platforms_other, COUNT(*) OVER () AS n FROM (SELECT number_of_platforms AS station_id, name, annual_entry_exit, annual_interchanges, total_passengers, LOCATION, main_services, number_of_platforms, name_other, annual_entry_exit_other, annual_interchanges_other, total_passengers_other, location_other, number_of_platforms_other FROM (SELECT LHS.station_id AS station_id, LHS.name AS name, LHS.annual_entry_exit AS annual_entry_exit, LHS.annual_interchanges AS annual_interchanges, LHS.total_passengers AS total_passengers, LHS.location AS LOCATION, LHS.main_services AS main_services, LHS.number_of_platforms AS number_of_platforms, RHS.name AS name_other, RHS.annual_entry_exit AS annual_entry_exit_other, RHS.annual_interchanges AS annual_interchanges_other, RHS.total_passengers AS total_passengers_other, RHS.location AS location_other, RHS.number_of_platforms AS number_of_platforms_other FROM station AS LHS INNER JOIN station AS RHS ON (LHS.number_of_platforms = RHS.station_id AND LHS.main_services = RHS.main_services)))) ORDER BY LOCATION;

/*
Gold Result:
('sta_43786a',)
*/

-- Prediction Query
SELECT LOCATION FROM station GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_f88419',)
*/