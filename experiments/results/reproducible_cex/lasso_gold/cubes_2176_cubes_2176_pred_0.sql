-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1006, 'Sean Blake', 1007.5, 1008.5, 1009.5, '4235 Christopher Court Suite 594
Lake Stephenville, MS 10829', 'old', 1010);
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1011, 'Benjamin Stanley', 1012.5, 1013.5, 1014.5, '16475 Mitchell Fords
Jacquelineland, PA 83728', 'Congress', 1015);
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1, 'Mark Mcclure', 'high', 'participant');
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (1016, 'Danielle Ford', 'expect', 'wish');
INSERT INTO "train_station" ("train_id", "station_id") VALUES (1, 1006);
INSERT INTO "train_station" ("train_id", "station_id") VALUES (NULL, 1011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.train_id AS train_id, LHS.station_id AS station_id, RHS.name AS name FROM train_station AS LHS INNER JOIN (SELECT name, station_id, COUNT(*) AS n FROM station GROUP BY name, station_id) AS RHS ON (LHS.station_id = RHS.station_id AND LHS.train_id = RHS.n)) ORDER BY name;

/*
Gold Result:
('Sean Blake',)
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Benjamin Stanley',)
*/