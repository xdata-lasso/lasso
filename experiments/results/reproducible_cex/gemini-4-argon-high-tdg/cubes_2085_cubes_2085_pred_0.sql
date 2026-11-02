-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'O Hare', 'Chicago', 'USA', 41.97, -87.90, 672, 'ORD', 'KORD');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Midway', 'Chicago', 'USA', 41.78, -87.75, 620, 'MDW', 'KMDW');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Rockford', 'Chicago', 'USA', 42.19, -89.09, 742, 'RFD', 'KRFD');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Logan', 'Boston', 'USA', 42.36, -71.00, 20, 'BOS', 'KBOS');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Hanscom', 'Boston', 'USA', 42.47, -71.28, 133, 'BED', 'KBED');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'Beverly', 'Boston', 'USA', 42.58, -70.91, 107, 'BVY', 'KBVY');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'Norwood', 'Boston', 'USA', 42.19, -71.17, 49, 'OWD', 'KOWD');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (8, 'Worcester', 'Boston', 'USA', 42.26, -71.87, 1009, 'ORH', 'KORH');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (9, 'Hartsfield', 'Atlanta', 'USA', 33.64, -84.42, 1026, 'ATL', 'KATL');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (10, 'DeKalb', 'Atlanta', 'USA', 33.87, -84.30, 1003, 'PDK', 'KPDK');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (11, 'Fulton', 'Atlanta', 'USA', 33.77, -84.52, 841, 'FTY', 'KFTY');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (12, 'Cobb', 'Atlanta', 'USA', 34.01, -84.59, 1040, 'RYY', 'KRYY');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (13, 'Dia', 'Denver', 'USA', 39.85, -104.67, 5431, 'DEN', 'KDEN');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (14, 'Centennial', 'Denver', 'USA', 39.57, -104.84, 5885, 'APA', 'KAPA');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (15, 'Tacoma', 'Seattle', 'USA', 47.45, -122.30, 433, 'SEA', 'KSEA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM (SELECT city, COUNT(*) AS n FROM airports GROUP BY city) WHERE (n > 2) ORDER BY city;

/*
Gold Result:
('Atlanta',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT city FROM airports GROUP BY city HAVING COUNT(*) > 2 ORDER BY COUNT(*), city NULLS LAST;

/*
Prediction Result:
('Chicago',)
('Atlanta',)
('Boston',)
*/