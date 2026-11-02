-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: station --
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1, 'sta_3080b1', 1.0, 1.0, 1.0, 'sta_3d0e50', 'sta_74cc17', 14);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (-2147483647, 'sta_39cf4d', 1.0, 1.0, 1.0, 'sta_3a78a7', 'sta_c0b637', 14);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (-2147483646, '5k5swwqcgs', 171.746906, 557.512061, 868.436572, 'q_2_defbd0', 'c4pgu7vfe', -1633151678);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (-2147483645, 'a2y', 797.015047, 241.913711, 759.708817, 'q_2_defbd0', 'hsrwbbp', 13244799);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (2, 'hvdltt', 125.12763, 22.535764, 600.048938, 'rmdp', 'siie', 14);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (3, 'unw6klfa', 587.783596, 558.971814, 406.809007, '0t5c4ec', 'gce', 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM station WHERE (number_of_platforms < 15)) ORDER BY number_of_platforms DESC) LIMIT 1);

/*
Gold Result:
('sta_3a78a7',)
*/

-- Prediction Query
SELECT LOCATION FROM station EXCEPT SELECT LOCATION FROM station WHERE number_of_platforms >= 15;

/*
Prediction Result:
('0t5c4ec',)
('rmdp',)
('sta_3a78a7',)
('sta_3d0e50',)
*/