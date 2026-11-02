-- Schema DDL
CREATE TABLE "station" ("Station_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Annual_entry_exit" REAL, "Annual_interchanges" REAL, "Total_Passengers" REAL, "Location" TEXT, "Main_Services" TEXT, "Number_of_Platforms" INTEGER);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Time" TEXT, "Service" TEXT);

CREATE TABLE "train_station" ("Train_ID" INTEGER, "Station_ID" INTEGER, PRIMARY KEY ("Train_ID", "Station_ID"), FOREIGN KEY ("Station_ID") REFERENCES "station" ("Station_ID"), FOREIGN KEY ("Train_ID") REFERENCES "train" ("Train_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: station --
INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (1, 't2__fe5e6b', 582.588439, 680.190136, 487.053947, 'swwqcgsk', '9n8c4pgu7v', -1865039888);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (2, 't2__fe5e6b', 816.814398, 396.776796, 676.357279, '4nrq', 'rofqyp5s5b', 2107872094);

INSERT INTO "station" ("station_id", "name", "annual_entry_exit", "annual_interchanges", "total_passengers", "location", "main_services", "number_of_platforms") VALUES (-2147483647, 't2__fe5e6b', 705.580387, 673.065986, 825.231787, 'ut', 'iqa', -314162272);

-- Inserting into table: train --
INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483647, 'n', 'rmdp', 'siie');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483646, 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483645, 'oo3o9', 'l7', 'klex14ji');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483644, 'au2dwyrq13', 'yu78', '9');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483643, 'ljsl0', '4', 'p5qi2rk');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483642, 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483641, 'nd', 'wnqcx', '5hncprjtu0d');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483640, '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483639, 'kn6vck6ah0f8', 'sww', 'q7x');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483638, '72fxa7ryfd', 'z16ni', 'jai');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483637, 'h', 'ogrgjd8y', 't1afgog');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483636, 'tsj', 'ayxp1q43', '1jh3den');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483635, 'c68x8vacx7', 'f', '5w1of7');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483634, 'zo72', 'ctdctmfg62g0', '5q8qdj');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483633, '1i', '2278', '07cvtjpt');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483632, '6b', 'ou5z', '36c');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483631, 'f', 'foa', 'cd07z2zezjo7');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483630, 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483629, 'im5k', '8qs27p2r', '4gth2mnaj');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483628, 'a3o', 'v8u', 'tmu2n');

INSERT INTO "train" ("train_id", "name", "time", "service") VALUES (-2147483627, '78lfvyz7', 'zzbe8yvkv4', 'q7sx58b4');

-- Inserting into table: train_station --
INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483648, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483647, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483646, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483647, 2);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483646, 2);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483645, 2);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483645, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483644, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483643, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483642, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483641, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483640, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483639, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483638, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483637, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483636, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483635, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483634, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483633, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483632, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483631, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483630, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483629, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483628, 1);

INSERT INTO "train_station" ("train_id", "station_id") VALUES (-2147483627, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.name AS name, LHS.station_id AS station_id, LHS.maxn AS maxn FROM (SELECT name, station_id, MAX(n) AS maxn FROM (SELECT name, station_id, COUNT(*) AS n FROM station GROUP BY name, station_id) GROUP BY name, station_id) AS LHS INNER JOIN train_station AS RHS ON (LHS.station_id = RHS.station_id AND LHS.maxn = RHS.train_id)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.name FROM train_station AS T1 JOIN station AS T2 ON T1.station_id = T2.station_id GROUP BY T1.station_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('t2__fe5e6b',)
*/